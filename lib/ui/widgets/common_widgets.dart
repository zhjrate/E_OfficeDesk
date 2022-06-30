import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/custom_text_editing_controller.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Background.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Attend_Visit/Attend_Visit_List/attend_visit_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/attendance/employee_attendance_list.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_list/bank_voucher_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/daily_activity/daily_activity_list/daily_activity_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/employee/employee_list/employee_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/expense/expense_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/external_lead/external_lead_list/external_lead_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/map_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request/leave_request_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request_approval/leave_approval_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/loan/loan_list/loan_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/loan_approval/loan_approval_list/loan_approval_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/maintenance/maintenance_list/maintenance_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/missed_punch/missed_punch_list/missed_punch_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_checklist_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/production_activity/production_activity_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_followup/quick_followup_list/quick_followup_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_inquiry/quick_inquiry_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salary_upad/salary_upad_list/salary_upad_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sale_bill_list/sales_bill_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/salesorder_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller/telecaller_list/telecaller_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller_new/telecaller_new_pagintion.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/authentication/first_screen.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

double sizeboxsize = 20;
double _fontSize_Label = 10;
double _fontSize_Title = 15;
int label_color = 0x66666666;
int title_color = 0xFF000000;
List<ALL_Name_ID> SALES;
List<ALL_Name_ID> Leads;
List<ALL_Name_ID> AccountList;

List<ALL_Name_ID> HR;
List<ALL_Name_ID> Purchase;

List<ALL_Name_ID> Office;
List<ALL_Name_ID> Support;
List<ALL_Name_ID> Production;

final primary = Colors.indigo;
final secondary = Colors.black;
final background = Colors.white10;

LoginUserDetialsResponse _offlineLoggedInData =
    SharedPrefHelper.instance.getLoginUserData();
CompanyDetailsResponse _offlineCompanyData =
    SharedPrefHelper.instance.getCompanyData();

Widget getCommonTextFormField(BuildContext context, ThemeData baseTheme,
    {String title: "",
    String hint: "",
    TextInputAction textInputAction: TextInputAction.next,
    bool obscureText: false,
    EdgeInsetsGeometry contentPadding:
        const EdgeInsets.only(top: 0, bottom: 10),
    int maxLength: 1000,
    TextAlign textAlign: TextAlign.left,
    TextEditingController controller,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
    int maxLines: 1,
    Function(String) onSubmitted,
    Function(String) onTextChanged,
    TextStyle titleTextStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle inputTextStyle,
    List<TextInputFormatter> inputFormatter,
    bool readOnly: false,
    Widget suffixIcon}) {
  if (titleTextStyle == null) {
    titleTextStyle = baseTheme.textTheme.subtitle1;
  }
  if (inputTextStyle == null) {
    inputTextStyle = baseTheme.textTheme.subtitle2;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.isNotEmpty
          ? Container(
              child: /*Text(
          title,
          style: titleTextStyle,
        ),*/
                  Text(
              title,
              style: TextStyle(
                color: Color(0xff3a3285),
                fontSize: 18,
              ),
            ))
          : Container(),
      TextFormField(
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatter,
        keyboardType: keyboardType,
        style: inputTextStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        cursorColor: colorPrimaryLight,
        textInputAction: textInputAction,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLength: maxLength,
        controller: controller,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: inputTextStyle.copyWith(color: colorGray),
          isDense: true,
          suffixIconConstraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
          contentPadding: EdgeInsets.only(bottom: 10, top: 15),
          suffixIcon: suffixIcon,
          counterText: "",
          errorStyle: baseTheme.textTheme.subtitle1.copyWith(
              color: Colors.red, fontSize: CAPTION_SMALLER_TEXT_FONT_SIZE),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorGrayDark, width: 0.4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colorPrimaryLight, width: 1),
          ),
        ),
        validator: validator,
        onChanged: onTextChanged,
        onFieldSubmitted: onSubmitted,
      )
    ],
  );
}

Widget getCommonTextFormFieldFloating(BuildContext context, ThemeData baseTheme,
    {String title: "",
    TextInputAction textInputAction: TextInputAction.next,
    bool obscureText: false,
    EdgeInsetsGeometry contentPadding:
        const EdgeInsets.only(top: 0, bottom: 14),
    int maxLength: 1000,
    TextEditingController controller,
    TextInputType keyboardType,
    FormFieldValidator<String> validator,
    int maxLines: 1,
    Function(String) onSubmitted,
    Function(String) onTextChanged,
    EdgeInsetsGeometry margin: const EdgeInsets.only(top: 30),
    TextStyle titleTextStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle inputTextStyle,
    List<TextInputFormatter> inputFormatters,
    bool readOnly: false,
    double labelHeight: 0.4,
    Widget suffixIcon}) {
  if (titleTextStyle == null) {
    titleTextStyle =
        baseTheme.textTheme.bodyText2.copyWith(height: labelHeight);
  }
  if (inputTextStyle == null) {
    inputTextStyle = baseTheme.textTheme.bodyText1;
  }
  if (onSubmitted == null && textInputAction == TextInputAction.next) {
    onSubmitted = (value) {
      FocusScope.of(context).nextFocus();
    };
  }
  return Container(
    margin: margin,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextFormField(
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            cursorColor: colorPrimaryLight,
            keyboardType: keyboardType,
            style: inputTextStyle,
            maxLines: maxLines,
            textInputAction: textInputAction,
            obscureText: obscureText,
            readOnly: readOnly,
            maxLength: maxLength,
            controller: controller,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              labelText: title,
              hintStyle: titleTextStyle,
              labelStyle: titleTextStyle,
              suffixIcon: suffixIcon,
              counterText: "",
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              contentPadding: contentPadding,
              errorStyle: baseTheme.textTheme.subtitle1.copyWith(
                  color: Colors.red, fontSize: CAPTION_SMALLER_TEXT_FONT_SIZE),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorTextTitleGray, width: 0.4),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorPrimaryLight, width: 1),
              ),
            ),
            validator: validator,
            onChanged: onTextChanged,
          ),
          margin: EdgeInsets.only(top: 0),
        )
      ],
    ),
  );
}

