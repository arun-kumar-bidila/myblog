import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myblog/common/theme/app_pallete.dart';

class EditInfo extends StatelessWidget {
  const EditInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
           
          ),
        ),
        title: Text(
          "Edit Personal Info",
           style: Theme.of(context).textTheme.titleMedium
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            "Currently we are not allowing our users to edit their info , it will be available soon",
            style: TextStyle(fontSize: 16, color: AppPallete.greyColor),textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
