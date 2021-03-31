import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/Views/LandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthenticationViewModel(),
        ),
      ],
      child: VRouter(
        mode: VRouterModes.hash,
        title: 'Abwab El Kheir',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.white,
        ),
        // locale: _locale,
        // supportedLocales: [
        //   Locale('en'),
        //   Locale('ar'),
        // ],
        // localizationsDelegates: [
        //   DemoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        buildTransition: (animation1, _, child) =>
            FadeTransition(opacity: animation1, child: child),
        routes: [
          VWidget(
            path: '/',
            widget: LandingScreen(),
          ),
          // VWidget(
          //   path: '/addCase',
          //   widget: LayoutTemplate(
          //     child: AboutUsView(),
          //   ),
          // ),
          // VWidget(
          //   path: '/cases',
          //   widget: LayoutTemplate(
          //     child: AboutUsView(),
          //   ),
          // ),
          // VWidget(
          //   path: '/notfound',
          //   widget: LayoutTemplate(
          //     child: ErrorView(),
          //   ),
          // ),

          VRouteRedirector(
            path: ':_(.*)',
            redirectTo: '/notfound',
          ),
        ],
        debugShowCheckedModeBanner: false,
        // child: MaterialApp(
        //   title: 'Raz3 Ordering Form',
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //     accentColor: Colors.white,
        //     primaryColor: ConstantColors.lightBlue,
        //   ),
        //   home: LandingScreen(),
        //   routes: {
        //     //OrderDetailsScreen.routeName: (ctx) => OrderDetailsScreen(),
        //   },
        // ),
      ),
    );
  }
}
