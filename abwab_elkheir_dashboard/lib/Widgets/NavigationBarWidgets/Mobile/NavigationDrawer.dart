import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/CasesViewModel.dart';
import 'package:flutter/material.dart';

import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerHeader.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';

import 'package:arabic_numbers/arabic_numbers.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  DateTimeRange dateTimeRange;
  ArabicNumbers arabicNumber = ArabicNumbers();
  CasesViewModel casesViewModel;
  AuthenticationViewModel auth;
  final _statusFocusNode = FocusNode();

  @override
  void initState() {
    casesViewModel = Provider.of<CasesViewModel>(context, listen: false);
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _statusFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 20,
      child: Container(
        width: 240,
        height: deviceSize.height,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.white30,
            blurRadius: 16,
          )
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NavigationDrawerHeader(),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  alignment: Alignment.topRight,
                  child: Text('البداية:'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.topRight,
                  child: Text(
                    dateTimeRange == null
                        ? 'N/A'
                        : arabicNumber.convert(
                            dateTimeRange.start.day.toString() +
                                ' - ' +
                                dateTimeRange.start.month.toString() +
                                ' - ' +
                                dateTimeRange.start.year.toString()),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  alignment: Alignment.topRight,
                  child: Text('النهاية:'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.topRight,
                  child: Text(
                    dateTimeRange == null
                        ? 'N/A'
                        : arabicNumber.convert(
                            dateTimeRange.end.day.toString() +
                                ' - ' +
                                dateTimeRange.end.month.toString() +
                                ' - ' +
                                dateTimeRange.end.year.toString()),
                  ),
                )
              ],
            ),
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: ConstantColors.lightBlue,
              ),
              child: Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: TextButton(
                    child: Text(
                      'اختر الفترة  الزمنية',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue),
                    ),
                    onPressed: () async {
                      dateTimeRange = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(
                          2020,
                        ),
                        lastDate: DateTime.now(),
                        currentDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.calendar,
                        locale: Locale('ar'),
                        useRootNavigator: true,
                        textDirection: TextDirection.ltr,
                      );

                      setState(() {
                        casesViewModel
                            .setStartDate(dateTimeRange.start.toString());
                        casesViewModel.setEndDate(dateTimeRange.end.toString());
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.topRight,
              child: Text('الحالة:'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: 200,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onTap: () {
                      FocusScope.of(context).requestFocus(_statusFocusNode);
                    },
                    isExpanded: true,
                    elevation: 10,
                    hint: Text(" درجة الحالة"),
                    value: casesViewModel.getCasesStatus,
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        value: "فى البداية",
                        child: Text("فى البداية"),
                      ),
                      DropdownMenuItem(
                        value: "قارب على الانتهاء ",
                        child: Text("قارب على الانتهاء"),
                      ),
                      DropdownMenuItem(
                        value: "جاري التجميع ",
                        child: Text("جاري التجميع"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        casesViewModel.setStatus(value);
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                child: Text('بحث'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ConstantColors.lightBlue)),
                onPressed: () {
                  casesViewModel.fetchCases(context, auth.accessToken);
                },
              ),
              color: ConstantColors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
