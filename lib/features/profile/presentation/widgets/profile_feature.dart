import 'package:flutter/material.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class ProfileFeature extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ProfileFeature({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 20),
          Expanded(
            child: Column(
               mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium
                ),
                SizedBox(height: 10),
                Container(height: 1, color: AppPallete.greyColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
