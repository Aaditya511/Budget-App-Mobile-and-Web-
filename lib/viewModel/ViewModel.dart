import 'package:check_ur_budget/models/models.dart';
import 'package:check_ur_budget/utils/Components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/Constansts.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(viewModel).authStatechange;
});

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  // bool isSignedIn = false;
  bool isObseure = true;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  List<Models> expense = [];
  List<Models> incomes = [];

  int totalExpense = 0;
  int totalIncome = 0;
  int budgetLeft = 0;

/*
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
*/

  Stream<User?> get authStatechange => _auth.authStateChanges();

  toggleObseure() {
    isObseure = !isObseure;
    notifyListeners();
  }

  _print( data) {
    print(data.toString());
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

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  //db
  Future<void> addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
              TextForm(
                text: "Name",
                containerWidth: 130.0,
                hintText: "Name",
                controler: controllerName,
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return "Required";
                  }
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              TextForm(
                text: "Amount",
                containerWidth: 100.0,
                hintText: "Amount",
                controler: controllerAmount,
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return "Required";
                  }
                },
                digitOnly: true,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await userCollection
                    .doc(_auth.currentUser!.uid)
                    .collection(Constants.EXPESES_COLLECTION)
                    .add({
                  "name": controllerName.text,
                  "amount": controllerAmount.text,
                }).onError((error, stackTrace) {
                  _print(error.toString());
                  return DialogBox(context, error.toString());
                });
                Navigator.pop(context);
              }
            },
            child: OpenSans(
              text: "Save",
              size: 15.0,
              color: Colors.white,
            ),
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          )
        ],
      ),
    );
  }

  Future<void> addIncome(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
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
              TextForm(
                text: "Name",
                containerWidth: 130.0,
                hintText: "Name",
                controler: controllerName,
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return "Required";
                  }
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              TextForm(
                text: "Amount",
                containerWidth: 100.0,
                hintText: "Amount",
                controler: controllerAmount,
                validator: (text) {
                  if (text.toString().isEmpty) {
                    return "Required";
                  }
                },
                digitOnly: true,
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await userCollection
                    .doc(_auth.currentUser!.uid)
                    .collection(Constants.INCOME_COLLECTION)
                    .add({
                  "name": controllerName.text,
                  "amount": controllerAmount.text,
                }).onError((error, stackTrace) {
                  _print(error.toString());
                  return DialogBox(context, error.toString());
                });
                Navigator.pop(context);
              }
            },
            child: OpenSans(
              text: "Save",
              size: 15.0,
              color: Colors.white,
            ),
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          )
        ],
      ),
    );
  }

  void expensesStream() async {
    await for (var snapShot in userCollection
        .doc(_auth.currentUser!.uid)
        .collection(Constants.EXPESES_COLLECTION)
        .snapshots()) {
      expense = [];
      snapShot.docs.forEach((element) {
        expense.add(Models.fromJson(element.data()));
      });

      /* expensesAmount = [];
      expensesName = [];
      for (var expenses in snapShot.docs) {
        expensesName.add(expenses.data()["name"]);
        expensesAmount.add(expenses.data()["amount"]);
        notifyListeners();
      }*/
      notifyListeners();
      calculate();
    }
  }

  void incomeStream() async {
    await for (var snapShot in userCollection
        .doc(_auth.currentUser!.uid)
        .collection(Constants.INCOME_COLLECTION)
        .snapshots()) {
      incomes = [];
      snapShot.docs.forEach((element) {
        incomes.add(Models.fromJson(element.data()));
      });


      /* incomeName = [];
      incomeAmount = [];
      for (var expenses in snapShot.docs) {
        incomeName.add(expenses.data()["name"]);
        incomeAmount.add(expenses.data()["amount"]);
        notifyListeners();
      }*/
      notifyListeners();
      calculate();
    }
  }

  Future<void> reset() async {
    await userCollection
        .doc(_auth.currentUser!.uid)
        .collection(Constants.EXPESES_COLLECTION)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    await userCollection
        .doc(_auth.currentUser!.uid)
        .collection(Constants.INCOME_COLLECTION)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    notifyListeners();
  }

  void calculate() {
    totalExpense = 0;
    totalIncome = 0;
    for (int i = 0; i < expense.length; i++) {
      totalExpense = totalExpense + int.parse(expense[i].amount);
    }
    for (int i = 0; i < incomes.length; i++) {
      totalIncome = totalIncome + int.parse(incomes[i].amount);
    }
    budgetLeft = totalIncome - totalExpense;
    notifyListeners();
  }
}
