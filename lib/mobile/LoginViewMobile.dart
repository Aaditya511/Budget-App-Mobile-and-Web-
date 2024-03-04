import 'package:check_ur_budget/utils/Components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: deviceHeight / 5.5,
              ),
              Image.asset("assests/logo.png"),
              SizedBox(
                height: 30.0,
              ),
              EmailAndPasswordFeild(),
              SizedBox(
                height: 30.0,
              ),
              LoginAndRegister(),
              SizedBox(
                height: 30,
              ),
              GoogleSingInBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
