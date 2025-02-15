import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            MainTagsHeader(),
            DraggableScrollableSheet(
              initialChildSize: _sheetPosition,
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
                      children: [
                        const SizedBox(height: 10),
                        Container(
                          width: 52,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFFB8ACCB),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 16),
                        EventTab(),
                      ],
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
