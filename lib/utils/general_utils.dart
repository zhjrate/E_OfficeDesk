import 'dart:io';

import 'package:flutter/material.dart' hide Key;
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';

/*Future navigateTo(BuildContext context, String routeName,
    {Object arguments,
    bool clearAllStack: false,
    bool clearSingleStack: false,
    bool useRootNavigator: false,
      bool ispop : false,
    String clearUntilRoute}) async {
  if (clearAllStack) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamedAndRemoveUntil(routeName, (route) => false,
            arguments: arguments);
  } else if (clearSingleStack) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .popAndPushNamed(routeName, arguments: arguments);
  } else if (clearUntilRoute != null) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamedAndRemoveUntil(
            routeName, ModalRoute.withName(clearUntilRoute),
            arguments: arguments);
  }
  else if(ispop != null)
    {
      await Navigator.of(context, rootNavigator: useRootNavigator)
          .popAndPushNamed(routeName, arguments: arguments);
    }
  else {
    return await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamed(routeName, arguments: arguments);
  }
}*/

Future navigateTo(BuildContext context, String routeName,
    {Object arguments,
    bool clearAllStack: false,
    bool clearSingleStack: false,
    bool useRootNavigator: false,
    String clearUntilRoute}) async {
  if (clearAllStack) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamedAndRemoveUntil(routeName, (route) => false,
            arguments: arguments);
  } else if (clearSingleStack) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .popAndPushNamed(routeName, arguments: arguments);
  } else if (clearUntilRoute != null) {
    await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamedAndRemoveUntil(
            routeName, ModalRoute.withName(clearUntilRoute),
            arguments: arguments);
  } else {
    return await Navigator.of(context, rootNavigator: useRootNavigator)
        .pushNamed(routeName, arguments: arguments);
  }
}

void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String message) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: colorWhite,
      ),
      textAlign: TextAlign.center,
    ),
  ));
}

Future showCommonDialogWithTwoOptions(BuildContext context, String message,
    {String negativeButtonTitle,
    String positiveButtonTitle,
    bool useRootNavigator = true,
    GestureTapCallback onTapOfNegativeButton,
    GestureTapCallback onTapOfPositiveButton}) async {
  ThemeData baseTheme = Theme.of(context);
  await showDialog(
    context: context,
    builder: (context2) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorWhite,
          ),
          width: double.maxFinite,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 100),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      maxLines: 15,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: baseTheme.textTheme.button,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: getCommonDivider(),
              ),
              Container(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              negativeButtonTitle,
                              textAlign: TextAlign.center,
                              style: baseTheme.textTheme.button,
                            ),
                          ),
                        ),
                        onTap: onTapOfNegativeButton ??
                            () {
                              Navigator.of(context,
                                      rootNavigator: useRootNavigator)
                                  .pop();
                            },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                      child: getCommonVerticalDivider(),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              positiveButtonTitle,
                              textAlign: TextAlign.center,
                              style: baseTheme.textTheme.button
                                  .copyWith(color: colorPrimaryLight),
                            ),
                          ),
                        ),
                        onTap: onTapOfPositiveButton ??
                            () {
                              Navigator.of(context,
                                      rootNavigator: useRootNavigator)
                                  .pop();
                            },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future showCommonDialogWithSingleOption(
  BuildContext context,
  String message, {
  String positiveButtonTitle = "OK",
  GestureTapCallback onTapOfPositiveButton,
  bool useRootNavigator = true,
  EdgeInsetsGeometry margin: const EdgeInsets.only(left: 20, right: 20),
}) async {
  ThemeData baseTheme = Theme.of(context);

  await showDialog(
    context: context,
    builder: (context2) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorWhite,
          ),
          width: double.maxFinite,
          margin: margin,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 100),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      maxLines: 15,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: baseTheme.textTheme.button,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: getCommonDivider(),
              ),
              GestureDetector(
                child: Container(
                  height: 60,
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      positiveButtonTitle,
                      textAlign: TextAlign.center,
                      style: baseTheme.textTheme.button
                          .copyWith(color: colorPrimaryLight),
                    ),
                  ),
                ),
                onTap: onTapOfPositiveButton ??
                    () {
                      Navigator.of(Globals.context).pop();
                      // Navigator.of(context, rootNavigator: true).pop();
                    },
              )
            ],
          ),
        ),
      );
    },
  );
}

bool shouldPaginate(dynamic scrollInfo,
    {AxisDirection axisDirection: AxisDirection.down}) {
  return scrollInfo is ScrollEndNotification &&
      scrollInfo.metrics.extentAfter == 0 &&
      scrollInfo.metrics.maxScrollExtent > 0 &&
      scrollInfo.metrics.axisDirection == axisDirection;
}

bool shouldPaginateFromController(ScrollController scrollController) {
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.offset;

  if (currentScroll >= (maxScroll * 0.9) &&
      scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
    return true;
  } else {
    return false;
  }
}

/*pickImage(
  BuildContext context, {
  @required Function(File f) onImageSelection,
}) {
  FocusScope.of(context).unfocus();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      PickedFile capturedFile = await ImagePicker().getImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (capturedFile != null) {
                        onImageSelection(File(capturedFile.path));
                      }
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    PickedFile capturedFile = await ImagePicker().getImage(
                        source: ImageSource.camera, imageQuality: 100);
                    if (capturedFile != null) {
                      onImageSelection(File(capturedFile.path));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
}*/

pickImage(
  BuildContext context, {
  @required Function(File f) onImageSelection,
}) {
  FocusScope.of(context).unfocus();
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      XFile capturedFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (capturedFile != null) {
                        onImageSelection(File(capturedFile.path));
                      }
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    XFile capturedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera, imageQuality: 100);
                    if (capturedFile != null) {
                      onImageSelection(File(capturedFile.path));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      });
}

MaterialPageRoute getMaterialPageRoute(Widget screen) {
  return MaterialPageRoute(
    builder: (context) {
      return screen;
    },
  );
}

bool viewvisiblitiyAsperClient({String SerailsKey, String RoleCode}) {
  if (SerailsKey.toLowerCase().toString() == "abcd-efgh-ijkl-mnow" ||
      SerailsKey.toLowerCase().toString() == "dol2-6uh7-ph03-in5h") {
    if (RoleCode.toLowerCase() == "admin") {
      return true;
    } else {
      return false;
    }
  } else {
    return true;
  }
}

Widget showCustomToast({String Title}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check, color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text(
          Title,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
