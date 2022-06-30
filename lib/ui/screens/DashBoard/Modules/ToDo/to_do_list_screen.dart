import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
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
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_work_log_list_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import '../../home_screen.dart';

class ToDoListScreen extends BaseStatefulWidget {
  static const routeName = '/ToDoListScreen';

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends BaseState<ToDoListScreen>
    with BasicScreen, WidgetsBindingObserver {
  ToDoBloc _ToDoBloc;
  int _pageNo = 0;
  ToDoListResponse _FollowupListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  ALL_Name_ID SelectedStatus;
  final TextEditingController edt_FollowupStatus = TextEditingController();
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  //ALL_EmployeeList_Response _offlineFollowerEmployeeListData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;
  TimeOfDay selectedTime = TimeOfDay.now();

  int CompanyID = 0;
  String LoginUserID = "";
  int TotalCount = 0;
  final TextEditingController edt_FollowupEmployeeList =
      TextEditingController();
  final TextEditingController edt_FollowupEmployeeUserID =
      TextEditingController();
  final TextEditingController edt_EmployeeUserName = TextEditingController();
  TextEditingController Remarks = TextEditingController();

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _ToDoBloc = ToDoBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    //_offlineFollowerEmployeeListData = SharedPrefHelper.instance.getALLEmployeeList();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();

    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    edt_FollowupEmployeeList.text =
        _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text =
        _offlineLoggedInData.details[0].employeeID.toString();
    FetchFollowupStatusDetails();
    edt_FollowupStatus.text = "Todays";

    edt_EmployeeUserName.text = LoginUserID;

    edt_FollowupStatus.addListener(followupStatusListener);
    edt_FollowupEmployeeList.addListener(followupStatusListener);
    edt_FollowupEmployeeUserID.addListener(followupStatusListener);
    edt_EmployeeUserName.addListener(followupStatusListener);
  }

