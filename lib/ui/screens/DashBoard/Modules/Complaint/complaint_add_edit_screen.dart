import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/complaint/complaint_bloc.dart';
import 'package:soleoserp/models/api_requests/complaint_save_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/complaint_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/digital_signature.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/search_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/image_full_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateComplaintScreenArguments {
  ComplaintDetails editModel;

  AddUpdateComplaintScreenArguments(this.editModel);
}

class ComplaintAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/ComplaintAddEditScreen';
  final AddUpdateComplaintScreenArguments arguments;

  ComplaintAddEditScreen(this.arguments);

  @override
  _ComplaintAddEditScreenState createState() => _ComplaintAddEditScreenState();
}

/*class JosKeys {
  static final cardA = GlobalKey<ExpansionTileCardState>();
  static final refreshKey  = GlobalKey<RefreshIndicatorState>();
}*/
class _ComplaintAddEditScreenState extends BaseState<ComplaintAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController edt_ComplanitID = TextEditingController();

  final TextEditingController edt_ComplanitDate = TextEditingController();
  final TextEditingController edt_ReverseComplanitDate =
      TextEditingController();

  final TextEditingController edt_SheduleDate = TextEditingController();
  final TextEditingController edt_ReverseSheduleDate = TextEditingController();

  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerID = TextEditingController();

  final TextEditingController edt_Referene = TextEditingController();
  final TextEditingController edt_ComplaintDiscription =
      TextEditingController();
  final TextEditingController edt_PreferedTime = TextEditingController();
  final TextEditingController edt_AssignTo = TextEditingController();
  final TextEditingController edt_AssignToID = TextEditingController();

  final TextEditingController edt_satus = TextEditingController();
  final TextEditingController edt_satusID = TextEditingController();

  final TextEditingController edt_Type = TextEditingController();
  final TextEditingController edt_ComplaintNotes = TextEditingController();
  final TextEditingController edt_FromTime = TextEditingController();
  final TextEditingController edt_ToTime = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_AssignTo = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadSource = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Type = [];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  ComplaintScreenBloc _complaintScreenBloc;

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  ALL_EmployeeList_Response _offlineALLEmployeeListData;
  SearchDetails _searchDetails;
  bool _isForUpdate;
  int CompanyID = 0;
  String LoginUserID = "";
  ComplaintDetails _editModel;
  int savepkID = 0;
  String ComplaintNo = "";

  Uint8List data;

  @override
  void initState() {
    super.initState();
    _complaintScreenBloc = ComplaintScreenBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineALLEmployeeListData =
        SharedPrefHelper.instance.getALLEmployeeList();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    FetchAssignTODetails(_offlineALLEmployeeListData);
    FetchTypeDetails();

    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      edt_ComplanitID.text = "";
      selectedDate = DateTime.now();
      edt_ComplanitDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseComplanitDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
      edt_SheduleDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseSheduleDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      TimeOfDay selectedTime1234 = TimeOfDay.now();
      String AM_PM123 =
          selectedTime1234.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour123 = selectedTime1234.hourOfPeriod <= 9
          ? "0" + selectedTime1234.hourOfPeriod.toString()
          : selectedTime1234.hourOfPeriod.toString();
      String beforZerominute123 = selectedTime1234.minute <= 9
          ? "0" + selectedTime1234.minute.toString()
          : selectedTime1234.minute.toString();
      edt_FromTime.text = beforZeroHour123 +
          ":" +
          beforZerominute123 +
          " " +
          AM_PM123; //picked_s.periodOffset.toString();

      TimeOfDay selectedToTime =
          TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));
      String AM_PMToTime =
          selectedToTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHourToTime = selectedToTime.hourOfPeriod <= 9
          ? "0" + selectedToTime.hourOfPeriod.toString()
          : selectedToTime.hourOfPeriod.toString();
      String beforZerominuteToTime = selectedToTime.minute <= 9
          ? "0" + selectedToTime.minute.toString()
          : selectedToTime.minute.toString();
      edt_ToTime.text = beforZeroHourToTime +
          ":" +
          beforZerominuteToTime +
          " " +
          AM_PMToTime; //picked_s.periodOffset.toString();

      /* TimeOfDay selectedTime123 = TimeOfDay.now();
      TimeOfDay newTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));*/ /*selectedTime123.replacing(
          hour: selectedTime123.hour +2,
          minute: selectedTime123.minute
      );*/ /*

      String AM_PM1 = newTime.periodOffset.toString() == "12" ? "AM" : "PM";
      edt_ToTime.text = newTime.hour.toString() +
          ":" +
          newTime.minute.toString() +
          " " +
          AM_PM1; //picked_s.periodOffset.toString();*/

      setState(() {});
    }
  }

  ///listener to multiple states of bloc to handles api responses
  ///use only BlocListener if only need to listen to events
