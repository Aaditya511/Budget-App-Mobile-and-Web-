import 'package:check_ur_budget/utils/Components.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../viewModel/ViewModel.dart';

bool isLoading = true;

class ExpenseViewMobile extends HookConsumerWidget {
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
            size: 20.0,
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
              height: 40.0,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  height: 240.0,
                  width: deviceWidth / 1.5,
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
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddExpenseAndIncomeBtn(
                  text: "Add Expense",
                  height: 40.0,
                  width: 155.0,
                  addExpense: true,
                ),
                SizedBox(
                  width: 10.0,
                ),
                AddExpenseAndIncomeBtn(
                  text: "Add Income",
                  height: 40.0,
                  width: 155.0,
                  addExpense: false,
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Expense List
                  Column(
                    children: [
                      OpenSans(text: "Expensese", size: 15.0),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        height: 210.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(width: 1.0, color: Colors.black),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.expense.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Popins(
                                  text: viewModelProvider.expense[index].name,
                                  size: 12.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Popins(
                                    text:
                                        viewModelProvider.expense[index].amount,
                                    size: 12.0,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  //Income List
                  Column(
                    children: [
                      OpenSans(text: "Income", size: 15.0),
                      Container(
                        padding: EdgeInsets.all(7.0),
                        height: 210.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(width: 1.0, color: Colors.black),
                        ),
                        child: ListView.builder(
                          itemCount: viewModelProvider.incomes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Popins(
                                  text: viewModelProvider.incomes[index].name,
                                  size: 12.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Popins(
                                    text: viewModelProvider.incomes[index].amount.toString(),
                                    size: 12.0,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                    ],
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
