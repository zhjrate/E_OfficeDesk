import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/todo/todo_bloc.dart';
import 'package:soleoserp/models/api_requests/task_category_list_request.dart';
import 'package:soleoserp/models/api_requests/to_do_header_save_request.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/todo_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/OfficeTODO/office_to_do.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_serach_customer_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateOfficeTODOScreenArguments {
  ToDoDetails editModel;

  AddUpdateOfficeTODOScreenArguments(this.editModel);
}

class OfficeToDoAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/OfficeToDoAddEditScreen';
  final AddUpdateOfficeTODOScreenArguments arguments;
  OfficeToDoAddEditScreen(this.arguments);

  @override
  _OfficeToDoAddEditScreenState createState() =>
      _OfficeToDoAddEditScreenState();
}

/*class JosKeys {
  static final cardA = GlobalKey<ExpansionTileCardState>();
  static final refreshKey  = GlobalKey<RefreshIndicatorState>();
}*/
class _OfficeToDoAddEditScreenState extends BaseState<OfficeToDoAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController edt_Category = TextEditingController();
  final TextEditingController edt_CategoryID = TextEditingController();

  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_Location = TextEditingController();
  final TextEditingController edt_AssignTo = TextEditingController();
  final TextEditingController edt_AssignToID = TextEditingController();

  final TextEditingController edt_InqNo = TextEditingController();
  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_TaskDetails = TextEditingController();
  final TextEditingController edt_StartDate = TextEditingController();
  final TextEditingController edt_StartDateReverse = TextEditingController();

  final TextEditingController edt_StartTime = TextEditingController();
  final TextEditingController edt_StartTimewith24Hours =
      TextEditingController();

  final TextEditingController edt_DueDate = TextEditingController();

  final TextEditingController edt_DueDateReverse = TextEditingController();

  final TextEditingController edt_DueTime = TextEditingController();
  final TextEditingController edt_DueTimeDatewith24Hours =
      TextEditingController();

  final TextEditingController edt_CloserDetails = TextEditingController();

  final TextEditingController edt_TransferTo = TextEditingController();
  final TextEditingController edt_ReAssignTo = TextEditingController();
  final TextEditingController edt_ReAssignToID = TextEditingController();

  final TextEditingController edt_CompletionDate = TextEditingController();
  final TextEditingController edt_CompletionDateReverse =
      TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Category = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_AssignTo = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_TransferTo = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];

  final TextEditingController edt_EmployeeID = TextEditingController();
  final TextEditingController edt_EmployeeName = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime SeletedStartDate = DateTime.now();

  DateTime SeletedDueDate = DateTime.now();
  DateTime SeletedCompletionDate = DateTime.now();

  bool viewVisibleCompletionDate = true;
  bool viewVisibleTransferToDropdown = false;
  FocusNode NotesFocusNode;
  ToDoBloc _toDoBloc;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  ALL_EmployeeList_Response _offlineFollowerEmployeeListData;
  int CompanyID = 0;
  String LoginUserID = "";
  int pkID = 0;
  bool _isForUpdate;
  ToDoDetails _editModel;

  bool ISCHECKED = false;
  SearchDetails _searchDetails;

  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerpkID = TextEditingController();

  bool IsForClient = false;

  void showWidgetCompletionDate() {
    setState(() {
      viewVisibleCompletionDate = true;
    });
  }

  void hideWidgetCompletionDate() {
    setState(() {
      viewVisibleCompletionDate = false;
      edt_CompletionDate.text = "";
      edt_CompletionDateReverse.text = "";
      edt_CloserDetails.text = "";
    });
  }

  void showWidgetTrasferToDropDown() {
    setState(() {
      viewVisibleTransferToDropdown = true;
    });
  }

  void hideWidgetTrasferToDropDown() {
    setState(() {
      viewVisibleTransferToDropdown = false;
    });
  }

  textListener() {
    print("Current Text is ${edt_TransferTo.text}");

    if (edt_TransferTo.text == "Complete Task") {
      showWidgetCompletionDate();
      hideWidgetTrasferToDropDown();
    } else {
      hideWidgetCompletionDate();
    }
    if (edt_TransferTo.text == "Re-Assign Task") {
      showWidgetTrasferToDropDown();
      hideWidgetCompletionDate();
    } else {
      hideWidgetTrasferToDropDown();
    }
    print("Current Transfer TO Bool is ${viewVisibleTransferToDropdown}");
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
    NotesFocusNode.dispose();
    edt_TransferTo.dispose();
  }

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getALLEmployeeList();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    if (_offlineLoggedInData.details[0].serialKey.toUpperCase() ==
            "SI08-SB94-MY45-RY15" ||
        _offlineLoggedInData.details[0].serialKey.toUpperCase() ==
            "TEST-0000-SI0F-0208") {
      IsForClient = true;
    } else {
      IsForClient = false;
    }

    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);

    CategoryTypeDetails();
    FetchPriorityDetails();
    FetchFollowupStatusDetails();
    FetchTransferToDetails();

    edt_TransferTo.addListener(textListener);
    NotesFocusNode = FocusNode();
    edt_TaskDetails.addListener(() {
      NotesFocusNode.requestFocus();
    });
    _toDoBloc = ToDoBloc(baseBloc);
    _isForUpdate = widget.arguments != null;

    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      edt_TransferTo.text = "Complete Task";

      fillData(_editModel);
    } else {
      edt_TransferTo.text = "Complete Task";
      edt_StartDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_StartDateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      edt_DueDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_DueDateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      edt_EmployeeName.text = _offlineLoggedInData.details[0].employeeName;
      edt_EmployeeID.text =
          _offlineLoggedInData.details[0].employeeID.toString();

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      edt_DueTime.text = beforZeroHour + ":" + beforZerominute + " " + AM_PM;
      edt_DueTimeDatewith24Hours.text =
          selectedTime.hour.toString() + ":" + beforZerominute;
      edt_StartTime.text = beforZeroHour + ":" + beforZerominute + " " + AM_PM;
      edt_StartTimewith24Hours.text =
          selectedTime.hour.toString() + ":" + beforZerominute;

      edt_Priority.text = "Low";

      edt_CustomerName.text = "";
      edt_CustomerpkID.text = "";

      /* edt_CompletionDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();

      edt_CompletionDateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();*/
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
/*  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerPaginationListScreenBloc
        ..add(CustomerPaginationListCallEvent(
            CustomerPaginationRequest(
                companyId: 8033, loginUserID: "admin", CustomerID: ""),
            _page + 1)),
      child: BlocConsumer<CustomerPaginationScreenBloc,
          CustomerPaginationScreenStates>(
        builder: (BuildContext context, CustomerPaginationScreenStates state) {
          //handle states
          if (state is CustomerPaginationListCallEventResponseState) {
            //_onGetListCallSuccess(state.response);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          if (currentState is CustomerPaginationListCallEventResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, CustomerPaginationScreenStates state) {
          //handle states
          if (state is CustomerLabelvalueEventResponseState) {
           // _onGetListLabelValueCallSuccess(state.customerlabelvalueresponse);
          }
          if (state is CustomerSearchByIdEventResponseState) {
            //_onGetSearchCustomerByIDCallSuccess(
              //  state.arr_customersearchbyidresponse);
          }
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          if (currentState is CustomerLabelvalueEventResponseState) {
            return true;
          }
          if (currentState is CustomerSearchByIdEventResponseState) {
            return true;
          }
          return false;
        },
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _toDoBloc,
      /*..add(ExpenseTypeByNameCallEvent(
            ExpenseTypeAPIRequest(CompanyId: CompanyID.toString()))),*/
      /* ..add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
            CompanyId: "8033", pkID: "", StatusCategory: "FollowUp"))),*/

      child: BlocConsumer<ToDoBloc, ToDoStates>(
        builder: (BuildContext context, ToDoStates state) {
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
        listener: (BuildContext context, ToDoStates state) {
          if (state is TaskCategoryCallResponseState) {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          if (state is ToDoSaveHeaderState) {
            _OnSaveToDoHeaderResponse(state);
          }
          if (state is ToDoSaveSubDetailsState) {
            _OnSaveToDoSubResponse(state);
          }
          /* if(state is DailyActivitySaveCallResponseState)
          {
           // _onLeaveSaveStatusCallSuccess(state);
          }*/
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is TaskCategoryCallResponseState ||
              currentState is ToDoSaveHeaderState ||
              currentState is ToDoSaveSubDetailsState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    getcurrentTimeInfoFromMain(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Add Task Details'),
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
                  navigateTo(context, OfficeToDoScreen.routeName,
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
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Task Description *",
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
                            controller: edt_TaskDetails,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Description',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),

                        showcustomdialogWithID1("Task Category",
                            enable1: false,
                            title: "Task Category *",
                            hintTextvalue: "Tap to Select Task Category",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Category,
                            controllerpkID: edt_CategoryID,
                            Custom_values1: arr_ALL_Name_ID_For_Category),
                        _buildEmplyeeListView(),
                        SizedBox(
                          height: 5,
                        ),
                        _buildNextFollowupDate(),
                        SizedBox(
                          height: 5,
                        ),
                        _buildDueDate(),
                        /* Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                          ],
                        ),*/

                        //  _buildDueTime(),

                        SizedBox(
                          height: 20,
                        ),

                        getCommonButton(baseTheme, () {
                          DateTime TodayDate = DateTime.now();
                          String Todayys = TodayDate.year.toString() +
                              "-" +
                              TodayDate.month.toString() +
                              "-" +
                              TodayDate.day.toString();

                          TimeOfDay selectedTime123 = TimeOfDay.now();
                          String AM_PM =
                              selectedTime123.periodOffset.toString() == "12"
                                  ? "PM"
                                  : "AM";
                          String beforZeroHour = selectedTime123.hourOfPeriod <=
                                  9
                              ? "0" + selectedTime123.hourOfPeriod.toString()
                              : selectedTime123.hourOfPeriod.toString();
                          String beforZerominute = selectedTime123.minute <= 9
                              ? "0" + selectedTime123.minute.toString()
                              : selectedTime123.minute.toString();

                          String todayTime = beforZeroHour +
                              ":" +
                              beforZerominute +
                              " " +
                              AM_PM;

                          if (edt_TaskDetails.text.toString() != "") {
                            if (edt_Category.text.toString() != "") {
                              /* if(edt_Priority.text.toString()!="")
                                  {*/

                              if (edt_EmployeeName.text.toString() != "") {
                                if (edt_DueDate.text.toString() != "") {
                                  showCommonDialogWithTwoOptions(context,
                                      "Are you sure you want to Save ToDo Details ?",
                                      negativeButtonTitle: "No",
                                      positiveButtonTitle: "Yes",
                                      onTapOfPositiveButton: () {
                                    Navigator.of(context).pop();

                                    _toDoBloc.add(ToDoSaveHeaderEvent(
                                        pkID,
                                        ToDoHeaderSaveRequest(
                                            Priority: "Medium",
                                            TaskDescription:
                                                edt_TaskDetails.text,
                                            Location: "",
                                            TaskCategoryID: edt_CategoryID.text,
                                            StartDate: edt_StartDateReverse
                                                    .text +
                                                " " +
                                                edt_StartTimewith24Hours.text,
                                            DueDate: edt_DueDateReverse.text +
                                                " " +
                                                edt_DueTimeDatewith24Hours.text,
                                            CompletionDate: "",
                                            LoginUserID: LoginUserID,
                                            EmployeeID: edt_EmployeeID.text,
                                            Reminder: "1",
                                            ReminderMonth: "",
                                            Latitude: "",
                                            Longitude: "",
                                            ClosingRemarks: "",
                                            CompanyId: CompanyID.toString())));
                                  });
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Due Date is Required !",
                                      positiveButtonTitle: "OK");
                                }
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Assign To is Required !",
                                    positiveButtonTitle: "OK");
                              }

                              //   }
                              /* else{
                                  showCommonDialogWithSingleOption(
                                      context, "Priority is Required !",
                                      positiveButtonTitle: "OK");
                                }
*/
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Task Category is Required !",
                                  positiveButtonTitle: "OK");
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "Task Description is Required !",
                                positiveButtonTitle: "OK");
                          }
                        }, "Save", backGroundColor: Colors.blueAccent),
                      ]))),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, OfficeToDoScreen.routeName, clearAllStack: true);
  }

  Widget FirstRow(
    String Category,
    String priority, {
    bool enable1,
    bool enable2,
    Icon icon,
    Icon icon2,
    TextEditingController controllerForLeft,
    TextEditingController controllerForRight,
    List<ALL_Name_ID> Custom_values1,
    List<ALL_Name_ID> Custom_values2,
  }) {
    return Container(
        child: Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showcustomdialog(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $Category"),
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable1,
                  userName_Controller: controllerForLeft,
                  labelName: Category,
                  icon: icon,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
          SizedBox(
            width: 20,
            height: 15,
          ),
          GestureDetector(
            onTap: () => showcustomdialog(
                values: Custom_values2,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $priority"),
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable1,
                  userName_Controller: controllerForLeft,
                  labelName: priority,
                  icon: icon,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
        ],
      ),
    ));
  }

  Widget SecondRow(
    String location,
    String assignTo, {
    bool enable1,
    bool enable2,
    Icon icon,
    Icon icon2,
    TextEditingController controllerForLeft,
    TextEditingController controllerForRight,
    List<ALL_Name_ID> Custom_values1,
  }) {
    return Container(
        child: Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable1,
                  userName_Controller: controllerForLeft,
                  labelName: location,
                  icon: icon,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
          SizedBox(
            width: 20,
            height: 15,
          ),
          GestureDetector(
            onTap: () => showcustomdialog(
                values: Custom_values1,
                context1: context,
                controller: controllerForRight,
                lable: "Select Employee "),
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable2,
                  userName_Controller: controllerForRight,
                  labelName: assignTo,
                  icon: icon2,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
        ],
      ),
    ));
  }

  Widget ThirdRow(
    String Category,
    String Source, {
    bool enable1,
    bool enable2,
    Icon icon,
    Icon icon2,
    TextEditingController controllerForLeft,
    TextEditingController controllerForRight,
    List<ALL_Name_ID> Custom_values1,
  }) {
    return Container(
        child: Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable1,
                  userName_Controller: controllerForLeft,
                  labelName: Category,
                  icon: icon,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
          SizedBox(
            width: 20,
            height: 15,
          ),
          GestureDetector(
            onTap: () => showcustomdialog(
                values: Custom_values1,
                context1: context,
                controller: controllerForRight,
                lable: "Select $Source"),
            child: Container(
              child: buildUserNameTextFiled(
                  enablevalue: enable2,
                  userName_Controller: controllerForRight,
                  labelName: Source,
                  icon: icon2,
                  maxline: 1,
                  baseTheme: baseTheme),
            ),
          ),
        ],
      ),
    ));
  }

  Widget FourthRow(
    String Category,
    String Source, {
    bool enable1,
    bool enable2,
    Icon icon,
    Icon icon2,
    TextEditingController controllerForLeft,
    TextEditingController controllerForRight,
  }) {
    return Container(
        child: Container(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectStartDate(context, controllerForLeft),
              child: Container(
                child: buildUserNameTextFiled(
                    enablevalue: enable1,
                    userName_Controller: controllerForLeft,
                    labelName: Category,
                    icon: icon,
                    maxline: 1,
                    baseTheme: baseTheme),
              ),
            ),
          ),
          SizedBox(
            width: 20,
            height: 15,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _StartTime(context),
              child: Container(
                child: buildUserNameTextFiled(
                    enablevalue: enable2,
                    userName_Controller: controllerForRight,
                    labelName: Source,
                    icon: icon2,
                    maxline: 1,
                    baseTheme: baseTheme),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget FifthRow(
    String Category,
    String Source, {
    bool enable1,
    bool enable2,
    Icon icon,
    Icon icon2,
    TextEditingController controllerForLeft,
    TextEditingController controllerForRight,
  }) {
    return Container(
        child: Container(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _SelectDueDate(context, controllerForLeft),
              child: Container(
                child: buildUserNameTextFiled(
                    enablevalue: enable1,
                    userName_Controller: controllerForLeft,
                    labelName: Category,
                    icon: icon,
                    maxline: 1,
                    baseTheme: baseTheme),
              ),
            ),
          ),
          SizedBox(
            width: 20,
            height: 15,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => _DueTime(context),
              child: Container(
                child: buildUserNameTextFiled(
                    enablevalue: enable2,
                    userName_Controller: controllerForRight,
                    labelName: Source,
                    icon: icon2,
                    maxline: 1,
                    baseTheme: baseTheme),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget SixthRow(
    String Category, {
    bool enable1,
    Icon icon,
    TextEditingController controllerForLeft,
    List<ALL_Name_ID> Custom_values1,
  }) {
    return Container(
        child: Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showcustomdialog(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $Category"),
            child: Container(
              child: TextFormField(
                style: baseTheme.textTheme.bodyText1,
                enabled: false,
                controller: edt_TransferTo,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                maxLines: 1,
                onChanged: (text) => {
                  print("EDTTransefer" + text),
                  /* if(text.trim().toLowerCase() == "completetask")
                        {
                          IsReAssignToVisible = false,
                          IsCompleteTaskVisible = true
                        }
                      else if(text.trim().toLowerCase() == "re-assigntask")
                        {
                          IsReAssignToVisible = true,
                          IsCompleteTaskVisible = false
                        }
                      else
                        {
                          IsReAssignToVisible = false,
                          IsCompleteTaskVisible = false
                        }*/
                },
                //initialValue: userName_Controller.text,
                decoration: InputDecoration(
                  labelText: "Transfer To",
                  labelStyle: TextStyle(
                    color: Color(0xFF000000),
                  ),
                  suffixIcon: icon,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF000000)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget SeventhRow(
    String Category, {
    bool enable1,
    Icon icon,
    TextEditingController controllerForLeft,
    List<ALL_Name_ID> Custom_values1,
  }) {
    return Visibility(
      visible: true,
      child: Container(
          child: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => showcustomdialog(
                  values: Custom_values1,
                  context1: context,
                  controller: controllerForLeft,
                  lable: "Select Employee"),
              child: Container(
                child: TextFormField(
                  style: baseTheme.textTheme.bodyText1,
                  enabled: false,
                  controller: edt_ReAssignTo,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  maxLines: 1,

                  //initialValue: userName_Controller.text,
                  decoration: InputDecoration(
                    labelText: "Re-Assign To",
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                    ),
                    suffixIcon: icon,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _selectStartDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_StartDate.text = selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString();
      });
  }

  Future<void> _selectCompletionDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        currentDate: SeletedCompletionDate,
        context: context,
        initialDate: selectedDate,
        firstDate: SeletedStartDate,
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        SeletedCompletionDate = picked;
        edt_CompletionDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();

        edt_CompletionDateReverse.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _StartTime(BuildContext context) async {
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
        edt_StartTime.text =
            selectedTime.hour.toString() + ":" + selectedTime.minute.toString();
      });
  }

  Future<void> _SelectDueDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_DueDate.text = selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString();
      });
  }

  Future<void> _DueTime(BuildContext context) async {
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
        edt_DueTime.text =
            selectedTime.hour.toString() + ":" + selectedTime.minute.toString();
      });
  }

  CategoryTypeDetails() {
    arr_ALL_Name_ID_For_Category.clear();
    for (var i = 0; i < 4; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Account";
      } else if (i == 1) {
        all_name_id.Name = "Administration";
      } else if (i == 2) {
        all_name_id.Name = "ClientVisit";
      } else if (i == 3) {
        all_name_id.Name = "Communication";
      } else if (i == 4) {
        all_name_id.Name = "Development";
      }
      arr_ALL_Name_ID_For_Category.add(all_name_id);
    }
  }

  FetchPriorityDetails() {
    arr_ALL_Name_ID_For_Priority.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "High";
      } else if (i == 1) {
        all_name_id.Name = "Medium";
      } else if (i == 2) {
        all_name_id.Name = "Low";
      }
      arr_ALL_Name_ID_For_Priority.add(all_name_id);
    }
  }

  FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Initialized";
      } else if (i == 1) {
        all_name_id.Name = "Pending";
      } else if (i == 2) {
        all_name_id.Name = "Sucess";
      }
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
    }
  }

  FetchTransferToDetails() {
    arr_ALL_Name_ID_For_TransferTo.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Re-Assign Task";
      } else if (i == 1) {
        all_name_id.Name = "Complete Task";
      } else if (i == 2) {
        all_name_id.Name = "Add Activity";
      }
      arr_ALL_Name_ID_For_TransferTo.add(all_name_id);
    }
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
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          InkWell(
            onTap:
                () => /*showcustomdialogWithID(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                controllerID: controllerpkID,
                lable: "Select $Category")*/
                    CreateDialogDropdown(Category),

            /* _toDoBloc.add(TaskCategoryListCallEvent(
                TaskCategoryListRequest(pkID:"",CompanyId: CompanyID.toString()))),*/

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
                    height: 45,
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
                                fontSize: 12,
                                color: colorBlack,
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

  CreateDialogDropdown(String category) {
    if (category == "Task Category") {
      _toDoBloc
        ..add(TaskCategoryListCallEvent(TaskCategoryListRequest(
            pkID: "", CompanyId: CompanyID.toString())));
    } else if (category == "Followup Type") {
      /*  _FollowupBloc.add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
          CompanyId: CompanyID.toString(),
          pkID: "",
          StatusCategory: "FollowUp",
          LoginUserID: LoginUserID,
          SearchKey: "")));*/
    } else {
      /*_FollowupBloc
        ..add(CloserReasonTypeListByNameCallEvent(CloserReasonTypeListRequest(
            CompanyId: CompanyID.toString(),
            pkID: "",
            StatusCategory: "DisQualifiedReason",
            LoginUserID: LoginUserID,
            SearchKey: "")));*/
    }
  }

  void _onLeaveRequestTypeSuccessResponse(TaskCategoryCallResponseState state) {
    if (state.taskCategoryResponse.details.length != 0) {
      arr_ALL_Name_ID_For_Category.clear();
      for (var i = 0; i < state.taskCategoryResponse.details.length; i++) {
        print("description : " +
            state.taskCategoryResponse.details[i].taskCategoryName);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.taskCategoryResponse.details[i].taskCategoryName;
        all_name_id.pkID = state.taskCategoryResponse.details[i].pkID;
        arr_ALL_Name_ID_For_Category.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_Category,
          context1: context,
          controller: edt_Category,
          controllerID: edt_CategoryID,
          lable: "Select Task Category");
    }
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
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_EmployeeName,
            controllerID: edt_EmployeeID,
            lable: "Assign To");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Assign To *",
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
              height: 45,
              padding: EdgeInsets.only(left: 5, right: 10),
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
                      ),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select"),
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

  void _onFollowerEmployeeListByStatusCallSuccess(
      ALL_EmployeeList_Response state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();
    arr_ALL_Name_ID_For_AssignTo.clear();
    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.pkID = state.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
        arr_ALL_Name_ID_For_AssignTo.add(all_name_id);
      }
    }
  }

  Widget Area() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Location",
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
                      controller: edt_Location,
