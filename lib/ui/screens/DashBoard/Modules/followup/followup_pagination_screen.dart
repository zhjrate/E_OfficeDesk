// ignore_for_file: non_constant_identifier_names

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/followup/followup_bloc.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/followup_filter_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_history_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:whatsapp_share/whatsapp_share.dart';

import '../../home_screen.dart';

class FollowupListScreen extends BaseStatefulWidget {
  static const routeName = '/FollowupListScreen';

  @override
  _FollowupListScreenState createState() => _FollowupListScreenState();
}

class _FollowupListScreenState extends BaseState<FollowupListScreen>
    with BasicScreen, WidgetsBindingObserver {
  FollowupBloc _FollowupBloc;
  int _pageNo = 0;
  FollowupFilterListResponse _FollowupListResponse;
  // FollowerEmployeeListResponse _FollowerEmployeeListResponse;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;

  bool expanded = true;
  bool isListExist = false;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  ALL_Name_ID SelectedStatus;
  final TextEditingController edt_FollowupStatus = TextEditingController();
  final TextEditingController edt_FollowupEmployeeList =
      TextEditingController();
  final TextEditingController edt_FollowupEmployeeUserID =
      TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  int selected = 0; //attention
  bool isExpand = false;

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  var _url = "https://api.whatsapp.com/send?phone=91";
  bool isDeleteVisible = true;
  int TotalCount = 0;

  @override
  void initState() {
    super.initState();

    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _FollowupBloc = FollowupBloc(baseBloc);

    edt_FollowupStatus.text = "Todays";

    FetchFollowupStatusDetails();
    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);
    edt_FollowupEmployeeList.text =
        _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text = _offlineLoggedInData.details[0].userID;
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
    if (edt_FollowupEmployeeUserID.text == null ||
        edt_FollowupStatus.text == null) {
      _FollowupBloc.add(FollowupFilterListCallEvent(
          "Todays",
          FollowupFilterListRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: LoginUserID,
              PageNo: 1,
              PageSize: 10000)));
    } else {
      // _FollowupBloc.add(SearchFollowupListByNameCallEvent(SearchFollowupListByNameRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,FollowupStatusID: "",FollowupStatus: edt_FollowupStatus.text,SearchKey: "",Month: "",Year: "")));
      _FollowupBloc.add(FollowupFilterListCallEvent(
          edt_FollowupStatus.text,
          FollowupFilterListRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: edt_FollowupEmployeeUserID.text,
              PageNo: 1,
              PageSize: 10000)));
    }
  }

  followerEmployeeList() {
    print(
        "CurrentEMP Text is ${edt_FollowupEmployeeList.text + " USERID : " + edt_FollowupEmployeeUserID.text}");
    if (edt_FollowupEmployeeUserID.text == null ||
        edt_FollowupStatus.text == null) {
      _FollowupBloc.add(FollowupFilterListCallEvent(
          "Todays",
          FollowupFilterListRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: LoginUserID,
              PageNo: 1,
              PageSize: 10)));
    } else {
      // _FollowupBloc.add(SearchFollowupListByNameCallEvent(SearchFollowupListByNameRequest(CompanyId: CompanyID.toString(),LoginUserID: edt_FollowupEmployeeUserID.text,FollowupStatusID: "",FollowupStatus: edt_FollowupStatus.text,SearchKey: "",Month: "",Year: "")));
      _FollowupBloc.add(FollowupFilterListCallEvent(
          edt_FollowupStatus.text,
          FollowupFilterListRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: edt_FollowupEmployeeUserID.text,
              PageNo: 1,
              PageSize: 10000)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc
        ..add(FollowupFilterListCallEvent(
            edt_FollowupStatus.text,
            FollowupFilterListRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: edt_FollowupEmployeeUserID.text,
                PageNo: 1,
                PageSize: 10000))),

      // _FollowupBloc..add(FollowupFilterListCallEvent("todays",FollowupFilterListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID,PageNo: 1,PageSize: 10))),
      child: BlocConsumer<FollowupBloc, FollowupStates>(
        builder: (BuildContext context, FollowupStates state) {
          if (state is FollowupFilterListCallResponseState) {
            _onFollowupListCallSuccess(state);
          }

          /* if(state is FollowerEmployeeListByStatusCallResponseState)
          {
            _onFollowerEmployeeListByStatusCallSuccess(state);
          }*/

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is FollowupFilterListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, FollowupStates state) {
          if (state is FollowupDeleteCallResponseState) {
            _onFollowupDeleteCallSucess(state, context);
          }
        },
        listenWhen: (oldState, currentState) {
          if (currentState is FollowupDeleteCallResponseState) {
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
          title: Text('Followup List'),
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
                    _FollowupBloc.add(FollowupFilterListCallEvent(
                        edt_FollowupStatus.text,
                        FollowupFilterListRequest(
                            CompanyId: CompanyID.toString(),
                            LoginUserID: edt_FollowupEmployeeUserID.text,
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

                        //_buildSearchView(),
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
            navigateTo(context, FollowUpAddEditScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: LoginUserID),
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
          /*  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Status",
                    style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
                Icon(
                  Icons.filter_list_alt,
                  color: colorGrayDark,
                ),]),*/
          /*  SizedBox(
            height: 5,
          ),
*/
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
              showcustomdialog(
                  values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
                  context1: context,
                  controller: edt_FollowupEmployeeList,
                  controller2: edt_FollowupEmployeeUserID,
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

  ///builds inquiry list
  Widget _buildFollowupList() {
    if (isListExist == true) {
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
          key: Key('selected $selected'),
          itemBuilder: (context, index) {
            return _buildFollowupListItem(index);
          },
          shrinkWrap: true,
          itemCount: _FollowupListResponse.details.length,
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
  Widget _buildFollowupListItem(int index) {
    //FilterDetails model = _FollowupListResponse.details[index];

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
                /*fontWeight: FontWeight.bold,*/ fontStyle: FontStyle
                    .italic) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
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
  void _onFollowupListCallSuccess(FollowupFilterListCallResponseState state) {
    // print("InqResponse" + state.followupFilterListResponse.details[0].customerName);
    /* if (_pageNo != state.newPage) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        _FollowupListResponse = state.response;
      } else {
        _FollowupListResponse.data.details.addAll(state.response.data.details);
      }
      _pageNo = state.newPage;
    }*/

    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        //edt_FollowupStatus.text = "";
        _FollowupListResponse = state.followupFilterListResponse;
      } else {
        _FollowupListResponse.details
            .addAll(state.followupFilterListResponse.details);
      }
      _pageNo = state.newPage;
    }

    if (_FollowupListResponse.details.length != 0) {
      isListExist = true;
      TotalCount = state.followupFilterListResponse.totalCount;
    } else {
      isListExist = false;
      TotalCount = 0;
    }

    /* for(int i=0;i<_FollowupListResponse.details.length;i++)
      {
        if(_FollowupListResponse.details)
      }*/
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onFollowupListPagination() {
    _FollowupBloc.add(FollowupFilterListCallEvent(
        edt_FollowupStatus.text,
        FollowupFilterListRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID,
            PageNo: _pageNo + 1,
            PageSize: 10000)));

    /* if (_FollowupListResponse.details.length < _FollowupListResponse.totalCount) {

    }*/
  }

  ExpantionCustomer(BuildContext context, int index) {
    FilterDetails model = _FollowupListResponse.details[index];
    //Totcount= _FollowupListResponse.totalCount;
    //  if(_FollowupListResponse.details[index].employeeName == edt_FollowupEmployeeList.text) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ExpansionTileCard(
        //isThreeLine: true,
        initialElevation: 5.0,
        elevation: 5.0,
        elevationCurve: Curves.easeInOut,
        // initiallyExpanded: index == selected,
        shadowColor: Color(0xFF504F4F),
        baseColor: Color(0xFFFCFCFC),
        expandedColor: Color(0xFFC1E0FA),
        //Colors.deepOrange[50],ADD8E6
        leading: CircleAvatar(
            backgroundColor: Color(0xFF504F4F),
            child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/ Image
                .network(
              "http://demo.sharvayainfotech.in/images/profile.png",
              height: 35,
              fit: BoxFit.fill,
              width: 35,
            )),
        //trailing: Text(model.timeIn),
        /* title: Text("Customer",style:TextStyle(fontSize: 12,color: Color(0xFF504F4F),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
      ),*/
        /*title: Text(model.customerName,style: TextStyle(
            color: Colors.black
        ),),*/

        title: Text(
          model.customerName,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              model.inquiryStatus,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            model.timeIn != "" || model.timeOut != ""
                ? Divider(
                    thickness: 1,
                  )
                : Container(),
            /* model.timeIn!="" || model.timeOut!=""? Text(
                "In-Time : "+getTime(model.timeIn) + " Out-Time : " + getTime(model.timeOut),
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),
              ):Container(),*/

            model.timeIn != "" || model.timeOut != ""
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: [
                          Text("In-Time : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10)),
                          Text(
                            getTime(model.timeIn),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: colorPrimary),
                          ),
                        ],
                      ),
                      model.timeOut != ""
                          ? Row(
                              children: [
                                Text("Out-Time : ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10)),
                                Text(
                                  getTime(model.timeOut),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: colorPrimary),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  )
                : Container(),
            SizedBox(
              height: 10,
            )
          ],
        ),

        /*Text(model.inquiryStatus, style: TextStyle(
            color: Color(0xFF504F4F),
            fontSize: _fontSize_Title,
          ),),
*/
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
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                //await _makePhoneCall(model.contactNo1);
                                await _makePhoneCall(model.contactNo1);
                              },
                              child: Container(
                                /* decoration: BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: colorPrimary,
                                                              borderRadius: BorderRadius.all(Radius.circular(30)),

                                                            ),*/
                                child: /*Icon(

                                                              Icons.call,
                                                              color: colorWhite,
                                                              size: 24,
                                                            )*/
                                    Image.asset(
                                  PHONE_CALL_IMAGE,
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                //await _makePhoneCall(model.contactNo1);
                                //await _makeSms(model.contactNo1);
                                showCommonDialogWithTwoOptions(
                                    context,
                                    "Do you have Two Accounts of WhatsApp ?" +
                                        "\n" +
                                        "Select one From below Option !",
                                    positiveButtonTitle: "WhatsApp",
                                    onTapOfPositiveButton: () {
                                      // _url = "https://api.whatsapp.com/send?phone=91";
                                      /* _url = "https://wa.me/";
                                                        _launchURL(model.contactNo1,_url);*/
                                      Navigator.pop(context);
                                      onButtonTap(
                                          Share.whatsapp_personal, model);
                                    },
                                    negativeButtonTitle: "Business",
                                    onTapOfNegativeButton: () {
                                      Navigator.pop(context);
                                      _launchWhatsAppBuz(model.contactNo1);
                                      //onButtonTap(Share.whatsapp_business,model);
                                      //share(model.contactNo1);
                                    });
                              },
                              child: Container(
                                /*decoration: BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: colorPrimary,
                                                              borderRadius: BorderRadius.all(Radius.circular(30)),

                                                            ),*/
                                child: /*Icon(

                                                              Icons.message_sharp,
                                                              color: colorWhite,
                                                              size: 20,
                                                            )*/
                                    Image.asset(
                                  WHATSAPP_IMAGE,
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                            ),
                            /*        model.inquiryNo==""?Container() :*/ SizedBox(
                              width: 15,
                            ),
                            Visibility(
                              visible: /*model.inquiryNo==""?false:*/ true,
                              child: GestureDetector(
                                onTap: () async {
                                  //await _makePhoneCall(model.contactNo1);
                                  //await _makeSms(model.contactNo1);
                                  //  _launchURL(model.contactNo1);
                                  MoveTofollowupHistoryPage(model.inquiryNo,
                                      model.customerID.toString());
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
                                      color: colorWhite,
                                      shape: BoxShape.circle),
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
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                model.meetingNotes = "";
                                model.pkID = 0;
                                model.followupDate = "";
                                model.nextFollowupDate = "";
                                model.preferredTime = "";

                                navigateTo(context,
                                        FollowUpAddEditScreen.routeName,
                                        arguments:
                                            AddUpdateFollowupScreenArguments(
                                                model))
                                    .then((value) {
                                  setState(() {
                                    followerEmployeeList();
                                  });
                                });

                                //await _makePhoneCall(model.contactNo1);
                                //await _makeSms(model.contactNo1);
                                //  _launchURL(model.contactNo1);
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
                                    color: colorPrimary,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  size: 24,
                                  color: colorWhite,
                                )),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Contact No1.",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Color(label_color),
                                      fontSize: _fontSize_Label,
                                      letterSpacing: .3)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  model.contactNo1 == ""
                                      ? "N/A"
                                      : model.contactNo1,
                                  style: TextStyle(
                                      color: Color(title_color),
                                      fontSize: _fontSize_Title,
                                      letterSpacing: .3))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Followup Date",
                                model.followupDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Next.Followup Date",
                                model.nextFollowupDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Followup Type", model.inquiryStatus ?? "-"),
                      ),
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Lead #",
                            model.inquiryNo == "" || model.inquiryNo == null
                                ? '-'
                                : model.inquiryNo),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Notes",
                        /*model.referenceName ?? "-" */
                        model.meetingNotes == "" || model.meetingNotes == null
                            ? '-'
                            : model.meetingNotes),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        //  child: _buildTitleWithValueView("No Followup", ""),
                        child: _buildTitleWithValueView(
                            "No Followup",
                            model.noFollowup.toString() == "0"
                                ? ''
                                : "No Followup"),
                      ),
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Closer Reason",
                            /*model.noFollClosureName ?? "-" */
                            model.noFollClosureName == "--Not Available--" ||
                                    model.noFollClosureName == null
                                ? '-'
                                : model.noFollClosureName),
                      ),
                    ]),
                    _buildTitleWithValueView(
                        "Created By",
                        /*model.referenceName ?? "-" */
                        model.employeeName == "" || model.employeeName == null
                            ? '-'
                            : model.employeeName),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    /*  SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                   
                    _buildTitleWithValueView("Created by", model.createdBy),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Created Date",
                        model.createdDate.getFormattedDate(
                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                            toFormat: "dd/MM/yyyy")),*/
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
              alignment: MainAxisAlignment.center,
              buttonHeight: 52.0,
              buttonMinWidth: 90.0,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {
                    navigateTo(context, FollowUpAddEditScreen.routeName,
                            arguments: AddUpdateFollowupScreenArguments(model))
                        .then((value) {
                      setState(() {
                        followerEmployeeList();
                      });
                    });
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
                isDeleteVisible == true
                    ? FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        onPressed: () {
                          //  cardA.currentState?.collapse();
                          //new ExpansionTileCardState().collapse();
                          _onTapOfDeleteCustomer(model.pkID);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ]),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Todays";
      } else if (i == 1) {
        all_name_id.Name = "Missed";
      } else if (i == 2) {
        all_name_id.Name = "Future";
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
        all_name_id.Name1 = state.details[i].userID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  void _onTapOfDeleteCustomer(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Followup?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _FollowupBloc.add(FollowupDeleteByNameCallEvent(
          id, FollowupDeleteRequest(CompanyId: CompanyID.toString())));
    });
  }

  void _onFollowupDeleteCallSucess(
      FollowupDeleteCallResponseState state, BuildContext buildContext123) {
    /* _FollowupListResponse.details
        .removeWhere((element) => element.pkID == state.id);*/
    print("CustomerDeleted" +
        state.followupDeleteResponse.details[0].toString() +
        "");
    // baseBloc.refreshScreen();
    navigateTo(buildContext123, FollowupListScreen.routeName,
        clearAllStack: true);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  void _launchURL(txt) async => await canLaunch(_url + txt)
      ? await launch(_url + txt)
      : throw 'Could not Launch $_url';

  Future<void> MoveTofollowupHistoryPage(String inquiryNo, String CustomerID) {
    navigateTo(context, FollowupHistoryScreen.routeName,
            arguments: FollowupHistoryScreenArguments(inquiryNo, CustomerID))
        .then((value) {});
  }

  Future<void> onButtonTap(Share share, FilterDetails customerDetails) async {
    String msg =
        "_"; //"Thank you for contacting us! We will be in touch shortly";
    //"Customer Name : "+customerDetails.customerName.toString()+"\n"+"Address : "+customerDetails.address+"\n"+"Mobile No. : " + customerDetails.contactNo1.toString();
    String url = 'https://pub.dev/packages/flutter_share_me';

    String response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;

      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp4Biz(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.whatsapp_personal:
        response = await flutterShareMe.shareWhatsAppPersonalMessage(
            message: msg, phoneNumber: '+91' + customerDetails.contactNo1);
        break;
      case Share.share_telegram:
        response = await flutterShareMe.shareToTelegram(msg: msg);
        break;
    }
    debugPrint(response);
  }

  void _launchWhatsAppBuz(String MobileNo) async {
    await launch("https://wa.me/${"+91" + MobileNo}?text=Hello");
  }

  Future<void> share(String contactNo1) async {
    String msg =
        "_"; //"Thank you for contacting us! We will be in touch shortly";

    /*await WhatsappShare.share(
        text: msg,
        //linkUrl: 'https://flutter.dev/',
        phone: "91"+contactNo1,
        package: Package.businessWhatsapp
    );*/
  }
}
