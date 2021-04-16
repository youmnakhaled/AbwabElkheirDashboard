import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class EditCaseScreenDesktop extends StatefulWidget {
  final deviceSize;

  const EditCaseScreenDesktop({Key key, this.deviceSize}) : super(key: key);
  @override
  _EditCaseScreenDesktopState createState() => _EditCaseScreenDesktopState();
}

class _EditCaseScreenDesktopState extends State<EditCaseScreenDesktop> {
  AuthenticationViewModel auth;
  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.vRouter.pathParameters['id']);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Text('Add Case Screen'),
        ),
      ),
    );
  }
}
