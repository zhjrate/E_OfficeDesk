import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:soleoserp/blocs/other/bloc_modules/dailyactivity/dailyactivity_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/expense/expense_bloc.dart';
import 'package:soleoserp/models/api_requests/task_category_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/daily_activity_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/daily_activity/daily_activity_list/daily_activity_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/image_full_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateDailyActivityRequestScreenArguments {
  DailyActivityDetails editModel;

  AddUpdateDailyActivityRequestScreenArguments(this.editModel);
}

class DailyActivityAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/DailyActivityAddEditScreen';
  final AddUpdateDailyActivityRequestScreenArguments arguments;

  DailyActivityAddEditScreen(this.arguments);

  @override
  _DailyActivityAddEditScreenState createState() =>
      _DailyActivityAddEditScreenState();
}

class _DailyActivityAddEditScreenState
    extends BaseState<DailyActivityAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController edt_ExpenseDateController =
      TextEditingController();
  final TextEditingController edt_ReverseExpenseDateController =
      TextEditingController();

  final TextEditingController edt_ExpenseNotes = TextEditingController();

  final TextEditingController edt_ExpenseType = TextEditingController();
  final TextEditingController edt_ExpenseTypepkID = TextEditingController();
  final TextEditingController edt_ExpenseAmount = TextEditingController();
  final TextEditingController edt_FromLocation = TextEditingController();
  final TextEditingController edt_ToLocation = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeaveType = [];

  DateTime selectedDate = DateTime.now();
  DailyActivityScreenBloc _expenseBloc;
  int savepkID = 0;
  bool _isForUpdate;
  int ExpensepkID = 0;

  DailyActivityDetails _editModel;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  //ExpenseTypeResponse _offlineExpenseType;

  int CompanyID = 0;
  String LoginUserID = "";

  DateTime FromDate = DateTime.now();
  DateTime ToDate = DateTime.now();
  bool is_visibleLocation;
  List<File> multiple_selectedImageFile = [];
  File _selectedImageFile;
  List<ALL_Name_ID> arr_ImageList = [];

  String fileName = "";

  String SiteURL = "";
  String ImageURLFromListing = "";
  String GetImageNamefromEditMode = "";
  FocusNode AmountFocusNode, FromLocationFocusNode;

  @override
  void initState() {
    super.initState();
    _expenseBloc = DailyActivityScreenBloc(baseBloc);
    AmountFocusNode = FocusNode();
    FromLocationFocusNode = FocusNode();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    //_offlineExpenseType = SharedPrefHelper.instance.getExpenseType();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    SiteURL = _offlineCompanyData.details[0].siteURL;
    //_onLeaveRequestTypeSuccessResponse(_offlineExpenseType);
    edt_ExpenseDateController.text = selectedDate.day.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.year.toString();

    edt_ReverseExpenseDateController.text = selectedDate.year.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.day.toString();

    _isForUpdate = widget.arguments != null;
    edt_ExpenseType.addListener(() {
      if (edt_ExpenseType.text == "Petrol") {
        FromLocationFocusNode.requestFocus();
      } else {
        AmountFocusNode.requestFocus();
      }
    });

    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData(_editModel);
    }

    is_visibleLocation = false;
    edt_ExpenseType.addListener(() {
      if (edt_ExpenseType.text == "Petrol") {
        is_visibleLocation = true;
      } else {
        is_visibleLocation = false;
      }
      setState(() {});
    });

    /*   List lst123 = "Expense Added Successfully !10047".split("!");
    String RetrunPkID = lst123[1].toString();
    print("SaveReturnPKID : " + RetrunPkID);
*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _expenseBloc,
      /*..add(ExpenseTypeByNameCallEvent(
            ExpenseTypeAPIRequest(CompanyId: CompanyID.toString()))),*/
      /* ..add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
            CompanyId: "8033", pkID: "", StatusCategory: "FollowUp"))),*/

      child: BlocConsumer<DailyActivityScreenBloc, DailyActivityScreenStates>(
        builder: (BuildContext context, DailyActivityScreenStates state) {
          /*  if(state is LeaveRequestTypeResponseState)
          {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          if(state is LeaveRequestEmployeeListResponseState)
          {
            _onFollowerEmployeeListByStatusCallSuccess(state);
          }*/

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, DailyActivityScreenStates state) {
          if (state is TaskCategoryCallResponseState) {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          if (state is DailyActivitySaveCallResponseState) {
            _onLeaveSaveStatusCallSuccess(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is TaskCategoryCallResponseState ||
              currentState is DailyActivitySaveCallResponseState) {
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
          title: Text('Daily Activities Details'),
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
                        _buildFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        showcustomdialogWithID1("Type Of Work",
                            enable1: false,
                            title: "Type Of Work *",
                            hintTextvalue: "Tap to Select Work Type",
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorPrimary,
                            ),
                            controllerForLeft: edt_ExpenseType,
                            controllerpkID: edt_ExpenseTypepkID,
                            Custom_values1: arr_ALL_Name_ID_For_LeaveType),
                        Visibility(
                            visible: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 15,
                                ),
                                FromLocation(),
                                SizedBox(
                                  width: 20,
                                  height: 15,
                                ),
                                ToLocation(),
                              ],
                            )),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        ExpenseAmount(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Work Notes *",
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
                            controller: edt_ExpenseNotes,
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
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        getCommonButton(baseTheme, () {
                          /*   if(arr_ImageList.length!=0)
                            {
                              for(var i=0;i<arr_ImageList.length;i++)
                                {
                                  print("getImageNameFromNetworkURL : " + arr_ImageList[i].Name + " Only Image Name : " + arr_ImageList[i].Name1);
                                  multiple_selectedImageFile.add(fileFromDocsDir(arr_ImageList[i].Name1));

                                }
                            }*/

                          if (multiple_selectedImageFile.length != 0) {
                            for (var i = 0;
                                i < multiple_selectedImageFile.length;
                                i++) {
                              print("GetImageFileFromDevice : " +
                                  "Path : " +
                                  multiple_selectedImageFile[i]
                                      .path
                                      .toString() +
                                  "ImageName" +
                                  multiple_selectedImageFile[i]
                                      .path
                                      .split('/')
                                      .last);
                            }
                          }

                          /*if(_selectedImageFile.path !=null)
                            {

                            }

                          String fileName = _selectedImageFile.path.split('/').last;*/

                          print("ImageNAme " + fileName);

                          print("LeaveFromDate1" +
                              edt_ExpenseDateController.text.toString() +
                              " ");
                          print("LeaveFromDate2" +
                              "Valid Date : " +
                              FromDate.isAfter(ToDate).toString());
                          print("LeaveReverseDate" +
                              " From : " +
                              edt_ExpenseDateController.text
                                  .getFormattedDate(
                                      fromFormat: "dd-MM-yyyy",
                                      toFormat: "yyyy-MM-dd")
                                  .toString());

                          if (edt_ExpenseDateController.text.toString() != "") {
                            if (edt_ExpenseType.text != "") {
                              if (edt_ExpenseAmount.text != "") {
                                if (edt_ExpenseNotes.text != "") {
                                  showCommonDialogWithTwoOptions(context,
                                      "Are you sure you want to Save DailyActivity Details ?",
                                      negativeButtonTitle: "No",
                                      positiveButtonTitle: "Yes",
                                      onTapOfPositiveButton: () {
                                    Navigator.of(context).pop();

                                    SendEmail();

                                    /*_expenseBloc.add(DailyActivitySaveByNameCallEvent(
                                            ExpensepkID,
                                            DailyActivitySaveRequest(
                                              CompanyId: CompanyID.toString(),
                                              ActivityDate: edt_ReverseExpenseDateController.text,
                                              TaskCategoryID: edt_ExpenseTypepkID.text,
                                              TaskDuration: edt_ExpenseAmount.text,
                                              LoginUserID: LoginUserID,
                                              TaskDescription: edt_ExpenseNotes.text
                                            )));*/
                                  });
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Work Note is required!",
                                      positiveButtonTitle: "OK");
                                }
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Work Hrs. is required!",
                                    positiveButtonTitle: "OK");
                              }
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Type of Work is required!",
                                  positiveButtonTitle: "OK");
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "Select Date is required!",
                                positiveButtonTitle: "OK");
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

  Future<bool> _onBackPressed() {
    navigateTo(context, DailyActivityListScreen.routeName, clearAllStack: true);
  }

  /*Future<int> deleteFile(File file123) async {
    try {
      final file = await file123.path;

      await file123.delete();
    } catch (e) {
      return 0;
    }
  }*/

  Widget ExpenseAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Worked Hrs *",
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
                      focusNode: AmountFocusNode,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: edt_ExpenseAmount,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Hrs.",
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
                  Icons.access_time,
                  size: 18,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget FromLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("From Location",
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
                      focusNode: FromLocationFocusNode,
                      textInputAction: TextInputAction.next,
                      controller: edt_FromLocation,
                      decoration: InputDecoration(
                        hintText: "Tap to enter location",
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
                  Icons.location_on,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget ToLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("To Location",
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
                      textInputAction: TextInputAction.next,
                      controller: edt_ToLocation,
                      decoration: InputDecoration(
                        hintText: "Tap to enter location",
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
                  Icons.location_on,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
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
            onTap: () => _expenseBloc
              ..add(TaskCategoryListCallEvent(TaskCategoryListRequest(
                  pkID: "", CompanyId: CompanyID.toString()))),
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

  void fillData(DailyActivityDetails expenseDetails) async {
    print("LeaveDateee" + expenseDetails.createdDate);

    //_expenseBloc.add(FetchImageListByExpensePKID_RequestCallEvent(FetchImageListByExpensePKID_Request(CompanyId: CompanyID.toString(),ExpenseID: expenseDetails.pkID.toString())));

    edt_ExpenseDateController.text = expenseDetails.createdDate
        .getFormattedDate(
            fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    edt_ReverseExpenseDateController.text = expenseDetails.createdDate
        .getFormattedDate(
            fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    print("LeaveFromDate" + FromDate.toString());

    /* try {
      var imageId = await ImageDownloader.downloadImage(SiteURL+"otherimages/"+expenseDetails.expenseImage);
      if (imageId == null) {
        return;
      }
      var path = await ImageDownloader.findPath(imageId);
      print("ImageFilePathfromAPI123" + path.toString());
      _selectedImageFile = File(path);

    } on PlatformException catch (error) {
      print(error);
    }*/

    edt_ExpenseNotes.text = expenseDetails.taskDescription;
    edt_ExpenseType.text =
        expenseDetails.taskCategoryName == "--Not Available--" ||
                expenseDetails.taskCategoryName == "N/A"
            ? ""
            : expenseDetails.taskCategoryName;
    edt_ExpenseTypepkID.text = expenseDetails.taskCategoryID.toString();
    ExpensepkID = expenseDetails.pkID;
    edt_ExpenseAmount.text = expenseDetails.taskDuration.toString();
  }

  Widget _buildFollowupDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, edt_ExpenseDateController);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Select Date *",
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
                      edt_ExpenseDateController.text == null ||
                              edt_ExpenseDateController.text == ""
                          ? "DD-MM-YYYY"
                          : edt_ExpenseDateController.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_ExpenseDateController.text == null ||
                                  edt_ExpenseDateController.text == ""
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

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_ExpenseDateController.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseExpenseDateController.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  void _onLeaveRequestTypeSuccessResponse(TaskCategoryCallResponseState state) {
    if (state.taskCategoryResponse.details.length != 0) {
      arr_ALL_Name_ID_For_LeaveType.clear();
      for (var i = 0; i < state.taskCategoryResponse.details.length; i++) {
        print("description : " +
            state.taskCategoryResponse.details[i].taskCategoryName);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.taskCategoryResponse.details[i].taskCategoryName;
        all_name_id.pkID = state.taskCategoryResponse.details[i].pkID;
        arr_ALL_Name_ID_For_LeaveType.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_LeaveType,
          context1: context,
          controller: edt_ExpenseType,
          controllerID: edt_ExpenseTypepkID,
          lable: "Select Work Type");
    }
  }

  void _onLeaveSaveStatusCallSuccess(DailyActivitySaveCallResponseState state) {
    print("SaveResponseLeave : " +
        state.dailyActivitySaveResponse.details[0].column3.toString());
    String Msg = _isForUpdate == true
        ? "DailyActivity Updated Successfully !"
        : "DailyActivity Added Successfully !";

    /* await showCommonDialogWithSingleOption(Globals.context,Msg,
        positiveButtonTitle: "OK");
    Navigator.of(context).pop();*/

    showCommonDialogWithSingleOption(context, Msg, positiveButtonTitle: "OK",
        onTapOfPositiveButton: () {
      navigateTo(context, DailyActivityListScreen.routeName,
          clearAllStack: true);
    });
    //navigateTo(context, routeName)
  }

  Widget uploadImage(BuildContext context123) {
    return Column(
      children: [
        /* if (multiple_selectedImageFile.length == 0)
          _isForUpdate //edit mode or not
                ? Container(
            height: 400,

                    child: arr_ImageList.length!=0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Flexible(
                                child:
                                ListView.builder(

                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {


                                      return Container(
                                        margin: EdgeInsets.all(5),
                                        height: 200,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: colorLightGray,
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10)),

                                              ),
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ImageFullScreenWrapperWidget(
                                                  child:
                                                  Image(
                                                    width: 125,
                                                    height: 125,
                                                    image: NetworkToFileImage(
                                                      url: arr_ImageList[index].Name,
                                                      file: fileFromDocsDir(arr_ImageList[index].Name1),
                                                      debug: true,
                                                    ),
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Text('Download image failed.');
                                                    },
                                                  ),
                                                  dark: true,
                                                ),
                                              ),
                                            ),


                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: colorGray,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)),
                                                  ),

                                                  child: GestureDetector(
                                                    onTap: () {
                                                      showCommonDialogWithTwoOptions(context,
                                                          "Are you sure you want to delete this Image ?",
                                                          negativeButtonTitle: "No",
                                                          positiveButtonTitle: "Yes",
                                                          onTapOfPositiveButton: () {
                                                            Navigator.of(context).pop();
                                                            _expenseBloc.add(
                                                                ExpenseDeleteImageNameCallEvent(
                                                                    ExpensepkID,
                                                                    ExpenseDeleteImageRequest(
                                                                        CompanyId: CompanyID
                                                                            .toString())));                                                            setState(() {

                                                            });
                                                          });
                                                    },
                                                    child: Icon(
                                                      Icons.delete_forever,
                                                      size: 32,
                                                      color: colorPrimary,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      );



                                  },
                                  shrinkWrap: true,
                                  itemCount: arr_ImageList.length,
                                ),
                              ),

                            ],
                          )
                        : Container())
                : Container() else
                  Container(
          height: 200,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Flexible(
                child:
                ListView.builder(

                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if(_selectedImageFile==null)
                      {
                         return Container();

                      }
                    else
                      {
                        return Container(
                          margin: EdgeInsets.all(5),
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [




                               Container(

                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: colorLightGray,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),

                                      ),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ImageFullScreenWrapperWidget(
                                          child: Image.file(multiple_selectedImageFile[index],
                                            height: 125,
                                            width: 125,
                                          ),
                                          dark: true,
                                        ),
                                      ),
                                    ),


                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: colorGray,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                    ),

                                    child: GestureDetector(
                                      onTap: () {
                                        showCommonDialogWithTwoOptions(context,
                                            "Are you sure you want to delete this Image ?",
                                            negativeButtonTitle: "No",
                                            positiveButtonTitle: "Yes",
                                            onTapOfPositiveButton: () {
                                              Navigator.of(context).pop();
                                              multiple_selectedImageFile.removeAt(index);
                                              setState(() {

                                              });
                                            });
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: 32,
                                        color: colorPrimary,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        );

                      }

                  },
                  shrinkWrap: true,
                  itemCount: multiple_selectedImageFile.length,
                ),
              )
            ],
          ),
        ),*/

        if (multiple_selectedImageFile.length != 0)
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /* if(multiple_selectedImageFile==null)
                      {
                        return Container();

                      }
                      else
                      {*/
                      return Container(
                        margin: EdgeInsets.all(5),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: colorLightGray,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImageFullScreenWrapperWidget(
                                  child: Image.file(
                                    multiple_selectedImageFile[index],
                                    height: 125,
                                    width: 125,
                                  ),
                                  dark: true,
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  // padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: colorGray,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),

                                  child: GestureDetector(
                                    onTap: () {
                                      showCommonDialogWithTwoOptions(context,
                                          "Are you sure you want to delete this Image ?",
                                          negativeButtonTitle: "No",
                                          positiveButtonTitle: "Yes",
                                          onTapOfPositiveButton: () {
                                        Navigator.of(context).pop();
                                        multiple_selectedImageFile
                                            .removeAt(index);
                                        setState(() {});
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      size: 32,
                                      color: colorPrimary,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      );

                      // }
                    },
                    shrinkWrap: true,
                    itemCount: multiple_selectedImageFile.length,
                  ),
                )
              ],
            ),
          )
        else
          Container(),
        getCommonButton(baseTheme, () {
          pickImage(context, onImageSelection: (file) {
            _selectedImageFile = file;
            multiple_selectedImageFile.add(_selectedImageFile);
            baseBloc.refreshScreen();
          });
        }, "Upload Image", backGroundColor: Colors.indigoAccent)
      ],
    );
  }

  void _onExpenseUploadImageCallSuccess(
      ExpenseUploadImageCallResponseState state) async {
    /* for(var i=0;i<multiple_selectedImageFile.length;i++)
    _expenseBloc.add(ExpenseImageUploadServerNameCallEvent(
        ExpenseImageUploadServerAPIRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID,
            ExpenseID: ExpensepkID.toString(),
            Name: multiple_selectedImageFile[i].path.split('/').last,
            Type: edt_ExpenseTypepkID.text)));*/
    String Msg = _isForUpdate == true
        ? "Expense Updated Successfully123 !"
        : "Expense Added Successfully !";

    /* showCommonDialogWithSingleOption(context, Msg, positiveButtonTitle: "OK",
        onTapOfPositiveButton: () {
          navigateTo(context, ExpenseListScreen.routeName, clearAllStack: true);
        });*/
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");
    Navigator.of(context).pop();
  }

  void _onExpenseUploadImageServerCallSuccess(
      ExpenseImageUploadServerCallResponseState state) async {
    print("RetrunMsgFromAPI : " +
        " Response :  " +
        state.expenseImageUploadServerAPIResponse.details[0].column2);
    String Msg = _isForUpdate == true
        ? "Expense Updated Successfully !"
        : "Expense Added Successfully !";

    /* showCommonDialogWithSingleOption(context, Msg, positiveButtonTitle: "OK",
        onTapOfPositiveButton: () {
      _selectedImageFile.delete(recursive: true);
      navigateTo(context, ExpenseListScreen.routeName, clearAllStack: true);
    });*/
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");
    Navigator.of(context).pop();
  }

  void _onExpenseDeleteImageCallSuccess(
      ExpenseDeleteImageCallResponseState state) {
    _isForUpdate = false;
    setState(() {});
  }

  openFullScreenImage(File multiple_selectedImageFile123) {
    /* return FullScreenWidget(
       child: Hero(
         tag: "customTag",
         child: ClipRRect(
           borderRadius: BorderRadius.circular(16),
           child: Image.file(
             multiple_selectedImageFile123,
             fit: BoxFit.cover,
           ),
         ),
       ),
     );
*/
    return ImageFullScreenWrapperWidget(
      child: Image.file(multiple_selectedImageFile123),
      dark: true,
    );
  }

  Widget fullScreenImage() => FullScreenWidget(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            IMG_HEADER_LOGO,
            fit: BoxFit.cover,
          ),
        ),
      );

  void _onFetchImageListResponse(
      FetchImageListByExpensePKID_ResponseState state) async {
    arr_ImageList.clear();
    multiple_selectedImageFile.clear();
    if (state.fetchImageListByExpensePKID_Response.details.length != 0) {
      for (var i = 0;
          i < state.fetchImageListByExpensePKID_Response.details.length;
          i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = SiteURL +
            "otherimages/" +
            state.fetchImageListByExpensePKID_Response.details[i].name
                .toString();
        all_name_id.Name1 = state
            .fetchImageListByExpensePKID_Response.details[i].name
            .toString();
        arr_ImageList.add(all_name_id);
        File fetchimage = await _fileFromImageUrl(
            SiteURL +
                "otherimages/" +
                state.fetchImageListByExpensePKID_Response.details[i].name
                    .toString(),
            state.fetchImageListByExpensePKID_Response.details[i].name
                .toString());
        /*NetworkToFileImage(
              url: SiteURL+"otherimages/"+state.fetchImageListByExpensePKID_Response.details[i].name.toString(),
              file: fileFromDocsDir(state.fetchImageListByExpensePKID_Response.details[i].name.toString()),
              debug: true,
            );*/
        print("ImageURL335" + "Image : " + fetchimage.path);
        multiple_selectedImageFile.add(fetchimage);
      }
    }
    setState(() {});
  }

  Future<File> _fileFromImageUrl(String url, String ImageName) async {
    final response = await http.get(Uri.parse(url));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(p.join(documentDirectory.path, ImageName));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  void SendEmail() async {
    /* final String _email = 'mailto:' +
        'bhanukaisuru96@gmail.com' +
        '?subject=' +
        'New Vendor Registered' +
        '&body=' +
        'Vendor Name =${value.title} ${value.ownerName}\n' +
        'Company Name = ${value.displayName}';

    await FlutterEmailSender.send(email);*/
  }
}
