import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/InquiryShareModel.dart';
import 'package:soleoserp/models/api_requests/customer_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_followup_details_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_search_by_pk_id_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_share_emp_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_emp_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_history_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_share_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';

///import 'package:whatsapp_share/whatsapp_share.dart';ge:whatsapp_share/whatsapp_share.dart';
import '../../home_screen.dart';
import 'inquiry_fillter/inquiry_filter_screen.dart';

class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication);
}

class InquiryListScreen extends BaseStatefulWidget {
  static const routeName = '/inquiryListScreen';
  MessageArguments arguments;

  InquiryListScreen(this.arguments);

  @override
  _InquiryListScreenState createState() => _InquiryListScreenState();
}

class _InquiryListScreenState extends BaseState<InquiryListScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  int _pageNo = 0;
  InquiryListResponse _inquiryListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  SearchInquiryDetails _searchDetails;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  var _url = "https://api.whatsapp.com/send?phone=91";
  FilterDetails followupHistoryDetails;
  bool isDeleteVisible = true;
  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  List<InquiryShareModel> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;

  List<InquirySharedEmpDetails> arr_Inquiry_Share_Emp_List = [];

  String INQ = "";
  CustomerDetails customerDetails = CustomerDetails();
  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();

    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineFollowerEmployeeListData);

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
    isDeleteVisible = viewvisiblitiyAsperClient(
        SerailsKey: _offlineLoggedInData.details[0].serialKey,
        RoleCode: _offlineLoggedInData.details[0].roleCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc
        ..add(InquiryListCallEvent(
            1,
            InquiryListApiRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID.toString(),
                PkId: ""))),
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
          if (state is InquiryListCallResponseState) {
            _onInquiryListCallSuccess(state);
          }
          if (state is InquirySearchByPkIDResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is InquiryListCallResponseState ||
              currentState is InquirySearchByPkIDResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, InquiryStates state) {
          if (state is InquiryDeleteCallResponseState) {
            _onInquiryDeleteCallSucess(state, context);
          }
          if (state is FollowupHistoryListResponseState) {
            _OnInquiryNoToFollowupDetails(state, context);
          }
          if (state is InquiryShareResponseState) {
            _OnInquiryShareResponseSucess(state);
          }
          if (state is InquiryShareEmpListResponseState) {
            _OnInquiryShareEmpListResponse(state);
          }

          if (state is SearchCustomerListByNumberCallResponseState) {
            _ONOnlyCustomerDetails(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is InquiryDeleteCallResponseState ||
              currentState is FollowupHistoryListResponseState ||
              currentState is InquiryShareResponseState ||
              currentState is InquiryShareEmpListResponseState ||
              currentState is SearchCustomerListByNumberCallResponseState) {
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
      onWillPop: () {
        navigateTo(context, HomeScreen.routeName, clearAllStack: true);
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Inquiry List'),
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
                    _inquiryBloc.add(InquiryListCallEvent(
                        1,
                        InquiryListApiRequest(
                            CompanyId: CompanyID.toString(),
                            LoginUserID: LoginUserID.toString(),
                            PkId: "")));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        _offlineLoggedInData.details[0].serialKey
                                    .toString()
                                    .toLowerCase() ==
                                "dol2-6uh7-ph03-in5h"
                            ? Container()
                            : _buildSearchView(),
                        Expanded(child: _buildInquiryList())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _offlineLoggedInData.details[0].serialKey
                    .toString()
                    .toLowerCase() ==
                "dol2-6uh7-ph03-in5h"
            ? Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                  onPressed: () => {
                    _onTapOfSearchView(),
                  },
                  child: Icon(Icons.filter_alt_sharp),
                  heroTag: "fab1",
                  backgroundColor: colorPrimary,
                ),
                SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await _onTapOfDeleteALLProduct();

                    navigateTo(context, InquiryAddEditScreen.routeName);
                  },
                  child: Icon(Icons.add),
                  heroTag: "fab2",
                  backgroundColor: colorPrimary,
                ),
              ])
            : FloatingActionButton(
                onPressed: () async {
                  await _onTapOfDeleteALLProduct();

                  navigateTo(context, InquiryAddEditScreen.routeName);
                },
                child: Icon(Icons.add),
                heroTag: "fab2",
                backgroundColor: colorPrimary,
              ),

        /*FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            await _onTapOfDeleteALLProduct();

            navigateTo(context, InquiryAddEditScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),*/
        drawer: build_Drawer(
            context: context,
            UserName: "KISHAN",
            RolCode: LoginUserID.toString()),
      ),
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        //_onTapOfSearchView();

        _onTaptoSearchInquiryView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Search Inquiry",
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
                      _searchDetails == null
                          ? "Tap to search inquiry"
                          : _searchDetails.customerName,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _searchDetails == null
                              ? colorGrayDark
                              : colorBlack),
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

  ///builds inquiry list
  Widget _buildInquiryList() {
    if (_inquiryListResponse == null) {
      return Container();
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (shouldPaginate(
              scrollInfo,
            ) &&
            _searchDetails == null) {
          _onInquiryListPagination();
          return true;
        } else {
          return false;
        }
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);
        },
        shrinkWrap: true,
        itemCount: _inquiryListResponse.details.length,
      ),
    );
  }

  ///builds row item view of inquiry list
  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context, index);
  }

  ///builds inquiry row items title and value's common view
  Widget _buildTitleWithValueView(
      String title, String value, String InquirySource) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: _fontSize_Label,
                color: Color(label_color),
                fontStyle: FontStyle
                    .italic) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
        SizedBox(
          height: 3,
        ),
        ColorCombination(value, InquirySource),
        /*InquirySource == "Close - Success"
            ? Text(value,
                style: TextStyle(
                    fontSize: _fontSize_Title,
                    color:
                        colorGreen) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                )
            : Text(value,
                style:
                    TextStyle(fontSize: _fontSize_Title, color: colorGrayDark)),*/
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
  void _onInquiryListCallSuccess(InquiryListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _searchDetails = null;
        _inquiryListResponse = state.response;
      } else {
        _inquiryListResponse.details.addAll(state.response.details);
      }
      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    _inquiryBloc.add(InquiryListCallEvent(
        _pageNo + 1,
        InquiryListApiRequest(
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID.toString(),
            PkId: "")));

    /* if (_inquiryListResponse.details.length < _inquiryListResponse.totalCount) {
    }*/
  }

  ExpantionCustomer(BuildContext context, int index) {
    InquiryDetails model = _inquiryListResponse.details[index];

    return Container(
      padding: EdgeInsets.all(15),
      child: ExpansionTileCard(
        initialElevation: 5.0,
        elevation: 5.0,
        elevationCurve: Curves.easeInOut,
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

        title: Text(
          model.customerName,
          style: TextStyle(color: Color(0xFF8A2CE2)), //8A2CE2)),
        ),
        subtitle: Text(
          model.inquiryNo,
          style: TextStyle(
            color: Color(0xFF8A2CE2),
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
                    Container(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                //await _makePhoneCall(model.contactNo1);
                                await _makePhoneCall(model.ContactNo);
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
                                  width: 30,
                                  height: 30,
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

                                      _launchWhatsAppBuz(model.ContactNo);

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
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            /*  model.inquiryNo==""?Container() :*/ SizedBox(
                              width: 15,
                            ),
                            Visibility(
                              visible: /* model.inquiryNo==""?false:*/ true,
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
                                  width: 30,
                                  height: 30,
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
                                _inquiryBloc.add(
                                    InquiryShareEmpListRequestEvent(
                                        InquiryShareEmpListRequest(
                                            InquiryNo: model.inquiryNo,
                                            CompanyId: CompanyID.toString())));
                                // _inquiryBloc..add(InquiryNoToFollowupDetailsRequestCallEvent(model,InquiryNoToFollowupDetailsRequest(InquiryNo:model.inquiryNo,CompanyId: CompanyID.toString(),CustomerID: model.customerID.toString())));
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
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    color: colorPrimary,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Icon(
                                  Icons.share,
                                  size: 24,
                                  color: colorWhite,
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                _inquiryBloc
                                  ..add(
                                      InquiryNoToFollowupDetailsRequestCallEvent(
                                          model,
                                          InquiryNoToFollowupDetailsRequest(
                                              InquiryNo: model.inquiryNo,
                                              CompanyId: CompanyID.toString(),
                                              CustomerID: model.customerID
                                                  .toString())));
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
                                width: 30,
                                height: 30,
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
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                FetchCustomerDetails(model.customerID);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    color: colorPrimary,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Icon(
                                  Icons.account_box,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTitleWithValueView("Lead #",
                                model.inquiryNo ?? "-", model.inquiryStatus),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Lead Date",
                                model.inquiryDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-",
                                model.inquiryStatus),
                          ),
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Source",
                            model.InquirySourceName ?? "-",
                            model.inquiryStatus),
                      ),
                      Expanded(
                        child: _buildTitleWithValueView("Status",
                            model.inquiryStatus ?? "-", model.inquiryStatus),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Reference Name",
                        /*model.referenceName ?? "-" */
                        model.referenceName == "" || model.referenceName == null
                            ? '-'
                            : model.referenceName,
                        model.inquiryStatus),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      _inquiryListResponse.details[index].followupDate == ''
                          ? Expanded(
                              child: _buildTitleWithValueView(
                                  "Next Followup Date",
                                  model.followupDate.getFormattedDate(
                                          fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                          toFormat: "dd-MM-yyyy") ??
                                      "-",
                                  model.inquiryStatus))
                          : Container(),
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Created Date",
                            model.createdDate.getFormattedDate(
                                fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                toFormat: "dd-MM-yyyy"),
                            model.inquiryStatus),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Created by", model.createdBy, model.inquiryStatus),
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
                    _onTapOfEditInquiry(model);
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
                          _onTapOfDeleteInquiry(model.pkID);
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

  Future<bool> _onBackPressed(BuildContext context) {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen
  Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchInquiryScreenFilter.routeName).then((value) {
      if (value != null) {
        InquiryDetails model = value;

        /* _inquiryBloc.add(SearchInquiryListByNumberCallEvent(
            SearchInquiryListByNumberRequest(
                searchKey: _searchDetails.label,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));*/
        _inquiryBloc.add(InquirySearchByPkIDCallEvent(
            model.pkID.toString(),
            InquirySearchByPkIdRequest(
                CompanyId: CompanyID.toString(), LoginUserID: LoginUserID)));
      }
    });
  }

  ///updates data of inquiry list
  void _onInquiryListByNumberCallSuccess(
      InquirySearchByPkIDResponseState state) {
    _inquiryListResponse = state.response;
  }

  void _onTapOfEditInquiry(InquiryDetails model) {
    navigateTo(context, InquiryAddEditScreen.routeName,
            arguments: AddUpdateInquiryScreenArguments(model))
        .then((value) {
      _inquiryBloc
        ..add(InquiryListCallEvent(
            1,
            InquiryListApiRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID.toString(),
                PkId: "")));
    });
  }

  void _onTapOfSahreInquiry(
      List<InquirySharedEmpDetails> arr_inquiry_share_emp_list) {
    navigateTo(context, InquiryShareScreen.routeName,
            arguments:
                AddInquiryShareScreenArguments(arr_inquiry_share_emp_list))
        .then((value) {
      _inquiryBloc
        ..add(InquiryListCallEvent(
            1,
            InquiryListApiRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID.toString(),
                PkId: "")));
    });
  }

  void _onTapOfDeleteInquiry(int id) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Inquiry Request ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _inquiryBloc.add(InquiryDeleteByNameCallEvent(
          id, FollowupDeleteRequest(CompanyId: CompanyID.toString())));
    });
  }

  void _onInquiryDeleteCallSucess(
      InquiryDeleteCallResponseState state, BuildContext buildContext123) {
    /* _FollowupListResponse.details
        .removeWhere((element) => element.pkID == state.id);*/
    print("CustomerDeleted" +
        state.inquiryDeleteResponse.details[0].column1.toString() +
        "");
    // baseBloc.refreshScreen();
    navigateTo(buildContext123, InquiryListScreen.routeName,
        clearAllStack: true);
  }

  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLInquiryProduct();
  }

  Widget ColorCombination(String value, String inquirySource) {
    if (inquirySource == "Close - Success") {
      return Text(value,
          style: TextStyle(
              fontSize: _fontSize_Title,
              color:
                  colorGreen) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
          );
    } else if (inquirySource == "Work In Progress") {
      return Text(value,
          style:
              TextStyle(fontSize: _fontSize_Title, color: Color(0xFF0E0EFF)));
    } else {
      return Text(value,
          style: TextStyle(fontSize: _fontSize_Title, color: colorGrayDark));
    }
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

  void _OnInquiryNoToFollowupDetails(
      FollowupHistoryListResponseState state, BuildContext context) {
    followupHistoryDetails = FilterDetails();
    if (state.followupHistoryListResponse.details.length != 0) {
      for (var i = 0;
          i < state.followupHistoryListResponse.details.length;
          i++) {
        followupHistoryDetails.pkID = 0;
        followupHistoryDetails.inquiryNo =
            state.followupHistoryListResponse.details[0].inquiryNo;
        followupHistoryDetails.followupDate = "";
        followupHistoryDetails.nextFollowupDate = "";
        followupHistoryDetails.meetingNotes = "";
        followupHistoryDetails.contactNumber1 =
            state.followupHistoryListResponse.details[0].contactNumber1;
        followupHistoryDetails.customerName =
            state.followupHistoryListResponse.details[0].customerName;
        followupHistoryDetails.customerID =
            state.followupHistoryListResponse.details[0].customerID;
        followupHistoryDetails.followupStatus =
            state.followupHistoryListResponse.details[0].followupStatus;
        followupHistoryDetails.followupStatusID =
            state.followupHistoryListResponse.details[0].followupStatusID;
        followupHistoryDetails.followupPriority =
            state.followupHistoryListResponse.details[0].followupPriority;
        followupHistoryDetails.inquiryStatus =
            state.followupHistoryListResponse.details[0].inquiryStatus;
        followupHistoryDetails.inquiryStatusID =
            state.followupHistoryListResponse.details[0].inquiryStatusID;
        followupHistoryDetails.inquiryStatusDesc =
            state.followupHistoryListResponse.details[0].inquiryStatusDesc;
        followupHistoryDetails.noFollClosureName =
            state.followupHistoryListResponse.details[0].noFollClosureName;
        followupHistoryDetails.noFollClosureID =
            state.followupHistoryListResponse.details[0].noFollClosureID;
        followupHistoryDetails.rating =
            state.followupHistoryListResponse.details[0].rating;
        followupHistoryDetails.preferredTime = "";
        followupHistoryDetails.FollowUpImage = "";
      }

      navigateTo(context, FollowUpAddEditScreen.routeName,
              arguments:
                  AddUpdateFollowupScreenArguments(followupHistoryDetails))
          .then((value) {});
    } else {
      if (state.inquiryDetails != 0) {
        followupHistoryDetails = FilterDetails();
        followupHistoryDetails.customerName = state.inquiryDetails.customerName;
        followupHistoryDetails.customerID = state.inquiryDetails.customerID;
        followupHistoryDetails.inquiryNo = state.inquiryDetails.inquiryNo;
        followupHistoryDetails.pkID = 0;
        followupHistoryDetails.FollowUpImage = "";
        followupHistoryDetails.rating = 0;

        followupHistoryDetails.pkID = 0;
        followupHistoryDetails.followupDate = "";
        followupHistoryDetails.nextFollowupDate = "";
        followupHistoryDetails.meetingNotes = "";
        followupHistoryDetails.contactNumber1 = state.inquiryDetails.ContactNo;
        followupHistoryDetails.followupStatus = "";
        followupHistoryDetails.followupStatusID = 0;
        followupHistoryDetails.followupPriority = 0;
        followupHistoryDetails.inquiryStatus = "";
        followupHistoryDetails.inquiryStatusID = 0;
        followupHistoryDetails.inquiryStatusDesc = "";
        followupHistoryDetails.noFollClosureName = "";
        followupHistoryDetails.noFollClosureID = 0;
        followupHistoryDetails.preferredTime = "";
        followupHistoryDetails.FollowUpImage = "";

        navigateTo(context, FollowUpAddEditScreen.routeName,
                arguments:
                    AddUpdateFollowupScreenArguments(followupHistoryDetails))
            .then((value) {});
      }

      // navigateTo(context, FollowUpAddEditScreen.routeName,clearAllStack: true);

    }
  }

  Future<void> onButtonTap(Share share, InquiryDetails customerDetails) async {
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
            message: msg, phoneNumber: '+91' + customerDetails.ContactNo);
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

  Future<void> onButtonTapCustomer(
      Share share, CustomerDetails customerDetails) async {
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

  Future<void> share(String contactNo1) async {
    String msg =
        "_"; //"Thank you for contacting us! We will be in touch shortly";
    /* await WhatsappShare.share(
        text: msg,
       //linkUrl: 'https://flutter.dev/',
        phone: "91"+contactNo1,
        package: Package.businessWhatsapp
    );*/
  }

  void _OnInquiryShareResponseSucess(InquiryShareResponseState state) {
    for (var i = 0; i < state.inquiryShareResponse.details.length; i++) {
      print("ResponseMsgShare" +
          "Column1 : " +
          state.inquiryShareResponse.details[0].column1.toString() +
          "\n" +
          "Column2 : " +
          state.inquiryShareResponse.details[0].column2);
    }
  }

  void _onFollowerEmployeeListByStatusCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        InquiryShareModel all_name_id = InquiryShareModel(
            LoginUserID,
            state.details[i].pkID.toString(),
            CompanyID.toString(),
            "",
            false,
            state.details[i].employeeName);
        /* all_name_id.Name = state.details[i].employeeName;
        all_name_id.Name1 = state.details[i].userID;
        all_name_id.isChecked = false;*/
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  showcustomdialogWithCheckBox(
      {List<InquiryShareModel> values,
      BuildContext context1,
      /*TextEditingController controller,
      TextEditingController controllerID,
      TextEditingController controller2,*/
      List<ALL_Name_ID> all_name_id,
      String lable,
      bool isChecked12 = false}) async {
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
                    lable,
                    style: TextStyle(
                        color: colorPrimary, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          children: [
            SizedBox(
                width: MediaQuery.of(context123).size.width,
                child: Column(
                  children: [
                    SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(children: <Widget>[
                          new ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: values.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Card(
                                  child: new Container(
                                    padding: new EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        new CheckboxListTile(
                                            activeColor: Colors.pink[300],
                                            dense: true,
                                            //font change
                                            title: new Text(
                                              values[index].EmployeeName,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                            value: values[index].ISCHECKED,
                                            secondary: Container(
                                              height: 50,
                                              width: 50,
                                            ),
                                            onChanged: (bool val) {
                                              setState(() {
                                                itemChange(val, index, values);
                                              });
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }),

                          /*ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            children: values
                                .map(
                                  (InquiryShareModel item) => CheckboxListTile(
                                    title: Text(item.EmployeeName),
                                    value: item.ISCHECKED,
                                    onChanged: (bool val) async {
                                      print(val);
                                      item.ISCHECKED = await val;
                                      setState(() {

                                      });

                                    },
                                  ),
                                )
                                .toList(),
                          ),*/
                          /*  ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 25,
                                        top: 10,
                                        bottom: 10,
                                        right: 10),
                                    child: Row(
                                      children: [



                                      ],
                                    ),
                                  ),
                                );


                              },
                              itemCount: values.length,
                            ),*/
                          FlatButton(
                            child: Text("Share Inquiry"),
                            onPressed: () => {generateShare(values)},
                          ),
                        ])),
                  ],
                )),
            /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
          ],
        );
      },
    );
  }

  generateShare(List<InquiryShareModel> all_name_id) {
    for (var i = 0; i < all_name_id.length; i++) {
      print("MessageStorate" +
          "EMpName" +
          all_name_id[i].EmployeeName +
          "ISChecked" +
          all_name_id[i].ISCHECKED.toString());
    }
  }

  void itemChange(bool val, int index, List<InquiryShareModel> values) {
    setState(() {
      values[index].ISCHECKED = val;
    });
  }

  void _OnInquiryShareEmpListResponse(InquiryShareEmpListResponseState state) {
    arr_Inquiry_Share_Emp_List.clear();

    if (state.response.totalCount != 0) {
      for (var i = 0; i < state.response.details.length; i++) {
        InquirySharedEmpDetails inquirySharedEmpDetails =
            state.response.details[i];
        arr_Inquiry_Share_Emp_List.add(inquirySharedEmpDetails);
      }
    } else {
      InquirySharedEmpDetails inquirySharedEmpDetails =
          InquirySharedEmpDetails();
      inquirySharedEmpDetails.inquiryNo = state.InquiryNo;
      inquirySharedEmpDetails.employeeID =
          _offlineLoggedInData.details[0].employeeID;
      inquirySharedEmpDetails.createdBy =
          _offlineLoggedInData.details[0].userID;
      arr_Inquiry_Share_Emp_List.add(inquirySharedEmpDetails);
    }

    if (arr_Inquiry_Share_Emp_List.length != 0) {
      _onTapOfSahreInquiry(arr_Inquiry_Share_Emp_List);
    }
  }

  void _onTaptoSearchInquiryView() {
    navigateTo(context, SearchInquiryScreen.routeName).then((value) {
      if (value != null) {
        SearchInquiryDetails model = value;

        /* _inquiryBloc.add(SearchInquiryListByNumberCallEvent(
            SearchInquiryListByNumberRequest(
                searchKey: _searchDetails.label,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));*/
        _inquiryBloc.add(InquirySearchByPkIDCallEvent(
            model.pkID.toString(),
            InquirySearchByPkIdRequest(
                CompanyId: CompanyID.toString(), LoginUserID: LoginUserID)));
      }
    });
  }

  void FetchCustomerDetails(int customerID321) {
    _inquiryBloc.add(SearchCustomerListByNumberCallEvent(
        CustomerSearchByIdRequest(
            companyId: CompanyID,
            loginUserID: LoginUserID,
            CustomerID: customerID321.toString())));
  }

  void _ONOnlyCustomerDetails(
      SearchCustomerListByNumberCallResponseState state) {
    for (int i = 0; i < state.response.details.length; i++) {
      print("CustomerDetailsw" +
          "CustomerName : " +
          state.response.details[i].customerName +
          " Customer ID : " +
          state.response.details[i].customerID.toString());
    }

    customerDetails = CustomerDetails();
    customerDetails.customerName = state.response.details[0].customerName;
    customerDetails.customerType = state.response.details[0].customerType;
    customerDetails.customerSourceName =
        state.response.details[0].customerSourceName;
    customerDetails.contactNo1 = state.response.details[0].contactNo1;
    customerDetails.emailAddress = state.response.details[0].emailAddress;
    customerDetails.address = state.response.details[0].address;
    customerDetails.area = state.response.details[0].area;
    customerDetails.pinCode = state.response.details[0].pinCode;
    customerDetails.countryName = state.response.details[0].countryName;
    customerDetails.stateName = state.response.details[0].stateName;
    customerDetails.cityName = state.response.details[0].cityName;
    customerDetails.cityName = state.response.details[0].cityName;

    showcustomdialog(
      context1: context,
      customerDetails123: customerDetails,
    );
  }

  showcustomdialog({
    BuildContext context1,
    CustomerDetails customerDetails123,
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
                    "Customer Details",
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
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              customerDetails123.customerName,
                              style: TextStyle(color: colorBlack),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Container(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
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
                                                Text("Category  ",
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
                                                    customerDetails123
                                                        .customerType
                                                        .toString(),
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
                                                Text("Source",
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
                                                    customerDetails123
                                                                .customerSourceName ==
                                                            "--Not Available--"
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .customerSourceName,
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
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Contact No1.",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Color(
                                                              label_color),
                                                          fontSize:
                                                              _fontSize_Label,
                                                          letterSpacing: .3)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                      customerDetails123
                                                                  .contactNo1 ==
                                                              ""
                                                          ? "N/A"
                                                          : customerDetails123
                                                              .contactNo1,
                                                      style: TextStyle(
                                                          color: Color(
                                                              title_color),
                                                          fontSize:
                                                              _fontSize_Title,
                                                          letterSpacing: .3))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await _makePhoneCall(
                                                              customerDetails123
                                                                  .contactNo1);
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            PHONE_CALL_IMAGE,
                                                            width: 32,
                                                            height: 32,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          showCommonDialogWithTwoOptions(
                                                              context,
                                                              "Do you have Two Accounts of WhatsApp ?" +
                                                                  "\n" +
                                                                  "Select one From below Option !",
                                                              positiveButtonTitle:
                                                                  "WhatsApp",
                                                              onTapOfPositiveButton:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                onButtonTapCustomer(
                                                                    Share
                                                                        .whatsapp_personal,
                                                                    customerDetails123);
                                                              },
                                                              negativeButtonTitle:
                                                                  "Business",
                                                              onTapOfNegativeButton:
                                                                  () {
                                                                Navigator.pop(
                                                                    context);
                                                                share(customerDetails123
                                                                    .contactNo1);
                                                                //onButtonTap(Share.whatsapp_business,model);
                                                              });
                                                        },
                                                        child: Container(
                                                          child: Image.asset(
                                                            WHATSAPP_IMAGE,
                                                            width: 32,
                                                            height: 32,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: sizeboxsize,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("Email",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(label_color),
                                                    fontSize: _fontSize_Label,
                                                    letterSpacing: .3)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                customerDetails123
                                                            .emailAddress ==
                                                        ""
                                                    ? "N/A"
                                                    : customerDetails123
                                                        .emailAddress,
                                                style: TextStyle(
                                                    color: Color(title_color),
                                                    fontSize: _fontSize_Title,
                                                    letterSpacing: .3)),
                                          ],
                                        )
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
                                                Text("Address",
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
                                                    customerDetails123
                                                                .address ==
                                                            ""
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .address,
                                                    style:
                                                        TextStyle(
                                                            color: Color(
                                                                title_color),
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
                                                Text("Area",
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
                                                    customerDetails123.area ==
                                                            ""
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .area,
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
                                                Text("Pin-Code",
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
                                                    customerDetails123
                                                                .pinCode ==
                                                            ""
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .pinCode,
                                                    style:
                                                        TextStyle(
                                                            color: Color(
                                                                title_color),
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
                                                Text("Country",
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
                                                    customerDetails123
                                                                .countryName
                                                                .toString() ==
                                                            ""
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .countryName
                                                            .toString(),
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
                                                Text("State",
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
                                                    customerDetails123.stateName
                                                                .toString() ==
                                                            ""
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .stateName
                                                            .toString(),
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
                                                Text("City",
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
                                                    customerDetails123
                                                                .cityName ==
                                                            null
                                                        ? "N/A"
                                                        : customerDetails123
                                                            .cityName,
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
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context1);
                                      },
                                      child: Center(
                                          child: Text(
                                        "Close",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.bold),
                                      )))
                                ],
                              ),
                            ),
                          ],
                        ))),
                  ],
                )),
          ],
        );
      },
    );
  }
}
