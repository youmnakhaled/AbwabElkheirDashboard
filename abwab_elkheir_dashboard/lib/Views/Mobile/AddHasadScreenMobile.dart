import 'package:abwab_elkheir_dashboard/Models/hasad_model.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AddHasadViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:vrouter/vrouter.dart';
import '../../Constants/ConstantColors.dart';

class AddHasadScreenMobile extends StatefulWidget {
  final deviceSize;

  const AddHasadScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _AddHasadScreenMobileState createState() => _AddHasadScreenMobileState();
}

class _AddHasadScreenMobileState extends State<AddHasadScreenMobile> {
  AuthenticationViewModel auth;
  AddHasadViewModel hasadViewModel;

  final _linkFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    hasadViewModel = Provider.of<AddHasadViewModel>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    _linkFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    Hasad currentHasad = Hasad(
        title: hasadViewModel.addHasadTitleController.text,
        link: hasadViewModel.addHasadLinkController.text);

    hasadViewModel.setHasadToAdd(currentHasad);
    await hasadViewModel.addHasad(context, auth.accessToken);
    context.vRouter.pop();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(" اضافة حصاد جديد"),
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
                  controller: hasadViewModel.addHasadTitleController,
                  isEnabled: true,
                  maxLines: 1,
                  deviceSize: deviceSize,
                  labelText: ' عنوان الحصاد',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_titleFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل عنوان الحصاد الجديد';
                    }
                    return null;
                  },
                  textDirection: TextDirection.rtl,
                  onSaved: (value) {},
                ),
                TextFieldWidget(
                  width: deviceSize.width * 0.8,
                  controller: hasadViewModel.addHasadLinkController,
                  isEnabled: true,
                  maxLines: 1,
                  deviceSize: deviceSize,
                  labelText: 'لينك الحصاد',
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_linkFocusNode);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'أدخل لينك الحصاد';
                    }
                    bool _validURL = Uri.parse(value).isAbsolute;
                    if (!_validURL) {
                      return ' (youtube) أدخل لينك صحيح الفيديو';
                    }
                    return null;
                  },
                  textDirection: TextDirection.rtl,
                  onSaved: (value) {},
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
                            ConstantColors.lightBlue)),
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
