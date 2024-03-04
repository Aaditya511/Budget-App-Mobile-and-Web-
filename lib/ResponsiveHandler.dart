import 'package:check_ur_budget/viewModel/ViewModel.dart';
import 'package:check_ur_budget/web/ExpenseViewWeb.dart';
import 'package:check_ur_budget/web/LoginViewWeb.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'mobile/ExpenseViewMobile.dart';
import 'mobile/LoginViewMobile.dart';

class ResponsiveHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final viewModelProvider = ref.watch(viewModel);
    // viewModelProvider.isLoggedIn();

    print("rebuild");
    final _authState = ref.watch(authStateProvider);
    return _authState.when(data: (data) {
      if (data != null) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return ExpenseViewWeb();
          } else
            return ExpenseViewMobile();
        });
      } else {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return LoginViewWeb();
          } else
            return LoginViewMobile();
        });
      }
    }, error: (e, trace) {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return LoginViewWeb();
        } else
          return LoginViewMobile();
      });
    }, loading: () {
      return LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return LoginViewWeb();
        } else
          return LoginViewMobile();
      });
    });
  }
}
