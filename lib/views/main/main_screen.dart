import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highthon_10th/views/main/widgets/header/main_tags_header.dart';
import 'package:highthon_10th/views/main/widgets/tab/event/event_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _sheetPosition = 0.5;
  final double _dragSensitivity = 600;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  final Map<String, String> _typeIcons = {
    'cafe': 'assets/image/cafe.png',
    'food': 'assets/image/restaurant.png',
    'park': 'assets/image/park.png',
    'etc': 'assets/image/etc.png',
  };

  /// API에서 마커 데이터 가져오기 (예제)
  Future<List<Map<String, dynamic>>> fetchMarkers() async {
    return [
      {
        'id': '1',
        'latitude': 37.578285212319,
        'longitude': 126.970646659393,
        'name': 'San Francisco',
        'description': 'Custom Marker 1',
        'place_type': 'cafe',
      },
      {
        'id': '2',
        'latitude': 37.5797361073093,
        'longitude': 126.969324927835,
        'name': 'Los Angeles',
        'description': 'Custom Marker 2',
        'place_type': 'food',
      },
    ];
  }

  /// 에셋 이미지를 바이트로 변환
  Future<Uint8List> getCustomMarker(String path, {int width = 100}) async {
    ByteData data = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// 마커 생성 함수
  Future<void> createMarkers() async {
    final markersData = await fetchMarkers();

    final List<Future<Uint8List>> iconFutures = markersData.map((marker) async {
      String? iconPath = _typeIcons[marker['place_type']];
      if (iconPath != null) {
        return getCustomMarker(iconPath);
      }
      return getCustomMarker(_typeIcons['etc']!); // 기본 아이콘 처리
    }).toList();

    final List<Uint8List> icons = await Future.wait(iconFutures);

    setState(() {
      markers = markersData.asMap().entries.map((entry) {
        final index = entry.key;
        final marker = entry.value;
        return Marker(
          markerId: MarkerId(marker['id']),
          position: LatLng(marker['latitude'], marker['longitude']),
          icon: BitmapDescriptor.fromBytes(icons[index]),
          infoWindow: InfoWindow(
            title: marker['name'],
            snippet: marker['description'],
          ),
          onTap: () {},
        );
      }).toSet();
    });
  }

  /// 드래그 위치 업데이트 함수
  void _updateSheetPosition(double delta) {
    setState(() {
      _sheetPosition -= delta / _dragSensitivity;
      _sheetPosition = _sheetPosition.clamp(0.25, 0.93);
    });
  }

  @override
  void initState() {
    super.initState();
    createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 구글 맵
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.545283, 126.952611),
              zoom: 15,
            ),
            markers: markers,
            onMapCreated: (controller) => mapController = controller,
            cloudMapId: '8bd96dd605bed81d',
          ),

          /// 상단 헤더
          const SafeArea(child: MainTagsHeader()),

          /// 하단 드래그 시트
          DraggableScrollableSheet(
            initialChildSize: _sheetPosition,
            builder: (context, controller) {
              return GestureDetector(
                onVerticalDragUpdate: (details) =>
                    _updateSheetPosition(details.delta.dy),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F5FA),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7A618D).withOpacity(0.05),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: 52,
                        height: 5,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB8ACCB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const EventTab(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}