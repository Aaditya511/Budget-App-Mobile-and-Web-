import 'package:check_ur_budget/utils/Components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assests/login_image.png",
              width: deviceWidth / 2.6,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight / 5.5,
                  ),
                  Image.asset(
                    "assests/logo.png",
                    fit: BoxFit.contain,
                    width: 200,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  EmailAndPasswordFeild(),
                  SizedBox(
                    height: 40.0,
                  ),
                  LoginAndRegister(),
                  SizedBox(
                    height: 40.0,
                  ),
                  GoogleSingInBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
