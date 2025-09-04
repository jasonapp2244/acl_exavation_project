import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDeleteTruckDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDeleteTruckDialog({
    Key? key,
    this.title = "Delete Registered Truck?",
    this.description =
        "Are you sure you want to delete this truck from your system? "
        "This action will remove the truck from your 'Manage Trucks' list.",
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top icon
            Container(
              width: 77,
              height: 77,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset('assets/icons/delete-03.svg'),
            ),
            const SizedBox(height: 15),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff111B19),
              ),
            ),

            const SizedBox(height: 10),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Yes button
                Expanded(
                  child: AuthButton(
                    buttonText: 'Yes',
                    loading: false,
                    onPress: onConfirm,
                  ),
                ),

                const SizedBox(width: 10),

                // Cancel button
                Expanded(
                  child: AuthButton(
                    buttonText: 'No',
                    loading: false,
                    onPress: onCancel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
