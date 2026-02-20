import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class EditInfoButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const EditInfoButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppPallete.whiteColor, size: 30),
                SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                    color: AppPallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppPallete.whiteColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
