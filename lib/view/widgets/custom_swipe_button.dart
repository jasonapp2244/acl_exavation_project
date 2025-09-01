import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomSwipeButton extends StatefulWidget {
  final VoidCallback? onSwipeComplete;
  final String buttonText;
  final Color backgroundColor;
  final Color fillColor;
  final Color thumbColor;

  const CustomSwipeButton({
    super.key,
    this.onSwipeComplete,
    this.buttonText = "Swipe to Time Out",
    this.backgroundColor = const Color(0xFF4EEED0),
    this.fillColor = Colors.white,
    this.thumbColor = const Color(0x3D4EEED0),
  });

  @override
  State<CustomSwipeButton> createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  double _dragValue = 0.0; // 0.0 → 1.0
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    final double buttonWidth =
        MediaQuery.of(context).size.width - 32; // padding
    final double thumbWidth = 50;

    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: widget.backgroundColor.withOpacity(0.24),
        ),
        child: Stack(
          children: [
            // Animated white background fill
            Align(
              alignment: Alignment.centerRight, // fill from right → left
              child: FractionallySizedBox(
                widthFactor: _dragValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.fillColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
              ),
            ),

            // Swipe thumb
            Positioned(
              top: 5,
              bottom: 5,
              right: _dragValue * (buttonWidth - thumbWidth),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (!_completed) {
                    setState(() {
                      _dragValue = (_dragValue - details.delta.dx / buttonWidth)
                          .clamp(0.0, 1.0); // reverse for right → left

                      if (_dragValue >= 0.95) {
                        _completed = true;
                        widget.onSwipeComplete?.call();

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
                  if (!_completed && _dragValue < 0.95) {
                    setState(() {
                      _dragValue = 0.0; // reset if not completed
                    });
                  }
                },
                child: Container(
                  width: thumbWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: widget.thumbColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back, // right → left
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),

            // Center text
            Positioned.fill(
              child: Center(
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(
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