  followupStatusListener() {
    print("Current Text is ${edt_FollowupStatus.text}");
    _ToDoBloc.add(ToDoListCallEvent(ToDoListApiRequest(
        CompanyId: CompanyID.toString(),
        LoginUserID: edt_EmployeeUserName.text,
        TaskStatus: edt_FollowupStatus.text,
        EmployeeID: edt_FollowupEmployeeUserID.text,
        PageNo: 1,
        PageSize: 10000)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _ToDoBloc
        ..add(ToDoListCallEvent(ToDoListApiRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: edt_EmployeeUserName.text,
            TaskStatus: edt_FollowupStatus.text,
            EmployeeID: edt_FollowupEmployeeUserID.text,
            PageNo: _pageNo + 1,
            PageSize: 10000))),
      child: BlocConsumer<ToDoBloc, ToDoStates>(
        builder: (BuildContext context, ToDoStates state) {
          if (state is ToDoListCallResponseState) {
            _onFollowupListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is ToDoListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, ToDoStates state) {
          if (state is ToDoSaveHeaderState) {
            _OnSaveToDoHeaderResponse(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is ToDoSaveHeaderState) {
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
          title: Text('To-Do List'),
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
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _ToDoBloc
                      ..add(ToDoListCallEvent(ToDoListApiRequest(
                          CompanyId: CompanyID.toString(),
                          LoginUserID: edt_EmployeeUserName.text,
                          TaskStatus: edt_FollowupStatus.text,
                          EmployeeID: edt_FollowupEmployeeUserID.text,
                          PageNo: 1,
                          PageSize: 10000)));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        //_buildSearchView(),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 2),
                          width: double.infinity,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("      Employee",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight
                                                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                              ),
                                          Icon(
                                            Icons.filter_list_alt,
                                            color: colorGrayDark,
                                          ),
                                          Expanded(
                                            child: Center(
                                                child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xffffff8d),
                                                    Color(0xffffff8d),
                                                    Color(0xffb9f6ca),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                              ),
                                              child: Text(
                                                "Count : " +
                                                    TotalCount.toString(),
                                                style: TextStyle(
                                                    color: colorPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            )),
                                          ),
                                        ]),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Status",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight
                                                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                              ),
                                          Icon(
                                            Icons.filter_list_alt,
                                            color: colorGrayDark,
                                          ),
                                        ]),
                                  ),
                                ),
                              ]),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Row(children: [
                          Expanded(
                            flex: 2,
                            child: _buildEmplyeeListView(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildSearchView(),
                          ),
                        ]),
                        Expanded(child: _buildFollowupList())
                      ],
                    ),
                  ),
                ),
              ),

              /*  Padding(
                padding: const EdgeInsets.all(18.0),
                child: _buildSearchView(),//searchUI(Custom_values1),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: _buildFollowupList(),
              ),*/
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            navigateTo(context, ToDoAddEditScreen.routeName,
                clearAllStack: true);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Folowup_Status,
            context1: context,
            controller: edt_FollowupStatus,
            lable: "Select Status");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Text(
              "Select Status",
              style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

          ),
          SizedBox(
            height: 5,
          ),*/
          Card(
            elevation: 5,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
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
                      controller: edt_FollowupStatus,
                      enabled: false,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Tap to Select Status"),
                    ),
                    // dropdown()
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///builds inquiry list
  Widget _buildFollowupList() {
    if (_FollowupListResponse == null) {
      return Container();
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (shouldPaginate(
          scrollInfo,
        )) {
          _onFollowupListPagination();
          return true;
        } else {
          return false;
        }
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Slidable(
            // Specify a key if the Slidable is dismissible.
            key: const ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.

                SlidableAction(
                  onPressed: (c) {
                    showcustomdialog123(
                        context1: context,
                        finalCheckingItems:
                            _FollowupListResponse.details[index],
                        index1: index);
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
            child: _buildFollowupListItem(index),
          );

          // return _buildFollowupListItem(index);
        },
        shrinkWrap: true,
        itemCount: _FollowupListResponse.details.length,
      ),
    );
  }

  ///builds row item view of inquiry list
  Widget _buildFollowupListItem(int index) {
    ToDoDetails model = _FollowupListResponse.details[index];
    return ExpantionCustomer(context, index);
  }

  ///builds inquiry row items title and value's common view
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

  Widget _buildLabelWithValueView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 12,
                color: Color(
                    0xff030303)) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
        SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: baseTheme.textTheme.headline3,
        )
      ],
    );
  }

  ///updates data of inquiry list
  void _onFollowupListCallSuccess(ToDoListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _FollowupListResponse = state.response;
      } else {
        _FollowupListResponse.details.addAll(state.response.details);
      }
      if (_FollowupListResponse.details.length != 0) {
        TotalCount = state.response.totalCount;
      } else {
        TotalCount = 0;
      }

      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onFollowupListPagination() {
    if (_FollowupListResponse.details.length <
        _FollowupListResponse.totalCount) {
      _ToDoBloc
        ..add(ToDoListCallEvent(ToDoListApiRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID,
            TaskStatus: edt_FollowupStatus.text,
            EmployeeID: edt_FollowupEmployeeUserID.text,
            PageNo: _pageNo + 1,
            PageSize: 10000)));
    }
  }

  ExpantionCustomer(BuildContext context, int index) {
    ToDoDetails model = _FollowupListResponse.details[index];

    return Container(
      padding: EdgeInsets.all(15),
      child: ExpansionTileCard(
        initialElevation: 5.0,
        elevation: 5.0,
        elevationCurve: Curves.easeInOut,
        shadowColor: Color(0xFF504F4F),
        baseColor: Color(0xFFFCFCFC),
        expandedColor: Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
        leading: CircleAvatar(
            backgroundColor: Color(0xFF504F4F),
            child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/ Image
                .network(
              "http://demo.sharvayainfotech.in/images/profile.png",
              height: 35,
              fit: BoxFit.fill,
              width: 35,
            )),
        /* title: Text("Customer",style:TextStyle(fontSize: 12,color: Color(0xFF504F4F),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
      ),*/
        /* title: Text(model.employeeName,style: TextStyle(
            color: Colors.black
        ),),*/
        title: Text(
          model.taskDescription,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          model.taskStatus,
          style: TextStyle(
            color: Color(0xFF504F4F),
            fontSize: _fontSize_Title,
          ),
        ),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Start Date",
                                model.startDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Due Date",
                                model.dueDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                          Visibility(
                            visible: true,
                            child: GestureDetector(
                              onTap: () async {
                                //await _makePhoneCall(model.contactNo1);
                                //await _makeSms(model.contactNo1);
                                //  _launchURL(model.contactNo1);
                                MoveTofollowupHistoryPage(
                                    model.pkID.toString());
                              },
                              child: /*Container(
                                            width:40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: colorPrimary,


                                                              ),
                                            child:
                                            Image.asset(
                                              HISTORY_ICON,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),*/
                                  Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                    color: colorWhite, shape: BoxShape.circle),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                      HISTORY_ICON,
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Assign To",
                        /*model.referenceName ?? "-" */ model.employeeName ==
                                    "" ||
                                model.employeeName == null
                            ? '-'
                            : model.employeeName),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Status",
                        /*model.referenceName ?? "-" */ model.taskStatus ==
                                    "" ||
                                model.taskStatus == null
                            ? '-'
                            : model.taskStatus),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Task Description",
                        /*model.referenceName ?? "-" */ model.taskDescription ==
                                    "" ||
                                model.taskDescription == null
                            ? '-'
                            : model.taskDescription),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Initiated By", model.fromEmployeeName),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Completion Date",
                        model.completionDate == "" ||
                                model.completionDate == null ||
                                model.completionDate == "1900-01-01T00:00:00"
                            ? '-'
                            : model.completionDate.getFormattedDate(
                                fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                toFormat: "dd-MM-yyyy")),
                    /*Row(children: [
                        Expanded(
                          child: getCommonButton(baseTheme, () {}, "Edit"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: getCommonButton(baseTheme, () {}, "Delete"),
                        ),
                      ]),*/
                  ],
                ),
              ),
            ),
          ),
          ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              buttonHeight: 52.0,
              buttonMinWidth: 90.0,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {
                    _onTapOfEditCustomer(model);
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {
                    //  cardA.currentState?.collapse();
                    //new ExpansionTileCardState().collapse();
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ]),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }
/*
  Future<void> _onTapOfSearchView() {


  }*/

  Widget dropdown() {
    return GestureDetector(
      onTap: () => showcustomdialog(
          values: arr_ALL_Name_ID_For_Folowup_Status,
          context1: context,
          controller: edt_FollowupStatus,
          lable: "Select Status"),
      child: Container(
        child: buildUserNameTextFiledRounded(
            enablevalue: false,
            userName_Controller: edt_FollowupStatus,
            labelName: "Followup Status",
            icon: Icon(Icons.arrow_drop_down),
            maxline: 1,
            baseTheme: baseTheme),
      ),
    );
  }

  Future<void> _onTapOfSearchView(BuildContext context) async {}

  FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Todays";
      } else if (i == 1) {
        all_name_id.Name = "Pending";
      } else if (i == 2) {
        all_name_id.Name = "Completed";
      }
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
    }
  }

  void _onFollowerEmployeeListByStatusCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        // all_name_id.Name1 = state.details[i].;
        all_name_id.pkID = state.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showcustomdialogWithID(
                  values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
                  context1: context,
                  controller: edt_FollowupEmployeeList,
                  controllerID: edt_FollowupEmployeeUserID,
                  lable: "Select Employee");
            },
            child: Card(
              elevation: 5,
              color: colorLightGray,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                        controller: edt_FollowupEmployeeList,
                        enabled: false,
                        /*  onChanged: (value) => {
                      print("StatusValue " + value.toString() )
                  },*/
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
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
            ),
          ),
        ],
      ),
    );
  }

  void _onTapOfEditCustomer(ToDoDetails model) {
    navigateTo(context, ToDoAddEditScreen.routeName,
            arguments: AddUpdateTODOScreenArguments(model))
        .then((value) {
      _ToDoBloc
        ..add(ToDoListCallEvent(ToDoListApiRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID,
            TaskStatus: edt_FollowupStatus.text,
            EmployeeID: edt_FollowupEmployeeUserID.text,
            PageNo: _pageNo + 1,
            PageSize: 10)));
    });
  }

  Future<void> MoveTofollowupHistoryPage(String inquiryNo) {
    navigateTo(context, ToDoWorkLogScreen.routeName,
            arguments: ToDoWorkLogScreenArguments(inquiryNo))
        .then((value) {});
  }

  doSomething() {
    print("ddf" + "Deleted");
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
                        _ToDoBloc.add(ToDoSaveHeaderEvent(
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

  void _OnSaveToDoHeaderResponse(ToDoSaveHeaderState state) {
    Remarks.text = "";
    commonalertbox(state.toDoSaveHeaderResponse.details[0].column2,
        onTapofPositive: () {
      _ToDoBloc.add(ToDoListCallEvent(ToDoListApiRequest(
          CompanyId: CompanyID.toString(),
          LoginUserID: edt_EmployeeUserName.text,
          TaskStatus: edt_FollowupStatus.text,
          EmployeeID: edt_FollowupEmployeeUserID.text,
          PageNo: 1,
          PageSize: 10000)));
      Navigator.pop(context);
    });
  }
}
