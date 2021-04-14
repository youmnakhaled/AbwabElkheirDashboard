import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerHeader.dart';
import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerItem.dart';
import 'package:flutter/material.dart';

import '../../../Constants/ConstantColors.dart';
import '../../../Constants/ConstantColors.dart';
import '../../../Constants/ConstantColors.dart';
import '../../TextFieldWidget.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  DateTimeRange dateTimeRange;
  TextEditingController dateRangeController = TextEditingController();

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
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.topRight,
              child: Text('البداية:'),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              alignment: Alignment.topRight,
              child: Text('النهاية:'),
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
                      'اختر الفترة الزمنية',
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

                      dateRangeController.text = dateTimeRange.start.toString();
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
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                child: Text('بحث'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ConstantColors.lightBlue)),
                onPressed: () {},
              ),
              color: ConstantColors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
