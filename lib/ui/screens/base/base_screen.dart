import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/repositories/custom_exception.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/localizations/app_localizations.dart';
import 'package:soleoserp/utils/general_utils.dart';

abstract class BaseStatefulWidget extends StatefulWidget
    with WidgetsBindingObserver {}

abstract class BaseState<Screen extends BaseStatefulWidget>
    extends State<Screen> with RouteAware {}

mixin BasicScreen<Screen extends BaseStatefulWidget> on BaseState<Screen> {
  AppLocalizations localizations;
  BaseBloc baseBloc;
  ThemeData baseTheme;

  ///progress bar related declarations
  bool _showProgressDialog = false;
  GlobalKey _progressBarKey = GlobalKey();
  final GlobalKey<ScaffoldState> mainScaffoldKey =
      new GlobalKey<ScaffoldState>();

  ///top bar related declarations
  Color screenStatusBarColor;
  GlobalKey appBarKey = GlobalKey();
  final rnd = math.Random();
  Color tempcol;
/*  List<Color> colors123 = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blueAccent
  ];
  RandomColor _randomColor = RandomColor();

  Color _color;*/

  ///initializes base bloc
  @override
  initState() {
    super.initState();
    baseBloc = BaseBloc();
    tempcol = Color.fromRGBO(
      rnd.nextInt(255),
      rnd.nextInt(255),
      rnd.nextInt(255),
      1,
    );
    //_color = _randomColor.randomColor(colorBrightness: ColorBrightness.light);
  }

  ///listens base blocs states
  ///builds screen
  @override
  Widget build(BuildContext context) {
    Globals.context = context;

    localizations = AppLocalizations.of(context);
    baseTheme = Theme.of(context).copyWith(
        primaryColor: colorPrimaryDark,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: colorPrimary));

    return WillPopScope(
      child: BlocProvider(
        child: BlocConsumer<BaseBloc, BaseStates>(
          //defining conditions for builder function about when it should rebuild screen
          buildWhen: (previousState, currentState) {
            if (currentState is ShowProgressIndicatorState ||
                currentState is ApiCallFailureState) {
              //no need to rebuild for these states
              return false;
            }
            return true;
          },
          builder: (context, state) {
            return _buildScreen();
          },
          //all base listeners are handled below
          listener: (BuildContext context, BaseStates state) async {
            if (state is ApiCallFailureState) {
              if (state.exception is UnauthorisedException) {
                //redirecting to login screen as session is expired
                //TODO
              } else {
                showCommonDialogWithSingleOption(
                    context, state.exception.toString(),
                    positiveButtonTitle: "OK");
              }
            }
            if (state is ShowProgressIndicatorState) {
              if (state.showProgress) {
                showProgressBar();
              } else {
                hideProgressBar();
              }
            }
          },
        ),
        create: (BuildContext context) => baseBloc,
      ),
      onWillPop: onPop,
    );
  }

  ///builds and returns screen as a widget
  Widget _buildScreen() {
    return Stack(
      children: [
        Scaffold(
          key: mainScaffoldKey,
          extendBody: false,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: StatefulBuilder(
              key: appBarKey,
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                /*return AppBar(
                  backgroundColor: screenStatusBarColor ?? Colors.transparent*/ /*== null ? Colors.transparent:Colors.transparent*/ /*,
                  elevation: 0,
                );*/
                if (screenStatusBarColor == colorWhite) {
                  /* return NewGradientAppBar(
                        title: Text('Flutter'),
                        gradient: LinearGradient(colors: [Colors.transparent, Colors.transparent, Colors.transparent])
                    );*/
                  return AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                  );
                } else {
                  return NewGradientAppBar(
                      title: Text('Flutter'),
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple, Colors.red]));
                }
              },
            ),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: buildBottomNavigationBar(context),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragDown: isBottomSheet()
                ? null
                : (value) {
                    FocusScope.of(context).unfocus();
                  },
            child: SafeArea(
              child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  child: buildBody(context)),
            ),
          ),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Visibility(
              visible: true, //_showProgressDialog,
              child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.black26,
                  child: ListView(
                    children: [
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/loader_json.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/sample_kishan_one.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/sample_kishan_two.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/sample_kishan_three.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/sample_kishan_four.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Lottie.asset(
                                    'assets/lang/sample_kishan_five.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ],
                          )),
                    ],
                  )

                  /*  Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    padding: EdgeInsets.all(10),
                    child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: Lottie.asset(
                                    'assets/lang/loader_json.json',
                                    width: 100,
                                    height: 100),
                              ),
                            ),
                            Text(
                              "Loading...",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )),
                  ),
                ),*/
                  /*CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      1,
                    )),
                  ),*/
                  /* LoadingBouncingGrid.circle(
                    borderColor: Color.fromRGBO(
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      1,
                    ),
                    backgroundColor: Color.fromRGBO(
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      rnd.nextInt(255),
                      1,
                    ),
                    borderSize: 1,
                    size: 100.0,
                  ),*/

                  ),
            );
          },
          key: _progressBarKey,
        )
      ],
    );
  }

  ///can be override following method in any screen if its bottomSheet
  ///if returns true gesture detector to hide keyboard while scrolling will disable
  ///if returns false gesture detector to hide keyboard while scrolling will enable
  bool isBottomSheet() {
    return false;
  }

  ///abstract method to be override following method in any screen to build main body of screen
  Widget buildBody(BuildContext context);

  ///can be override following method in any screen to provide bottom navigation bar
  Widget buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  ///can be override following method in any screen if want to perform anything on pop
  Future<bool> onPop() async {
    return true;
  }

  ///can be override following method in any screen if want to resize avoiding bottom inset
  bool resizeToAvoidBottomInset() {
    return true;
  }

  ///shows progressbar
  void showProgressBar() {
    _progressBarKey.currentState.setState(() {
      _showProgressDialog = true;
    });
  }

  ///hides progressbar
  void hideProgressBar() {
    _progressBarKey.currentState.setState(() {
      _showProgressDialog = false;
    });
  }

  ///returns true/false if progressbar is showing
  bool isProgressBarShowing() {
    return _showProgressDialog;
  }
}
