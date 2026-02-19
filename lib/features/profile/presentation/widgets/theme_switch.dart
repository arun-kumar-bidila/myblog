import 'package:flutter/material.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.dark_mode, color: AppPallete.whiteColor, size: 30),
              SizedBox(width: 20),
              Text(
                "Dark Mode",
                style: TextStyle(
                  color: AppPallete.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Switch(
            value: false,
            onChanged: (value) {
              value = true;
            },
          ),
        ],
      ),
    );
  }
}