Widget getCommonTextFormFieldFloatingWithCustomError(
    BuildContext context, ThemeData baseTheme,
    {String title: "",
    TextInputAction textInputAction: TextInputAction.next,
    bool obscureText: false,
    EdgeInsetsGeometry contentPadding:
        const EdgeInsets.only(top: 0, bottom: 14),
    int maxLength: 1000,
    CustomTextEditingController customController,
    TextInputType keyboardType,
    GestureTapCallback onTap,
    Function validator,
    int maxLines: 1,
    Function(String) onSubmitted,
    Function(String) onTextChanged,
    FocusNode focusNode,
    EdgeInsetsGeometry margin: const EdgeInsets.only(top: 30),
    TextStyle titleTextStyle,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle inputTextStyle,
    List<TextInputFormatter> inputFormatters,
    bool readOnly: false,
    double labelHeight: 0.4,
    Widget suffixIcon}) {
  if (titleTextStyle == null) {
    titleTextStyle =
        baseTheme.textTheme.bodyText2.copyWith(height: labelHeight);
  }
  if (inputTextStyle == null) {
    inputTextStyle = baseTheme.textTheme.bodyText1;
  }

  final Widget widget = StatefulBuilder(
      builder: (BuildContext context, StateSetter updateWidget) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextFormField(
              textCapitalization: textCapitalization,
              inputFormatters: inputFormatters,
              cursorColor: colorPrimaryLight,
              focusNode: focusNode,
              keyboardType: keyboardType,
              style: inputTextStyle,
              maxLines: maxLines,
              textInputAction: textInputAction,
              obscureText: obscureText,
              readOnly: readOnly,
              onFieldSubmitted: onSubmitted,
              onSaved: onSubmitted,
              maxLength: maxLength,
              onTap: onTap,
              controller: customController.controller,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                labelText: title,
                hintStyle: titleTextStyle,
                labelStyle: titleTextStyle,
                suffixIcon: (suffixIcon != null || customController.showError)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          suffixIcon == null
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: suffixIcon),
                          SizedBox(
                            width: customController.showError ? 5 : 0,
                          ),
                          customController.showError
                              ? Container(
                                  width: TEXT_FORM_FIELD_SUFFIX_ICON,
                                  child: Image.asset(
                                    IC_ERROR,
                                    width: TEXT_FORM_FIELD_SUFFIX_ICON,
                                    height: TEXT_FORM_FIELD_SUFFIX_ICON,
                                  ))
                              : Container(),
                        ],
                      )
                    : null,
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: contentPadding,
                errorStyle: baseTheme.textTheme.subtitle1.copyWith(
                    color: Colors.red,
                    fontSize: CAPTION_SMALLER_TEXT_FONT_SIZE),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorTextTitleGray, width: 0.4),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorPrimaryLight, width: 1),
                ),
              ),
              validator: (value) {
                updateWidget(() {
                  if (validator(value) != null) {
                    customController.showError = true;
                  } else {
                    customController.showError = false;
                  }
                });
                return validator(value);
              },
              onChanged: onTextChanged,
            ),
            margin: EdgeInsets.only(top: 0),
          )
        ],
      ),
    );
  });
  return widget;
}

Widget getCommonBoxTextFormField(
  ThemeData baseTheme, {
  String title: "",
  TextInputAction textInputAction: TextInputAction.next,
  bool obscureText: false,
  EdgeInsetsGeometry contentPadding: const EdgeInsets.all(5),
  int maxLength: 1000,
  double spaceBetweenTitleBox: 0,
  TextEditingController controller,
  TextInputType keyboardType,
  FormFieldValidator<String> validator,
  Function(String) onSubmitted,
  Function(String) onTextChanged,
  EdgeInsetsGeometry margin: const EdgeInsets.only(top: 30),
  TextStyle titleTextStyle,
  TextCapitalization textCapitalization = TextCapitalization.none,
  TextStyle inputTextStyle,
  int maxLines: 3,
  Color enabledBorderColor: colorGrayDark,
  Color focusedBorderColor: colorPrimaryDark,
  double boxRadius: 0,
  TextAlign textAlign = TextAlign.start,
  List<TextInputFormatter> inputFormatters,
}) {
  if (titleTextStyle == null) {
    titleTextStyle = baseTheme.textTheme.subtitle2;
  }
  if (inputTextStyle == null) {
    inputTextStyle = baseTheme.textTheme.bodyText2;
  }

  return Container(
    margin: margin,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty
            ? Container()
            : Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  title,
                  style: titleTextStyle,
                ),
              ),
        Container(
          margin: EdgeInsets.only(top: spaceBetweenTitleBox),
          child: TextFormField(
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            style: inputTextStyle,
            textInputAction: textInputAction,
            obscureText: obscureText,
            maxLength: maxLength,
            textAlign: textAlign,
            controller: controller,
            obscuringCharacter: "*",
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              counterText: "",
              errorStyle: baseTheme.textTheme.subtitle1.copyWith(
                  color: Colors.red, fontSize: CAPTION_SMALLER_TEXT_FONT_SIZE),
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: enabledBorderColor, width: 0.4),
                  borderRadius: BorderRadius.circular(boxRadius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: focusedBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(boxRadius)),
            ),
            validator: validator,
            onChanged: onTextChanged,
            onFieldSubmitted: onSubmitted,
          ),
        )
      ],
    ),
  );
}

