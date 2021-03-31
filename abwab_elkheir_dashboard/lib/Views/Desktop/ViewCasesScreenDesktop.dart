import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCasesScreenDesktop extends StatefulWidget {
  final deviceSize;

  const ViewCasesScreenDesktop({Key key, this.deviceSize}) : super(key: key);
  @override
  _ViewCasesScreenDesktopState createState() => _ViewCasesScreenDesktopState();
}

class _ViewCasesScreenDesktopState extends State<ViewCasesScreenDesktop> {
  AuthenticationViewModel auth;
  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Text('View Cases Screen'),
        ),
      ),
    );
  }
}