/*
  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerPaginationListScreenBloc, CustomerPaginationListScreenStates>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, CustomerPaginationListScreenStates state) {
        if (state is CustomerPaginationListScreenResponseState) {
          _onCustomerPaginationListScreenCallSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }
*/

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _complaintScreenBloc,
      child: BlocConsumer<ComplaintScreenBloc, ComplaintScreenStates>(
        builder: (BuildContext context, ComplaintScreenStates state) {
          /* if (state is ComplaintListResponseState) {
            _onGetListCallSuccess(state);
          }
          if (state is ComplaintSearchByIDResponseState) {
            _onSearchByIDCallSuccess(state);
          }*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          /*    if (currentState is ComplaintListResponseState || currentState is ComplaintSearchByIDResponseState) {
            return true;
          }*/
          return false;
        },
        listener: (BuildContext context, ComplaintScreenStates state) {
          //handle states
          /* if (state is ComplaintDeleteResponseState) {
            _onDeleteCallSuccess(state);
          }*/
          if (state is CustomerSourceCallEventResponseState) {
            _onLeadSourceListTypeCallSuccess(state);
          }
          if (state is ComplaintSaveResponseState) {
            _OnComplaintSaveResponseSucess(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is CustomerSourceCallEventResponseState ||
              currentState is ComplaintSaveResponseState) {
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
          title: Text('Complaint Details'),
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
                        _isForUpdate == true
                            ? _buildComplaintNo()
                            : Container(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildBankACSearchView(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Reference #",
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
                            controller: edt_Referene,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Reference #',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Complaint Description *",
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
                            controller: edt_ComplaintNotes,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Notes',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildNextFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Preferred Time",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorPrimary,
                                  fontWeight: FontWeight
                                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Card(
                                    elevation: 5,
                                    color: colorLightGray,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectFromTime(context, edt_FromTime);
                                      },
                                      child: Container(
                                        height: 60,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 10),
                                        alignment: Alignment.center,
                                        child: Row(children: [
                                          Expanded(
                                            child: TextField(
                                                enabled: false,
                                                controller: edt_FromTime,
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
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                child: Card(
                                    elevation: 5,
                                    color: colorLightGray,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _selectToTime(context, edt_ToTime);
                                      },
                                      child: Container(
                                        height: 60,
                                        margin: EdgeInsets.only(
                                            left: 20, right: 10),
                                        alignment: Alignment.center,
                                        child: Row(children: [
                                          Expanded(
                                            child: TextField(
                                                enabled: false,
                                                controller: edt_ToTime,
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
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildEmplyeeListView(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        showcustomdialogWithID1("Status",
                            enable1: false,
                            title: "Status",
                            hintTextvalue: "Tap to Select Status",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_satus,
                            controllerpkID: edt_satusID,
                            Custom_values1: arr_ALL_Name_ID_For_LeadSource),
                        CustomDropDown1("Type",
                            enable1: false,
                            title: "Type",
                            hintTextvalue: "Tap to Select Type",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Type,
                            Custom_values1: arr_ALL_Name_ID_For_Type),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        data != null
                            ? Center(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: Center(
                                    child: ImageFullScreenWrapperWidget(
                                      child: Image.memory(data),
                                      dark: true,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        getCommonButton(baseTheme, () {
                          // showcustomdialogSignature(context1: context);

                          navigateTo(context, MyDigitalSignature.routeName)
                              .then((value) {
                            if (value != null) {
                              data = value;
                              setState(() {});
                            }
                          });
                        }, "Add Signature", backGroundColor: colorPrimary),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        getCommonButton(baseTheme, () {
                          print("ComplaintDetails" +
                              "ComplaintDate : " +
                              edt_ComplanitDate.text +
                              " ComplaintReverseDate : " +
                              edt_ReverseComplanitDate.text +
                              " CustomerName : " +
                              edt_CustomerName.text +
                              " Customer ID : " +
                              edt_CustomerID.text +
                              " Reference : " +
                              edt_Referene.text +
                              " ComplaintNotes : " +
                              edt_ComplaintNotes.text +
                              " SheduleDate : " +
                              edt_SheduleDate.text +
                              " ReverseSheduleDate : " +
                              edt_ReverseSheduleDate.text +
                              " FromTime : " +
                              edt_FromTime.text +
                              " ToTime : " +
                              edt_ToTime.text +
                              " AssignTo : " +
                              edt_AssignTo.text +
                              " AssignToID : " +
                              edt_AssignToID.text +
                              " Status : " +
                              edt_satus.text +
                              " StatusID : " +
                              edt_satusID.text +
                              " Type : " +
                              edt_Type.text +
                              "");

                          if (edt_CustomerName.text != "") {
                            if (edt_ComplaintNotes.text != "") {
                              if (edt_SheduleDate.text != "") {
                                if (edt_AssignTo.text != "") {
                                  DateTime FbrazilianDate =
                                      new DateFormat("dd-MM-yyyy")
                                          .parse(edt_ComplanitDate.text);
                                  DateTime NbrazilianDate =
                                      new DateFormat("dd-MM-yyyy")
                                          .parse(edt_SheduleDate.text);

                                  if (FbrazilianDate.isBefore(NbrazilianDate)) {
                                    showCommonDialogWithTwoOptions(context,
                                        "Are you sure you want to Save this Complaint Details ?",
                                        negativeButtonTitle: "No",
                                        positiveButtonTitle: "Yes",
                                        onTapOfPositiveButton: () {
                                      Navigator.of(context).pop();
                                      _complaintScreenBloc.add(
                                          ComplaintSaveCallEvent(
                                              savepkID,
                                              ComplaintSaveRequest(
                                                  ComplaintDate:
                                                      edt_ReverseComplanitDate
                                                          .text,
                                                  ComplaintNo: ComplaintNo,
                                                  CustomerID: edt_CustomerID
                                                      .text,
                                                  ReferenceNo: edt_Referene
                                                              .text ==
                                                          null
                                                      ? ""
                                                      : edt_Referene.text,
                                                  ComplaintNotes:
                                                      edt_ComplaintNotes.text,
                                                  ComplaintType: edt_Type
                                                              .text ==
                                                          null
                                                      ? ""
                                                      : edt_Type.text,
                                                  ComplaintStatus:
                                                      edt_satus.text == null
                                                          ? ""
                                                          : edt_satus.text,
                                                  EmployeeID:
                                                      edt_AssignToID.text,
                                                  PreferredDate:
                                                      edt_ReverseSheduleDate
                                                          .text,
                                                  TimeFrom: edt_FromTime.text,
                                                  TimeTo: edt_ToTime.text,
                                                  LoginUserID: LoginUserID,
                                                  CompanyId:
                                                      CompanyID.toString())));
                                    });
                                  } else {
                                    if (FbrazilianDate.isAtSameMomentAs(
                                        NbrazilianDate)) {
                                      showCommonDialogWithTwoOptions(context,
                                          "Are you sure you want to Save this Complaint Details ?",
                                          negativeButtonTitle: "No",
                                          positiveButtonTitle: "Yes",
                                          onTapOfPositiveButton: () {
                                        Navigator.of(context).pop();
                                        _complaintScreenBloc
                                            .add(ComplaintSaveCallEvent(
                                                savepkID,
                                                ComplaintSaveRequest(
                                                    ComplaintDate:
                                                        edt_ReverseComplanitDate
                                                            .text,
                                                    ComplaintNo: ComplaintNo,
                                                    CustomerID: edt_CustomerID
                                                        .text,
                                                    ReferenceNo:
                                                        edt_Referene.text == null
                                                            ? ""
                                                            : edt_Referene.text,
                                                    ComplaintNotes:
                                                        edt_ComplaintNotes.text,
                                                    ComplaintType:
                                                        edt_Type
                                                                    .text ==
                                                                null
                                                            ? ""
                                                            : edt_Type.text,
                                                    ComplaintStatus:
                                                        edt_satus.text == null
                                                            ? ""
                                                            : edt_satus.text,
                                                    EmployeeID:
                                                        edt_AssignToID.text,
                                                    PreferredDate:
                                                        edt_ReverseSheduleDate
                                                            .text,
                                                    TimeFrom: edt_FromTime.text,
                                                    TimeTo: edt_ToTime.text,
                                                    LoginUserID: LoginUserID,
                                                    CompanyId:
                                                        CompanyID.toString())));
                                      });
                                    } else {
                                      showCommonDialogWithSingleOption(context,
                                          "Schedule Date Should be greater than Complaint Date !",
                                          positiveButtonTitle: "OK",
                                          onTapOfPositiveButton: () {
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  }
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Assign To is required !",
                                      onTapOfPositiveButton: () {
                                    Navigator.of(context).pop();
                                  });
                                }
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Schedule Date is required !",
                                    onTapOfPositiveButton: () {
                                  Navigator.of(context).pop();
                                });
                              }
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Complaint Notes is required !",
                                  onTapOfPositiveButton: () {
                                Navigator.of(context).pop();
                              });
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "Customer name is required !",
                                onTapOfPositiveButton: () {
                              Navigator.of(context).pop();
                            });
                          }
                        }, "Save", backGroundColor: colorPrimary),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                      ]))),
        ),
      ),
    );
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithOnlyName(
                values: arr_ALL_Name_ID_For_Type,
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
            onTap: () => _complaintScreenBloc.add(CustomerSourceCallEvent(
                CustomerSourceRequest(
                    pkID: "0",
                    StatusCategory: "ComplaintStatus",
                    companyId: CompanyID,
                    LoginUserID: LoginUserID,
                    SearchKey: ""))),
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

  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialogWithID(
            values: arr_ALL_Name_ID_For_AssignTo,
            context1: context,
            controller: edt_AssignTo,
            controllerID: edt_AssignToID,
            lable: "Select AssignTo");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Assigned To *",
                  style: TextStyle(
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight
                          .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                  ),
              /* Icon(
                Icons.filter_list_alt,
                color: colorPrimary,
              ),*/
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
                      controller: edt_AssignTo,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/
                      style: TextStyle(
                          color: Colors.black, // <-- Change this

                          fontSize: 15),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select Employee"),
                    ),
                    // dropdown()
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
    );
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

        edt_FromTime.text = beforZeroHour +
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

        edt_ToTime.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
      });
  }

  Widget _buildNextFollowupDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_SheduleDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Schedule Date *",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_SheduleDate.text == null || edt_SheduleDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_SheduleDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_SheduleDate.text == null ||
                                  edt_SheduleDate.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectNextFollowupDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_SheduleDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseSheduleDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Widget _buildFollowupDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, edt_ComplanitDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Complaint Date *",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_ComplanitDate.text == null ||
                              edt_ComplanitDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_ComplanitDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_ComplanitDate.text == null ||
                                  edt_ComplanitDate.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComplaintNo() {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Complaint No",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_ComplanitID.text == null || edt_ComplanitID.text == ""
                          ? "Complaint No."
                          : edt_ComplanitID.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_ComplanitID.text == null ||
                                  edt_ComplanitID.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_ComplanitDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseComplanitDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Widget _buildBankACSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfBankACSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Customer Name * ",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: edt_CustomerName,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Search Customer",
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
                    Icons.search,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapOfBankACSearchView() async {
    if (_isForUpdate == false) {
      navigateTo(context, SearchComplaintCustomerScreen.routeName)
          .then((value) {
        if (value != null) {
          _searchDetails = value;
          edt_CustomerID.text = _searchDetails.value.toString();
          edt_CustomerName.text = _searchDetails.label.toString();

          /*  _FollowupBloc.add(SearchBankVoucherCustomerListByNameCallEvent(
              CustomerLabelValueRequest(
                  CompanyId: CompanyID.toString(),
                  LoginUserID: "admin",
                  word: _searchDetails.value.toString())));*/

        }
        print("CustomerInfo : " +
            edt_CustomerName.text.toString() +
            " CustomerID : " +
            edt_CustomerID.text.toString());
      });
    }
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, ComplaintPaginationListScreen.routeName,
        clearAllStack: true);
  }

  FetchAssignTODetails(ALL_EmployeeList_Response offlineALLEmployeeListData) {
    arr_ALL_Name_ID_For_AssignTo.clear();
    for (var i = 0; i < offlineALLEmployeeListData.details.length; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      all_name_id.Name = offlineALLEmployeeListData.details[i].employeeName;
      all_name_id.pkID = offlineALLEmployeeListData.details[i].pkID;

      arr_ALL_Name_ID_For_AssignTo.add(all_name_id);
    }
  }

  void fillData() {
    if (_editModel.complaintDate == "") {
      selectedDate = DateTime.now();
      edt_ComplanitDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseComplanitDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
    } else {
      edt_ComplanitDate.text = _editModel.complaintDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseComplanitDate.text = _editModel.complaintDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }
    if (_editModel.preferredDate == "") {
      selectedDate = DateTime.now();

      edt_SheduleDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseSheduleDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
    } else {
      edt_SheduleDate.text = _editModel.preferredDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseSheduleDate.text = _editModel.preferredDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }
    savepkID = _editModel.pkID.toInt();
    edt_CustomerName.text = _editModel.customerName;
    edt_CustomerID.text = _editModel.customerID.toString();
    edt_Referene.text = _editModel.referenceNo;
    edt_ComplaintNotes.text = _editModel.complaintNotes;

    if (_editModel.timeFrom == "") {
      TimeOfDay selectedTime1234 = TimeOfDay.now();
      String AM_PM123 =
          selectedTime1234.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour123 = selectedTime1234.hourOfPeriod <= 9
          ? "0" + selectedTime1234.hourOfPeriod.toString()
          : selectedTime1234.hourOfPeriod.toString();
      String beforZerominute123 = selectedTime1234.minute <= 9
          ? "0" + selectedTime1234.minute.toString()
          : selectedTime1234.minute.toString();
      edt_FromTime.text = beforZeroHour123 +
          ":" +
          beforZerominute123 +
          " " +
          AM_PM123; //picked_s.periodOffset.toString();

    } else {
      edt_FromTime.text = _editModel.timeFrom.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "hh:mm a");
    }
    if (_editModel.timeTo == "") {
      TimeOfDay selectedToTime =
          TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));
      String AM_PMToTime =
          selectedToTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHourToTime = selectedToTime.hourOfPeriod <= 9
          ? "0" + selectedToTime.hourOfPeriod.toString()
          : selectedToTime.hourOfPeriod.toString();
      String beforZerominuteToTime = selectedToTime.minute <= 9
          ? "0" + selectedToTime.minute.toString()
          : selectedToTime.minute.toString();
      edt_ToTime.text =
          beforZeroHourToTime + ":" + beforZerominuteToTime + " " + AM_PMToTime;
    } else {
      edt_ToTime.text = _editModel.timeTo.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "hh:mm a");
    }

    //selectedInTime =

    edt_AssignTo.text = _editModel.employeeName;
    edt_AssignToID.text = _editModel.employeeID.toString();
    edt_satus.text =
        _editModel.complaintStatus == "0" ? "" : _editModel.complaintStatus;
    edt_Type.text = _editModel.complaintType;
    edt_ComplanitID.text = _editModel.complaintNo;
  }

  void _onLeadSourceListTypeCallSuccess(
      CustomerSourceCallEventResponseState state) {
    if (state.sourceResponse.details.length != 0) {
      arr_ALL_Name_ID_For_LeadSource.clear();
      for (var i = 0; i < state.sourceResponse.details.length; i++) {
        print(
            "InquiryStatus : " + state.sourceResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.sourceResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.sourceResponse.details[i].pkID;
        arr_ALL_Name_ID_For_LeadSource.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_LeadSource,
          context1: context,
          controller: edt_satus,
          controllerID: edt_satusID,
          lable: "Select Status");
    }
  }

  FetchTypeDetails() {
    arr_ALL_Name_ID_For_Type.clear();
    for (var i = 0; i <= 1; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Online";
      } else if (i == 1) {
        all_name_id.Name = "Offline";
      }
      arr_ALL_Name_ID_For_Type.add(all_name_id);
    }
  }

  void _OnComplaintSaveResponseSucess(ComplaintSaveResponseState state) async {
    String Msg = "";
    for (var i = 0; i < state.complaintSaveResponse.details.length; i++) {
      print("SAveSucesss" + state.complaintSaveResponse.details[i].column2);
      Msg = _isForUpdate == true
          ? "Complaint Updated Successfully"
          : "Complaint Added Successfully";
    }
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");

    Navigator.of(context).pop();
  }
}