Widget getCommonBottomSheetTitleView({
  @required ThemeData baseTheme,
  @required BuildContext context,
  @required String title,
  String actionTitle = "",
  GestureTapCallback onActionButtonTap,
}) {
  return Container(
    height: 35,
    margin: const EdgeInsets.only(top: 5),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: baseTheme.textTheme.bodyText1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset(IC_CLOSE),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
              onTap: onActionButtonTap,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  actionTitle,
                  style: baseTheme.textTheme.caption,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getCircleImage(String url, double radius,
    {String errorPlaceHolderImage = IC_USER_IMAGE_PLACEHOLDER,
    Widget loader,
    Color errorPlaceHolderBackgroundColor: Colors.transparent,
    File imageFile,
    Color loaderColor: colorPrimaryDark}) {
  if (url == null) {
    url = "";
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: imageFile == null
        ? Image.network(
            url,
            width: radius,
            height: radius,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                  child: Container(
                height: radius,
                width: radius,
                decoration: BoxDecoration(
                    color: errorPlaceHolderBackgroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          errorPlaceHolderImage,
                        ))),
              ));
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return loader == null
                  ? Container(
                      width: radius,
                      height: radius,
                      child: Stack(
                        children: [
                          Center(
                              child: Container(
                            height: radius,
                            width: radius,
                            decoration: BoxDecoration(
                                color: errorPlaceHolderBackgroundColor,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      errorPlaceHolderImage,
                                    ))),
                          )),
                          Center(
                            child: Container(
                              width: radius / 2,
                              height: radius / 2,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      loaderColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : loader;
            },
          )
        : Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: radius,
            height: radius,
          ),
  );
}

Widget getSquareImage(String url, double width, double height,
    {String errorPlaceHolderImage = IC_USER_IMAGE_PLACEHOLDER,
    Widget loader,
    Color errorPlaceHolderBackgroundColor = Colors.transparent,
    Color loaderColor: colorPrimaryDark}) {
  if (url == null) {
    url = "";
  }
  return Container(
    width: width,
    height: height,
    color: errorPlaceHolderBackgroundColor,
    child: Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
            child: Container(
          height: width,
          width: height,
          decoration: BoxDecoration(
              color: errorPlaceHolderBackgroundColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    errorPlaceHolderImage,
                  ))),
        ));
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return loader == null
            ? Container(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Center(
                        child: Image.asset(
                      errorPlaceHolderImage,
                      height: width,
                      color: errorPlaceHolderBackgroundColor,
                      fit: BoxFit.cover,
                      width: width,
                    )),
                    Center(
                      child: Container(
                        width: width / 2,
                        height: height / 2,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(loaderColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : loader;
      },
    ),
  );
}

Widget getCommonImage(String path,
    {double width: double.maxFinite,
    double height,
    BoxFit fit: BoxFit.fitWidth,
    Widget errorWidget}) {
  return Image.network(
    path,
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      print("Error loading image - $path\n$error");
      if (errorWidget != null) {
        return errorWidget;
      }
      return Container();
    },
  );
}

Widget getCommonEmptyView({message: "No data found"}) {
  return Center(
    child: Text(
      message,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget getCommonDivider({double thickness, double width: double.maxFinite}) {
  if (thickness == null) {
    thickness = COMMON_DIVIDER_THICKNESS;
  }
  return Container(
    height: thickness,
    color: colorGray,
    width: width,
  );
}

Widget getCommonVerticalDivider(
    {double thickness, double height: double.maxFinite}) {
  if (thickness == null) {
    thickness = COMMON_DIVIDER_THICKNESS;
  }
  return Container(
    width: thickness,
    color: colorGray,
    height: height,
  );
}

///add here common header if app have in each screen
Widget getCommonHeaderLogo() {
  //TODO
}

Widget getCommonButtonWithImage(
    ThemeData baseTheme, Function onPressed, String text, String image,
    {Color textColor: colorWhite,
    Color backGroundColor: colorPrimary,
    double elevation: 5.0,
    double radius: COMMON_BUTTON_RADIUS}) {
  return Container(
    height: 50,
    child: RaisedButton(
      onPressed: onPressed,
      padding: EdgeInsets.only(left: 20.0, right: 10),
      color: backGroundColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(COMMON_BUTTON_RADIUS))),
      elevation: elevation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              image,
              height: 22,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            text,
            style: baseTheme.textTheme.button.copyWith(color: textColor),
          ),
        ],
      ),
    ),
  );
}

Widget getCommonButton(ThemeData baseTheme, Function onPressed, String text,
    {Color textColor: colorWhite,
    Color backGroundColor: colorPrimary,
    double elevation: 0.0,
    bool showOnlyBorder: false,
    Color borderColor: colorPrimary,
    double textSize: BUTTON_TEXT_FONT_SIZE,
    double width: double.maxFinite,
    double height: COMMON_BUTTON_HEIGHT,
    double radius: COMMON_BUTTON_RADIUS}) {
  if (!showOnlyBorder) {
    borderColor = backGroundColor;
  }
  return Container(
    width: width,
    height: height,
    child: RaisedButton(
      onPressed: onPressed,
      color: backGroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: BorderSide(width: showOnlyBorder ? 2 : 0, color: borderColor)),
      elevation: elevation,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: baseTheme.textTheme.button
            .copyWith(color: textColor, fontSize: textSize),
      ),
    ),
  );
}

