import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/leave_request/leave_request_bloc.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'leave_request_add_edit_screen.dart';

class LeaveRequestListScreen extends BaseStatefulWidget {
  static const routeName = '/LeaveRequestListScreen';

  @override
  _LeaveRequestListScreenState createState() => _LeaveRequestListScreenState();
}

class _LeaveRequestListScreenState extends BaseState<LeaveRequestListScreen>
    with BasicScreen, WidgetsBindingObserver {
  LeaveRequestScreenBloc _leaveRequestScreenBloc;
  int _pageNo = 0;
  bool isListExist = false;

  LeaveRequestListResponse _leaveRequestListResponse;

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

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;
  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_FollowupEmployeeList =
      TextEditingController();
  final TextEditingController edt_FollowupEmployeeUserID =
      TextEditingController();
  bool isDeleteVisible = true;

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
    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);

    _leaveRequestScreenBloc = LeaveRequestScreenBloc(baseBloc);
    edt_FollowupEmployeeList.text =
        _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text =
        _offlineLoggedInData.details[0].employeeID.toString();
    edt_FollowupStatus.text = "Pending";

    //_leaveRequestScreenBloc..add(LeaveRequestEmployeeListCallEvent(AttendanceEmployeeListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    FetchFollowupStatusDetails();
    edt_FollowupStatus.addListener(followupStatusListener);
    edt_FollowupEmployeeList.addListener(followerEmployeeList);
    edt_FollowupEmployeeUserID.addListener(followerEmployeeList);
    isExpand = false;
    isDeleteVisible = viewvisiblitiyAsperClient(
        SerailsKey: _offlineLoggedInData.details[0].serialKey,
        RoleCode: _offlineLoggedInData.details[0].roleCode);
  }

  followupStatusListener() {
    print("Current status Text is ${edt_FollowupStatus.text}");

    // _FollowupBloc.add(SearchFollowupListByNameCallEvent(SearchFollowupListByNameRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,FollowupStatusID: "",FollowupStatus: edt_FollowupStatus.text,SearchKey: "",Month: "",Year: "")));
    _leaveRequestScreenBloc.add(LeaveRequestCallEvent(
        1,
        LeaveRequestListAPIRequest(
            EmployeeID: edt_FollowupEmployeeUserID.text,
            ApprovalStatus: edt_FollowupStatus.text,
            Month: "",
            Year: "",
            CompanyId: CompanyID)));
  }

  followerEmployeeList() {
    print(
        "CurrentEMP Text is ${edt_FollowupEmployeeList.text + " USERID : " + edt_FollowupEmployeeUserID.text}");
    _leaveRequestScreenBloc.add(LeaveRequestCallEvent(
        1,
        LeaveRequestListAPIRequest(
            EmployeeID: edt_FollowupEmployeeUserID.text,
            ApprovalStatus: edt_FollowupStatus.text,
            Month: "",
            Year: "",
            CompanyId: CompanyID)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _leaveRequestScreenBloc
        ..add(LeaveRequestCallEvent(
            1,
            LeaveRequestListAPIRequest(
                EmployeeID: edt_FollowupEmployeeUserID.text,
                ApprovalStatus: edt_FollowupStatus.text,
                Month: "",
                Year: "",
                CompanyId: CompanyID))),
      child: BlocConsumer<LeaveRequestScreenBloc, LeaveRequestStates>(
        builder: (BuildContext context, LeaveRequestStates state) {
          if (state is LeaveRequestStatesResponseState) {
            _onInquiryListCallSuccess(state);
          }
          /* if(state is LeaveRequestEmployeeListResponseState)
          {
            _onFollowerEmployeeListByStatusCallSuccess(state);
          }
*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState
              is LeaveRequestStatesResponseState /*|| currentState is LeaveRequestEmployeeListResponseState*/) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, LeaveRequestStates state) {
          if (state is LeaveRequestDeleteCallResponseState) {
            _onLeaveRequestDeleteCallSucess(state, context);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is LeaveRequestDeleteCallResponseState) {
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
          title: Text('Leave Request List'),
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
                    _leaveRequestScreenBloc.add(LeaveRequestCallEvent(
                        1,
                        LeaveRequestListAPIRequest(
                            EmployeeID: edt_FollowupEmployeeUserID.text,
                            ApprovalStatus: edt_FollowupStatus.text,
                            Month: "",
                            Year: "",
                            CompanyId: CompanyID)));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
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
                        Expanded(child: _buildInquiryList())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            navigateTo(context, LeaveRequestAddEditScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );
  }

  ///builds inquiry list
  Widget _buildInquiryList() {
    if (isListExist == true) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (shouldPaginate(
            scrollInfo,
          )) {
            _onInquiryListPagination();
            return true;
          } else {
            return false;
          }
        },
        child: ListView.builder(
          key: Key('selected $selected'),
          itemBuilder: (context, index) {
            return _buildInquiryListItem(index);
          },
          shrinkWrap: true,
          itemCount: _leaveRequestListResponse.details.length,
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Lottie.asset(NO_SEARCH_RESULT_FOUND, height: 200, width: 200),
      );
    }
  }

  ///builds row item view of inquiry list
  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context, index);
  }

  ///updates data of inquiry list
  void _onInquiryListCallSuccess(LeaveRequestStatesResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _leaveRequestListResponse = state.leaveRequestListResponse;
      } else {
        _leaveRequestListResponse.details
            .addAll(state.leaveRequestListResponse.details);
      }
      _pageNo = state.newPage;
    }
    if (_leaveRequestListResponse.details.length != 0) {
      isListExist = true;
    } else {
      isListExist = false;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    _leaveRequestScreenBloc.add(LeaveRequestCallEvent(
        _pageNo + 1,
        LeaveRequestListAPIRequest(
            EmployeeID: edt_FollowupEmployeeUserID.text,
            ApprovalStatus: edt_FollowupStatus.text,
            Month: "",
            Year: "",
            CompanyId: CompanyID)));

    /* if (_leaveRequestListResponse.details.length < _leaveRequestListResponse.totalCount) {
       _leaveRequestScreenBloc.add(LeaveRequestCallEvent(_pageNo + 1,LeaveRequestListAPIRequest(CompanyId: CompanyID,LoginUserID: LoginUserID,pkID: "",ApprovalStatus: "",Reason: "")));

     }*/
  }

  ExpantionCustomer(BuildContext context, int index) {
    // Details model = _leaveRequestListResponse.details[index];

    return Container(
        padding: EdgeInsets.all(15),
        child: ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          /* elevationCurve: Curves.easeInOut,
          initiallyExpanded : index==selected,*/

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
          title: Text(
            _leaveRequestListResponse.details[index].employeeName,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            _leaveRequestListResponse.details[index].approvalStatus,
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
                    margin: EdgeInsets.all(20),
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("From Date  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                .details[index]
                                                                .fromDate ==
                                                            ""
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                                .details[index]
                                                                .fromDate
                                                                .getFormattedDate(
                                                                    fromFormat:
                                                                        "yyyy-MM-ddTHH:mm:ss",
                                                                    toFormat:
                                                                        "dd-MM-yyyy") ??
                                                            "-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("To Date",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                .details[index]
                                                                .toDate ==
                                                            ""
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                                .details[index]
                                                                .toDate
                                                                .getFormattedDate(
                                                                    fromFormat:
                                                                        "yyyy-MM-ddTHH:mm:ss",
                                                                    toFormat:
                                                                        "dd-MM-yyyy") ??
                                                            "-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Reason For Leave  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                .details[index]
                                                                .reasonForLeave ==
                                                            ""
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                            .details[index]
                                                            .reasonForLeave,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Created By  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                .details[index]
                                                                .createdBy ==
                                                            ""
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                            .details[index]
                                                            .createdBy,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Leave Type  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                    .details[
                                                                        index]
                                                                    .leaveType ==
                                                                "" ||
                                                            _leaveRequestListResponse
                                                                    .details[
                                                                        index]
                                                                    .leaveType ==
                                                                "--Not Available--"
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                            .details[index]
                                                            .leaveType,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Created Date  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse
                                                                .details[index]
                                                                .createdDate ==
                                                            ""
                                                        ? "N/A"
                                                        : _leaveRequestListResponse
                                                                .details[index]
                                                                .createdDate
                                                                .getFormattedDate(
                                                                    fromFormat:
                                                                        "yyyy-MM-ddTHH:mm:ss",
                                                                    toFormat:
                                                                        "dd-MM-yyyy HH:mm") ??
                                                            "-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ),
            ),
            ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                      _onTapOfEditCustomer(
                          _leaveRequestListResponse.details[index]);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: colorPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(color: colorPrimary),
                        ),
                      ],
                    ),
                  ),
                  isDeleteVisible == true
                      ? FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
                            _onTapOfDeleteCustomer(
                                _leaveRequestListResponse.details[index].pkID);
                          },
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                                color: colorPrimary,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: colorPrimary),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ]),
          ],
        ));
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen

  ///updates data of inquiry list

  void _onTapOfEditCustomer(LeaveRequestDetails detail) {
    navigateTo(context, LeaveRequestAddEditScreen.routeName,
            arguments: AddUpdateLeaveRequestScreenArguments(detail))
        .then((value) {
      _leaveRequestScreenBloc.add(LeaveRequestCallEvent(
          1,
          LeaveRequestListAPIRequest(
              EmployeeID: edt_FollowupEmployeeUserID.text,
              ApprovalStatus: edt_FollowupStatus.text,
              Month: "",
              Year: "",
              CompanyId: CompanyID)));
    });
  }

  void _onFollowerEmployeeListByStatusCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if (state.details != null) {
      if (_offlineLoggedInData.details[0].roleCode.toLowerCase().trim() ==
          "admin") {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = "ALL";
        all_name_id.Name1 = "";
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }

      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.Name1 = state.details[i].pkID.toString();
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  void FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Pending";
      } else if (i == 1) {
        all_name_id.Name = "Approved";
      } else if (i == 2) {
        all_name_id.Name = "Rejected";
      }
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
    }
  }

  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialog(
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_FollowupEmployeeList,
            controller2: edt_FollowupEmployeeUserID,
            lable: "Select Employee");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Select Employee",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
            Icon(
              Icons.filter_list_alt,
              color: colorPrimary,
            ),
          ]),
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
                      controller: edt_FollowupEmployeeList,
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

  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialog(
            values: arr_ALL_Name_ID_For_Folowup_Status,
            context1: context,
            controller: edt_FollowupStatus,
            lable: "Select Status");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Select Status",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
            Icon(
              Icons.filter_list_alt,
              color: colorPrimary,
            ),
          ]),
          SizedBox(
            height: 5,
          ),
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
                        hintText: "Select",
                        /* hintStyle: TextStyle(
                    color: Colors.grey, // <-- Change this
                    fontSize: 12,

                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey, // <-- Change this
                    fontSize: 12,

                  ),*/
                      ),
                    ),
                    // dropdown()
                  ),
                  /*Icon(
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

  void _onLeaveRequestDeleteCallSucess(
      LeaveRequestDeleteCallResponseState state, BuildContext buildContext123) {
    print("DeleteLeaveRequestResponse" +
        " Msg : " +
        state.leaveRequestDeleteResponse.details[0].column1.toString());
    navigateTo(buildContext123, LeaveRequestListScreen.routeName,
        clearAllStack: true);
  }

  void _onTapOfDeleteCustomer(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Leave Request ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _leaveRequestScreenBloc.add(LeaveRequestDeleteByNameCallEvent(
          id, FollowupDeleteRequest(CompanyId: CompanyID.toString())));
    });
  }
}
