import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../viewModel/ViewModel.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;

  const OpenSans(
      {super.key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.openSans(
          fontSize: size,
          color: color == null ? Colors.black : color,
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight),
    );
  }
}

DialogBox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            contentPadding: EdgeInsets.all(32.0),
            actionsAlignment: MainAxisAlignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(width: 2.0, color: Colors.black),
            ),
            title: OpenSans(
              text: title,
              size: 20.0,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
                child: OpenSans(
                  text: "Ok",
                  size: 20.0,
                  color: Colors.white,
                ),
              )
            ],
          ));
}

class Popins extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;

  const Popins(
      {super.key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: GoogleFonts.poppins(
          fontSize: size,
          color: color == null ? Colors.white : color,
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight),
    );
  }
}

class TextForm extends StatelessWidget {
  final text;
  final containerWidth;
  final hintText;
  final controler;
  final digitOnly;
  final validator;

  const TextForm(
      {super.key,
      this.text,
      this.containerWidth,
      this.hintText,
      this.controler,
      this.digitOnly,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OpenSans(text: text, size: 14.0),
        SizedBox(
          height: 5.0,
        ),
        SizedBox(
          width: containerWidth,
          child: TextFormField(
            validator: validator,
            inputFormatters: digitOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            controller: controler,
            decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                hintStyle: GoogleFonts.poppins(fontSize: 14.0),
                hintText: hintText),
          ),
        )
      ],
    );
  }
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();

class EmailAndPasswordFeild extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProider = ref.watch(viewModel);
    return Column(
      children: [
        SizedBox(
          width: 350,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: _emailField,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              prefixIcon: Icon(
                Icons.email,
                size: 30.0,
                color: Colors.black,
              ),
              hintText: "Email",
              hintStyle: GoogleFonts.openSans(),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: 350,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: _passwordField,
            obscureText: viewModelProider.isObseure,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              prefixIcon: IconButton(
                onPressed: () {
                  viewModelProider.toggleObseure();
                },
                icon: Icon(
                  viewModelProider.isObseure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              hintText: "Password",
              hintStyle: GoogleFonts.openSans(),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginAndRegister extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Register Btn
        SizedBox(
          height: 50.0,
          width: 150,
          child: MaterialButton(
            onPressed: () async {
              await viewModelProvider.createUserWithEmailAndPassword(
                  context, _emailField.text, _passwordField.text);
            },
            splashColor: Colors.grey,
            child: OpenSans(
              text: "Register",
              color: Colors.white,
              size: 25.0,
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "or",
            style: GoogleFonts.pacifico(color: Colors.black, fontSize: 15),
          ),
        ),
        // Login Btn
        SizedBox(
          height: 50.0,
          width: 150,
          child: MaterialButton(
            onPressed: () async {
              await viewModelProvider.signInWithEmailAndPassword(
                  context, _emailField.text, _passwordField.text);
            },
            splashColor: Colors.grey,
            child: OpenSans(
              text: "Login",
              color: Colors.white,
              size: 25.0,
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GoogleSingInBtn extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);

    return SignInButton(
        buttonType: ButtonType.google,
        btnColor: Colors.black,
        btnTextColor: Colors.white,
        buttonSize: ButtonSize.large,
        onPressed: () async {
          if (kIsWeb) {
            await viewModelProvider.singInWithGoogleWeb(context);
          } else {
            await viewModelProvider.signInWithGoogleMobile(context);
          }
        });
  }
}

class SideDrawer extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerHeader(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  )),
              child: CircleAvatar(
                radius: 180.0,
                backgroundColor: Colors.white,
                child: Image(
                  height: 100,
                  image: AssetImage("assests/logo.png"),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            height: 50.0,
            minWidth: 200.0,
            color: Colors.black,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () async {
              await viewModelProvider.logout();
            },
            child: OpenSans(
              text: "Logout",
              size: 20.0,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class AddExpenseAndIncomeBtn extends HookConsumerWidget {
  final String text;
  final double height;

  final double width;

  final bool addExpense;

  AddExpenseAndIncomeBtn({
    required this.text,
    required this.height,
    required this.width,
    required this.addExpense,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);

    return SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () async {
          if (addExpense) {
            await viewModelProvider.addExpense(context);
          } else {
            viewModelProvider.addIncome(context);
          }
        },
        splashColor: Colors.grey,
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            OpenSans(
              text: text,
              size: 17.0,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
