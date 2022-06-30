import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/loan/loan_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/missed_punch/missed_punch_bloc.dart';
import 'package:soleoserp/models/api_requests/attendance_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/loan_approval_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_list_response.dart';
import 'package:soleoserp/models/api_responses/loan_list_response.dart';
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





class MissedPunchApprovalListScreen extends BaseStatefulWidget {
  static const routeName = '/MissedPunchApprovalListScreen';

  @override
  _MissedPunchApprovalListScreenState createState() => _MissedPunchApprovalListScreenState();
}

class _MissedPunchApprovalListScreenState extends BaseState<MissedPunchApprovalListScreen>
    with BasicScreen, WidgetsBindingObserver {
  MissedPunchScreenBloc _leaveRequestScreenBloc;
  int _pageNo = 0;
  bool isListExist = false;


  LoanListResponse _leaveRequestListResponse;
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

  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];

  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_ApprovalStatus = TextEditingController();

  final TextEditingController edt_FollowupEmployeeList = TextEditingController();
  final TextEditingController edt_FollowupEmployeeUserID = TextEditingController();

  List<String> selectedItemValue = [];


  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorDarkYellow;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData = SharedPrefHelper.instance.getFollowerEmployeeList();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _onFollowerEmployeeListByStatusCallSuccess(_offlineFollowerEmployeeListData);

    _leaveRequestScreenBloc = MissedPunchScreenBloc(baseBloc);
    edt_FollowupEmployeeList.text = _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text = _offlineLoggedInData.details[0].employeeID.toString();
    edt_FollowupStatus.text = "Pending";

    // _leaveRequestScreenBloc..add(LeaveRequestEmployeeListCallEvent(AttendanceEmployeeListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    FetchFollowupStatusDetails();
    edt_FollowupStatus.addListener(followupStatusListener);

    isExpand=false;

  }

  followupStatusListener(){
    print("Current status Text is ${edt_FollowupStatus.text}");

    // _FollowupBloc.add(SearchFollowupListByNameCallEvent(SearchFollowupListByNameRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,FollowupStatusID: "",FollowupStatus: edt_FollowupStatus.text,SearchKey: "",Month: "",Year: "")));
   // _leaveRequestScreenBloc.add(MissedPunchApprovalListCallEvent(MissedPunchApproval ApprovalListRequest(pkID: "",ApprovalStatus: edt_FollowupStatus.text,LoginUserID: LoginUserID,CompanyId: CompanyID)));


  }



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>    _leaveRequestScreenBloc,//..add(LoanApprovalListCallEvent(LoanApprovalListRequest(pkID: "",ApprovalStatus: edt_FollowupStatus.text,LoginUserID: LoginUserID,CompanyId: CompanyID))),

      child: BlocConsumer<MissedPunchScreenBloc, MissedPunchScreenStates>(
        builder: (BuildContext context, MissedPunchScreenStates state) {
          if (state is LoanApprovalListResponseState) {
           // _onInquiryListCallSuccess(state);
          }


          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is LoanApprovalListResponseState) {

            return true;
          }
          return false;
        },
        listener: (BuildContext context, MissedPunchScreenStates state) {

          return super.build(context);

        },
        listenWhen: (oldState, currentState) {


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
          title: Text('Leave Approval'),
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
                   // _leaveRequestScreenBloc.add(LoanApprovalListCallEvent(LoanApprovalListRequest(pkID: "",ApprovalStatus: edt_FollowupStatus.text,LoginUserID: LoginUserID,CompanyId: CompanyID)));

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

        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );



  }



  ///builds inquiry list
  Widget _buildInquiryList() {
    if (isListExist == true) {
      return  ListView.builder(
        key: Key('selected $selected'),

        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);
        },
        shrinkWrap: true,
        itemCount: _leaveRequestListResponse.details.length,
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
  void _onInquiryListCallSuccess(LoanApprovalListResponseState state) {
    _leaveRequestListResponse =  state.employeeListResponse;

    if(_leaveRequestListResponse.details.length !=0)
    {
      isListExist = true;
    }
    else{
      isListExist = false;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page


  ExpantionCustomer(BuildContext context, int index) {
    // Details model = _leaveRequestListResponse.details[index];

    return Container(
        padding: EdgeInsets.all(15),
        child : ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          /* elevationCurve: Curves.easeInOut,
          initiallyExpanded : index==selected,*/

          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: Color(0xFFC1E0FA),//Colors.deepOrange[50],ADD8E6
          leading: CircleAvatar(

              backgroundColor: Color(0xFF504F4F),
              child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/Image.network("http://demo.sharvayainfotech.in/images/profile.png", height: 35, fit: BoxFit.fill,width: 35,)),
          title: Text(_leaveRequestListResponse.details[index].employeeName,style: TextStyle(
              color: Colors.black
          ),),
          subtitle: Text(_leaveRequestListResponse.details[index].approvalStatus,style: TextStyle(
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
                        child:  Row(
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
                                                Text("Apply Date",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse.details[index]
                                                        .createdDate ==
                                                        ""
                                                        ? "N/A"
                                                        :_leaveRequestListResponse.details[index]
                                                        .createdDate.getFormattedDate(
                                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                        toFormat: "dd-MM-yyyy") ??
                                                        "-",
                                                    style: TextStyle(
                                                        color: Color(title_color),
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
                                                Text("Loan Amount",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse.details[index]
                                                        .loanAmount ==0.00

                                                        ? "N/A"
                                                        :_leaveRequestListResponse.details[index]
                                                        .loanAmount.toString(),
                                                    style: TextStyle(
                                                        color: Color(title_color),
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
                                                Text("No.Of Installments ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse.details[index]
                                                        .noOfInstallments ==
                                                        0.00
                                                        ? "N/A"
                                                        :_leaveRequestListResponse.details[index]
                                                        .noOfInstallments.toString(),
                                                    style: TextStyle(
                                                        color: Color(title_color),
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
                                                Text("Installment Amount  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    _leaveRequestListResponse.details[index]
                                                        .installmentAmount ==
                                                        0.00
                                                        ? "N/A"
                                                        :_leaveRequestListResponse.details[index]
                                                        .installmentAmount.toString(),
                                                    style: TextStyle(
                                                        color: Color(title_color),
                                                        fontSize: _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),



                                  Container(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: colorWhite,
                                        border: Border.all(color: colorPrimary)),
                                    child: DropdownButtonHideUnderline(
                                      child:  DropdownButton(
                                        isExpanded: true,
                                        style: TextStyle(color: colorPrimary),
                                        value:_leaveRequestListResponse.details[index].approvalStatus ,
                                        items: _dropDownApprovalItem(),
                                        onChanged: (value) {
                                          _leaveRequestListResponse.details[index].approvalStatus = value;
                                          setState(() {});
                                        },
                                        hint: Text('Select Gender'),
                                      ),
                                    ),
                                  ),


                                  // _buildApprovalStatus(index),
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
            Divider(
                color: Colors.black
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

                      //_onTapOfEditCustomer(_leaveRequestListResponse.details[index]);

                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Save',style: TextStyle(color: colorPrimary,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  /*  FlatButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {


                      _onTapOfDeleteCustomer(_leaveRequestListResponse.details[index].pkID);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.delete,color: colorPrimary,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Delete',style: TextStyle(color: colorPrimary),),
                      ],
                    ),
                  ),
*/



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

    /* navigateTo(context, LeaveRequestAddEditScreen.routeName,

        arguments: AddUpdateLeaveRequestScreenArguments(detail))
        .then((value) {
      _leaveRequestScreenBloc..add(LeaveRequestCallEvent(1,LeaveRequestListAPIRequest(CompanyId: CompanyID,LoginUserID: edt_FollowupEmployeeUserID.text,pkID: "",ApprovalStatus: edt_FollowupStatus.text,Reason: "")));

    });*/

    ///_leaveRequestScreenBloc.add(LeaveRequestApprovalSaveCallEvent(detail.pkID,LeaveApprovalSaveAPIRequest(ApprovalStatus: detail.approvalStatus,LoginUserID: LoginUserID,CompanyId: CompanyID)));

  }

  void _onFollowerEmployeeListByStatusCallSuccess(FollowerEmployeeListResponse state) {

    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if(state.details!=null)
    {
      if(_offlineLoggedInData.details[0].roleCode.toLowerCase().trim()=="admin")
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = "ALL";
        all_name_id.Name1 ="";
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
      for(var i=0;i<state.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.Name1 = state.details[i].pkID.toString();
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }



  void FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for(var i =0 ; i<3;i++)
    {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if(i==0)
      {
        all_name_id.Name = "Pending";
        all_name_id.Name1 = "Pending";

      }
      else if(i==1)
      {
        all_name_id.Name = "Approved";
        all_name_id.Name1 = "Approved";

      }
      else if(i==2)
      {
        all_name_id.Name = "Rejected";
        all_name_id.Name1 = "Rejected";

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
        showcustomdialog(
            values: arr_ALL_Name_ID_For_Folowup_Status,
            context1: context,
            controller: edt_FollowupStatus,
            controller2: edt_FollowupStatus,
            lable: "Select Status");
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








  List<DropdownMenuItem<String>> _dropDownApprovalItem() {
    List<String> ddl = ["Pending", "Approved", "Rejected"];
    return ddl
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    ))
        .toList();
  }
  List<DropdownMenuItem<String>> _dropDownPaidUnpaidItem() {
    List<String> ddl = ["Paid","unpaid"];
    return ddl
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    ))
        .toList();
  }




}