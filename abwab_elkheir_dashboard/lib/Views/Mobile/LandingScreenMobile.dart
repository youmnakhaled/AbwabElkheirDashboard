import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreenMobile extends StatefulWidget {
  final deviceSize;

  const LandingScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _LandingScreenMobileState createState() => _LandingScreenMobileState();
}

class _LandingScreenMobileState extends State<LandingScreenMobile> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationViewModel auth;
  bool isLoading = false;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: "test@test.com");
    TextEditingController passwordController =
        TextEditingController(text: "12345678");
    final deviceSize = widget.deviceSize;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 25,
                left: 35,
                right: 35,
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 50),
                child: Center(
                  child: Image.asset(
                    'assets/images/ARCADE FILMS .png',
                    width: deviceSize.height * 0.3,
                  ),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ConstantColors.purple,
                    ),
                  )
                : Form(
                    key: _formKey,
                    child: Container(
                      width: deviceSize.width * 0.8,
                      child: Card(
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  color: ConstantColors.purple, fontSize: 30),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            TextFieldWidget(
                              controller: emailController,
                              deviceSize: deviceSize,
                              labelText: 'Email',
                              prefixIconData: Icons.person,
                            ),
                            TextFieldWidget(
                              controller: passwordController,
                              deviceSize: deviceSize,
                              labelText: 'Password',
                              prefixIconData: Icons.vpn_key,
                              obscureText: true,
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                top: 45,
                              ),
                              child: Container(
                                width: deviceSize.width * 0.4,
                                height: deviceSize.height * 0.05,
                                child: FloatingActionButton(
                                  heroTag: "Button2",
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      bool success = await auth.signIn(
                                          emailController.text,
                                          passwordController.text,
                                          context);
                                      if (success) {
                                        // Navigator.of(context)
                                        //     .pushNamed(HomeScreen.routeName);
                                        print('Success');
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  backgroundColor: ConstantColors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Bungee',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