//                      onSubmitted: (_) => PicCodeFocus.requestFocus(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Location",
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
                  Icons.house,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNextFollowupDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_StartDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("StartDate *",
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
              height: 45,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_StartDate.text == null || edt_StartDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_StartDate.text,
                      style: TextStyle(fontSize: 12, color: colorBlack),
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

  Widget _buildPreferredTime() {
    return InkWell(
      onTap: () {
        _selectTime(context, edt_StartTime);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Start Time",
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
                      edt_StartTime.text == null || edt_StartTime.text == ""
                          ? "HH:MM:SS"
                          : edt_StartTime.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_StartTime.text == null ||
                                  edt_StartTime.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.watch_later_outlined,
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

  Widget _buildDueDate() {
    return InkWell(
      onTap: () {
        _selectDueDate(context, edt_DueDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("DueDate *",
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
              height: 45,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_DueDate.text == null || edt_DueDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_DueDate.text,
                      style: TextStyle(fontSize: 12, color: colorBlack),
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

  Widget _buildDueTime() {
    return InkWell(
      onTap: () {
        _selectDueTime(context, edt_DueTime);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Due Time",
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
                      edt_DueTime.text == null || edt_DueTime.text == ""
                          ? "HH:MM:SS"
                          : edt_DueTime.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color:
                              edt_DueTime.text == null || edt_DueTime.text == ""
                                  ? colorGrayDark
                                  : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.watch_later_outlined,
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
        currentDate: SeletedStartDate,
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        SeletedStartDate = picked;

        String AddZero = selectedDate.month <= 9
            ? "0" + selectedDate.month.toString()
            : selectedDate.month.toString();

        edt_StartDate.text = selectedDate.day.toString() +
            "-" +
            AddZero +
            "-" +
            selectedDate.year.toString();
        edt_StartDateReverse.text = selectedDate.year.toString() +
            "-" +
            AddZero +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectTime(
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
        /*edt_StartTimewith24Hours*/
        print("24HourseTime" +
            selectedTime.hour.toString() +
            ":" +
            selectedTime.minute.toString());

        String AM_PM =
            selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = selectedTime.hourOfPeriod <= 9
            ? "0" + selectedTime.hourOfPeriod.toString()
            : selectedTime.hourOfPeriod.toString();
        String beforZerominute = selectedTime.minute <= 9
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        edt_StartTime.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
        edt_StartTimewith24Hours.text =
            selectedTime.hour.toString() + ":" + beforZerominute;
      });
  }

  Future<void> _selectDueDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        currentDate: SeletedStartDate,
        context: context,
        initialDate: SeletedStartDate,
        firstDate: SeletedStartDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        SeletedDueDate = picked;

        String AddZero = selectedDate.month <= 9
            ? "0" + selectedDate.month.toString()
            : selectedDate.month.toString();

        edt_DueDate.text = selectedDate.day.toString() +
            "-" +
            AddZero +
            "-" +
            selectedDate.year.toString();
        edt_DueDateReverse.text = selectedDate.year.toString() +
            "-" +
            AddZero +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectDueTime(
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

        edt_DueTime.text = beforZeroHour + ":" + beforZerominute + " " + AM_PM;

        edt_DueTimeDatewith24Hours.text =
            selectedTime.hour.toString() + ":" + beforZerominute;

        //picked_s.periodOffset.toString();
      });
  }

  void _OnSaveToDoHeaderResponse(ToDoSaveHeaderState state) async {
    await showCommonDialogWithSingleOption(
        Globals.context, state.toDoSaveHeaderResponse.details[0].column2,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
      navigateTo(context, OfficeToDoScreen.routeName, clearAllStack: true);
    });
  }

  void _OnSaveToDoSubResponse(ToDoSaveSubDetailsState state) async {
    String Msg = _isForUpdate == true
        ? "Task Updated Successfully !"
        : "Task Added Successfully !";

    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
      navigateTo(context, ToDoListScreen.routeName, clearAllStack: true);
    });
  }

  void fillData(ToDoDetails editModel) {
    pkID = editModel.pkID;
    edt_TaskDetails.text = editModel.taskDescription;
    edt_Category.text = editModel.taskCategory;
    edt_CategoryID.text = editModel.taskCategoryId.toString();
    edt_Priority.text = editModel.priority;
    edt_EmployeeName.text = editModel.employeeName;
    edt_EmployeeID.text = editModel.employeeID.toString();

    if (editModel.startDate != "" &&
        editModel.startDate != "1900-01-01T00:00:00") {
      SeletedStartDate = DateTime.parse(editModel.startDate);
      edt_StartDate.text = editModel.startDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_StartDateReverse.text = editModel.startDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
      edt_StartTime.text = editModel.startDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "h:mm a");
      edt_StartTimewith24Hours.text = editModel.startDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "H:mm a");
    } else {
      edt_StartDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_StartDateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
      TimeOfDay selectedTime = TimeOfDay.now();

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();
      edt_StartTime.text = beforZeroHour + ":" + beforZerominute + " " + AM_PM;
      edt_StartTimewith24Hours.text =
          selectedTime.hour.toString() + ":" + beforZerominute;
    }

    if (editModel.dueDate != "" || editModel.dueDate != "1900-01-01T00:00:00") {
      SeletedDueDate = DateTime.parse(editModel.dueDate);
      edt_DueDate.text = editModel.dueDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_DueDateReverse.text = editModel.dueDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
      edt_DueTime.text = editModel.dueDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "h:mm a");
      edt_DueTimeDatewith24Hours.text = editModel.dueDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "H:mm a");
    } else {
      edt_DueDate.text = SeletedDueDate.day.toString() +
          "-" +
          SeletedDueDate.month.toString() +
          "-" +
          SeletedDueDate.year.toString();
      edt_DueDateReverse.text = SeletedDueDate.year.toString() +
          "-" +
          SeletedDueDate.month.toString() +
          "-" +
          SeletedDueDate.day.toString();
      TimeOfDay selectedTime = TimeOfDay.now();

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      edt_DueTime.text = beforZeroHour + ":" + beforZerominute + " " + AM_PM;
      edt_DueTimeDatewith24Hours.text =
          selectedTime.hour.toString() + ":" + beforZerominute;
    }
    //

    /* edt_StartTime.text = editModel.startDate
        .getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "HH:mm");*/

    if (editModel.completionDate != "1900-01-01T00:00:00" &&
        editModel.completionDate != "") {
      edt_CompletionDate.text = editModel.completionDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_CompletionDateReverse.text = editModel.completionDate
          .getFormattedDate(
              fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");

      SeletedCompletionDate = DateTime.parse(editModel.completionDate);
    } else {
      edt_CompletionDate.text = "";
      edt_CompletionDateReverse.text = "";
    }

    // SeletedStartDate = DateTime.parse(editModel.startDate);

    //  SeletedDueDate = DateTime.parse(editModel.dueDate);

    edt_CloserDetails.text = editModel.closingRemarks;

    edt_Location.text = editModel.location;

    ISCHECKED = editModel.reminder;
  }

  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Search Customer ",
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
                          hintText: "Tap to search customer",
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

  Future<void> _onTapOfSearchView() async {
    if (_isForUpdate == false) {
      navigateTo(context, SearchTODOCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchDetails = value;
          edt_CustomerpkID.text = _searchDetails.value.toString();
          edt_CustomerName.text = _searchDetails.label.toString();
        }
      });
    }
  }
}
/* if(edt_TransferTo.text =="Complete Task")
    {
      showWidgetCompletionDate();
      hideWidgetTrasferToDropDown();

    }
    else{
      hideWidgetCompletionDate();
    }
    if(edt_TransferTo.text == "Re-Assign Task")
      {
        showWidgetTrasferToDropDown();
        hideWidgetCompletionDate();

      }
    else{
      hideWidgetTrasferToDropDown();
    }*/