Widget getCommonAppBar(
  BuildContext context,
  ThemeData baseTheme,
  String title, {
  Function onTapOfBack,
  bool showBack: true,
  bool showHome: true,
}) {
  return Container(
    color: colorPrimary,
    height: DEFAULT_APP_BAR_HEIGHT,
    padding: EdgeInsets.only(
      left: DEFAULT2_LEFT_MARGIN,
      right: DEFAULT_APPBAR_NOTIFICATION_RIGHT_MARGIN,
    ),
    child: Row(
      children: [
        showBack
            ? InkWell(
                onTap: () {
                  if (onTapOfBack == null) {
                    Navigator.of(context).pop();
                  } else {
                    onTapOfBack();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: Image.asset(
                    IC_BACK,
                    width: 30,
                    height: 30,
                    color: colorWhite,
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: Text(
            title,
            style: baseTheme.textTheme.headline4,
          ),
        ),
        showHome
            ? InkWell(
                onTap: () {
                  if (onTapOfBack == null) {
                    Navigator.of(context).pop();
                  } else {
                    onTapOfBack();
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(right: 20, left: 10),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 24,
                    )),
              )
            : Container(),
      ],
    ),
  );
}

///This Widgets For Login Screens
///_________________________________________________
Widget buildLogoImage(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
    height: 80.0,
    width: 250.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/custom_logo_icon/soleos_logo.png'),
        fit: BoxFit.fill,
      ),
      shape: BoxShape.rectangle,
    ),
  );
}

Widget buildLoginTitle() {
  return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        'Login',
        maxLines: 20,
        style: TextStyle(
            fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.black),
      ));
}

Widget buildLoginSubTitle() {
  return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Text(
        'Log in to your existing account ',
        maxLines: 20,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
      ));
}

Widget buildUserNameTextFiled(
    {TextEditingController userName_Controller,
    String labelName,
    Icon icon,
    int maxline,
    bool enablevalue,
    ThemeData
        baseTheme} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
/*
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
*/
    child: TextFormField(
      style: baseTheme.textTheme.bodyText1,
      enabled: enablevalue,
      controller: userName_Controller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      maxLines: maxline,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: icon,
        /*Icon(
          Icons.person,
        ),*/
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildUserNameTextFiledRounded(
    {TextEditingController userName_Controller,
    String labelName,
    Icon icon,
    int maxline,
    bool enablevalue,
    ThemeData
        baseTheme} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
/*
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
*/
    child: TextFormField(
      style: baseTheme.textTheme.bodyText1,
      enabled: enablevalue,
      controller: userName_Controller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      maxLines: maxline,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: icon,
        /*Icon(
          Icons.person,
        ),*/
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    ),
  );
}

Widget build_Dropdown_label(
    {TextEditingController userName_Controller,
    String labelName,
    Icon icon,
    int maxline,
    bool enablevalue} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    child: TextFormField(
      enabled: enablevalue,
      controller: userName_Controller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      maxLines: maxline,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: labelName,
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: icon,
        /*Icon(
          Icons.person,
        ),*/
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildPasswordTextFiled(
    {TextEditingController user_password_Controller}) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
    child: TextFormField(
      controller: user_password_Controller,
      obscureText: true,
      cursorColor: Colors.black,
      // initialValue: user_password_Controller.text,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.lock,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildForgotTitle() {
  return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forget Password ?',
          maxLines: 20,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ));
}

Widget buildLoginButton(BuildContext context, Function onPressed) {
  return Container(
    width: double.infinity,
    height: 50.0,
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF27442)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: onPressed,
      child: Text('Login'),
    ),
  );
}

Widget buildLoginWithGoogleButton(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 50.0,
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () async {},
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(left: 25.0),
                alignment: Alignment.centerLeft,
                child: ImageIcon(
                  AssetImage('assets/images/custom_logo_icon/google_icon.png'),
                )
                /*Image.network(
                  'https://www.pngfind.com/pngs/m/34-344426_google-icon-logo-black-and-white-johns-hopkins.png',
                 ),*/
                ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Sign in with Google',
              ),
            ),
            //Icon(FlutterIcons.ac_unit_mdi),
            // Text('Sign in with Google'),
          ],
        )),
  );
}

