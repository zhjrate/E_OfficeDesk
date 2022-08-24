import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:soleoserp/blocs/other/bloc_modules/todo/todo_bloc.dart';
import 'package:soleoserp/models/api_requests/to_do_header_save_request.dart';
import 'package:soleoserp/models/api_requests/todo_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/todo_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/OfficeTODO/office_to_do_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import '../../home_screen.dart';

class OfficeToDoScreen extends BaseStatefulWidget {
  static const routeName = '/OfficeToDoScreen';

  @override
  _OfficeToDoScreenState createState() => _OfficeToDoScreenState();
}

class _OfficeToDoScreenState extends BaseState<OfficeToDoScreen>
    with BasicScreen, WidgetsBindingObserver {
  ToDoBloc _officeToDoScreenBloc;

  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;
  int _key;
  String foos = 'One';
  int selected = 0; //attention
  bool isExpand = false;
  final GlobalKey<ScaffoldState> _key123 = GlobalKey(); // Create a key

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;

  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  bool pressAttention = true;
  bool pressAttention1 = true;
  ToDoListResponse _FollowupTodayListResponse;

  ToDoListResponse _FollowupListOverDueResponse;
  ToDoListResponse _FollowupListCompletedResponse;

  TextEditingController Remarks = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  int _pageNo = 0;
  int TotalTodayCount = 0;
  int TotalOverDueCount = 0;
  int TotalCompltedCount = 0;


  bool IsExpandedTodays = false;
  bool IsExpandedOverDue = false;
  bool IsExpandedCompleted = false;

  List<ToDoDetails> arrToDoDetails = [];

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorDarkYellow;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _officeToDoScreenBloc = ToDoBloc(baseBloc);

    _officeToDoScreenBloc.add(ToDoTodayListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Todays",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Today",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Pending",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoTComplitedListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Completed",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));

    isExpand = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _officeToDoScreenBloc,
      //..add(LoanApprovalListCallEvent(LoanApprovalListRequest(pkID: "",ApprovalStatus: edt_FollowupStatus.text,LoginUserID: LoginUserID,CompanyId: CompanyID))),

      child: BlocConsumer<ToDoBloc, ToDoStates>(
        builder: (BuildContext context, ToDoStates state) {
          if (state is ToDoTodayListCallResponseState) {
            _onFollowupTodayListCallSuccess(state);
          }

          if (state is ToDoOverDueListCallResponseState) {
            _onFollowupOverDueListCallSuccess(state);
          }
          if (state is ToDoCompletedListCallResponseState) {
            _onFollowupCompletedListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is ToDoTodayListCallResponseState || currentState is ToDoOverDueListCallResponseState || currentState is ToDoCompletedListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, ToDoStates state) {

          if(state is ToDoSaveHeaderState)
            {
              _OnTODOSaveResponse(state);
            }
          if(state is ToDoDeleteResponseState)
            {
              _OnTaptoDeleteTodo(state);
            }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if(currentState is ToDoSaveHeaderState || currentState is ToDoDeleteResponseState)
            {
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
        //98E0FF
        backgroundColor: Color(0xff1e6091),
        appBar: AppBar(
          elevation: 0.1,
          toolbarHeight: 100,
          backgroundColor: Color(0xff1e6091),
          centerTitle: false,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 100,
          title: Text(
            "Office Task",
            style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                //alignment: Alignment(),
                icon: Image.asset(
                  NAV_ICON,
                  height: 48,
                  width: 48,
                  color: colorWhite,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            //LADY_ICON
            Container(
              margin: EdgeInsets.only(right: 30),
              child: IconButton(
                  icon: Image.asset(
                    LADY_ICON,
                    height: 48,
                    width: 48,
                  ),
                  onPressed: () {
                    //_onTapOfLogOut();
                    navigateTo(context, HomeScreen.routeName,
                        clearAllStack: true);
                  }),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {

                    navigateTo(context, OfficeToDoScreen.routeName,clearAllStack: true);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Hello " +
                                _offlineLoggedInData.details[0].employeeName +
                                " !",
                            style: TextStyle(
                                color: colorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text("Have a nice day !",
                              style:
                                  TextStyle(color: colorBlack, fontSize: 24)),
                        ),
                        SizedBox(
                          height: 30,
                        ),*/

                        /*  HeaderTabList(),
                        SizedBox(
                          height: 10,
                        ),
                        TWOCARDDesign(),*/
                        SizedBox(
                          height: 5,
                        ),
                        TaskStatus(),
                        SizedBox(
                          height: 5,
                        ),
                        // TaskPendingList(),
                        pressAttention == true ? TO_DO() : Container(),
                        IsExpandedTodays == true
                            ? pressAttention == true ? _buildFollowupTodayList() : Container()
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        pressAttention == true ? OVER_DUEU() :Container(),
                        IsExpandedOverDue == true
                            ?  pressAttention == true ? _buildFollowupOverDueList() : Container()
                            : Container(),
                        pressAttention == false ? TodayCompleted() : Container(),
                        pressAttention == false
                            ? IsExpandedCompleted ==true ? _buildFollowupCompletedList() :Container()
                            : Container(),



                        // TaskOverDueList(),
                        //Expanded(child: _buildFollowupList())
                        /* TaskStatus(),
                        _buildFollowupList(),
                        TaskPendingList(),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  HeaderTabList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
              color: Color(0xffb4d0ea),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  width: 100,
                  height: 33,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Project",
                      style: TextStyle(color: Color(0xff5a5a5a), fontSize: 14),
                    ),
                  ))),
          Card(
              color: Color(0xff0066ff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  width: 100,
                  height: 33,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "My Task",
                      style: TextStyle(color: colorWhite, fontSize: 14),
                    ),
                  ))),
          Card(
              color: Color(0xffb4d0ea),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  width: 100,
                  height: 33,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Schedule",
                      style: TextStyle(color: Color(0xff5a5a5a), fontSize: 14),
                    ),
                  ))),
          Card(
              color: Color(0xffb4d0ea),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  width: 100,
                  height: 33,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Note",
                      style: TextStyle(color: Color(0xff5a5a5a), fontSize: 14),
                    ),
                  )))
        ],
      ),
    );
  }

  TWOCARDDesign() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: Color(0xff0066ff),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
                width: 178,
                height: 180,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 54,
                        right: 54,
                        top: 32,
                      ),
                      child: Container(
                        child: CircularPercentIndicator(
                          radius: 25,
                          lineWidth: 2,
                          animation: true,
                          percent: 0.7,
                          backgroundColor: Color(0xff0066ff),
                          center: Text(
                            "70.0%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          ),
                          /*  footer: Text(
                                                "Daily Task",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),*/
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Daily Task",
                      style: TextStyle(
                          fontSize: 10,
                          color: colorWhite,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Remaining Task:   2",
                      style: TextStyle(fontSize: 10, color: colorWhite),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Total Task:   10",
                      style: TextStyle(fontSize: 10, color: colorWhite),
                    )
                  ],
                ))),
        Card(
            color: Color(0xff0066ff),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
                width: 178,
                height: 180,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 54,
                        right: 54,
                        top: 32,
                      ),
                      child: Container(
                        child: CircularPercentIndicator(
                          radius: 25,
                          lineWidth: 2,
                          animation: true,
                          percent: 0.5,
                          backgroundColor: Color(0xff0066ff),
                          // arcBackgroundColor: Colors.red,
                          center: Text(
                            "50.0%",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white),
                          ),
                          /*  footer: Text(
                                                "Daily Task",
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),*/
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Weekly Task",
                      style: TextStyle(
                          fontSize: 10,
                          color: colorWhite,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Remaining Task:   20",
                      style: TextStyle(fontSize: 10, color: colorWhite),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Total Task:   40",
                      style: TextStyle(fontSize: 10, color: colorWhite),
                    )
                  ],
                ))),
      ],
    );
  }

  TaskStatus() {

    int TotalTodoCount = TotalTodayCount+TotalOverDueCount;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              //pressAttention = true;
              // doSomething("Pending");
              pressAttention = !pressAttention;
              pressAttention1 = false;
            });
          },
          child: Card(
              color: Color(0xffef6f6c),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child:


                    Text(
                      "To-Do "+" ("+TotalTodoCount.toString()+")",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ))),
        ),
        GestureDetector(
          onTap: () {
            //doSomething("Completed");

            setState(() {
              //pressAttention = true;
              // doSomething("Pending");
              pressAttention1 = !pressAttention1;
              pressAttention = false;

            });
          },
          child: Card(
              color:  Color(0xff39c3aa),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Completed ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ))),
        ),
      ],
    );
  }



  Widget _buildFollowupTodayList() {
    if (_FollowupTodayListResponse == null) {
      return Container();
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (shouldPaginate(
            scrollInfo,
          )) {
            _onFollowupTodayListPagination();
            return true;
          } else {
            return false;
          }
        },
        child: Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _FollowupTodayListResponse.details[index].taskStatus ==
                      "Todays" /*&&
                      _FollowupListResponse.details[index].taskStatus ==
                          "Completed-OverDue"*/
                  ? Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.

                          SlidableAction(
                            // padding: EdgeInsets.only(left: 10),
                            onPressed: (c) {
                              /*  showcustomdialog123(
                                    context1: context,
                                    finalCheckingItems:
                                        _FollowupListResponse.details[index],
                                    index1: index);*/
                            },
                            backgroundColor: colorGreen,
                            foregroundColor: Colors.white,
                            icon: Icons.done,
                            label: 'Complete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: _buildFollowupTodayListItem(index),
                    )
                  : _buildFollowupTodayListItem(index);

              // return _buildFollowupListItem(index);
            },
            shrinkWrap: true,
            itemCount: _FollowupTodayListResponse.details.length,
          ),
        ),
      );
    }
  }

  Widget _buildFollowupOverDueList() {
    if (_FollowupListOverDueResponse == null) {
      return Container();
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (shouldPaginate(
            scrollInfo,
          )) {
            _onFollowupOverDueListPagination();
            return true;
          } else {
            return false;
          }
        },
        child: Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _FollowupListOverDueResponse.details[index].taskStatus ==
                      "Pending1" /*&&
                      _FollowupListResponse.details[index].taskStatus ==
                          "Completed-OverDue"*/
                  ? Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.

                          SlidableAction(
                            // padding: EdgeInsets.only(left: 10),
                            onPressed: (c) {
                              /*  showcustomdialog123(
                                    context1: context,
                                    finalCheckingItems:
                                        _FollowupListResponse.details[index],
                                    index1: index);*/
                            },
                            backgroundColor: colorGreen,
                            foregroundColor: Colors.white,
                            icon: Icons.done,
                            label: 'Complete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: _buildFollowupOverDueListItem(index),
                    )
                  : _buildFollowupOverDueListItem(index);

              // return _buildFollowupListItem(index);
            },
            shrinkWrap: true,
            itemCount: _FollowupListOverDueResponse.details.length,
          ),
        ),
      );
    }
  }


  Widget _buildFollowupCompletedList() {
    if (_FollowupListCompletedResponse == null) {
      return Container();
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (shouldPaginate(
            scrollInfo,
          )) {
            _onFollowupCompletedListPagination();
            return true;
          } else {
            return false;
          }
        },
        child: Flexible(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _FollowupListCompletedResponse.details[index].taskStatus ==
                  "Pending1" /*&&
                      _FollowupListResponse.details[index].taskStatus ==
                          "Completed-OverDue"*/
                  ? Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.

                    SlidableAction(
                      // padding: EdgeInsets.only(left: 10),
                      onPressed: (c) {
                        /*  showcustomdialog123(
                                    context1: context,
                                    finalCheckingItems:
                                        _FollowupListResponse.details[index],
                                    index1: index);
                        */
                      },
                      backgroundColor: colorGreen,
                      foregroundColor: Colors.white,
                      icon: Icons.done,
                      label: 'Complete',
                    ),
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.

                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child: _buildFollowupCompletedListItem(index),
              )
                  : _buildFollowupCompletedListItem(index);

              // return _buildFollowupListItem(index);
            },
            shrinkWrap: true,
            itemCount: _FollowupListCompletedResponse.details.length,
          ),
        ),
      );
    }
  }


  void _onFollowupTodayListPagination() {
    if (_FollowupTodayListResponse.details.length <
        _FollowupTodayListResponse.totalCount) {

    }
  }
  void _onFollowupOverDueListPagination() {
    if (_FollowupListOverDueResponse.details.length <
        _FollowupListOverDueResponse.totalCount) {

    }
  }
  void _onFollowupCompletedListPagination() {
    if (_FollowupListCompletedResponse.details.length <
        _FollowupListCompletedResponse.totalCount) {

    }
  }


  Widget _buildFollowupTodayListItem(int index) {
    // ToDoDetails model = _FollowupListResponse.details[index];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(onTap: (){
          navigateTo(context, OfficeToDoAddEditScreen.routeName,
              arguments: AddUpdateOfficeTODOScreenArguments(_FollowupTodayListResponse.details[index]))
              .then((value) {

          });
        },child: ExpantionTodayCustomer(context, index))

      ],
    );
  }

  Widget _buildFollowupOverDueListItem(int index) {
    // ToDoDetails model = _FollowupListResponse.details[index];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(onTap : (){
         /* showcustomdialog123(
              context1: context,
              finalCheckingItems:
              _FollowupListOverDueResponse.details[index],
              index1: index);*/
          navigateTo(context, OfficeToDoAddEditScreen.routeName,
              arguments: AddUpdateOfficeTODOScreenArguments(_FollowupListOverDueResponse.details[index]))
              .then((value) {

          });
        },child: ExpantionOverDueCustomer(context, index),)

      ],
    );
  }

  Widget _buildFollowupCompletedListItem(int index) {
    // ToDoDetails model = _FollowupListResponse.details[index];
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ExpantionCompletedCustomer(context, index)
      ],
    );
  }

  ExpantionTodayCustomer(BuildContext context, int index) {
    ToDoDetails model = _FollowupTodayListResponse.details[index];
    var colorwe =   model.taskStatus=="Pending"?Color(0xFFFCFCFC):Color(0xFFC1E0FA);
    return Container(
      //  color: Color(0xff98e0ff),
        // padding: EdgeInsets.only(left: 10, right: 10),
        child:// _FollowupTodayListResponse.details[index].taskStatus == "Pending" || _FollowupTodayListResponse.details[index].taskStatus == "Todays"
             Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),


                  children: [

                    SlidableAction(
                      // padding: EdgeInsets.only(left: 10),
                      onPressed: (c) {

                        String AM_PM =
                            selectedTime.periodOffset.toString() == "12"
                                ? "PM"
                                : "AM";
                        String beforZeroHour = selectedTime.hourOfPeriod <= 9
                            ? "0" + selectedTime.hourOfPeriod.toString()
                            : selectedTime.hourOfPeriod.toString();
                        String beforZerominute = selectedTime.minute <= 9
                            ? "0" + selectedTime.minute.toString()
                            : selectedTime.minute.toString();

                        String TimeHour =
                            beforZeroHour + ":" + beforZerominute + " " + AM_PM;
                        _officeToDoScreenBloc.add(ToDoSaveHeaderEvent(
                            _FollowupTodayListResponse.details[index].pkID,
                            ToDoHeaderSaveRequest(
                                Priority: "Medium",
                                TaskDescription: _FollowupTodayListResponse.details[index].taskDescription,
                                Location: _FollowupTodayListResponse
                                    .details[index].location,
                                TaskCategoryID: _FollowupTodayListResponse
                                    .details[index].taskCategoryId
                                    .toString(),
                                StartDate: _FollowupTodayListResponse.details[index].startDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "yyyy-MM-dd") +
                                    " " +
                                    TimeHour,
                                DueDate: _FollowupTodayListResponse.details[index].dueDate
                                        .getFormattedDate(
                                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                            toFormat: "yyyy-MM-dd") +
                                    " " +
                                    TimeHour,
                                CompletionDate: _FollowupTodayListResponse.details[index].startDate
                                    .getFormattedDate(fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd"),
                                LoginUserID: LoginUserID,
                                EmployeeID: _FollowupTodayListResponse.details[index].employeeID.toString(),
                                Reminder: "",
                                ReminderMonth: "",
                                Latitude: "",
                                Longitude: "",
                                ClosingRemarks: _FollowupTodayListResponse.details[index].closingRemarks,
                                CompanyId: CompanyID.toString())));
                      },

                 //Color(0xff39c3aa) Green = Color(0xff39c3aa)
                      backgroundColor: Color(0xff39c3aa),
                      foregroundColor: Colors.white,
                      icon: Icons.done,
                    ),
                  ],
                ),


                child: IgnorePointer(
                  child: InkWell(
                    onTap: (){
                      navigateTo(context, OfficeToDoAddEditScreen.routeName,
                          arguments: AddUpdateOfficeTODOScreenArguments(model))
                          .then((value) {

                      });
                    },
                    child: /*ExpansionTileCard(
                      elevationCurve: Curves.easeInOut,
                      trailing: SizedBox(
                        height: 1,
                        width: 1,
                      ),
                      shadowColor: Color(0xFF504F4F),
                      baseColor: Colors.white ,
                      expandedColor:
                          Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
                      leading: Container(
                          height: 35, width: 35, child: Icon(Icons.access_alarm)),

                      title: Text(
                        model.taskDescription,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),

                    ),*/
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(


                        border: Border.all(
                            color: colorWhite, // Set border color
                            width: 1.0),   // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        // Make rounded corner of border
                      ),
                      child: Row(

                        children: [
                          Container(
                              height: 35, width: 35, child: Icon(Icons.access_alarm,color: colorWhite,)),
                          SizedBox(width: 2,),
                          Expanded(
                            child: Text( model.taskDescription,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: colorWhite),),
                          )
                        ],),
                    )
                  ),
                ),
              ));
            /*: IgnorePointer(
                child: ExpansionTileCard(
                  elevationCurve: Curves.easeInOut,
                  trailing: SizedBox(
                    height: 1,
                    width: 1,
                  ),
                  shadowColor: Color(0xFF504F4F),

                  baseColor: Color(0xFFBB0909),//Color(0xFF9CF1A3),
                  expandedColor:
                      Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
                  leading: Container(
                      height: 35, width: 35, child: Icon(Icons.access_alarm)),

                  title: Text(
                    model.taskDescription,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),

                ),
              ));*/
  }

  ExpantionOverDueCustomer(BuildContext context, int index) {
    ToDoDetails model = _FollowupListOverDueResponse.details[index];
    return Container(
        /*width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(


          border: Border.all(
              color: colorWhite, // Set border color
              width: 1.0),   // Set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
          // Make rounded corner of border
        ),*/
        // padding: EdgeInsets.only(left: 10, right: 10),
        child: _FollowupListOverDueResponse.details[index].taskStatus == "Pending"
            ? Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
             /* SlidableAction(
                onPressed: (c){
                 // print("Dleif" + "Delete Itme");
                  _officeToDoScreenBloc.add(ToDoDeleteEvent(model.pkID,
                      ToDoDeleteRequest(CompanyId: CompanyID.toString())));
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,

              ),*/
              SlidableAction(
                // padding: EdgeInsets.only(left: 10),
                onPressed: (c) {
                  /*showcustomdialog123(
                                  context1: context,
                                  finalCheckingItems:
                                      _FollowupListResponse.details[index],
                                  index1: index);*/
                  String AM_PM =
                  selectedTime.periodOffset.toString() == "12"
                      ? "PM"
                      : "AM";
                  String beforZeroHour = selectedTime.hourOfPeriod <= 9
                      ? "0" + selectedTime.hourOfPeriod.toString()
                      : selectedTime.hourOfPeriod.toString();
                  String beforZerominute = selectedTime.minute <= 9
                      ? "0" + selectedTime.minute.toString()
                      : selectedTime.minute.toString();

                  String TimeHour =
                      beforZeroHour + ":" + beforZerominute + " " + AM_PM;

                  DateTime selectedDate = DateTime.now();


                  _officeToDoScreenBloc.add(ToDoSaveHeaderEvent(
                      _FollowupListOverDueResponse.details[index].pkID,
                      ToDoHeaderSaveRequest(
                          Priority: "Medium",
                          TaskDescription: _FollowupListOverDueResponse
                              .details[index].taskDescription,
                          Location: _FollowupListOverDueResponse
                              .details[index].location,
                          TaskCategoryID: _FollowupListOverDueResponse
                              .details[index].taskCategoryId
                              .toString(),
                          StartDate: _FollowupListOverDueResponse.details[index].startDate.getFormattedDate(
                              fromFormat: "yyyy-MM-ddTHH:mm:ss",
                              toFormat: "yyyy-MM-dd") +
                              " " +
                              TimeHour,
                          DueDate: _FollowupListOverDueResponse.details[index].dueDate
                              .getFormattedDate(
                              fromFormat: "yyyy-MM-ddTHH:mm:ss",
                              toFormat: "yyyy-MM-dd") +
                              " " +
                              TimeHour,
                          CompletionDate: selectedDate.year.toString()+"-"+selectedDate.month.toString()+"-"+selectedDate.day.toString(),
                          LoginUserID: LoginUserID,
                          EmployeeID: _FollowupListOverDueResponse.details[index].employeeID.toString(),
                          Reminder: "",
                          ReminderMonth: "",
                          Latitude: "",
                          Longitude: "",
                          ClosingRemarks: _FollowupListOverDueResponse.details[index].closingRemarks,
                          CompanyId: CompanyID.toString())));
                },
                backgroundColor: Color(0xff39c3aa),

                foregroundColor: Colors.white,
                icon: Icons.done,
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: IgnorePointer(
            child: InkWell(
              onTap: (){
              /*  showcustomdialog123(
                                  context1: context,
                                  finalCheckingItems:
                                  _FollowupListOverDueResponse.details[index],
                                  index1: index);*/

                navigateTo(context, OfficeToDoAddEditScreen.routeName,
                    arguments: AddUpdateOfficeTODOScreenArguments(model))
                    .then((value) {

                });
              },
              child: /*ExpansionTileCard(
                elevationCurve: Curves.easeInOut,
                trailing: SizedBox(height: 1,width: 1,),
                shadowColor: Color(0xFF504F4F),
                baseColor: Color(0xFFFCFCFC),
                expandedColor:
                Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
                leading: Container(
                    height: 35, width: 35, child: Icon(Icons.access_alarm)),

                title: Text(
                  model.taskDescription,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black),
                ),*/
              Container(
                width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(


          border: Border.all(
              color: colorWhite, // Set border color
              width: 1.0),   // Set border width
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Set rounded corner radius
          // Make rounded corner of border
        ),
                child: Row(

                  children: [
                    Container(
                        height: 35, width: 35, child: Icon(Icons.access_alarm,color: colorWhite,)),
                    SizedBox(width: 2,),
                    Expanded(
                      child: Text( model.taskDescription,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: colorWhite),),
                    )
                  ],),
              )

            ),
          ),
        )
            : IgnorePointer(
          child: InkWell(
            onTap: (){
             /* showcustomdialog123(
                  context1: context,
                  finalCheckingItems:
                  _FollowupListOverDueResponse.details[index],
                  index1: index);*/
            },
            child:/* ExpansionTileCard(
              elevationCurve: Curves.easeInOut,
              trailing: SizedBox(
                height: 1,
                width: 1,
              ),
              shadowColor: Color(0xFF504F4F),
              baseColor: Color(0xFFFCFCFC),
              expandedColor:
              Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
              leading: Container(
                  height: 35, width: 35, child: Icon(Icons.access_alarm)),

              title: Text(
                model.taskDescription,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              ),

            ),*/        Row(

              children: [
                Container(
                    height: 35, width: 35, child: Icon(Icons.access_alarm,color: colorWhite,)),
                SizedBox(width: 2,),
                Expanded(
                  child: Text( model.taskDescription,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorWhite),),
                )
              ],)
          ),
        ));
  }


  ExpantionCompletedCustomer(BuildContext context, int index) {
    ToDoDetails model = _FollowupListCompletedResponse.details[index];

    return Container(
      width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(


            border: Border.all(
                color: Color(0xff39c3aa), // Set border color
                width: 1.0),   // Set border width
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
          // Make rounded corner of border
        ),
        // padding: EdgeInsets.only(left: 10, right: 10),
        child: _FollowupListCompletedResponse.details[index].taskStatus == "Pending"
            ? Slidable(
          // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.

              SlidableAction(
                // padding: EdgeInsets.only(left: 10),
                onPressed: (c) {
                  /*showcustomdialog123(
                                  context1: context,
                                  finalCheckingItems:
                                      _FollowupListResponse.details[index],
                                  index1: index);*/
                  String AM_PM =
                  selectedTime.periodOffset.toString() == "12"
                      ? "PM"
                      : "AM";
                  String beforZeroHour = selectedTime.hourOfPeriod <= 9
                      ? "0" + selectedTime.hourOfPeriod.toString()
                      : selectedTime.hourOfPeriod.toString();
                  String beforZerominute = selectedTime.minute <= 9
                      ? "0" + selectedTime.minute.toString()
                      : selectedTime.minute.toString();

                  String TimeHour =
                      beforZeroHour + ":" + beforZerominute + " " + AM_PM;
                  _officeToDoScreenBloc.add(ToDoSaveHeaderEvent(
                      _FollowupListCompletedResponse.details[index].pkID,
                      ToDoHeaderSaveRequest(
                          Priority: "Medium",
                          TaskDescription: _FollowupListCompletedResponse.details[index].taskDescription,
                          Location: _FollowupListCompletedResponse
                              .details[index].location,
                          TaskCategoryID: _FollowupListCompletedResponse
                              .details[index].taskCategoryId
                              .toString(),
                          StartDate: _FollowupListCompletedResponse.details[index].startDate.getFormattedDate(
                              fromFormat: "yyyy-MM-ddTHH:mm:ss",
                              toFormat: "yyyy-MM-dd") +
                              " " +
                              TimeHour,
                          DueDate: _FollowupListCompletedResponse.details[index].dueDate
                              .getFormattedDate(
                              fromFormat: "yyyy-MM-ddTHH:mm:ss",
                              toFormat: "yyyy-MM-dd") +
                              " " +
                              TimeHour,
                          CompletionDate: _FollowupListCompletedResponse.details[index].startDate
                              .getFormattedDate(fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd"),
                          LoginUserID: LoginUserID,
                          EmployeeID: _FollowupListCompletedResponse.details[index].employeeID.toString(),
                          Reminder: "",
                          ReminderMonth: "",
                          Latitude: "",
                          Longitude: "",
                          ClosingRemarks: _FollowupListCompletedResponse.details[index].closingRemarks,
                          CompanyId: CompanyID.toString())));
                },
                backgroundColor: colorGreen,
                foregroundColor: Colors.white,
                icon: Icons.done,
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: IgnorePointer(
            child: /*ExpansionTileCard(
              elevationCurve: Curves.easeInOut,
              trailing: SizedBox(
                height: 1,
                width: 1,
              ),


              leading: Container(
                  height: 35, width: 35, child: Icon(Icons.access_alarm)),

              title: Text(
                model.taskDescription,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              ),

            ),*/Text( model.taskDescription,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color(0xff39c3aa)),)
          ),
        )
            : IgnorePointer(
          child: /*ExpansionTileCard(
            elevationCurve: Curves.easeInOut,
            trailing: SizedBox(
              height: 1,
              width: 1,
            ),

            leading: Container(
                height: 35, width: 35, child: Icon(Icons.access_alarm)),

            title: Text(
              model.taskDescription,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            ),

          ),*/

          Row(

            children: [
            Container(
                height: 35, width: 35, child: Icon(Icons.access_alarm,color: Color(0xff39c3aa),)),
            SizedBox(width: 2,),
            Expanded(
              child: Text( model.taskDescription,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xff39c3aa)),),
            )
          ],)

        ));
  }

  Widget _buildTitleWithValueView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: _fontSize_Label,
                color: Color(0xFF504F4F),
                fontWeight: FontWeight
                    .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
        SizedBox(
          height: 3,
        ),
        Text(value,
            style: TextStyle(
                fontSize: _fontSize_Title,
                color:
                    colorPrimary) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            )
      ],
    );
  }


  void _onFollowupTodayListCallSuccess(ToDoTodayListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _FollowupTodayListResponse = state.response;
      } else {
        _FollowupTodayListResponse.details.addAll(state.response.details);
      }
      if (_FollowupTodayListResponse.details.length != 0) {
        TotalTodayCount = state.response.totalCount;
      } else {
        TotalTodayCount = 0;
      }

      _pageNo = state.newPage;
    }
  }

  void _onFollowupOverDueListCallSuccess(ToDoOverDueListCallResponseState state) {
    print("sdfjf45"+ state.response.details.length.toString());

    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _FollowupListOverDueResponse = state.response;
      } else {
        _FollowupListOverDueResponse.details.addAll(state.response.details);
      }
      if (_FollowupListOverDueResponse.details.length != 0) {
        TotalOverDueCount = state.response.totalCount;
      } else {
        TotalOverDueCount = 0;
      }

      _pageNo = state.newPage;
    }
  }

  void _onFollowupCompletedListCallSuccess(ToDoCompletedListCallResponseState state) {
    print("sdfjf45"+ state.response.details.length.toString());

    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _FollowupListCompletedResponse = state.response;
      } else {
        _FollowupListCompletedResponse.details.addAll(state.response.details);
      }
      if (_FollowupListCompletedResponse.details.length != 0) {
        TotalCompltedCount = state.response.totalCount;
      } else {
        TotalCompltedCount = 0;
      }

      _pageNo = state.newPage;
    }
  }


  showcustomdialog123({
    BuildContext context1,
    ToDoDetails finalCheckingItems,
    int index1,
  }) async {
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
                    "Remarks",
                    style: TextStyle(
                        color: colorPrimary, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          children: [
            SizedBox(
                width: MediaQuery.of(context123).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 7, right: 7, top: 5),
                            child: TextFormField(
                              controller: Remarks,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getCommonButton(baseTheme, () {
                      if (Remarks.text != "") {
                        Navigator.pop(context123);

                        String AM_PM =
                            selectedTime.periodOffset.toString() == "12"
                                ? "PM"
                                : "AM";
                        String beforZeroHour = selectedTime.hourOfPeriod <= 9
                            ? "0" + selectedTime.hourOfPeriod.toString()
                            : selectedTime.hourOfPeriod.toString();
                        String beforZerominute = selectedTime.minute <= 9
                            ? "0" + selectedTime.minute.toString()
                            : selectedTime.minute.toString();

                        String TimeHour =
                            beforZeroHour + ":" + beforZerominute + " " + AM_PM;
                        _officeToDoScreenBloc.add(ToDoSaveHeaderEvent(
                            finalCheckingItems.pkID,
                            ToDoHeaderSaveRequest(
                                Priority: "Medium",
                                TaskDescription: Remarks.text,
                                Location: finalCheckingItems.location,
                                TaskCategoryID: finalCheckingItems
                                    .taskCategoryId
                                    .toString(),
                                StartDate: finalCheckingItems.startDate
                                        .getFormattedDate(
                                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                            toFormat: "yyyy-MM-dd") +
                                    " " +
                                    TimeHour,
                                DueDate: finalCheckingItems.dueDate
                                        .getFormattedDate(
                                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                            toFormat: "yyyy-MM-dd") +
                                    " " +
                                    TimeHour,
                                CompletionDate: finalCheckingItems.startDate
                                    .getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "yyyy-MM-dd"),
                                LoginUserID: LoginUserID,
                                EmployeeID:
                                    finalCheckingItems.employeeID.toString(),
                                Reminder: "",
                                ReminderMonth: "",
                                Latitude: "",
                                Longitude: "",
                                ClosingRemarks:
                                    finalCheckingItems.closingRemarks,
                                CompanyId: CompanyID.toString())));
                      } else {
                        commonalertbox("Remarks should not Empty");
                      }
                    }, "Submit Details",
                        backGroundColor: colorPrimary,
                        textColor: colorWhite,
                        width: 200)
                  ],
                )),
          ],
        );
      },
    );
  }

  Widget commonalertbox(String msg,
      {GestureTapCallback onTapofPositive, bool useRootNavigator = true}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ab) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            actions: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colorPrimary, width: 2.00),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Alert!",
                  style: TextStyle(
                    fontSize: 20,
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                //margin: EdgeInsets.only(left: 10),
                child: Text(
                  msg,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                height: 1.00,
                thickness: 2.00,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: onTapofPositive ??
                    () {
                      Navigator.of(context, rootNavigator: useRootNavigator)
                          .pop();
                    },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }

  TO_DO() {
    return InkWell(
      onTap: () {
        setState(() {
          IsExpandedOverDue = false;
          IsExpandedTodays = !IsExpandedTodays;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xffef6f6c),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IsExpandedTodays == true
                      ? Icon(Icons.keyboard_arrow_up_outlined,color: Colors.white)
                      : Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Today " +" ("+TotalTodayCount.toString()+")",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              InkWell(

                  onTap: (){
                    navigateTo(context, OfficeToDoAddEditScreen.routeName,clearAllStack: true);

                  },
                  child: Icon(Icons.add,color: Colors.white,)),
            ],
          ),
        ),
      ),
    );
  }

  OVER_DUEU() {
    return InkWell(
      onTap: () {
        setState(() {
          IsExpandedTodays = false;
          IsExpandedOverDue = !IsExpandedOverDue;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        color:  Color(0xffef6f6c),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IsExpandedOverDue == true
                      ? Icon(Icons.keyboard_arrow_up_outlined,color: Colors.white)
                      : Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                   "Over-Due " +" ("+TotalOverDueCount.toString()+")",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              InkWell(

                  onTap: (){


                    navigateTo(context, OfficeToDoAddEditScreen.routeName,clearAllStack: true);


                  },
                  child: Icon(Icons.add,color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }



  TodayCompleted() {
    return InkWell(
      onTap: () {
        setState(() {

          IsExpandedCompleted = !IsExpandedCompleted;
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xff39c3aa),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IsExpandedCompleted == true
                      ? Icon(Icons.keyboard_arrow_up_outlined,color: Colors.white)
                      : Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white),

                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Completed" + "("+TotalCompltedCount.toString()+")",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _OnTODOSaveResponse(ToDoSaveHeaderState state) {

    print("TodoSave" + state.toDoSaveHeaderResponse.details[0].column2);
    _officeToDoScreenBloc.add(ToDoTodayListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Todays",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Today",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Pending",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoTComplitedListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Completed",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));

  }

  void _OnTaptoDeleteTodo(ToDoDeleteResponseState state) {
    print("TodoDelete" + state.toDoDeleteResponse.details[0].column1);
    _officeToDoScreenBloc.add(ToDoTodayListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Todays",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Today",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoOverDueListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Pending",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
    _officeToDoScreenBloc.add(ToDoTComplitedListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID,
        TaskStatus: "Completed",
        EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
        PageNo: 1,
        PageSize: 10000)));
  }

}
