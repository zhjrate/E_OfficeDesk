// ignore_for_file: non_constant_identifier_names

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/followup/followup_bloc.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/followup_filter_list_request.dart';
import 'package:soleoserp/models/api_requests/quick_followup_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/quick_followup_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_history_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_followup/quick_followup_add_edit/quick_followup_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:whatsapp_share/whatsapp_share.dart';

class QuickFollowupListScreen extends BaseStatefulWidget {
  static const routeName = '/QuickFollowupListScreen';

  @override
  _QuickFollowupListScreenState createState() =>
      _QuickFollowupListScreenState();
}

class _QuickFollowupListScreenState extends BaseState<QuickFollowupListScreen>
    with BasicScreen, WidgetsBindingObserver {
  FollowupBloc _FollowupBloc;
  int _pageNo = 0;
  QuickFollowupListResponse _FollowupListResponse;

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
  final TextEditingController PuchInTime = TextEditingController();
  final TextEditingController PuchOutTime = TextEditingController();
  double CardViewHeight = 45.00;
  final TextEditingController edt_Application = TextEditingController();
  final TextEditingController edt_SerialNo = TextEditingController();
  final TextEditingController edt_FollowUpDate = TextEditingController();
  final TextEditingController edt_ReverseFollowUpDate = TextEditingController();
  final TextEditingController edt_Status = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];

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
    FetchFollowupPriorityDetails();

    _FollowupBloc = FollowupBloc(baseBloc);

    edt_Status.text = "active";

    FetchFollowupStatusDetails();
    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);
    edt_FollowupEmployeeList.text =
        _offlineLoggedInData.details[0].employeeName;
    edt_FollowupEmployeeUserID.text = _offlineLoggedInData.details[0].userID;

    isExpand = false;

    isDeleteVisible = viewvisiblitiyAsperClient(
        SerailsKey: _offlineLoggedInData.details[0].serialKey,
        RoleCode: _offlineLoggedInData.details[0].roleCode);

    edt_FollowUpDate.text = selectedDate.day.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.year.toString();
    edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.day.toString();

    edt_Status.addListener(() {
      _FollowupBloc.add(QuickFollowupListRequestEvent(QuickFollowupListRequest(
          FollowupStatus: edt_Status.text,
          /*FollowupDate:edt_ReverseFollowUpDate.text*/ CompanyId:
              CompanyID.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc
        ..add(QuickFollowupListRequestEvent(QuickFollowupListRequest(
            FollowupStatus: edt_Status.text,
            /*FollowupDate:edt_ReverseFollowUpDate.text*/ CompanyId:
                CompanyID.toString()))),

      // _FollowupBloc..add(FollowupFilterListCallEvent("todays",FollowupFilterListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID,PageNo: 1,PageSize: 10))),
      child: BlocConsumer<FollowupBloc, FollowupStates>(
        builder: (BuildContext context, FollowupStates state) {
          if (state is QuickFollowupListResponseState) {
            _onFollowupListCallSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is QuickFollowupListResponseState) {
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
          title: Text('QuickFollowup List'),
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
                    _FollowupBloc.add(QuickFollowupListRequestEvent(
                        QuickFollowupListRequest(
                            FollowupStatus: edt_Status.text,
                            /*FollowupDate:edt_ReverseFollowUpDate.text*/ CompanyId:
                                CompanyID.toString())));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        CustomDropDown1("Status",
                            enable1: false,
                            title: "Status",
                            hintTextvalue: "Tap to Select Status",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Status,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Folowup_Priority),
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
            navigateTo(context, QuickFollowUpAddEditScreen.routeName);
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
    if (isListExist) {
      return ListView.builder(
        key: Key('selected $selected'),
        itemBuilder: (context, index) {
          return _buildFollowupListItem(index);
        },
        shrinkWrap: true,
        itemCount: _FollowupListResponse.details.length,
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
                /*fontWeight: FontWeight.bold,*/
                fontStyle: FontStyle
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
  void _onFollowupListCallSuccess(QuickFollowupListResponseState state) {
    //print("Response326584"+state.quickFollowupListResponse.details[0].customerName.toString());

    if (state.quickFollowupListResponse.details.length != 0) {
      //_FollowupListResponse = state.quickFollowupListResponse;

      for (int i = 0; i < state.quickFollowupListResponse.details.length; i++) {
        /* QuickFollowupListResponseDetails quickFollowupListResponseDetails = QuickFollowupListResponseDetails();
            quickFollowupListResponseDetails.customerName*/

        _FollowupListResponse = state.quickFollowupListResponse;
      }

      if (_FollowupListResponse != null) {
        isListExist = true;
        TotalCount = state.quickFollowupListResponse.totalCount;
      } else {
        isListExist = false;
        TotalCount = 0;
      }
    } else {
      isListExist = false;
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
    QuickFollowupListResponseDetails model =
        _FollowupListResponse.details[index];

    //Totcount= _FollowupListResponse.totalCount;
    //  if(_FollowupListResponse.details[index].employeeName == edt_FollowupEmployeeList.text) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ExpansionTileCard(
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
            child: Image.network(
              "http://demo.sharvayainfotech.in/images/profile.png",
              height: 35,
              fit: BoxFit.fill,
              width: 35,
            )),

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
                      children: [
                        Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    await _makePhoneCall(model.contactNo1);
                                  },
                                  child: Container(
                                      child: Column(
                                    children: [
                                      Text(
                                        "Call",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        PHONE_CALL_IMAGE,
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
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
                                          Navigator.pop(context);
                                          onButtonTap(
                                              Share.whatsapp_personal, model);
                                        },
                                        negativeButtonTitle: "Business",
                                        onTapOfNegativeButton: () {
                                          Navigator.pop(context);

                                          _launchWhatsAppBuz(model.contactNo1);
                                        });
                                  },
                                  child: Container(
                                    child: /*Image.asset(
                                                    WHATSAPP_IMAGE,
                                                    width: 30,
                                                    height: 30,
                                                  ),*/
                                        Column(
                                      children: [
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Image.asset(
                                          WHATSAPP_IMAGE,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                model.latitudeIN != "" ||
                                        model.longitude_IN != ""
                                    ? GestureDetector(
                                        onTap: () async {
                                          if (model.latitudeIN != "" ||
                                              model.longitude_IN != "") {
                                            print("jdjfds45" +
                                                double.parse(model.latitudeIN)
                                                    .toString() +
                                                " Longitude : " +
                                                double.parse(model.longitude_IN)
                                                    .toString());
                                            MapsLauncher.launchCoordinates(
                                                double.parse(model.latitudeIN),
                                                double.parse(
                                                    model.longitude_IN),
                                                'Location In');
                                          } else {
                                            showCommonDialogWithSingleOption(
                                                context,
                                                "Location In Not Valid !",
                                                positiveButtonTitle: "OK",
                                                onTapOfPositiveButton: () {
                                              Navigator.of(context).pop();
                                            });
                                          }
                                        },
                                        child: Container(
                                            child: Column(
                                          children: [
                                            Text(
                                              "In",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.deepOrange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                              LOCATION_ICON,
                                              width: 30,
                                              height: 30,
                                            ),
                                          ],
                                        )),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 20,
                                ),
                                model.latitudeOUT != "" ||
                                        model.longitude_OUT != ""
                                    ? GestureDetector(
                                        onTap: () async {
                                          if (model.timeOut != "" &&
                                              model.timeOut != "00:00:00") {
                                            if (model.latitudeOUT != "" ||
                                                model.longitude_OUT != "") {
                                              MapsLauncher.launchCoordinates(
                                                  double.parse(
                                                      model.latitudeOUT),
                                                  double.parse(
                                                      model.longitude_OUT),
                                                  'Location Out');
                                            } else {
                                              showCommonDialogWithSingleOption(
                                                  context,
                                                  "Location Out Not Valid !",
                                                  positiveButtonTitle: "OK",
                                                  onTapOfPositiveButton: () {
                                                Navigator.of(context).pop();
                                              });
                                            }
                                          }
                                        },
                                        child: model.timeOut != "" &&
                                                model.timeOut != "00:00:00"
                                            ? Container(
                                                child: Column(
                                                children: [
                                                  Text(
                                                    "Out",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.deepOrange,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Image.asset(
                                                    LOCATION_ICON,
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ],
                                              ))
                                            : Container(),
                                      )
                                    : Container(),
                              ]),
                        ),
                        SizedBox(
                          height: sizeboxsize,
                        ),
                      ],
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
                                "Followup Type", model.inquiryStatus ?? "-"),
                          ),
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Next Followup Date",
                                model.nextFollowupDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                              "CreatedBy : ",
                              model.createdBy,
                            ),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
          edt_Status.text == "completestatus" || edt_Status.text == "future"
              ? Container()
              : ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                      model.timeIn.toString() == ""
                          ? FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              onPressed: () {
                                navigateTo(context,
                                        QuickFollowUpAddEditScreen.routeName,
                                        arguments:
                                            QuickAddUpdateFollowupScreenArguments(
                                                _FollowupListResponse
                                                    .details[index],
                                                false,
                                                "PunchIn"))
                                    .then((value) {
                                  _FollowupBloc.add(QuickFollowupListRequestEvent(
                                      QuickFollowupListRequest(
                                          /*FollowupDate:edt_ReverseFollowUpDate.text,*/ CompanyId:
                                              CompanyID.toString())));
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.login,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text(
                                    'PunchIn',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      model.timeIn.toString() != ""
                          ? FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              onPressed: () {
                                navigateTo(context,
                                        QuickFollowUpAddEditScreen.routeName,
                                        arguments:
                                            QuickAddUpdateFollowupScreenArguments(
                                                _FollowupListResponse
                                                    .details[index],
                                                false,
                                                "PunchOut"))
                                    .then((value) {
                                  _FollowupBloc.add(QuickFollowupListRequestEvent(
                                      QuickFollowupListRequest(
                                          /*FollowupDate:edt_ReverseFollowUpDate.text,*/ CompanyId:
                                              CompanyID.toString(),
                                          FollowupStatus: edt_Status.text)));
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                  ),
                                  Text(
                                    'PunchOut',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ]),
          edt_Status.text == "future"
              ? ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        onPressed: () {
                          navigateTo(
                                  context, QuickFollowUpAddEditScreen.routeName,
                                  arguments:
                                      QuickAddUpdateFollowupScreenArguments(
                                          _FollowupListResponse.details[index],
                                          true,
                                          "PunchIn"))
                              .then((value) {
                            _FollowupBloc.add(QuickFollowupListRequestEvent(
                                QuickFollowupListRequest(
                                    /*FollowupDate:edt_ReverseFollowUpDate.text,*/ CompanyId:
                                        CompanyID.toString())));
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.login,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text(
                              'PunchIn',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ])
              : Container(),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 4; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Todays";
      } else if (i == 1) {
        all_name_id.Name = "Missed";
      } else if (i == 2) {
        all_name_id.Name = "Future";
      } else if (i == 3) {
        all_name_id.Name = "completestatus";
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
        context, "Are you sure you want to delete this Visit ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _FollowupBloc.add(QuickFollowupDeleteByNameCallEvent(
          id, FollowupDeleteRequest(CompanyId: CompanyID.toString())));
    });
  }

  void _onFollowupDeleteCallSucess(FollowupDeleteCallResponseState state,
      BuildContext buildContext123) async {
    /* _FollowupListResponse.details
        .removeWhere((element) => element.pkID == state.id);*/
    print("CustomerDeleted" +
        state.followupDeleteResponse.details[0].column1.toString() +
        "");
    // baseBloc.refreshScreen();
    String Msg = "Visit Delete SucessFully";
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
      //navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
      navigateTo(context, QuickFollowupListScreen.routeName,
          clearAllStack: true);
    });

    /* navigateTo(buildContext123, QuickFollowupListScreen.routeName,
        clearAllStack: true);*/
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

  Future<void> onButtonTap(
      Share share, QuickFollowupListResponseDetails customerDetails) async {
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
        phone: "91" + contactNo1,
        package: Package.businessWhatsapp);*/
  }

  showcustomdialogPunchIn({
    BuildContext context1,
    TextEditingController followupDate,
    TextEditingController reversefollowupDate,
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
                    "Add Details",
                    style: TextStyle(
                        color: colorPrimary, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          children: [
            SizedBox(
                width: MediaQuery.of(context123).size.width,
                child: Column(
                  children: [
                    /* TextField(
                        controller: edt_Application,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Tap to enter Application",
                          labelStyle: TextStyle(
                            color: Color(0xFF000000),
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                    ),*/
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              // _selectDate(context1, followupDate);

                              DateTime selectedDate = DateTime.now();

                              final DateTime picked = await showDatePicker(
                                  context: context1,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != selectedDate)
                                setState(() {
                                  selectedDate = picked;
                                  edt_FollowUpDate.text =
                                      selectedDate.day.toString() +
                                          "-" +
                                          selectedDate.month.toString() +
                                          "-" +
                                          selectedDate.year.toString();

                                  print("Dateee" + edt_FollowUpDate.text);
                                  /* edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();*/
                                });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("FollowUp Date *",
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
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            edt_FollowUpDate.text == null ||
                                                    edt_FollowUpDate.text == ""
                                                ? "DD-MM-YYYY"
                                                : edt_FollowUpDate.text,
                                            style: baseTheme.textTheme.headline3
                                                .copyWith(
                                                    color:
                                                        edt_FollowUpDate.text ==
                                                                    null ||
                                                                edt_FollowUpDate
                                                                        .text ==
                                                                    ""
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
                              height: CardViewHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        enabled: true,
                                        controller: edt_Application,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: "Tap to enter Application",
                                          labelStyle: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF000000),
                                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text("Serial No",
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
                              height: CardViewHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        enabled: true,
                                        controller: edt_SerialNo,
                                        decoration: InputDecoration(
                                          hintText: "Tap to enter SerialNo",
                                          labelStyle: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF000000),
                                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                        color: colorPrimary,
                        onPressed: () {
                          setState(() {});
                          // _productList[index1].SerialNo = edt_Application.text;
                          Navigator.pop(context123);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(color: colorWhite),
                        ))
                  ],
                )),
          ],
        );
      },
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
        F_datecontroller.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        /* edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();*/
      });
  }

  FetchFollowupPriorityDetails() {
    arr_ALL_Name_ID_For_Folowup_Priority.clear();
    for (var i = 0; i <= 4; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "active";
      } else if (i == 1) {
        all_name_id.Name = "todays";
      } else if (i == 2) {
        all_name_id.Name = "missed";
      } else if (i == 3) {
        all_name_id.Name = "future";
      } else if (i == 4) {
        all_name_id.Name = "completestatus";
      }
      arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
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
}
