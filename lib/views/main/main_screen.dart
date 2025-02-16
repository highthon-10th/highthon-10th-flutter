import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highthon_10th/provider/event_provider.dart';
import 'package:highthon_10th/provider/visit_provider.dart';
import 'package:highthon_10th/views/main/providers/tags_header_type_provider.dart';
import 'package:highthon_10th/views/main/widgets/header/main_tags_header.dart';
import 'package:highthon_10th/views/main/widgets/tab/event/event_tab.dart';
import 'package:highthon_10th/views/main/widgets/tab/visit/visit_tab.dart';

GoogleMapController? googleMapController;
DraggableScrollableController? draggableScrollableController;

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
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
        "id": "67b0a19e267320d6d20379f4",
        "name": "물나무 사진관",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a19e267320d6d20379f4.jpg",
        "latitude": 37.578285212319,
        "longitude": 126.970646659393,
        "description": "아이유가 좋아하는 흑백 사진관",
        "place_type": "etc",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/Mulnamoo+Photo+Studio+(물나무+사진관)+서울특별시+종로구+자하문로5가길+19/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca32b02013987:0xddc08cd7ca074ac9!2m2!1d126.970676!2d37.578285?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:15:58.879000"
      },
      {
        "id": "67b0a22a267320d6d20379f5",
        "name": "대오서점",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a22a267320d6d20379f5.jpg",
        "latitude": 37.5797361073093,
        "longitude": 126.969324927835,
        "description": "아이유 꽃갈피 앨범자켓 촬영지",
        "place_type": "etc",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/서울특별시+종로구+자하문로7길+대오서점/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca2bdeec9d0eb:0xae22fd1a4899a3e8!2m2!1d126.9693256!2d37.5797341?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:18:18.577000"
      },
      {
        "id": "67b0a334267320d6d20379f6",
        "name": "텍사스 돈까스",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a334267320d6d20379f6.jpg",
        "latitude": 37.5103155508239,
        "longitude": 127.027023994828,
        "description": "아이유가 인정한 텍사스씩 돈까스 식당",
        "place_type": "food",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/서울특별시+강남구+학동로20길+택사스돈까스/data=!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca3004a7e28e3:0x9c44512be16dc6a4!2m2!1d127.027003!2d37.5103172?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:22:44.153000"
      },
      {
        "id": "67b0a48e267320d6d20379f7",
        "name": "여의도따로국밥",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a48e267320d6d20379f7.jpg",
        "latitude": 37.521398852831,
        "longitude": 126.930233423328,
        "description": "아이유가 탄핵 시위하는 팬들을 위해 결제했던 국밥집",
        "place_type": "food",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/서울특별시+영등포구+여의대방로69길+여의도따로국밥/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357c9f3fa970294d:0x3b270615ba913237!2m2!1d126.9301731!2d37.5213871?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:28:30.061000"
      },
      {
        "id": "67b0a52c267320d6d20379f8",
        "name": "반포 한강공원",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a52c267320d6d20379f8.jpg",
        "latitude": 37.5076939718271,
        "longitude": 126.992730984132,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "park",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/반포한강공원+서울특별시+서초구+신반포로11길+40/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357b4515dd278e39:0xedac66f15585f616!2m2!1d126.9959627!2d37.5106226?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:31:08.683000"
      },
      {
        "id": "67b0a80b267320d6d20379f9",
        "name": "동아디지털미디어센터",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a80b267320d6d20379f9.jpg",
        "latitude": 37.5784544591109,
        "longitude": 126.892916405925,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "etc",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/동아디지털미디어센터+서울특별시+마포구+상암동+1610/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357c99ac04b0c71f:0xd84f75f9e1c69ffd!2m2!1d126.8934147!2d37.5790909?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:43:23.567000"
      },
      {
        "id": "67b0a8d8267320d6d20379fa",
        "name": "구룡근린공원",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a8d8267320d6d20379fa.jpg",
        "latitude": 37.5827886325892,
        "longitude": 126.883716034113,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "park",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/구룡근린공원+서울특별시+마포구+월드컵북로+456/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357c993bf16c94db:0x1ccd84be9c4fe1f7!2m2!1d126.8837267!2d37.5828837?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:46:48.427000"
      },
      {
        "id": "67b0a9b8267320d6d20379fb",
        "name": "혜민당",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0a9b8267320d6d20379fb.jpg",
        "latitude": 37.5664782494879,
        "longitude": 126.988611270403,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "cafe",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/서울특별시+중구+삼일대로12길+혜민당/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca2e5cdd6a179:0xb40241d87be62a4e!2m2!1d126.9885944!2d37.5664953?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:50:32.263000"
      },
      {
        "id": "67b0aaa7267320d6d20379fc",
        "name": "이음 더 플레이스",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0aaa7267320d6d20379fc.jpg",
        "latitude": 37.5819295224925,
        "longitude": 126.982235453701,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "etc",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/이음+더+플레이스+서울특별시+종로구+북촌로5나길+30/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca330a41ffa4b:0xb9f26fcfb87b2115!2m2!1d126.9822309!2d37.5819301?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:54:31.676000"
      },
      {
        "id": "67b0ab00267320d6d20379fd",
        "name": "카페 뜨락",
        "favorite_member": "아이유",
        "photo_url":
            "http://167.71.249.204/static/아이유/visits/67b0ab00267320d6d20379fd.jpg",
        "latitude": 37.5645541852439,
        "longitude": 126.975613605737,
        "description": "호텔 델루나 촬영 중 방문",
        "place_type": "cafe",
        "directions_link":
            "https://www.google.co.kr/maps/dir/서울특별시+마포구+마포대로+FRONT1/카페+뜨락+서울특별시+중구+덕수궁길+15/data=!3m1!4b1!4m13!4m12!1m5!1m1!1s0x357c99de9a60a81f:0x9c1d1d27cd41be06!2m2!1d126.9525219!2d37.5453203!1m5!1m1!1s0x357ca28cc7155ee7:0xb706af412714b2bf!2m2!1d126.9744987!2d37.5639639?hl=ko&entry=ttu&g_ep=EgoyMDI1MDIxMi4wIKXMDSoASAFQAw%3D%3D",
        "created_at": "2025-02-15T14:56:00.956000"
      },
      {
        "id": "67b0be8825f4a39516a0ed8e",
        "favorite_member": "아이유",
        "latitude": 37.554748653019,
        "longitude": 126.926233053738,
        "photo_url":
            "http://167.71.249.204/static/아이유/events/67b0be8825f4a39516a0ed8e.jpg",
        "event_name": "아이유 생일카페",
        "event_time": "2025.05.06 ~ 2025.05.08",
        "event_link": "https://s.blip.kr/c/7a176370",
        "user_name": "string",
        "description": "홍대 공이도시 카페에서 아이유의 생일카페합니다.",
        "created_at": "2025-02-15T16:19:20.933000"
      },
      {
        "id": "67b0c0e925f4a39516a0ed8f",
        "favorite_member": "아이유",
        "latitude": 37.5564943733388,
        "longitude": 126.922631917858,
        "photo_url":
            "http://167.71.249.204/static/아이유/events/67b0c0e925f4a39516a0ed8f.jpg",
        "event_name": "아이유 포토 프레임 론칭 이벤트",
        "event_time": "2025.01.24 ~ 2025.01.25",
        "event_link": "https://m.blog.naver.com/dltpdud03/223740307188",
        "user_name": "string",
        "description": "CGV 홍대에서 <아이유 콘서트 : 더 위닝> 당일 관람 인증 고객 한정 포토카드 증정",
        "created_at": "2025-02-15T16:29:29.549000"
      },
      {
        "id": "67b0c540d2dba82cd6d53d29",
        "favorite_member": "아이유",
        "latitude": 37.5038976731769,
        "longitude": 127.026711121177,
        "photo_url":
            "http://167.71.249.204/static/아이유/events/67b0c540d2dba82cd6d53d29.jpg",
        "event_name": "아이유 데뷔 14주년 기념 이벤트",
        "event_time": "2025.01.24 ~ 2025.01.25",
        "event_link": "https://m.blog.naver.com/o__dda/222893895279",
        "user_name": "string",
        "description":
            "아이유 데뷔 14주년 기념으로 아이유가 쏜다! 카페에서 음료수를 마시면 스티커, 포토카드, 포스터 증정 ",
        "created_at": "2025-02-15T16:48:00.123000"
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(visitProvider.notifier).loadVisits();
      ref.read(eventProvider.notifier).loadEvents();
    });
    createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(tagsHeaderTypeProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// 구글 맵
            GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.545283, 126.952611),
                zoom: 15,
              ),
              markers: markers,
              onMapCreated: (controller) =>
                  googleMapController = controller,
              cloudMapId: '8bd96dd605bed81d',
            ),

            /// 상단 헤더
            const SafeArea(child: MainTagsHeader()),

            /// 하단 드래그 시트
            DraggableScrollableSheet(
              controller: draggableScrollableController,
              initialChildSize: _sheetPosition,
              minChildSize: 0.25,
              maxChildSize: 0.93,
              builder: (context, controller) {
                return GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    setState(() {
                      _sheetPosition -= details.delta.dy / _dragSensitivity;
                      if (_sheetPosition < 0.25) {
                        _sheetPosition = 0.25;
                      }
                      if (_sheetPosition > 0.93) {
                        _sheetPosition = 0.93;
                      }
                    });
                  },
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F5FA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF7A618D).withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: 52,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Color(0xFFB8ACCB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          switch (type) {
                            TagsHeaderType.pick => VisitTab(),
                            TagsHeaderType.event => EventTab(),
                          },
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
