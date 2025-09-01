import 'package:flutter/material.dart';

class CustomSwipeButton extends StatefulWidget {
  const CustomSwipeButton({super.key});

  @override
  State<CustomSwipeButton> createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  double _dragValue = 0.0;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
        child: Stack(
          children: [
            // Background
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _dragValue * 320,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
            ),

            // Swipe thumb
            Positioned(
              top: 5,
              bottom: 5,
              right: _dragValue * 270,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (!_completed) {
                    setState(() {
                      _dragValue = (_dragValue - details.delta.dx / 320).clamp(
                        0.0,
                        1.0,
                      );

                      if (_dragValue >= 0.95) {
                        _completed = true;
                        Future.delayed(const Duration(milliseconds: 500), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Timed out successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                      }
                    });
                  }
                },
                onHorizontalDragEnd: (_) {
                  if (!_completed && _dragValue < 0.7) {
                    setState(() {
                      _dragValue = 0.0;
                    });
                  }
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0x3D4EEED0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back, // points left
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),

            // Text
            Positioned.fill(
              child: Center(
                child: Text(
                  'Swipe to Time Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
