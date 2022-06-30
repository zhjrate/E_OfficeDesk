import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/expense/expense_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/leave_request/leave_request_bloc.dart';
import 'package:soleoserp/models/api_requests/attendance_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/expense_list_request.dart';
import 'package:soleoserp/models/api_requests/expense_type_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/expense_list_response.dart';
import 'package:soleoserp/models/api_responses/expense_type_response.dart';
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
import 'package:soleoserp/ui/widgets/custom_gredient_app_bar.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'expense_add_edit_screen.dart';





class ExpenseListScreen extends BaseStatefulWidget {
  static const routeName = '/ExpenseListScreen';

  @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends BaseState<ExpenseListScreen>
    with BasicScreen, WidgetsBindingObserver {
  ExpenseBloc _expenseBloc;
  int _pageNo = 0;
  bool isListExist = false;

  ExpenseListResponse _expenseListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F;//0x66666666;
  int title_color = 0xff362d8b;
  int _key;
  String foos = 'One';
  int selected = 0; //attention
  bool isExpand=false;

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;
 // ExpenseTypeResponse _offlineExpenseType;
  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_FollowupEmployeeList = TextEditingController();
  final TextEditingController edt_FollowupEmployeeUserID = TextEditingController();
  bool isDeleteVisible =true;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorDarkYellow;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData = SharedPrefHelper.instance.getFollowerEmployeeList();
   // _offlineExpenseType = SharedPrefHelper.instance.getExpenseType();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _onFollowerEmployeeListByStatusCallSuccess(_offlineFollowerEmployeeListData);
    //_onExpenseTypeSuccessResponse(_offlineExpenseType);
    edt_FollowupStatus.text = "Account";
    edt_FollowupEmployeeList.text = _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text = _offlineLoggedInData.details[0].userID;
    _expenseBloc = ExpenseBloc(baseBloc);
    _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: "Account",needALL: "0")));
   // _expenseBloc..add(ExpenseEmployeeListCallEvent(AttendanceEmployeeListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    //_expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    edt_FollowupStatus.addListener(followerEmployeeList);
    edt_FollowupEmployeeList.addListener(followerEmployeeList);
    edt_FollowupEmployeeUserID.addListener(followerEmployeeList);
    isExpand=false;
    isDeleteVisible =  viewvisiblitiyAsperClient(SerailsKey:_offlineLoggedInData.details[0].serialKey,RoleCode: _offlineLoggedInData.details[0].roleCode );


  }

 /* followupStatusListener(){
    print("Current status Text is ${edt_FollowupStatus.text}");

    _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0")));


  }*/

  followerEmployeeList(){
    print("CurrentEMP Text is ${edt_FollowupEmployeeList.text+ " USERID : " + edt_FollowupEmployeeUserID.text}");
    _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0")));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>_expenseBloc,
     //_expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0"))),
      child: BlocConsumer<ExpenseBloc, ExpenseStates>(
        builder: (BuildContext context, ExpenseStates state) {




          if (state is ExpenseListCallResponseState) {
            _onInquiryListCallSuccess(state);
          }


          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is ExpenseListCallResponseState) {

            return true;
          }
          return false;
        },
        listener: (BuildContext context, ExpenseStates state) {
          if (state is ExpenseDeleteCallResponseState) {
            _onExpenseRequestDeleteCallSucess(state,context);
          }
          if (state is ExpenseTypeCallResponseState) {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          return super.build(context);

        },
        listenWhen: (oldState, currentState) {

          if (currentState is ExpenseDeleteCallResponseState || currentState is ExpenseTypeCallResponseState ) {

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
          title: Text('Expense List'),
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.water_damage_sharp,color: colorWhite,),
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
                   // _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
                    _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0")));

                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        Row(
                            children: [
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
           navigateTo(context, ExpenseAddEditScreen.routeName);

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
          ) ) {
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
          itemCount: _expenseListResponse.details.length,
        ),
      );
    }
    else {
      return Container(
        alignment: Alignment.center,
        child:   Lottie.asset(
            NO_SEARCH_RESULT_FOUND,
            height: 200,
            width: 200
        ),);
    }
  }

  ///builds row item view of inquiry list
  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context,index);

  }

  ///updates data of inquiry list
  void _onInquiryListCallSuccess(ExpenseListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _expenseListResponse =  state.response;
      } else {
        _expenseListResponse.details.addAll(state.response.details);
      }
      _pageNo = state.newPage;
    }
    if(_expenseListResponse.details.length !=0)
      {
        isListExist = true;
      }
    else{
      isListExist = false;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
   // _expenseBloc..add(ExpenseEventsListCallEvent(_pageNo+ 1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    _expenseBloc..add(ExpenseEventsListCallEvent(_pageNo+1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0")));

    /* if (_leaveRequestListResponse.details.length < _leaveRequestListResponse.totalCount) {
       _leaveRequestScreenBloc.add(LeaveRequestCallEvent(_pageNo + 1,LeaveRequestListAPIRequest(CompanyId: CompanyID,LoginUserID: LoginUserID,pkID: "",ApprovalStatus: "",Reason: "")));

     }*/
  }

  ExpantionCustomer(BuildContext context, int index) {
    // Details model = _leaveRequestListResponse.details[index];

    print("EmployeeName:"+ edt_FollowupEmployeeList.text.toString());

    if(_expenseListResponse.details[index].employeeName == edt_FollowupEmployeeList.text) {
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
            expandedColor: Color(0xFFC1E0FA),
            //Colors.deepOrange[50],ADD8E6
            leading: CircleAvatar(

                backgroundColor: Color(0xFF504F4F),
                child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/Image
                    .network(
                  "http://demo.sharvayainfotech.in/images/profile.png",
                  height: 35, fit: BoxFit.fill, width: 35,)),
            title: Text(_expenseListResponse.details[index].employeeName,
              style: TextStyle(
                  color: Colors.black
              ),),
            subtitle: Text(_expenseListResponse.details[index].expenseTypeName,
              style: TextStyle(
                color: Color(0xFF504F4F),
                fontSize: _fontSize_Title,
              ),),

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
                                                  Text("Expense Date  ",
                                                      style: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .expenseDate ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .expenseDate
                                                          .getFormattedDate(
                                                          fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                          toFormat: "dd-MM-yyyy") ??
                                                          "-",
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
                                                          letterSpacing: .3)),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Amount",
                                                      style: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .amount.toString() ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .amount.toString(),
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
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
                                                  Text("Expense Notes  ",
                                                      style: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .expenseNotes ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .expenseNotes,
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
                                                          letterSpacing: .3)),
                                                ],
                                              )),
                                        ]),
                                    SizedBox(
                                      height: sizeboxsize,
                                    ),
                                    _expenseListResponse.details[index]
                                        .expenseTypeName == "Petrol" ?
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
                                                  Text("From Location",
                                                      style: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .fromLocation ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .fromLocation,
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
                                                          letterSpacing: .3)),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("To Location ",
                                                      style: TextStyle(
                                                          fontStyle:
                                                          FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .toLocation ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .toLocation,
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
                                                          letterSpacing: .3)),
                                                ],
                                              )),
                                        ]) : Container(),
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
                                                          color: Color(
                                                              label_color),
                                                          fontSize: _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      _expenseListResponse
                                                          .details[index]
                                                          .createdDate ==
                                                          ""
                                                          ? "N/A"
                                                          : _expenseListResponse
                                                          .details[index]
                                                          .createdDate
                                                          .getFormattedDate(
                                                          fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                          toFormat: "dd-MM-yyyy HH:mm") ??
                                                          "-",
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize: _fontSize_Title,
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
                 // alignment: MainAxisAlignment.spaceAround,
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        _onTapOfEditCustomer(
                            _expenseListResponse.details[index]);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.edit, color: colorPrimary,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Edit', style: TextStyle(color: colorPrimary),),
                        ],
                      ),
                    ),
                    isDeleteVisible == true ? FlatButton(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        _onTapOfDeleteCustomer(
                            _expenseListResponse.details[index].pkID);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.delete, color: colorPrimary,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Delete', style: TextStyle(color: colorPrimary),),
                        ],
                      ),
                    ):Container(),


                  ]),

            ],
          ));
    }
    else if (edt_FollowupEmployeeList.text.toString() =="ALL")
      {
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
              expandedColor: Color(0xFFC1E0FA),
              //Colors.deepOrange[50],ADD8E6
              leading: CircleAvatar(

                  backgroundColor: Color(0xFF504F4F),
                  child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/Image
                      .network(
                    "http://demo.sharvayainfotech.in/images/profile.png",
                    height: 35, fit: BoxFit.fill, width: 35,)),
              title: Text(_expenseListResponse.details[index].employeeName,
                style: TextStyle(
                    color: Colors.black
                ),),
              subtitle: Text(_expenseListResponse.details[index].expenseTypeName,
                style: TextStyle(
                  color: Color(0xFF504F4F),
                  fontSize: _fontSize_Title,
                ),),

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
                                                    Text("Expense Date  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .expenseDate ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .expenseDate
                                                            .getFormattedDate(
                                                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                            toFormat: "dd-MM-yyyy") ??
                                                            "-",
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Amount",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .amount.toString() ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .amount.toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
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
                                                    Text("Expense Notes  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .expenseNotes ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .expenseNotes,
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),
                                      SizedBox(
                                        height: sizeboxsize,
                                      ),
                                      _expenseListResponse.details[index]
                                          .expenseTypeName == "Petrol" ?
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
                                                    Text("From Location",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .fromLocation ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .fromLocation,
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("To Location ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .toLocation ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .toLocation,
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]) : Container(),
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
                                                            color: Color(
                                                                label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        _expenseListResponse
                                                            .details[index]
                                                            .createdDate ==
                                                            ""
                                                            ? "N/A"
                                                            : _expenseListResponse
                                                            .details[index]
                                                            .createdDate
                                                            .getFormattedDate(
                                                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                            toFormat: "dd-MM-yyyy HH:mm") ??
                                                            "-",
                                                        style: TextStyle(
                                                            color: Color(
                                                                title_color),
                                                            fontSize: _fontSize_Title,
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
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        onPressed: () {
                          _onTapOfEditCustomer(
                              _expenseListResponse.details[index]);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.edit, color: colorPrimary,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Edit', style: TextStyle(color: colorPrimary),),
                          ],
                        ),
                      ),
                      FlatButton(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        onPressed: () {
                          _onTapOfDeleteCustomer(
                              _expenseListResponse.details[index].pkID);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.delete, color: colorPrimary,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Delete', style: TextStyle(color: colorPrimary),),
                          ],
                        ),
                      ),


                    ]),

              ],
            ));
      }
    else
      {
        return Container();
      }
  }


  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen


  ///updates data of inquiry list



  void _onTapOfEditCustomer(ExpenseDetails detail) {

    navigateTo(context, ExpenseAddEditScreen.routeName,

        arguments: AddUpdateExpenseRequestScreenArguments(detail))
        .then((value) {
      _expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0")));

    });
  }


  void _onFollowerEmployeeListByStatusCallSuccess(FollowerEmployeeListResponse state) {

    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if(state.details!=null)
    {
      if(_offlineLoggedInData.details[0].roleCode.toLowerCase().trim()=="admin")
        {
          ALL_Name_ID all_name_id = ALL_Name_ID();
          all_name_id.Name = "ALL";
          all_name_id.Name1 =LoginUserID;
          arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
        }

      for(var i=0;i<state.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.Name1 = state.details[i].userID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }

    }
  }

 /* void FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for(var i =0 ; i<3;i++)
    {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if(i==0)
      {
        all_name_id.Name = "Pending";
      }
      else if(i==1)
      {
        all_name_id.Name = "Approved";
      }
      else if(i==2)
      {
        all_name_id.Name = "Rejected";
      }
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);

    }
  }
*/
  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialog(
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_FollowupEmployeeList,
            controller2: edt_FollowupEmployeeUserID ,
            lable: "Select Employee");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Select Employee",
                    style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
                Icon(
                  Icons.filter_list_alt,
                  color: colorPrimary,
                ),]),
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
                    child:/* Text(
                        SelectedStatus =="" ?
                        "Tap to select Status" : SelectedStatus.Name,
                        style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),*/

                    TextField(
                      controller: edt_FollowupEmployeeList,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/  style: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 12, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select"
                      ),),
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
       /* showcustomdialog(
            values: arr_ALL_Name_ID_For_Folowup_Status,
            context1: context,
            controller: edt_FollowupStatus,
            lable: "Select Status");*/
        _expenseBloc.add(ExpenseTypeByNameCallEvent(ExpenseTypeAPIRequest(CompanyId: CompanyID.toString())));

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Select Status",
                    style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
                Icon(
                  Icons.filter_list_alt,
                  color: colorPrimary,
                ),]),
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
                    child:/* Text(
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
                          fontSize: 12,fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Select",
                        /* hintStyle: TextStyle(
                    color: Colors.grey, // <-- Change this
                    fontSize: 12,

                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey, // <-- Change this
                    fontSize: 12,

                  ),*/

                      ),),
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

  void _onExpenseRequestDeleteCallSucess(ExpenseDeleteCallResponseState state, BuildContext buildContext123) {

    print("ExpenseDeleteresponse" + " Msg : " + state.expenseDeleteResponse.details[0].column1.toString());
    navigateTo(buildContext123, ExpenseListScreen.routeName,
        clearAllStack: true);

  }


  void _onTapOfDeleteCustomer(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Expense ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
     _expenseBloc.add(ExpenseDeleteByNameCallEvent(id,FollowupDeleteRequest(CompanyId: CompanyID.toString())));
    });
  }

  void _onExpenseTypeSuccessResponse(ExpenseTypeResponse state) {
    arr_ALL_Name_ID_For_Folowup_Status.clear();

    for(var i=0;i<state.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =  state.details[i].expenseTypeName;
        arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
      }
  }

  void _onLeaveRequestTypeSuccessResponse(ExpenseTypeCallResponseState state) {
    if (state.expenseTypeResponse.details.length != 0) {
      arr_ALL_Name_ID_For_Folowup_Status.clear();
      for (var i = 0; i < state.expenseTypeResponse.details.length; i++) {
        print("description : " + state.expenseTypeResponse.details[i].expenseTypeName);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.expenseTypeResponse.details[i].expenseTypeName;
        all_name_id.pkID = state.expenseTypeResponse.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
      }
      showcustomdialog(
          values: arr_ALL_Name_ID_For_Folowup_Status,
          context1: context,
          controller: edt_FollowupStatus,
          lable: "Select Status");

    }
  }





}