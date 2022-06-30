

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/telecaller_new/telecaller_new_bloc.dart';
import 'package:soleoserp/models/api_requests/customer_delete_request.dart';
import 'package:soleoserp/models/api_requests/swastick_telecaller_request/telecaller_new_pagination_request.dart';

import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/expense_type_response.dart';

import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/swastik_telecaller_response/telecaller_new_pagination_response.dart';

import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';

import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller_new/telecaller_new_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class TeleCallerNewListScreen extends BaseStatefulWidget {
  static const routeName = '/TeleCallerNewListScreen';

  @override
  _TeleCallerNewListScreenState createState() => _TeleCallerNewListScreenState();
}

class _TeleCallerNewListScreenState extends BaseState<TeleCallerNewListScreen>
    with BasicScreen, WidgetsBindingObserver {
  TeleCallerNewBloc teleCallerNewBloc;
  int _pageNo = 0;
  bool isListExist = false;

  //TeleCallerListResponse _expenseListResponse;
  //TeleCallerOnlyNameDetails _externalDetails;
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
  TelecallerNewpaginationResponse Response;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;
  // ExpenseTypeResponse _offlineExpenseType;
  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  /*List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];*/
  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_LeadStatus = TextEditingController();


  final TextEditingController edt_FollowupEmployeeList = TextEditingController();

  final TextEditingController edt_SearchCustomer = TextEditingController();

  final TextEditingController edt_FollowupEmployeeUserID = TextEditingController();
  bool isDeleteVisible =true;

  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorDarkYellow;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData = SharedPrefHelper.instance.getFollowerEmployeeList();
    LeadStatus();
    // _offlineExpenseType = SharedPrefHelper.instance.getExpenseType();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _onFollowerEmployeeListByStatusCallSuccess(_offlineFollowerEmployeeListData);
    //_onExpenseTypeSuccessResponse(_offlineExpenseType);
    edt_FollowupStatus.text = "Account";
    edt_LeadStatus.text = "ALL Leads";
    teleCallerNewBloc = TeleCallerNewBloc(baseBloc);
    // _expenseBloc..add(ExpenseEmployeeListCallEvent(AttendanceEmployeeListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    //_expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    //edt_LeadStatus.addListener(followerEmployeeList);
    ///_expenseBloc..add(TeleCallerListCallEvent(1,TeleCallerListRequest(pkID:"",acid:"",LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text,LoginUserID:LoginUserID,CompanyId:CompanyID.toString())));
    teleCallerNewBloc.add(TeleCallerNewListCallEvent(1,TeleCallerNewListRequest(CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

    //_expenseBloc.add(TeleCallerSearchByIDCallEvent(TeleCallerSearchRequest(CompanyId: CompanyID.toString(),word: "",needALL: "0",LoginUserID: LoginUserID,LeadStatus: edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

    isExpand=false;
    isDeleteVisible = true; //viewvisiblitiyAsperClient(SerailsKey:_offlineLoggedInData.details[0].serialKey,RoleCode: _offlineLoggedInData.details[0].roleCode );
    edt_SearchCustomer.addListener(() {
      if(edt_SearchCustomer.text.length>2)
        {
          teleCallerNewBloc.add(TeleCallerNewListCallEvent(1,TeleCallerNewListRequest(pkID:"",acid:"",SerialKey:_offlineLoggedInData.details[0].serialKey,SearchKey:edt_SearchCustomer.text,CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

        }
    });
    edt_LeadStatus.addListener(() {

        teleCallerNewBloc.add(TeleCallerNewListCallEvent(1,TeleCallerNewListRequest(pkID:"",acid:"",SerialKey:_offlineLoggedInData.details[0].serialKey,SearchKey:edt_SearchCustomer.text,CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));


    });
  }



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>teleCallerNewBloc,
      //_expenseBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,word: edt_FollowupStatus.text,needALL: "0"))),
      child: BlocConsumer<TeleCallerNewBloc, TeleCallerNewStates>(
        builder: (BuildContext context, TeleCallerNewStates state) {

          if (state is TeleCallerNewListCallResponseState) {
            _onTelecallerNewpaginationCallSuccess(state);
          }
         /* if (state is TeleCallerSearchByIDResponseState) {
            _onInquirySearchCallSuccess(state);
          }*/

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is TeleCallerNewListCallResponseState ) {

            return true;
          }
          return false;
        },
        listener: (BuildContext context, TeleCallerNewStates state) {


          if(state is TeleCallerDeleteCallResponseState)
            {
              _onDeleteLead(context,state);
            }
          return super.build(context);

        },
        listenWhen: (oldState, currentState) {

          if(currentState is TeleCallerDeleteCallResponseState)
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
        appBar: NewGradientAppBar(
          title: Text('TeleCaller List'),
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
                     //teleCallerNewBloc..add(ExpenseEventsListCallEvent(1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
                     teleCallerNewBloc.add(TeleCallerNewListCallEvent(1,TeleCallerNewListRequest(CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));
                     //teleCallerNewBloc.add(TeleCallerSearchByIDCallEvent(TeleCallerSearchRequest(CompanyId: CompanyID.toString(),word: "",needALL: "0",LoginUserID: LoginUserID,LeadStatus: edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

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
          onPressed: () async {
            // Add your onPressed code here!

            navigateTo(context, TeleCallerAddEditNewScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),        drawer: build_Drawer(
          context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );

  }


  LeadStatus() {

    arr_ALL_Name_ID_For_LeadStatus.clear();
    for (var i = 0; i < 4; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "ALL Leads";
      } else if (i == 1) {
        all_name_id.Name = "DisQualified";
      } else if (i == 2) {
        all_name_id.Name = "Qualified";
      }
      else if (i == 3) {
        all_name_id.Name = "InProcess";
      }
      arr_ALL_Name_ID_For_LeadStatus.add(all_name_id);
    }
  }

  ///builds inquiry list
  Widget _buildInquiryList() {
    if (isListExist == true) {
      /*return ListView.builder(
        key: Key('selected $selected'),

        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);
        },
        shrinkWrap: true,
        itemCount: 2,
      );*/

      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (shouldPaginate(
            scrollInfo,
          ) ) {
            _onTelecallerListPagination();
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
          itemCount: Response.details.length,
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
  void _onTelecallerNewpaginationCallSuccess(TeleCallerNewListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search


        Response =  state.response;
      } else {
    Response.details.addAll(state.response.details);
      }
      _pageNo = state.newPage;
    }
    if(Response.details.length !=0)
    {
      isListExist = true;
    }
    else{
      isListExist = false;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  /*void _onInquiryListPagination() {
    // _expenseBloc..add(ExpenseEventsListCallEvent(_pageNo+ 1,ExpenseListAPIRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    _expenseBloc.add(TeleCallerListCallEvent(_pageNo + 1,TeleCallerListRequest(pkID:"",acid:"",LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text,LoginUserID:LoginUserID,CompanyId:CompanyID.toString())));
    //_expenseBloc.add(TeleCallerSearchByIDCallEvent(TeleCallerSearchRequest(CompanyId: CompanyID.toString(),word:"",needALL: "0",LoginUserID: LoginUserID,LeadStatus: edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

    *//* if (_leaveRequestListResponse.details.length < _leaveRequestListResponse.totalCount) {
       _leaveRequestScreenBloc.add(LeaveRequestCallEvent(_pageNo + 1,LeaveRequestListAPIRequest(CompanyId: CompanyID,LoginUserID: LoginUserID,pkID: "",ApprovalStatus: "",Reason: "")));

     }*//*
  }*/

  ExpantionCustomer(BuildContext context, int index) {
    TelecallerNewpaginationDetails model = Response.details[index];
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
          title: Text(model.companyName.toString(),
            style: TextStyle(
                color: Colors.black
            ),),
          subtitle: Text(model.leadStatus.toString(),
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
                                                Text("Company Name",
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
                                                    model.companyName.toString()==null?"N/A":model.companyName.toString(),
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
                                                Text("PI No",
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
                                                Text(model.refNo.toString()==null?"N/A":model.refNo.toString(),
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
                                                Text("Initiated",
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
                                                Text(model.createdBy.toString()==null?"N/A":model.createdBy.toString(),

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
                                                Text("Assign To",
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
                                                    model.employeeName.toString()==null?"N/A":model.employeeName.toString(),
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
                                                Text("Sender",
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
                                                    model.senderName.toString()==null?"N/A":model.senderName.toString(),

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
                                                Text("For Product",
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
                                                Text(model.forProduct.toString()==null?"N/A":model.forProduct.toString(),

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
                                                Text("Date",
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

                                                  model.createdDate.toString().getFormattedDate(fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy"),


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
                                                Text("State",
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
                                                Text(model.state.toString()==null?"N/A":model.state.toString(),
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
                                                Text("Status",
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
                                                    model.leadStatus.toString()==null?"N/A":model.leadStatus.toString(),
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
                                                Text("Lead#",
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
                                                    model
                                                        .leadID==""?"N/A": model.leadID,
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
                      _onTapOfEditCustomer(Response.details[index]);
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
                          Response.details[index].pkId);
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


  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen


  ///updates data of inquiry list



  void _onTapOfDeleteCustomer(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this TeleCaller Lead ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      teleCallerNewBloc.add(TeleCallerDeleteCallEvent(id,CustomerDeleteRequest(CompanyID: CompanyID.toString())));
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
        /*_onTapOfSearchView();*/

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Search Customer",
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
                      controller: edt_SearchCustomer,
                      enabled: true,
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
                          hintText: "Search Customer"
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

        showcustomdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_LeadStatus,
            context1: context,
            controller: edt_LeadStatus,
            lable: "Select Lead Status");
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
                      controller: edt_LeadStatus,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/
                      style: TextStyle(
                          color: Colors.black, // <-- Change this
                          fontSize: 10,fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Select",


                      ),),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /*void _onExpenseRequestDeleteCallSucess(TeleCallerDeleteCallResponseState state, BuildContext buildContext123) {
    print("ExpenseDeleteresponse" + " Msg : " + state.customerDeleteResponse.details[0].column1.toString());
    navigateTo(buildContext123, TeleCallerListScreen.routeName,
        clearAllStack: true);

  }*/


  /*void _onTapOfDeleteCustomer(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this TeleCaller Lead ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _expenseBloc.add(TeleCallerDeleteCallEvent(id,CustomerDeleteRequest(CompanyID: CompanyID.toString())));
    });
  }*/
/*
  void _onExpenseTypeSuccessResponse(ExpenseTypeResponse state) {
    arr_ALL_Name_ID_For_Folowup_Status.clear();

    for(var i=0;i<state.details.length;i++)
    {
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name =  state.details[i].expenseTypeName;
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
    }
  }*/

  void _onTelecallerListPagination() {
    teleCallerNewBloc.add(TeleCallerNewListCallEvent(_pageNo+1,TeleCallerNewListRequest(CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

  }

  void _onTapOfEditCustomer(detail) {

    navigateTo(context, TeleCallerAddEditNewScreen.routeName,

        arguments: AddUpdateTeleCallerScreenArguments(detail))
        .then((value) {
      teleCallerNewBloc.add(TeleCallerNewListCallEvent(_pageNo+1,TeleCallerNewListRequest(CompanyId: CompanyID.toString(),LoginUserID:LoginUserID,LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

    });
  }

  void _onDeleteLead(BuildContext buildContext123, TeleCallerDeleteCallResponseState state) {


    print("ExpenseDeleteresponse" + " Msg : " + state.customerDeleteResponse.details[0].column1.toString());
    navigateTo(buildContext123, TeleCallerNewListScreen.routeName,
        clearAllStack: true);
  }

  /*void _onLeaveRequestTypeSuccessResponse(ExpenseTypeCallResponseState state) {
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
  }*/

  /*Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchTeleCallerScreen.routeName,
        arguments: AddUpdateTeleCallerSearchScreenArguments(edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())).then((value) {
      if (value != null) {
        _externalDetails = value;
        edt_FollowupEmployeeList.text =_externalDetails.label;
        *//* _inquiryBloc.add(SearchInquiryListByNumberCallEvent(
            SearchInquiryListByNumberRequest(
                searchKey: _searchDetails.label,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));*//*
        _expenseBloc.add(TeleCallerSearchByIDCallEvent(
            TeleCallerSearchRequest(CompanyId: CompanyID.toString(),word: _externalDetails.value.toString(),needALL: "0",LoginUserID: LoginUserID,LeadStatus: edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

      }
    });
  }*/

  /*void _onInquirySearchCallSuccess(TeleCallerSearchByIDResponseState state) {
    _expenseListResponse =  state.response;

    isListExist=true;
    *//* for(int i=0;i<state.response.details.length;i++)
      {
        print("sddfdf"+state.response.details[i].senderName);
        TeleCallerListDetails teleCallerOnlyNameDetails = new  TeleCallerListDetails();
        teleCallerOnlyNameDetails = state.response.details[i];
        _expenseListResponse.details.add(teleCallerOnlyNameDetails);
      }
*//*
    // _expenseListResponse.details.addAll(state.response.details);

  }*/





  /*followerEmployeeList() {
    _expenseBloc.add(TeleCallerListCallEvent(1,TeleCallerListRequest(pkID:"",acid:"",LeadStatus:edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text,LoginUserID:LoginUserID,CompanyId:CompanyID.toString())));
    //_expenseBloc.add(TeleCallerSearchByIDCallEvent(TeleCallerSearchRequest(CompanyId: CompanyID.toString(),word: "",needALL: "0",LoginUserID: LoginUserID,LeadStatus: edt_LeadStatus.text=="ALL Leads"?"":edt_LeadStatus.text.toString())));

  }*/
}