Widget buildRegisterbTitle(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 40.0, right: 30.0, top: 30.0),
    child: Row(
      children: [
        Text(
          "Don't have an account ? ",
          maxLines: 20,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        InkWell(
          child: Text(
            "Register Here ",
            maxLines: 20,
            style: TextStyle(
                fontSize: 15.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          onTap: () {},
        )
      ],
    ),
  );
}

///_________________________________________________

///This Widget is For Dashboard Screen
makeDashboardItem(
    String title, IconData icon, BuildContext context, String ImageURL) {
  return Container(
      // padding: EdgeInsets.all(5),
      child: Container(
    decoration: BoxDecoration(
      color: colorWhite, //colorCombination(title),
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: colorPrimary, //                   <--- border color
        width: 1.0,
      ),
    ),
    child: new InkWell(
      onTap: () {
        if (title == "Customer") {
          //Navigator.pushReplacementNamed(context, "/Customer");
          //Get.to(Customer());
          navigateTo(context, CustomerListScreen.routeName);
        } else if (title == "Inquiry") {
          // navigateTo(context, CustomerPaginationListScreen .routeName);
          navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);

          //Navigator.pushReplacementNamed(context, "/Inquiry");
        } else if (title == "Quick Inquiry") {
          navigateTo(context, QuickInquiryScreen.routeName,
              clearAllStack: true);
        } else if (title == "Follow-up") {
          navigateTo(context, FollowupListScreen.routeName,
              clearAllStack: true);

          //  Navigator.pushReplacementNamed(context, "/Followup");
        } else if (title == "Quick Follow-up") {
          navigateTo(context, QuickFollowupListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Leave Request") {
          navigateTo(context, LeaveRequestListScreen.routeName,
              clearAllStack: true);

          // Navigator.pushReplacementNamed(context, "/SalesOrder");
        } else if (title == "Leave Approval") {
          navigateTo(context, LeaveRequestApprovalListScreen.routeName,
              clearAllStack: true);

          // Navigator.pushReplacementNamed(context, "/Financial");
        } else if (title == "Attendance") {
          //Navigator.pushReplacementNamed(context, "/Complaint");
          getcurrentTimeInfo(context);
        } else if (title == "Expense") {
          // Navigator.pushReplacementNamed(context, "/ToDo");

          navigateTo(context, ExpenseListScreen.routeName, clearAllStack: true);
        } else if (title == "Daily Activities") {
          navigateTo(context, DailyActivityListScreen.routeName,
              clearAllStack: true);
        } else if (title == "To-Do") {
          navigateTo(context, ToDoListScreen.routeName, clearAllStack: true);
        } else if (title == "Quotation") {
          navigateTo(context, QuotationListScreen.routeName,
              clearAllStack: true);
        } else if (title == "SalesOrder") {
          navigateTo(context, SalesOrderListScreen.routeName,
              clearAllStack: true);
        } else if (title == "SalesBill") {
          navigateTo(context, SalesBillListScreen.routeName,
              clearAllStack: true);
        } else if (title == "BankVoucher") {
          navigateTo(context, BankVoucherListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Complaint") {
          navigateTo(context, ComplaintPaginationListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Attend Visit") {
          if (SharedPrefHelper.instance
                  .getLoginUserData()
                  .details[0]
                  .serialKey
                  .toLowerCase() ==
              "dol2-6uh7-ph03-in5h") {
            /* navigateTo(context, DolphinComplaintVisitListScreen.routeName,
                      clearAllStack: true);*/

            navigateTo(context, AttendVisitListScreen.routeName,
                clearAllStack: true);
          } else {
            navigateTo(context, AttendVisitListScreen.routeName,
                clearAllStack: true);
          }
          //

        } else if (title == "Employee") {
          navigateTo(context, EmployeeListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Loan Installments") {
          navigateTo(context, LoanListScreen.routeName, clearAllStack: true);
        } else if (title == "Loan Approval") {
          navigateTo(context, LoanApprovalListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Missed Punch") {
          navigateTo(context, MissedPunchListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Salary Adv/Upad") {
          navigateTo(context, SalaryUpadListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Maintenance Contract") {
          navigateTo(context, MaintenanceListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Portal Leads") {
          navigateTo(context, ExternalLeadListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Packing Checklist") {
          navigateTo(context, PackingChecklistScreen.routeName,
              clearAllStack: true);
        } else if (title == "Final Checking") {
          navigateTo(context, FinalCheckingListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Installation") {
          navigateTo(context, InstallationListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Production Activity") {
          navigateTo(context, ProductionActivityListScreen.routeName,
              clearAllStack: true);
        } else if (title == "TeleCaller") {
          navigateTo(context, TeleCallerListScreen.routeName,
              clearAllStack: true);
        } else if (title == "Tele Caller") {
          navigateTo(context, TeleCallerNewListScreen.routeName,
              clearAllStack: true);
        }
      },
      child: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Center(
                  child: Image.network(ImageURL, height: 48, fit: BoxFit.fill)
                  /*
                       Icon(
                    icon,
                    size: 24.0,
                    color: Colors.black,
                  )*/

                  ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: Text(title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0, color: colorPrimary)),
              )
            ],
          ),
        ),
      ),
    ),
  ));
}

colorCombination(String title) {
  if (title == "Customer") {
    return colorYellow;
  } else if (title == "Follow-up") {
    return colorGreen;
  } else if (title == "Inquiry") {
    return colorOrange;
  } else if (title == "Attendance") {
    return colorPresentDay;
  } else if (title == "Expense") {
    return colorRedProgress;
  } else if (title == "LeaveApproval") {
    return colorGreen;
  } else if (title == "LeaveRequest") {
    return colorGray;
  } else {
    return colorWhite;
  }
}

void getcurrentTimeInfo(BuildContext context) async {
  DateTime startDate = await NTP.now();
  print('NTP DateTime: ${startDate} ${DateTime.now()}');
  /* var PresentDate = startDate.year.toString() +
      "-" +
      startDate.month.toString() +
      "-" +
      startDate.day.toString();*/
  var now = startDate;
  var formatter = new DateFormat('yyyy-MM-ddTHH:mm');
  String currentday = formatter.format(now);
  String PresentDate1 = formatter.format(DateTime.now());
  print(
      'NTP DateTime123456: ${DateTime.parse(currentday)} ${DateTime.parse(PresentDate1)}');

  if (DateTime.parse(currentday) == DateTime.parse(PresentDate1)) {
    navigateTo(context, AttendanceListScreen.routeName, clearAllStack: true);
  } else {
    return showCommonDialogWithSingleOption(
      context,
      "Your Device DateTime is not correct as per current DateTime , Kindly Update Your Device Time to Access Attendance !",
      positiveButtonTitle: "OK", /*onTapOfPositiveButton: () {

      }*/
    );
  }
}

getSaleListFromDashBoard(List<ALL_Name_ID> Sale) {
  SALES = Sale;
  return SALES;
}

getLeadListFromDashBoard(List<ALL_Name_ID> Leads1) {
  Leads = Leads1;
  return Leads;
}

getAccountListFromDashBoard(List<ALL_Name_ID> AccountList1) {
  AccountList = AccountList1;
  return Leads;
}

getHRListFromDashBoard(List<ALL_Name_ID> HR1) {
  HR = HR1;
  return HR;
}

getPurchaseListFromDashBoard(List<ALL_Name_ID> Purchase1) {
  Purchase = Purchase1;
  return Purchase;
}

getSupportListFromDashBoard(List<ALL_Name_ID> Support1) {
  Support = Support1;
  return Support;
}

getOfficeListFromDashBoard(List<ALL_Name_ID> Office1) {
  Office = Office1;
  return Office;
}

getProductionListFromDashBoard(List<ALL_Name_ID> Production1) {
  Production = Production1;
  return Production;
}

Widget build_Drawer({BuildContext context, String UserName, String RolCode}) {
  return Drawer(
    child: Background(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            color: colorPrimary,
          ),
          accountName: Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              SharedPrefHelper.instance.getLoginUserData().details[0].userID,
              style: TextStyle(color: Colors.white),
            ),
          ),
          accountEmail: Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              SharedPrefHelper.instance.getLoginUserData().details[0].roleCode,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          currentAccountPicture: Container(
            child: Card(
              elevation: 5,
              color: colorWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Image.network(
                  SharedPrefHelper.instance
                          .getCompanyData()
                          .details[0]
                          .siteURL +
                      "images/CompanyLogo/CompanyLogo.png",
                ),
              ),
            ),
          ),
          currentAccountPictureSize: const Size.square(85),
        ),

        /* Container(

            color: colorPrimary,

            child: Row(
              children: [
              Expanded(
                child: Card(
                elevation: 5,
                color: colorWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(

                  padding: EdgeInsets.all(5),

                  child: Image.network(


                    SharedPrefHelper.instance
                        .getCompanyData()
                        .details[0]
                        .siteURL +
                        "images/CompanyLogo/CompanyLogo.png",
                    height: 100,
                    width: 100,
                  ),

                ),
            ),
              ),

                Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        SharedPrefHelper.instance.getLoginUserData().details[0].userID,
                        style: TextStyle(color: Colors.white,fontSize: 10),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),

                      child: Text(
                        SharedPrefHelper.instance
                            .getLoginUserData()
                            .details[0]
                            .roleCode,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              )

              ],
            ),
          ),*/

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.dashboard, color: colorPrimary),
                title: Text("DashBoard",
                    softWrap: true,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  navigateTo(context, HomeScreen.routeName);
                },
              ),
              Leads.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Leads",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        Leads.length != 0
                            ? getLeadList(Leads, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              SALES.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Sales",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        SALES.length != 0
                            ? getSalesList(SALES, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              Production.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Production",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        Production.length != 0
                            ? getProductionList(Production, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              AccountList.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Account",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        AccountList.length != 0
                            ? getAccountList(AccountList, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              HR.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("HR",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        HR.length != 0 ? getHRList(HR, context) : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              Purchase.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Purchase",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        Purchase.length != 0
                            ? getPurchaseList(Purchase, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              Office.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Office",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        Office.length != 0
                            ? getOfficeList(Office, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              Support.length != 0
                  ? ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.center,
                      leading: Icon(Icons.dashboard, color: colorPrimary),
                      title: Text("Support",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        Support.length != 0
                            ? getSupportList(Support, context)
                            : Container(),
                      ],
                      trailing: Icon(
                        Icons.account_tree,
                        color: colorPrimary,
                      ))
                  : Container(),
              SharedPrefHelper.instance
                              .getLoginUserData()
                              .details[0]
                              .serialKey
                              .toLowerCase()
                              .trim() ==
                          "ZE5W-HOME-AG41-SF61".toLowerCase().trim() ||
                      SharedPrefHelper.instance
                              .getLoginUserData()
                              .details[0]
                              .serialKey
                              .toLowerCase()
                              .trim() ==
                          "SW0T-GLA5-IND7-AS71".toLowerCase().trim() ||
                      SharedPrefHelper.instance
                              .getLoginUserData()
                              .details[0]
                              .serialKey
                              .toLowerCase()
                              .trim() ==
                          "ONIX-ST17-P4AD-SA1D".toLowerCase().trim()
                  ? ListTile(
                      leading: Icon(Icons.login_outlined, color: colorPrimary),
                      title: Text("MapDistance",
                          softWrap: true,
                          style: new TextStyle(
                              fontSize: 15.0,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        navigateTo(context, MapScreen.routeName,
                            clearAllStack: true);
                      },
                    )
                  : Container(),
              ListTile(
                leading: Icon(Icons.login_outlined, color: colorPrimary),
                title: Text("LogOut",
                    softWrap: true,
                    style: new TextStyle(
                        fontSize: 15.0,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
                onTap: () {
                  // Constants.prefs.setBool("Registration", true);
                  //  Constants.prefs.setString("loggedIn", "");
                  //  Navigator.pushReplacementNamed(context, "/login");
                  // Get.to(LoginPage());
                  SharedPrefHelper.instance
                      .putBool(SharedPrefHelper.IS_LOGGED_IN_DATA, false);
                  navigateTo(context, FirstScreen.routeName,
                      clearAllStack: true);
                },
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "PowerBy : SharvayaInfotech",
              style: TextStyle(fontSize: 10, color: colorPrimary),
            ))
      ],
    )),
  );
}

getLeadList(List<ALL_Name_ID> sale, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: sale.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(sale[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(sale[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (sale[i].Name == "Customer")
              navigateTo(context, CustomerListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Inquiry")
              navigateTo(context, InquiryListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Quick Inquiry")
              navigateTo(context, QuickInquiryScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Follow-up")
              navigateTo(context, FollowupListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Quotation")
              navigateTo(context, QuotationListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "SalesBill")
              navigateTo(context, SalesBillListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Portal Leads")
              navigateTo(context, ExternalLeadListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Tele Caller") {
              navigateTo(context, TeleCallerNewListScreen.routeName,
                  clearAllStack: true);
            }
            if (sale[i].Name == "TeleCaller") {
              navigateTo(context, TeleCallerListScreen.routeName,
                  clearAllStack: true);
            }
            //navigateTo(context, TeleCallerListScreen.routeName, clearAllStack: true);
            if (sale[i].Name == "Quick Follow-up")
              navigateTo(context, QuickFollowupListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getSalesList(List<ALL_Name_ID> leads, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: leads.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(leads[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(leads[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (leads[i].Name == "SalesBill")
              navigateTo(context, SalesBillListScreen.routeName,
                  clearAllStack: true);
            if (leads[i].Name == "SalesOrder")
              navigateTo(context, SalesOrderListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getProductionList(List<ALL_Name_ID> sale, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: sale.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(sale[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(sale[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (sale[i].Name == "Packing Checklist")
              navigateTo(context, PackingChecklistScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Final Checking")
              navigateTo(context, FinalCheckingListScreen.routeName,
                  clearAllStack: true);
            if (sale[i].Name == "Installation") {
              navigateTo(context, InstallationListScreen.routeName,
                  clearAllStack: true);
            }

            if (sale[i].Name == "Production Activity") {
              navigateTo(context, ProductionActivityListScreen.routeName,
                  clearAllStack: true);
            }
          });
    },
  );
}

getPurchaseList(List<ALL_Name_ID> Purchase, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: Purchase.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading:
              Image.network(Purchase[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(Purchase[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (Purchase[i].Name == "Purchase Order")
              navigateTo(context, CustomerListScreen.routeName,
                  clearAllStack: true);
            if (Purchase[i].Name == "Purchase Order Approval")
              navigateTo(context, CustomerListScreen.routeName,
                  clearAllStack: true);
            if (Purchase[i].Name == "Purchase Bill")
              navigateTo(context, CustomerListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getAccountList(List<ALL_Name_ID> AccountList, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: AccountList.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(HR[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(AccountList[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (HR[i].Name == "BankVoucher")
              navigateTo(context, BankVoucherListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getHRList(List<ALL_Name_ID> HR, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: HR.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(HR[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(HR[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (HR[i].Name == "Leave Request")
              navigateTo(context, LeaveRequestListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Leave Approval")
              navigateTo(context, LeaveRequestApprovalListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Attendance")
              navigateTo(context, AttendanceListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Expense")
              navigateTo(context, ExpenseListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "BankVoucher")
              navigateTo(context, BankVoucherListScreen.routeName,
                  clearAllStack: true);

            if (HR[i].Name == "Employee")
              navigateTo(context, EmployeeListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Loan Approval")
              navigateTo(context, BankVoucherListScreen.routeName,
                  clearAllStack: true);

            if (HR[i].Name == "Missed Punch")
              navigateTo(context, MissedPunchListScreen.routeName,
                  clearAllStack: true);

            if (HR[i].Name == "Missed Punch Approval")
              navigateTo(context, BankVoucherListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Salary Adv/Upad")
              navigateTo(context, BankVoucherListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Loan Installments")
              navigateTo(context, LoanListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "Loan Approval")
              navigateTo(context, LoanApprovalListScreen.routeName,
                  clearAllStack: true);

            if (HR[i].Name == "Salary Adv/Upad")
              navigateTo(context, SalaryUpadListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getOfficeList(List<ALL_Name_ID> HR, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: HR.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading: Image.network(HR[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(HR[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (HR[i].Name == "Daily Activities")
              navigateTo(context, DailyActivityListScreen.routeName,
                  clearAllStack: true);
            if (HR[i].Name == "To-Do")
              navigateTo(context, ToDoListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

getSupportList(List<ALL_Name_ID> Support, BuildContext context) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: Support.length,
    itemBuilder: (context, i) {
      return ListTile(
          leading:
              Image.network(Support[i].Name1, height: 32, fit: BoxFit.fill),
          title: Text(Support[i].Name,
              softWrap: true,
              style: new TextStyle(fontSize: 15.0, color: colorPrimary)),
          onTap: () {
            if (Support[i].Name == "Complaint")
              navigateTo(context, ComplaintPaginationListScreen.routeName,
                  clearAllStack: true);
            if (Support[i].Name == "Attend Visit")
              navigateTo(context, AttendVisitListScreen.routeName,
                  clearAllStack: true);
            if (Support[i].Name == "Maintenance Contract")
              navigateTo(context, MaintenanceListScreen.routeName,
                  clearAllStack: true);
          });
    },
  );
}

ExpantionCustomer(BuildContext context, int index, customerdetails) {
  return ExpansionTile(
    //gif: 'lib/assets/gifs/bg_gif.gif',
    title: Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Customer",
            style: TextStyle(
              fontFamily: 'BalooBhai',
              fontSize: _fontSize_Label,
              color: Color(label_color),
            ),
          ),
          Text(
            customerdetails[index].customerName,
            style: TextStyle(
                fontFamily: 'BalooBhai',
                fontSize: _fontSize_Title,
                color: Color(title_color)),
          ),
        ],
      ),
    ),
    children: <Widget>[
      Container(
          margin: EdgeInsets.only(left: 50),
          child:
              /*Text("Content goes over here !",
              style: TextStyle(
                  fontFamily: 'BalooBhai',
                  fontSize: 20,
                  color: Colors.black)),*/
              Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*  Center(
            child: Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(right: 15),
                child: Image(image: AssetImage('images/user.png'))),
          ),*/
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("GST No  ",
                                      style: TextStyle(
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          fontStyle: FontStyle.italic,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].gSTNO == ""
                                          ? "N/A"
                                          : customerdetails[index].gSTNO,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Category  ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].customerType == ""
                                          ? "N/A"
                                          : customerdetails[index].customerType,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Source",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index]
                                                  .customerSourceName ==
                                              "--Not Available--"
                                          ? "N/A"
                                          : customerdetails[index]
                                              .customerSourceName,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Contact No1.",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].contactNo1 == ""
                                          ? "N/A"
                                          : customerdetails[index].contactNo1,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Contact No2.",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].contactNo2 == ""
                                          ? "N/A"
                                          : customerdetails[index].contactNo2,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Email",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].emailAddress == ""
                                          ? "N/A"
                                          : customerdetails[index].emailAddress,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Address",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].address == ""
                                          ? "N/A"
                                          : customerdetails[index].address,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Area",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].area == ""
                                          ? "N/A"
                                          : customerdetails[index].area,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Pin-Code",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].pinCode == ""
                                          ? "N/A"
                                          : customerdetails[index].pinCode,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("City",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].cityName == ""
                                          ? "N/A"
                                          : customerdetails[index].cityName,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("State",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].stateName == ""
                                          ? "N/A"
                                          : customerdetails[index].stateName,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Country",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].countryName == ""
                                          ? "N/A"
                                          : customerdetails[index].countryName,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("WebSite",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].websiteAddress ==
                                              ""
                                          ? "N/A"
                                          : customerdetails[index]
                                              .websiteAddress,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Created By",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].createdBy == ""
                                          ? "N/A"
                                          : customerdetails[index].createdBy,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ))
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Created Date",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Label,
                                          letterSpacing: .3)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      customerdetails[index].createdDate == ""
                                          ? "N/A"
                                          : customerdetails[index].createdDate,
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              )),
                          /* Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[
                                    Text("Created By",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            letterSpacing: .3)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(Customerdetails[index].createdBy == "" ?"N/A" : Customerdetails[index].createdBy,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            letterSpacing: .3)),
                                  ],
                                )
                            )*/
                        ]),
                    SizedBox(
                      height: sizeboxsize,
                    ),
                  ],
                ),
              ),
            ],
          ))
    ],
  );
}

///Customer ADD_EDIT Screen
Container MyCustomDropDown(String dropdownValue, Function getDetails) {
  return Container(
      child: DropdownButton<String>(
    isExpanded: true,
    value: dropdownValue,
    icon: const Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: const TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    items: <String>['One', 'Two', 'Free', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (String newValue) {
      getDetails(() {
        dropdownValue = newValue;
      });
    },
  ));
}

Widget buildCustomerTextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "User Name",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.person,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildContactNo1TextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "Contact No1",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildContactNo2TextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(right: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "Contact No2",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildGSTTextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "GST No",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildPANTextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(right: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "PAN No",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildEmailTextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(left: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "Email ID",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Widget buildWebSiteTextFiled(
    {TextEditingController
        userName_Controller} /*String Username,TextEditingController edt_UserName*/) {
  return Container(
    margin: const EdgeInsets.only(right: 20.0, top: 10.0),
    child: TextFormField(
      controller: userName_Controller,
      cursorColor: Colors.black,
      //initialValue: userName_Controller.text,
      decoration: InputDecoration(
        labelText: "WebSite",
        labelStyle: TextStyle(
          color: Color(0xFF000000),
        ),
        suffixIcon: Icon(
          Icons.phone_android,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF000000)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}

Container getDropDown(List<String> data, String selected, BuildContext context,
    ThemeData baseTheme, Function f) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12, right: 20),
            child: DropdownButton(
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
/*
                underline: Container(),
*/
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                icon: Container(
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(0 / 360),
                    child: Center(
                      child: Image.asset(
                        IC_DROP_DOWN_ARROW,
                        width: 20,
                        height: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                isExpanded: true,
                value: selected,
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

                /*data
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: baseTheme.textTheme.bodyText1)))
                    .toList()*/
                onChanged: f),
          ),
        ),
      ],
    ),
  );
}

showcustomdialog(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    TextEditingController controller2,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controller2.text = values[index].Name1 == null
                                    ? ""
                                    : values[index].Name1;
                                /* if(controller2!=null)
                                  {
                                    controller2.text = values[index].Name1==null?"":values[index].Name1;

                                  }*/
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      values[index].Name,
                                      style: TextStyle(color: colorPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

showcustomdialogWithOnlyName(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      values[index].Name,
                                      style: TextStyle(color: colorPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

/*showcustomdialogWithID(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        title: Text(lable),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controllerID.text =
                                    values[index].pkID.toString();
                                print(
                                    "IDSS : " + values[index].pkID.toString());
                              },
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(values[index].Name)),
                            );


                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),

        ],
      );
    },
  );
}*/

showcustomdialogWithID(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controllerID.text =
                                    values[index].pkID.toString();

                                print(
                                    "IDSS : " + values[index].pkID.toString());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        values[index].Name,
                                        style: TextStyle(
                                            color: colorPrimary, fontSize: 12),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

showcustomdialogWithLargeNameID(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controllerID.text =
                                    values[index].pkID.toString();

                                print(
                                    "IDSS : " + values[index].pkID.toString());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        values[index].Name,
                                        style: TextStyle(
                                            color: colorPrimary, fontSize: 12),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

showcustomdialogWithOtherCharges(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    TextEditingController controller1,
    TextEditingController controller2,
    TextEditingController controller3,
    TextEditingController controller4,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controllerID.text =
                                    values[index].pkID.toString();
                                controller1.text = values[index].TaxRate;
                                controller2.text = values[index].Taxtype;
                                controller3.text =
                                    values[index].isChecked.toString();

                                print(
                                    "IDSS : " + values[index].pkID.toString());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      values[index].Name,
                                      style: TextStyle(color: colorPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

showcustomdialogWithMultipleID(
    {List<ALL_Name_ID> values,
    BuildContext context1,
    TextEditingController controller,
    TextEditingController controllerID,
    TextEditingController controller2,
    String lable}) async {
  await showDialog(
    barrierDismissible: false,
    context: context1,
    builder: (BuildContext context123) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: colorPrimary, //                   <--- border color
              ),
              borderRadius: BorderRadius.all(Radius.circular(
                      15.0) //                 <--- border radius here
                  ),
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  lable,
                  style: TextStyle(
                      color: colorPrimary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        children: [
          SizedBox(
              width: MediaQuery.of(context123).size.width,
              child: Column(
                children: [
                  SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: <Widget>[
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context1).pop();
                                controller.text = values[index].Name;
                                controllerID.text =
                                    values[index].pkID.toString();
                                controller2.text =
                                    values[index].Name1.toString();
                                print(
                                    "IDSS : " + values[index].pkID.toString());
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, top: 10, bottom: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorPrimary), //Change color
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.5),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      values[index].Name,
                                      style: TextStyle(color: colorPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                          },
                          itemCount: values.length,
                        ),
                      ])),
                ],
              )),
          /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
        ],
      );
    },
  );
}

class CustomAnimatedPadding extends StatelessWidget {
  final Widget child;

  CustomAnimatedPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child);
  }
}
