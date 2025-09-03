import 'package:acl/viewmodel/truck_driver_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CustomSwipeButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onSubmit;
  final Color innerColor;
  final Color outerColor;
  final Color sliderIconColor;
  String? id;

  CustomSwipeButton({
    Key? key,
    this.id,
    required this.buttonText,
    required this.onSubmit,
    this.innerColor = Colors.black,
    this.outerColor = Colors.white,
    this.sliderIconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SlideActionState> _key = GlobalKey();
    final truckProvider = Provider.of<TruckEntryViewModel>(
      context,
      listen: false,
    );

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SlideAction(
        key: _key,
        height: 50, // ✅ make it slimmer (default ~70, now half)
        text: buttonText,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        innerColor: innerColor,
        outerColor: outerColor,
        sliderButtonIcon: Icon(
          Icons.arrow_forward,
          size: 20, // ✅ smaller icon to match reduced height
          color: Colors.black,
        ),
        onSubmit: () {
          if (buttonText == 'Swipe to Time In') {
            truckProvider.recordTimeIn(id ?? '');
          } else {
            truckProvider.recordTimeOut(id ?? '');
          }

          onSubmit();
          Future.delayed(
            const Duration(seconds: 1),
            () => _key.currentState?.reset(),
          );
        },
      ),
    );
  }
}
