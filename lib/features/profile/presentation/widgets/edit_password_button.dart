import 'package:flutter/material.dart';


class EditInfoPasswordButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const EditInfoPasswordButton({
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
                Icon(icon, size: 30),
                SizedBox(width: 20),
                Text(
                  label,
                   style: Theme.of(context).textTheme.titleMedium
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
             
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
