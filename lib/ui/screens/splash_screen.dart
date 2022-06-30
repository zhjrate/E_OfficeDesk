import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'DashBoard/home_screen.dart';

class SplashScreen extends BaseStatefulWidget {
  static const routeName = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen>
    with BasicScreen, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => {
        if (SharedPrefHelper.instance.isRegisteredIn())
    {
        navigateTo(context, HomeScreen.routeName, clearAllStack: true)
  }else{
    navigateTo(context, HomeScreen.routeName,clearAllStack: true)

    }
  }

    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/custom_logo_icon/logo.png'),
      ),
    );
  }
}