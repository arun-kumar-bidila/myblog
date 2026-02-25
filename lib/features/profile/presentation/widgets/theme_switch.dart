import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myblog/common/theme/theme_cubit.dart';

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
            children:  [
              Icon(Icons.dark_mode, size: 30),
              SizedBox(width: 20),
              Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.titleMedium
              ),
            ],
          ),
          Switch(
            value: context.watch<ThemeCubit>().state == ThemeMode.dark,
            onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
    );
  }
}
