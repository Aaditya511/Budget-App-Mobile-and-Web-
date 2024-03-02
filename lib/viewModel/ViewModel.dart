import 'package:check_ur_budget/utils/Components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool isSignedIn = false;
  bool isObseure = true;
  CollectionReference userCollection = FirebaseFirestore.instance.collection("users");


  List expensesName = [];
  List expensesAmount = [];
  List incomeName = [];
  List incomeAmount = [];

  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    });
    notifyListeners();
  }

  toggleObseure() {
    isObseure = !isObseure;
    notifyListeners();
  }

  _print(String data) {
    print(data);
  }


  //Auth
  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => _print("Success"))
        .onError((error, stackTrace) {
      _print(error.toString());
      DialogBox(context, error.toString());
    });
  }

  Future<void> signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => _print("Success"))
        .onError((error, stackTrace) {
      _print(error.toString());
      DialogBox(context, error.toString());
    });
  }

  Future<void> singInWithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth
        .signInWithPopup(googleAuthProvider)
        .onError((error, stackTrace) => DialogBox(context, error.toString()));
  }

  Future<void> signInWithGoogleMobile(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn()
        .signIn()
        .onError((error, stackTrace) => DialogBox(context, error.toString()));
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    await _auth
        .signInWithCredential(credential)
        .then((value) => _print("Success"))
        .onError((error, stackTrace) => _print("error"));
  }

  Future<void> logout() async{
    await _auth.signOut();
    notifyListeners();
  }

  //db
  Future<void> addExpense(BuildContext context) async{
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(context: context, builder:
    (BuildContext context) =>AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           TextForm(text:"Name" ,containerWidth:130.0 ,hintText:"Name" ,controler: controllerName ,validator:(text){
             if(text.toString().isEmpty){
               return "Required";
             }
           } ),
            SizedBox(width: 10.0,),
            TextForm(text:"Amount" ,containerWidth:100.0 ,hintText:"Amount" ,controler: controllerAmount ,validator:(text){
              if(text.toString().isEmpty){
                return "Required";
              }
            },),

          ],
        ),
      ),
      actions: [
        MaterialButton(onPressed: () async{
          if(formKey.currentState!.validate()){
          await  userCollection.doc(_auth.currentUser!.uid).collection("Expenses").
            add({
              "name":controllerName.text,
              "amount":controllerAmount.text
            }).onError((error, stackTrace) {
              _print(error.toString());
              return  DialogBox(context, error.toString());
            });
            Navigator.pop(context);
          }
        },
        child: OpenSans(text: "Save", size: 15.0,color: Colors.white,),
        splashColor: Colors.grey,
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),)
      ],
    ),);

  }

  Future<void> addIncome(BuildContext context) async{
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(context: context, builder:
        (BuildContext context) =>AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextForm(text:"Name" ,containerWidth:130.0 ,hintText:"Name" ,controler: controllerName ,validator:(text){
              if(text.toString().isEmpty){
                return "Required";
              }
            } ),
            SizedBox(width: 10.0,),
            TextForm(text:"Amount" ,containerWidth:100.0 ,hintText:"Amount" ,controler: controllerAmount ,validator:(text){
              if(text.toString().isEmpty){
                return "Required";
              }
            },),

          ],
        ),
      ),
      actions: [
        MaterialButton(onPressed: () async{
          if(formKey.currentState!.validate()){
            await  userCollection.doc(_auth.currentUser!.uid).collection("Income").
            add({
              "name":controllerName.text,
              "amount":controllerAmount.text
            }).onError((error, stackTrace) {
              _print(error.toString());
              return  DialogBox(context, error.toString());
            });
            Navigator.pop(context);
          }
        },
          child: OpenSans(text: "Save", size: 15.0,color: Colors.white,),
          splashColor: Colors.grey,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),)
      ],
    ),);

  }

  void expensesStream() async{
    await for(var snapShot in userCollection.doc(_auth.currentUser!.uid).collection("Expenses").snapshots()){
      expensesAmount = [];
      expensesName = [];
      for(var expenses in snapShot.docs){
        expensesName.add(expenses.data()["name"]);
        expensesAmount.add(expenses.data()["amount"]);
        notifyListeners();
      }

    }
  }

  void incomeStream() async{
    await for(var snapShot in userCollection.doc(_auth.currentUser!.uid).collection("Income").snapshots()){
      incomeName = [];
      incomeAmount = [];
      for(var expenses in snapShot.docs){
        incomeName.add(expenses.data()["name"]);
        incomeAmount.add(expenses.data()["amount"]);
        notifyListeners();
      }

    }
  }

  Future<void> reset() async {
    await userCollection.doc(_auth.currentUser!.uid).collection("Expenses").get().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    } );

    await userCollection.doc(_auth.currentUser!.uid).collection("Income").get().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    } );

  }


}
