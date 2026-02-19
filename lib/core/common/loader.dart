import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myblog/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: AppPallete.secondaryColor,
        size: 30,
       
      ),
    );
  }
}
