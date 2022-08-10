import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/missed_punch/missed_punch_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_list_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_search_by_id_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_list_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_search_by_name_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/missed_punch/missed_punch_list/missed_punch_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class MissedPunchListScreen extends BaseStatefulWidget {
  static const routeName = '/MissedPunchListScreen';

  @override
  _MissedPunchListScreenState createState() => _MissedPunchListScreenState();
}

class _MissedPunchListScreenState extends BaseState<MissedPunchListScreen>
    with BasicScreen, WidgetsBindingObserver {
  MissedPunchScreenBloc _SalesOrderBloc;
  int _pageNo = 0;
  MissedPunchListResponse _SalesOrderListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  MissedPunchSearchDetails _searchDetails;
  int CompanyID = 0;
  String LoginUserID = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _SalesOrderBloc = MissedPunchScreenBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _SalesOrderBloc
        ..add(MissedPunchListCallEvent(
            1,
            MissedPunchListRequest(
                CompanyID: CompanyID.toString(), LoginUserID: LoginUserID))),
      child: BlocConsumer<MissedPunchScreenBloc, MissedPunchScreenStates>(
        builder: (BuildContext context, MissedPunchScreenStates state) {
          if (state is MissedPunchListResponseState) {
            _onInquiryListCallSuccess(state);
          }
          if (state is MissedPunchSearchByIDResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is MissedPunchListResponseState ||
              currentState is MissedPunchSearchByIDResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, MissedPunchScreenStates state) {
          if (state is MissedPunchDeleteResponseState) {
            _OndeleteResponse(state);
          }
        },
        listenWhen: (oldState, currentState) {
          if (currentState is MissedPunchDeleteResponseState) {
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
          title: Text('Missed Punch List'),
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
                    _SalesOrderBloc.add(MissedPunchListCallEvent(
                        1,
                        MissedPunchListRequest(
                            CompanyID: CompanyID.toString(),
                            LoginUserID: LoginUserID)));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        _buildSearchView(),
                        Expanded(child: _buildInquiryList())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        /*     floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!

          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),*/
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: LoginUserID),
      ),
    );

    return Column(
      children: [
        getCommonAppBar(context, baseTheme, localizations.inquiry),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              top: 25,
            ),
            child: Column(
              children: [
                _buildSearchView(),
                Expanded(child: _buildInquiryList())
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search Employee",
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF000000),
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

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
                          ? _offlineLoggedInData.details[0].employeeName
                          : _searchDetails.label,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color:
                              _searchDetails == null ? colorBlack : colorBlack),
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
    if (_SalesOrderListResponse == null) {
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
        itemCount: _SalesOrderListResponse.details.length,
      ),
    );
  }

  ///builds row item view of inquiry list
  Widget _buildInquiryListItem(int index) {
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
  void _onInquiryListCallSuccess(MissedPunchListResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _searchDetails = null;
        _SalesOrderListResponse = state.loanListResponse;
      } else {
        _SalesOrderListResponse.details.addAll(state.loanListResponse.details);
      }
      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    if (_SalesOrderListResponse.details.length <
        _SalesOrderListResponse.totalCount) {
      _SalesOrderBloc
        ..add(MissedPunchListCallEvent(
            _pageNo + 1,
            MissedPunchListRequest(
                CompanyID: CompanyID.toString(), LoginUserID: LoginUserID)));
    }
  }

  ExpantionCustomer(BuildContext context, int index) {
    MissedPunchDetails model = _SalesOrderListResponse.details[index];

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
        /*  title: Row(
            children:<Widget>[
              Expanded(
                child: Text(model.customerName,style: TextStyle(
                    color: Colors.black
                ),),
              ),
              Expanded(child:  Text(model.orderNo,style: TextStyle(
                  color: Colors.black
              ),),)
            ]
        ),*/
        title: Text(
          model.employeeName,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          model.approvalStatus,
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
                              "Time IN",
                              model.timeIn.toString(),
                            ),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                              "Time OUT",
                              model.timeOut.toString(),
                            ),
                          )
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Notes", model.notes ?? "-"),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                          child: _buildTitleWithValueView(
                              "Missed Date",
                              model.presenceDate.getFormattedDate(
                                  fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                  toFormat: "dd/MM/yyyy"))),
                    ]),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Initiated By", model.createdBy ?? "-"),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Created Date",
                        model.createdDate.getFormattedDate(
                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                            toFormat: "dd/MM/yyyy")),
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
                /*  FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {


                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.edit,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Text('Edit',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),*/
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {
                    //  cardA.currentState?.collapse();
                    //new ExpansionTileCardState().collapse();
                    _onTaptoDelete(model.pkID);
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

  ///navigates to search list screen
  Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchMissedPunchScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        _SalesOrderBloc.add(MissedPunchSearchByIDCallEvent(
            _searchDetails.pkID,
            MissedPunchSearchByIDRequest(
                CompanyID: CompanyID.toString(), LoginUserID: LoginUserID)));
      }
    });
  }

  ///updates data of inquiry list
  void _onInquiryListByNumberCallSuccess(
      MissedPunchSearchByIDResponseState state) {
    _SalesOrderListResponse = state.missedPunchListResponse;
  }

  void _onTaptoDelete(int pkID) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Employee ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _SalesOrderBloc.add(MissedPunchDeleteCallEvent(
          pkID, BankVoucherDeleteRequest(CompanyID: CompanyID.toString())));
      // _CustomerBloc..add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: CompanyID,loginUserID: LoginUserID,CustomerID: "",ListMode: "L")));
    });
  }

  void _OndeleteResponse(MissedPunchDeleteResponseState state) {
    navigateTo(context, MissedPunchListScreen.routeName, clearAllStack: true);
    /* setState(() {
      _SalesOrderBloc.add(MissedPunchSearchByIDCallEvent(
          _searchDetails.pkID,
          MissedPunchSearchByIDRequest(
              CompanyID: CompanyID.toString(), LoginUserID: LoginUserID)));
    });*/
  }
}
