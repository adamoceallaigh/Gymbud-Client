// Imports

// Library Imports
import 'package:Client/Managers/Controllers/AppController.dart';
import 'package:Client/Managers/Providers.dart';
import 'package:Client/Presentation/General_Pages/Onboarding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:Client/Helpers/Libs_Required.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// Page Imports
import 'package:Client/Helpers/HexColor.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appLoaded = useProvider(app_notifier_provider.state);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashScreenBody(appState: appLoaded),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({Key key, AppState appState}) : super(key: key);

  @override
  _SplashScreenBodyState createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  settingUpApp(BuildContext context) {
    context.read(app_notifier_provider).setUpApp(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingUpApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appState = watch(app_notifier_provider.state);
      if (appState is AppInitial) {
        return SplashScreenLoading();
      } else if (appState is AppLoading) {
        return SplashScreenLoading();
      } else if (appState is AppLoaded) {
        return SplashScreenLoaded();
      } else {
        return SplashScreenLoading();
      }
    });
  }
}

class SplashScreenLoading extends StatelessWidget {
  const SplashScreenLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.0),
          width: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Image.asset('Resources/Images/logoGymbud.png'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: HexColor("2E2B2B"),
            ),
          ],
        ),
      ],
    );
  }
}

class SplashScreenLoaded extends StatefulWidget {
  @override
  _SplashScreenLoadedState createState() => _SplashScreenLoadedState();
}

class _SplashScreenLoadedState extends State<SplashScreenLoaded> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
