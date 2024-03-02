import 'package:check_ur_budget/utils/Components.dart';
import 'package:check_ur_budget/viewModel/ViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailField = useTextEditingController();
    TextEditingController _passwordField = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
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
                  obscureText: viewModelProvider.isObseure,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {
                        viewModelProvider.toggleObseure();
                      },
                      icon: Icon(
                        viewModelProvider.isObseure
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
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Register Btn
                  SizedBox(
                    height: 50.0,
                    width: 150,
                    child: MaterialButton(
                      onPressed: () async{
                        await viewModelProvider.createUserWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                      },
                      splashColor: Colors.grey,
                      child: OpenSans(
                        text: "Register",
                        color: Colors.white,
                        size: 25.0,
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                    Text("or",style: GoogleFonts.pacifico(color:Colors.black,fontSize:15),),
                  ),
                  // Login Btn
                  SizedBox(
                    height: 50.0,
                    width: 150,
                    child: MaterialButton(
                      onPressed: () async{
                        await viewModelProvider.signInWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                      },
                      splashColor: Colors.grey,
                      child: OpenSans(
                        text: "Login",
                        color: Colors.white,
                        size: 25.0,
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0),),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SignInButton(
                  buttonType: ButtonType.google,
                  btnColor: Colors.black,
                  btnTextColor:Colors.white ,
                  buttonSize: ButtonSize.medium, // small(default), medium, large
                  onPressed: () async {
                    if(kIsWeb){
                    await viewModelProvider.singInWithGoogleWeb(context);
                    }else{
                      await viewModelProvider.signInWithGoogleMobile(context);
                    }

                  })
            ],
          ),
        ),
      ),
    );
  }
}
