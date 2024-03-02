import 'package:check_ur_budget/utils/Components.dart';
import 'package:check_ur_budget/viewModel/ViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class LoginViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailField = useTextEditingController();
    TextEditingController _passwordField = useTextEditingController();
    final viewModelProider = ref.watch(viewModel);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment:CrossAxisAlignment.center ,
          children: [
            Image.asset("assests/login_image.png",width: deviceWidth/2.6,),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: deviceHeight/5.5,),
                  Image.asset("assests/logo.png",fit: BoxFit.contain,width: 200,),
                  SizedBox(height: 40.0,),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      controller: _emailField,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                        ),
                        prefixIcon: Icon(Icons.email,size: 30,color: Colors.black,),
                        hintText: "Email",
                        hintStyle: GoogleFonts.openSans()
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: viewModelProider.isObseure,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      controller: _passwordField,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          ),
                          prefixIcon:IconButton(onPressed: () {
                            viewModelProider.toggleObseure();
                          }, icon: Icon(viewModelProider.isObseure ? Icons.visibility:Icons.visibility_off),) ,
                          hintText: "Password",
                          hintStyle: GoogleFonts.openSans()
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: 150.0,
                        child:MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          splashColor: Colors.grey,
                          color: Colors.black,
                          onPressed: () async {
                            await viewModelProider.createUserWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                          },
                          child: OpenSans(text: "Register",size: 25.0,color: Colors.white,),
                        ) ,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child:
                        Text("or",style: GoogleFonts.pacifico(color:Colors.black,fontSize:20),),
                      ),
                      SizedBox(
                        height: 50.0,
                        width: 150.0,
                        child:MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          splashColor: Colors.grey,
                          color: Colors.black,
                          onPressed: () async {
                            await viewModelProider.signInWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                          },
                          child: OpenSans(text: "Login",size: 25.0,color: Colors.white,),
                        ) ,),

                    ],
                  ),
                  SizedBox(height: 40.0,),
                  SignInButton(
                      buttonType: ButtonType.google,
                      btnColor: Colors.black,
                      btnTextColor:Colors.white ,
                      buttonSize: ButtonSize.large,
                      onPressed: () async{
                        if(kIsWeb){
                          await viewModelProider.singInWithGoogleWeb(context);
                        }else{
                          await viewModelProider.signInWithGoogleMobile(context);
                        }
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
