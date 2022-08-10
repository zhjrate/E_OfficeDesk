import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/leave_request/leave_request_bloc.dart';
import 'package:soleoserp/models/api_requests/leave_request_save_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_type_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request/leave_request_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateLeaveRequestScreenArguments {
  LeaveRequestDetails editModel;

  AddUpdateLeaveRequestScreenArguments(this.editModel);
}

class LeaveRequestAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/LeaveRequestAddEditScreen';
  final AddUpdateLeaveRequestScreenArguments arguments;

  LeaveRequestAddEditScreen(this.arguments);

  @override
  _LeaveRequestAddEditScreenState createState() =>
      _LeaveRequestAddEditScreenState();
}

class _LeaveRequestAddEditScreenState
    extends BaseState<LeaveRequestAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController edt_fromDateController = TextEditingController();
  final TextEditingController edt_fromTimeController = TextEditingController();

  final TextEditingController edt_toDateController = TextEditingController();
  final TextEditingController edt_toTimeController = TextEditingController();

  final TextEditingController edt_leaveNotes = TextEditingController();

  final TextEditingController edt_LeaveType = TextEditingController();
  final TextEditingController edt_LeaveTypepkID = TextEditingController();
  final TextEditingController edt_EmployeeID = TextEditingController();
  final TextEditingController edt_EmployeeName = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_FolowupType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeaveType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  LeaveRequestScreenBloc _leaveRequestScreenBloc;
  int savepkID = 0;
  bool _isForUpdate;
  int LeavePkID = 0;
  TimeOfDay selectedInTime = TimeOfDay.now();
  TimeOfDay selectedOutTime = TimeOfDay.now();

  LeaveRequestDetails _editModel;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;
  //LeaveRequestTypeResponse _offlineLeaveRequestTypeResponseData;

  int CompanyID = 0;
  String LoginUserID = "";
  DateTime FromDate = DateTime.now();
  DateTime ToDate = DateTime.now();
  FocusNode LeaveAppliedForFocusNode;

  @override
  void initState() {
    super.initState();
    _leaveRequestScreenBloc = LeaveRequestScreenBloc(baseBloc);
    LeaveAppliedForFocusNode = FocusNode();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();
    // _offlineLeaveRequestTypeResponseData = SharedPrefHelper.instance.getLeaveRequestType();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);
    //_onLeaveRequestTypeSuccessResponse(_offlineLeaveRequestTypeResponseData);

    edt_LeaveType.addListener(() {
      LeaveAppliedForFocusNode.requestFocus();
    });

    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData(_editModel);
    } else {
      edt_fromDateController.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_toDateController.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();

      TimeOfDay selectedTime1234 = TimeOfDay(hour: 0, minute: 0);
      String AM_PM123 =
          selectedTime1234.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour123 = selectedTime1234.hourOfPeriod <= 9
          ? "0" + selectedTime1234.hourOfPeriod.toString()
          : selectedTime1234.hourOfPeriod.toString();
      String beforZerominute123 = selectedTime1234.minute <= 9
          ? "0" + selectedTime1234.minute.toString()
          : selectedTime1234.minute.toString();
      edt_fromTimeController.text = beforZeroHour123 +
          ":" +
          beforZerominute123 +
          " " +
          AM_PM123; //picked_s.periodOffset.toString();

      TimeOfDay selectedTime123 = TimeOfDay(hour: 11, minute: 59);
      String AM_PM1 =
          selectedTime123.periodOffset.toString() == "12" ? "AM" : "PM";
      edt_toTimeController.text = selectedTime123.hour.toString() +
          ":" +
          selectedTime123.minute.toString() +
          " " +
          AM_PM1; //picked_s.periodOffset.toString();

      edt_EmployeeName.text = _offlineLoggedInData.details[0].employeeName;
      edt_EmployeeID.text =
          _offlineLoggedInData.details[0].employeeID.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _leaveRequestScreenBloc,
      /* ..add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
            CompanyId: "8033", pkID: "", StatusCategory: "FollowUp"))),*/

      child: BlocConsumer<LeaveRequestScreenBloc, LeaveRequestStates>(
        builder: (BuildContext context, LeaveRequestStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, LeaveRequestStates state) {
          if (state is LeaveRequestSaveResponseState) {
            _onLeaveSaveStatusCallSuccess(state);
          }

          if (state is LeaveRequestTypeResponseState) {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is LeaveRequestSaveResponseState ||
              currentState is LeaveRequestTypeResponseState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Leave Request Details'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(Constant.CONTAINERMARGIN),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fromdateandtime(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        todateandtime(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildEmplyeeListView(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        showcustomdialogWithID1("Leave Type",
                            enable1: false,
                            title: "Type Of Leave ",
                            hintTextvalue: "Tap to Select Leave Type",
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorPrimary,
                            ),
                            controllerForLeft: edt_LeaveType,
                            controllerpkID: edt_LeaveTypepkID,
                            Custom_values1: arr_ALL_Name_ID_For_LeaveType),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Leave Applied For *",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorPrimary,
                                  fontWeight: FontWeight
                                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7, right: 7, top: 10),
                          child: TextFormField(
                            focusNode: LeaveAppliedForFocusNode,
                            controller: edt_leaveNotes,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Details',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: colorPrimary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        getCommonButton(baseTheme, () {
                          print("LeaveFromDate1" +
                              edt_fromDateController.text.toString() +
                              " " +
                              edt_fromTimeController.text.toString());
                          print("LeaveFromDate2" +
                              "Valid Date : " +
                              FromDate.isAfter(ToDate).toString() +
                              " From : " +
                              FromDate.toString() +
                              "TO : " +
                              ToDate.toString());
                          print("LeaveReverseDate" +
                              " From : " +
                              edt_fromDateController.text
                                  .getFormattedDate(
                                      fromFormat: "dd-MM-yyyy",
                                      toFormat: "yyyy-MM-dd")
                                  .toString() +
                              " ToDate : " +
                              edt_toDateController.text
                                  .getFormattedDate(
                                      fromFormat: "dd-MM-yyyy",
                                      toFormat: "yyyy-MM-dd")
                                  .toString() +
                              "Timeeee : " +
                              stringToTimeOfDay(edt_fromTimeController.text)
                                  .hour
                                  .toString() +
                              ":" +
                              stringToTimeOfDay(edt_fromTimeController.text)
                                  .minute
                                  .toString());
                          print("BothTimeValid" +
                              FromDate.isBefore(ToDate).toString() +
                              " Equal : " +
                              FromDate.isAtSameMomentAs(ToDate).toString());

                          bool isValidDate = FromDate.isBefore(
                              ToDate); // FromDate.isAtSameMomentAs(ToDate) ;
                          bool isequalTime = FromDate == ToDate;

                          /*if(edt_fromTimeController.text=="0:0:00.000")
                            {
                              edt_fromTimeController.text = "12:00 AM";
                            }*/
                          String TempFromDate = edt_fromDateController.text
                                  .getFormattedDate(
                                      fromFormat: "dd-MM-yyyy",
                                      toFormat: "yyyy-MM-dd")
                                  .toString() +
                              stringToTimeOfDay(edt_fromTimeController.text)
                                  .hour
                                  .toString() +
                              ":" +
                              stringToTimeOfDay(edt_fromTimeController.text)
                                  .minute
                                  .toString() +
                              ":00.000";
                          String TempToDate = edt_toDateController.text
                                  .getFormattedDate(
                                      fromFormat: "dd-MM-yyyy",
                                      toFormat: "yyyy-MM-dd")
                                  .toString() +
                              stringToTimeOfDay(edt_toTimeController.text)
                                  .hour
                                  .toString() +
                              ":" +
                              stringToTimeOfDay(edt_toTimeController.text)
                                  .minute
                                  .toString() +
                              ":00.000";
                          print("BothTimeFormatefromUI" +
                              " TempFromDate : " +
                              TempFromDate +
                              " TempToDate : " +
                              TempToDate);

                          print("RemoveDash" +
                              " TempFromDate : " +
                              RemoveMultipleChar(TempFromDate) +
                              " TempToDate : " +
                              RemoveMultipleChar(TempToDate));

                          double intime =
                              double.parse(RemoveMultipleChar(TempFromDate));
                          double outtime =
                              double.parse(RemoveMultipleChar(TempToDate));

                          List<String> aaaa =
                              edt_fromTimeController.text.toString().split(":");
                          List<String> bbbb =
                              edt_toTimeController.text.toString().split(":");

                          List<String> removeAMPM = aaaa[1].split(" ");
                          List<String> removeAMPM1 = bbbb[1].split(" ");

                          print("StrArrayy" +
                              "First" +
                              aaaa[0] +
                              "Second" +
                              removeAMPM[0] /*"Third"+aaaa[2]*/);
                          print("StrArrayy123" +
                              "First" +
                              bbbb[0] +
                              "Second" +
                              removeAMPM1[0] /*"Third"+aaaa[2]*/);

                          double Fromdatevalid = double.parse(
                              edt_fromDateController.text.replaceAll("-", "") +
                                  aaaa[0] +
                                  removeAMPM[0]);
                          double ToDateValid = double.parse(
                              edt_toDateController.text.replaceAll("-", "") +
                                  bbbb[0] +
                                  removeAMPM1[0]);

                          double Fromdatevalid1 = double.parse(
                              edt_fromDateController.text.replaceAll("-", ""));
                          double ToDateValid1 = double.parse(
                              edt_toDateController.text.replaceAll("-", ""));

                          print("StrArrayyDate" +
                              "From : " +
                              Fromdatevalid.toString() +
                              "ToDate : " +
                              ToDateValid.toString());

                          // print("ValidDateFromdouble" + "In-Time" + edt_fromDateController.text.toString()+edt_fromTimeController.text.toString() + " Out-Time" + edt_toDateController.text.toString() +edt_toTimeController.text.toString()+ "False" );

                          //  print("testdate" + "In-Time" + Fromdatevalid.toString()+ " Out-Time" + ToDateValid.toString() );

                          if (edt_fromDateController.text.toString() != "") {
                            if (edt_toDateController.text != "") {
                              if (edt_EmployeeName.text != "") {
                                if (edt_leaveNotes.text != "") {
                                  if (Fromdatevalid1 <= ToDateValid1) {
                                    print("ValidDateFromdouble" +
                                        "In-Time" +
                                        intime.toString() +
                                        " Out-Time" +
                                        outtime.toString() +
                                        "True");

                                    showCommonDialogWithTwoOptions(context,
                                        "Are you sure you want to Save this Leave Request?",
                                        negativeButtonTitle: "No",
                                        positiveButtonTitle: "Yes",
                                        onTapOfPositiveButton: () {
                                      Navigator.of(context).pop();

                                      _leaveRequestScreenBloc.add(LeaveRequestSaveCallEvent(
                                          LeavePkID,
                                          LeaveRequestSaveAPIRequest(
                                              CompanyId: CompanyID.toString(),
                                              EmployeeID: edt_EmployeeID.text,
                                              LeaveTypeID:
                                                  edt_LeaveTypepkID.text,
                                              FromDate: edt_fromDateController
                                                      .text
                                                      .getFormattedDate(
                                                          fromFormat:
                                                              "dd-MM-yyyy",
                                                          toFormat:
                                                              "yyyy-MM-dd")
                                                      .toString() +
                                                  " " +
                                                  stringToTimeOfDay(edt_fromTimeController.text)
                                                      .hour
                                                      .toString() +
                                                  ":" +
                                                  stringToTimeOfDay(edt_fromTimeController.text)
                                                      .minute
                                                      .toString() +
                                                  ":00.000",
                                              ToDate: edt_toDateController.text
                                                      .getFormattedDate(
                                                          fromFormat:
                                                              "dd-MM-yyyy",
                                                          toFormat:
                                                              "yyyy-MM-dd")
                                                      .toString() +
                                                  " " +
                                                  stringToTimeOfDay(edt_toTimeController.text)
                                                      .hour
                                                      .toString() +
                                                  ":" +
                                                  stringToTimeOfDay(edt_toTimeController.text)
                                                      .minute
                                                      .toString() +
                                                  ":00.000",
                                              ReasonForLeave:
                                                  edt_leaveNotes.text,
                                              shouldmail: "0",
                                              LoginUserID: LoginUserID)));
                                    });
                                  } else {
                                    print("ValidDateFromdouble" +
                                        "In-Time" +
                                        intime.toString() +
                                        " Out-Time" +
                                        outtime.toString() +
                                        "False");

                                    /*if(isequalTime==true)
                                      {



                                        showCommonDialogWithTwoOptions(
                                            context, "Are you sure you want to Save this Leave Request?",
                                            negativeButtonTitle: "No",
                                            positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
                                          Navigator.of(context).pop();

                                          _leaveRequestScreenBloc.add(LeaveRequestSaveCallEvent(LeavePkID,LeaveRequestSaveAPIRequest(
                                              CompanyId: CompanyID.toString(),
                                              EmployeeID: edt_EmployeeID.text,
                                              LeaveTypeID: edt_LeaveTypepkID.text,
                                              FromDate: edt_fromDateController.text.getFormattedDate(
                                                  fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString(),
                                              ToDate:  edt_toDateController.text.getFormattedDate(
                                                  fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString(),
                                              ReasonForLeave: edt_leaveNotes.text,
                                              shouldmail: "0",
                                              LoginUserID: LoginUserID
                                          )));
                                        });
                                      }
                                      else{*/
                                    showCommonDialogWithSingleOption(context,
                                        "FromTime should be less than ToTime ",
                                        positiveButtonTitle: "OK");
                                    /* }*/

                                  }
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Leave applied for is required!",
                                      positiveButtonTitle: "OK");
                                }
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Employee Name required!",
                                    positiveButtonTitle: "OK");
                              }
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "To date is required!",
                                  positiveButtonTitle: "OK");
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "From date is required!",
                                positiveButtonTitle: "OK");
                          }
                        }, "Save", backGroundColor: colorPrimary),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        /*getCommonButton(baseTheme, () {

                          print("LeaveFromDate1"+ edt_fromDateController.text.toString() +" "+ edt_fromTimeController.text.toString());
                          print("LeaveFromDate2"+ "Valid Date : "+ FromDate.isAfter(ToDate).toString());
                          print("LeaveReverseDate"+ " From : "+ edt_fromDateController.text.getFormattedDate(
                              fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString() + " ToDate : " + edt_toDateController.text.getFormattedDate(
                              fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString());

                          if(edt_fromDateController.text.toString() != "")
                          {
                            if(edt_toDateController.text != "")
                            {
                              if(edt_LeaveType.text != "")
                              {
                                if(edt_leaveNotes.text != "")
                                {
                                  if(FromDate.isBefore(ToDate))
                                  {
                                    final snackBar = SnackBar(
                                      content: Text('Leave Added Success full !'),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    _leaveRequestScreenBloc.add(LeaveRequestSaveCallEvent(LeavePkID,LeaveRequestSaveAPIRequest(
                                        CompanyId: CompanyID,
                                        EmployeeID: edt_EmployeeID.text,
                                        LeaveTypeID: edt_LeaveTypepkID.text,
                                        FromDate: edt_fromDateController.text.getFormattedDate(
                                            fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString(),
                                        ToDate:  edt_toDateController.text.getFormattedDate(
                                            fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd").toString(),
                                        ReasonForLeave: edt_leaveNotes.text,
                                        shouldmail: "1",
                                        LoginUserID: LoginUserID
                                    )));
                                  }
                                  else{
                                    print("ValidDate is "+ FromDate.isBefore(ToDate).toString() );
                                    showCommonDialogWithSingleOption(
                                        context, "FromDate should be less than ToDate ",
                                        positiveButtonTitle: "OK");
                                  }
                                }
                                else
                                {
                                  showCommonDialogWithSingleOption(
                                      context, "Leave applied for is required!",
                                      positiveButtonTitle: "OK");
                                }
                              }
                              else
                              {
                                showCommonDialogWithSingleOption(
                                    context, "Type of leave is required!",
                                    positiveButtonTitle: "OK");
                              }
                            }
                            else
                            {
                              showCommonDialogWithSingleOption(
                                  context, "To date is required!",
                                  positiveButtonTitle: "OK");
                            }
                          }
                          else
                          {
                            showCommonDialogWithSingleOption(
                                context, "From date is required!",
                                positiveButtonTitle: "OK");
                          }
                        }, "Save & Send Email", backGroundColor: colorPrimary),*/
                      ]))),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, LeaveRequestListScreen.routeName, clearAllStack: true);
  }

  String RemoveMultipleChar(String str) {
    str = str.replaceAll("-", "");
    str = str.replaceAll(":", "");
    str = str.replaceAll(".", "");
    // str = str.replaceAll('v', '<');
    return str;
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialog(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $Category"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight
                              .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: hintTextvalue,
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showcustomdialogWithID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _leaveRequestScreenBloc.add(LeaveRequestTypeCallEvent(
                LeaveRequestTypeAPIRequest(
                    pkID: "",
                    PageNo: "1",
                    PageSize: "1000",
                    LoginUserID: LoginUserID,
                    CompanyId: CompanyID))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 12,
                          color: colorPrimary,
                          fontWeight: FontWeight
                              .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: hintTextvalue,
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fillData(LeaveRequestDetails leaveRequestDetails) {
    print("LeaveDateee" + leaveRequestDetails.fromDate);
    edt_fromDateController.text = leaveRequestDetails.fromDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    edt_toDateController.text = leaveRequestDetails.toDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    FromDate = DateTime.parse(leaveRequestDetails.fromDate);
    ToDate = DateTime.parse(leaveRequestDetails.toDate);
    print("LeaveFromDate123" + FromDate.toString());
    print("LeaveToDate123" + ToDate.toString());

    edt_fromTimeController.text = leaveRequestDetails.fromDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "hh:mm a");
    //selectedInTime =

    edt_toTimeController.text = leaveRequestDetails.toDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "hh:mm a");
    edt_leaveNotes.text = leaveRequestDetails.reasonForLeave;
    edt_LeaveType.text = leaveRequestDetails.leaveType == "--Not Available--" ||
            leaveRequestDetails.leaveType == "N/A"
        ? ""
        : leaveRequestDetails.leaveType;
    edt_LeaveTypepkID.text = leaveRequestDetails.leaveTypeID.toString();
    edt_EmployeeName.text = leaveRequestDetails.employeeName.toString();
    edt_EmployeeID.text = leaveRequestDetails.employeeID.toString();
    LeavePkID = leaveRequestDetails.pkID;
  }

  Widget fromdateandtime() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(children: [
                    Text("From Date *",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight
                                .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                        ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                    elevation: 5,
                    color: colorLightGray,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: GestureDetector(
                      onTap: () {
                        _selectFromDate(context, edt_fromDateController);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                edt_fromDateController.text == null ||
                                        edt_fromDateController.text == ""
                                    ? "DD-MM-YYYY"
                                    : edt_fromDateController.text,
                                style: baseTheme.textTheme.headline3.copyWith(
                                    color: edt_fromDateController.text ==
                                                null ||
                                            edt_fromDateController.text == ""
                                        ? colorGrayDark
                                        : colorBlack),
                              ),
                            ),
                            Icon(
                              Icons.date_range,
                              color: colorPrimary,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 25),
              child: Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () {
                      _selectFromTime(context, edt_fromTimeController);
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 10),
                      alignment: Alignment.center,
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                              enabled: false,
                              controller: edt_fromTimeController,
                              decoration: InputDecoration(
                                hintText: "hh:mm",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        /* Icon(
                              Icons.watch_later_outlined,
                              color: colorGrayDark,
                            )*/
                      ]),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget todateandtime() {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(children: [
                    Text("To Date *",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight
                                .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                        ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                    elevation: 5,
                    color: colorLightGray,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: GestureDetector(
                      onTap: () {
                        _selectToDate(context, edt_toDateController);
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                edt_toDateController.text == null ||
                                        edt_toDateController.text == ""
                                    ? "DD-MM-YYYY"
                                    : edt_toDateController.text,
                                style: baseTheme.textTheme.headline3.copyWith(
                                    color: edt_toDateController.text == null ||
                                            edt_toDateController.text == ""
                                        ? colorGrayDark
                                        : colorBlack),
                              ),
                            ),
                            Icon(
                              Icons.date_range,
                              color: colorPrimary,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 25),
              child: Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    onTap: () {
                      _selectToTime(context, edt_toTimeController);
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20, right: 10),
                      alignment: Alignment.center,
                      child: Row(children: [
                        Expanded(
                          child: TextField(
                              enabled: false,
                              controller: edt_toTimeController,
                              decoration: InputDecoration(
                                hintText: "hh:mm",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        /* Icon(
                              Icons.watch_later_outlined,
                              color: colorGrayDark,
                            )*/
                      ]),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _onLeaveRequestTypeSuccessResponse(LeaveRequestTypeResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_LeaveType.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("description : " + state.response.details[i].description);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].description;
        all_name_id.pkID = state.response.details[i].pkID;
        arr_ALL_Name_ID_For_LeaveType.add(all_name_id);
      }

      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_LeaveType,
          context1: context,
          controller: edt_LeaveType,
          controllerID: edt_LeaveTypepkID,
          lable: "Select Leave Type");
    }
  }

  void _onFollowerEmployeeListByStatusCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.pkID = state.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialogWithID(
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_EmployeeName,
            controllerID: edt_EmployeeID,
            lable: "Select Employee");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Select Employee *",
                  style: TextStyle(
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight
                          .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                  ),
            ]),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 5,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: /* Text(
                        SelectedStatus =="" ?
                        "Tap to select Status" : SelectedStatus.Name,
                        style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),*/

                        TextField(
                      controller: edt_EmployeeName,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/
                      style: TextStyle(
                          color: Colors.black, // <-- Change this
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Tap to select employee"),
                    ),
                    // dropdown()
                  ),
                  /*  Icon(
                    Icons.arrow_drop_down,
                    color: colorGrayDark,
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onLeaveSaveStatusCallSuccess(
      LeaveRequestSaveResponseState state) async {
    print("SaveResponseLeave : " + state.response.toString());
    /* navigateTo(context, LeaveRequestListScreen.routeName,
        clearAllStack: true);*/
    Navigator.of(context).pop();
  }

  Future<void> _selectFromTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;

        String AM_PM =
            selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = selectedTime.hourOfPeriod <= 9
            ? "0" + selectedTime.hourOfPeriod.toString()
            : selectedTime.hourOfPeriod.toString();
        String beforZerominute = selectedTime.minute <= 9
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        edt_fromTimeController.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
      });
  }

  Future<void> _selectToTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;

        String AM_PM =
            selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = selectedTime.hourOfPeriod <= 9
            ? "0" + selectedTime.hourOfPeriod.toString()
            : selectedTime.hourOfPeriod.toString();
        String beforZerominute = selectedTime.minute <= 9
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        edt_toTimeController.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
      });
  }

  Future<void> _selectFromDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      edt_fromDateController.text = picked.day.toString() +
          "-" +
          picked.month.toString() +
          "-" +
          picked.year.toString();
    FromDate = picked;
    setState(() {
      //selectedDate = picked;

      /*  .text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();*/
    });
  }

  Future<void> _selectToDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) ToDate = picked;
    edt_toDateController.text = picked.day.toString() +
        "-" +
        picked.month.toString() +
        "-" +
        picked.year.toString();
    setState(() {
      //selectedDate = picked;

      /*  .text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();*/
    });
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
}
