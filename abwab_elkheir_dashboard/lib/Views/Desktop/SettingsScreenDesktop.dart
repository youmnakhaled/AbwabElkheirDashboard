// import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'dart:html';

import 'package:abwab_elkheir_dashboard/Models/case_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/SettingViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:vrouter/vrouter.dart';
// import '../../Models/case_model.dart';
import '../../Constants/ConstantColors.dart';

class SettingsScreenDesktop extends StatefulWidget {
  final deviceSize;

  const SettingsScreenDesktop({Key key, this.deviceSize}) : super(key: key);
  @override
  _SettingsScreenDesktopState createState() => _SettingsScreenDesktopState();
}

class _SettingsScreenDesktopState extends State<SettingsScreenDesktop> {
  AuthenticationViewModel auth;
  SettingViewModel settingViewModel;
  final _linkFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String currentLink;

  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
    Future.microtask(() async {
      await settingViewModel.getCurrentLink(context, auth.accessToken);
    });

    super.initState();
  }

  @override
  void dispose() {
    _linkFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    await settingViewModel.editLink(
        context, auth.accessToken, settingViewModel.getYoutubeLink);
    settingViewModel.isChanged = false;
    context.vRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("اعدادات الصفحة الرئيسية "),
        backgroundColor: ConstantColors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  width: deviceSize.width * 0.8,
                  // controller: settingViewModel.youtubeLinkController,
                  initialValue: settingViewModel.youtubeLink,
                  isEnabled: true,
                  maxLines: 1,
                  deviceSize: deviceSize,
                  onChanged: (value) {
                    setState(() {
                      settingViewModel.isChanged = true;
                    });
                  },
                  labelText: 'لينك فيديو الصفحة الرئيسية',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_linkFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل لينك الفيديو';
                    }
                    bool _validURL = Uri.parse(value).isAbsolute;
                    if (!_validURL) {
                      return 'أدخل لينك صحيح الفيديو';
                    }
                    return null;
                  },
                  textDirection: TextDirection.rtl,
                  onSaved: (value) {
                    settingViewModel.setNewLink(value);
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveForm();
                    },
                    child: Text('حفظ'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            settingViewModel.isChanged
                                ? ConstantColors.lightBlue
                                : Colors.grey)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      window.history.back();
                    },
                    child: Text('test'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            settingViewModel.isChanged
                                ? ConstantColors.lightBlue
                                : Colors.grey)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
