import 'package:check_ur_budget/viewModel/ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/Components.dart';

bool isLoading = true;

class ExpenseViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    double deviceWidth = MediaQuery.of(context).size.width;

    if (isLoading == true) {
      viewModelProvider.expensesStream();
      viewModelProvider.incomeStream();
      isLoading = false;
    }

    return SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white, size: 30.0),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Popins(
            text: "DashBoard",
            size: 30.0,
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  viewModelProvider.reset();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assests/login_image.png",
                  width: deviceWidth / 1.6,
                ),
                // add Income and expenses

                SizedBox(
                  height: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // add expense
                      AddExpenseAndIncomeBtn(
                        text: "Add Expense",
                        height: 45.0,
                        width: 160.0,
                        addExpense: true,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // add income
                      AddExpenseAndIncomeBtn(
                        text: "Add Income",
                        height: 45.0,
                        width: 160.0,
                        addExpense: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Container(
                  height: 300.0,
                  width: 280,
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Popins(text: "Budget Left", size: 14.0),
                          Popins(text: "Total Expense", size: 14.0),
                          Popins(text: "Total Income", size: 14.0),
                        ],
                      ),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Divider(
                          color: Colors.grey,
                          indent: 40.0,
                          endIndent: 40.0,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Popins(
                              text: viewModelProvider.budgetLeft.toString(),
                              size: 14.0),
                          Popins(
                              text: viewModelProvider.totalExpense.toString(),
                              size: 14.0),
                          Popins(
                              text: viewModelProvider.totalIncome.toString(),
                              size: 14.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              indent: deviceWidth / 4,
              endIndent: deviceWidth / 4,
              thickness: 3.0,
            ),
            SizedBox(
              height: 50,
            ),
            // Expanses and income list
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Expense List
                Container(
                  padding: EdgeInsets.all(7.0),
                  height: 320.0,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.black,
                    border: Border.all(width: 1.0, color: Colors.black),
                  ),
                  child: Column(
                    // expense heading
                    children: [
                      Center(
                        child: Popins(
                          text: "Expenses",
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            border:
                                Border.all(width: 1.0, color: Colors.white)),
                        child: ListView.builder(
                          itemCount: viewModelProvider.expense.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Popins(
                                  text: viewModelProvider.expense[index].name,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Popins(
                                    text:
                                        viewModelProvider.expense[index].amount,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //Income List
                Container(
                  padding: EdgeInsets.all(7.0),
                  height: 320.0,
                  width: 240.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.black,
                    border: Border.all(width: 1.0, color: Colors.black),
                  ),
                  child: Column(
                    // expense heading
                    children: [
                      Center(
                        child: Popins(
                          text: "Income",
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        indent: 30.0,
                        endIndent: 30.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        height: 210,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            border:
                                Border.all(width: 1.0, color: Colors.white)),
                        child: ListView.builder(
                          itemCount: viewModelProvider.incomes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Popins(
                                  text: viewModelProvider.incomes[index].name,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Popins(
                                    text: viewModelProvider.incomes[index].amount,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
