import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/quotation/quotation_bloc.dart';
import 'package:soleoserp/models/api_requests/customer_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/quotation_delete_request.dart';
import 'package:soleoserp/models/api_requests/quotation_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_pdf_generate_request.dart';
import 'package:soleoserp/models/api_requests/search_quotation_list_by_number_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/quotation_list_response.dart';
import 'package:soleoserp/models/api_responses/search_quotation_list_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotation_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/search_quotation_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home_screen.dart';

class QuotationListScreen extends BaseStatefulWidget {
  static const routeName = '/QuotationListScreen';

  @override
  _QuotationListScreenState createState() => _QuotationListScreenState();
}

enum Share {
  facebook,
  twitter,
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}

class _QuotationListScreenState extends BaseState<QuotationListScreen>
    with BasicScreen, WidgetsBindingObserver {
  QuotationBloc _QuotationBloc;
  int _pageNo = 0;
  QuotationListResponse _quotationListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  SearchDetails _searchDetails;
  int CompanyID = 0;
  String LoginUserID = "";
  String Password = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  int prgresss = 0;
  final urlController = TextEditingController();

  String SiteURL = "";
  String QTGEN = "";
  bool isLoading = true;

  URLRequest urlRequest;
  CustomerDetails customerDetails = CustomerDetails();
  //EmailTO

  TextEditingController EmailTO = TextEditingController();

  TextEditingController EmailBCC = TextEditingController();

  @override
  void initState() {
    super.initState();
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    screenStatusBarColor = colorPrimary;
    _QuotationBloc = QuotationBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    SiteURL = _offlineCompanyData.details[0].siteURL;
    Password = _offlineLoggedInData.details[0].userPassword;
    baseBloc.emit(ShowProgressIndicatorState(true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _QuotationBloc
        ..add(QuotationListCallEvent(
            _pageNo + 1,
            QuotationListApiRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID,
                pkId: ""))),
      child: BlocConsumer<QuotationBloc, QuotationStates>(
        builder: (BuildContext context, QuotationStates state) {
          if (state is QuotationListCallResponseState) {
            _onInquiryListCallSuccess(state);
          }
          if (state is SearchQuotationListByNumberCallResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is QuotationListCallResponseState ||
              currentState is SearchQuotationListByNumberCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, QuotationStates state) {
          if (state is QuotationPDFGenerateResponseState) {
            _onGenerateQuotationPDFCallSuccess(state);
          }

          if (state is QuotationDeleteCallResponseState) {
            _OnDeleteQuotationSucessResponse(state);
          }

          if (state is SearchCustomerListByNumberCallResponseState) {
            _ONOnlyCustomerDetails(state);
          }
        },
        listenWhen: (oldState, currentState) {
          if (currentState is QuotationPDFGenerateResponseState ||
              currentState is QuotationDeleteCallResponseState ||
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
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Quotation List'),
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
                    _QuotationBloc.add(QuotationListCallEvent(
                        1,
                        QuotationListApiRequest(
                            CompanyId: CompanyID.toString(),
                            LoginUserID: LoginUserID,
                            pkId: "")));
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            await _onTapOfDeleteALLProduct();

            navigateTo(context, QuotationAddEditScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
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
          Text("Search Quotation",
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
                          ? "Tap to search quotation"
                          : _searchDetails.custoemerName,
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
    if (_quotationListResponse == null) {
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
        itemCount: _quotationListResponse.details.length,
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
  void _onInquiryListCallSuccess(QuotationListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _searchDetails = null;
        _quotationListResponse = state.response;
      } else {
        _quotationListResponse.details.addAll(state.response.details);
      }
      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    if (_quotationListResponse.details.length <
        _quotationListResponse.totalCount) {
      _QuotationBloc.add(QuotationListCallEvent(
          _pageNo + 1,
          QuotationListApiRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: LoginUserID,
              pkId: "")));
    }
  }

  ExpantionCustomer(BuildContext context, int index) {
    QuotationDetails model = _quotationListResponse.details[index];

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
        /* title:  Row(
            children:<Widget>[
              Expanded(
                child: Text(model.customerName,style: TextStyle(
                    color: Colors.black
                ),),
              ),
              Expanded(child:  Text(model.quotationNo,style: TextStyle(
                  color: Colors.black
              ),),)
            ]
        ),*/
        title: Text(
          model.customerName,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          model.quotationNo,
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
                                child: Image.asset(
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
                                      onButtonTap(Share.whatsapp_personal,
                                          model.contactNo1);
                                    },
                                    negativeButtonTitle: "Business",
                                    onTapOfNegativeButton: () {
                                      Navigator.pop(context);
                                      _launchWhatsAppBuz(model.contactNo1);
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
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () async {
                                print("jdlfdjf" +
                                    SiteURL +
                                    "/Quotation.aspx?MobilePdf=yes&userid=" +
                                    LoginUserID +
                                    "&password=" +
                                    Password +
                                    "&pQuotID=" +
                                    model.pkID.toString());

                                String URLPDFF = SiteURL +
                                    "/Quotation.aspx?MobilePdf=yes&userid=" +
                                    LoginUserID +
                                    "&password=" +
                                    Password +
                                    "&pQuotID=" +
                                    model.pkID.toString();

                                /*  http.Response response =
                                    await http.get(Uri.parse(URLPDFF));

                                if (response.statusCode == 200) {
                                  // await _showMyDialog(model);

                                  showCommonDialogWithSingleOption(
                                      context, "PDF RUN Sucess !",
                                      positiveButtonTitle: "OK");
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Something Went Wrong !",
                                      positiveButtonTitle: "OK");
                                }*/
                                await _showMyDialog(model);

                                /* var progesCount23;
                               webViewController.getProgress().whenComplete(() async =>  {
                                 progesCount23 = await webViewController.getProgress(),
                                 print("PAgeLoaded" + progesCount23.toString())
                               });*/

                                /*  await _makePhoneCall(
                                        model.contactNo1);*/

                                // baseBloc.emit(ShowProgressIndicatorState(true));
                                /* setState(() {
                                  urlRequest = URLRequest(url: Uri.parse(SiteURL+"/Quotation.aspx?MobilePdf=yes&userid="+LoginUserID+"&password="+Password+"&pQuotID="+model.pkID.toString()));


                                });*/

                                // await Future.delayed(const Duration(milliseconds: 500), (){});
                                // baseBloc.emit(ShowProgressIndicatorState(false));
                                //_QuotationBloc.add(QuotationPDFGenerateCallEvent(QuotationPDFGenerateRequest(CompanyId: CompanyID.toString(),QuotationNo: model.quotationNo)));
                              },
                              child: Container(
                                child: Image.asset(
                                  PDF_ICON,
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
                                //FetchCustomerDetails(model.customerID);
                                /*
                                sddsfdj ds;jdsfdsj sdljdsj
                                */

                                EmailTO.text = model.emailAddress;
                                showcustomdialogSendEmail(
                                    context1: context,
                                    Email: model.emailAddress);
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    color: colorPrimary,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Icon(
                                  Icons.email,
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
                            child: _buildTitleWithValueView(
                                "QT.Date",
                                model.quotationDate.getFormattedDate(
                                        fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                        toFormat: "dd-MM-yyyy") ??
                                    "-"),
                          ),
                          Expanded(
                            child: _buildTitleWithValueView(
                                "Quotation #", model.quotationNo ?? "-"),
                          ),
                          /*Expanded(
                        child: Container(
                          child: ,
                        ),
                      ),*/
                          /* Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    await _showMyDialog(model);

                                    */ /* var progesCount23;
                               webViewController.getProgress().whenComplete(() async =>  {
                                 progesCount23 = await webViewController.getProgress(),
                                 print("PAgeLoaded" + progesCount23.toString())
                               });*/ /*

                                    */ /*  await _makePhoneCall(
                                        model.contactNo1);*/ /*

                                    // baseBloc.emit(ShowProgressIndicatorState(true));
                                    */ /* setState(() {
                                  urlRequest = URLRequest(url: Uri.parse(SiteURL+"/Quotation.aspx?MobilePdf=yes&userid="+LoginUserID+"&password="+Password+"&pQuotID="+model.pkID.toString()));


                                });*/ /*

                                    // await Future.delayed(const Duration(milliseconds: 500), (){});
                                    // baseBloc.emit(ShowProgressIndicatorState(false));
                                    //_QuotationBloc.add(QuotationPDFGenerateCallEvent(QuotationPDFGenerateRequest(CompanyId: CompanyID.toString(),QuotationNo: model.quotationNo)));
                                  },
                                  child: Container(
                                    child: Image.asset(
                                      PDF_ICON,
                                      width: 48,
                                      height: 48,
                                    ),
                                  ),
                                ),
                              ])*/
                        ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Lead #", model.inquiryNo ?? "-"),
                      ),
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Status", model.inquiryStatus ?? "-"),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Project Name",
                        /*model.referenceName ?? "-" */ model.projectName ==
                                    "" ||
                                model.projectName == null
                            ? '-'
                            : model.projectName),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "BasicAmt.", model.basicAmt.toString() ?? "-"),
                      ),
                      Expanded(
                        child: _buildTitleWithValueView(
                            "NetAmt.", model.netAmt.toString() ?? "-"),
                      ),
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Sales Executive", model.createdBy),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    _buildTitleWithValueView(
                        "Created Date",
                        model.createdDate.getFormattedDate(
                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                            toFormat: "dd-MM-yyyy")),
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
                    _onTaptoEditQuotation(model);
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

                    _OnDeleteQuotationRequest(model);
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

  Future<void> onButtonTap(Share share, String customerDetails) async {
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
            message: msg, phoneNumber: '+91' + customerDetails);
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

  void FetchCustomerDetails(int customerID321) {
    _QuotationBloc.add(SearchCustomerListByNumberCallEvent(
        CustomerSearchByIdRequest(
            companyId: CompanyID,
            loginUserID: LoginUserID,
            CustomerID: customerID321.toString())));
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen
  Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchQuotationScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        _QuotationBloc.add(SearchQuotationListByNumberCallEvent(
            _searchDetails.value,
            SearchQuotationListByNumberRequest(
                CompanyId: CompanyID.toString(),
                QuotationNo: _searchDetails.quotationNo)));
      }
    });
  }

  ///updates data of inquiry list
  void _onInquiryListByNumberCallSuccess(
      SearchQuotationListByNumberCallResponseState state) {
    _quotationListResponse = state.response;
  }

  _launchURL(String pdfURL) async {
    var url123 = pdfURL;
    if (await canLaunch(url123)) {
      await launch(url123);
    } else {
      throw 'Could not launch $url123';
    }
  }

  void _onGenerateQuotationPDFCallSuccess(
      QuotationPDFGenerateResponseState state) {
    _launchURL(state.response.details[0].column1.toString());
  }

  Future<void> _showMyDialog(QuotationDetails model) async {
    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context123) {
        return AlertDialog(
          title: Text('Do You want to Generate Quotation ? '),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: false,
                  child: GenerateQT(model, context123),
                )
                //GetCircular123(),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context)
                    .pop(), //  We can return any object from here
                child: Text('NO')),
            /* prgresss!=100 ? CircularProgressIndicator() :*/ FlatButton(
                onPressed: () => {
                      Navigator.of(context).pop(),
                      _QuotationBloc.add(QuotationPDFGenerateCallEvent(
                          QuotationPDFGenerateRequest(
                              CompanyId: CompanyID.toString(),
                              QuotationNo: model.quotationNo)))
                    }, //  We can return any object from here
                child: Text('YES'))
          ],
        );
      },
    );
  }

  GenerateQT(QuotationDetails model, BuildContext context123) {
    return Container(
      height: 200,
      child: Visibility(
        visible: true,
        child: InAppWebView(
          //                        webView.loadUrl(SiteURL+"/Quotation.aspx?MobilePdf=yes&userid="+userName123+"&password="+UserPassword+"&pQuotID="+contactListFiltered.get(position).getPkID() + "");
          // initialUrlRequest:urlRequest == null ? URLRequest(url: Uri.parse("http://122.169.111.101:3346/Default.aspx")) :urlRequest ,
          initialUrlRequest: URLRequest(
              url: Uri.parse(SiteURL +
                  "/Quotation.aspx?MobilePdf=yes&userid=" +
                  LoginUserID +
                  "&password=" +
                  Password +
                  "&pQuotID=" +
                  model.pkID.toString())),
          // initialFile: "assets/index.html",
          initialUserScripts: UnmodifiableListView<UserScript>([]),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,

          onWebViewCreated: (controller) {
            webViewController = controller;
          },

          onLoadStart: (controller, url) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
          shouldOverrideUrlLoading: (controller, navigationAction) async {
            var uri = navigationAction.request.url;

            if (![
              "http",
              "https",
              "file",
              "chrome",
              "data",
              "javascript",
              "about"
            ].contains(uri.scheme)) {
              if (await canLaunch(url)) {
                // Launch the App
                await launch(
                  url,
                );

                // and cancel the request
                return NavigationActionPolicy.CANCEL;
              }
            }

            return NavigationActionPolicy.ALLOW;
          },
          onLoadStop: (controller, url) async {
            pullToRefreshController.endRefreshing();

            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onLoadError: (controller, url, code, message) {
            pullToRefreshController.endRefreshing();
            isLoading = false;
          },
          onProgressChanged: (controller, progress) {
            if (progress == 100) {
              pullToRefreshController.endRefreshing();
              this.prgresss = progress;
              // _QuotationBloc.add(QuotationPDFGenerateCallEvent(QuotationPDFGenerateRequest(CompanyId: CompanyID.toString(),QuotationNo: model.quotationNo)));

            }

            //  EasyLoading.showProgress(progress / 100, status: 'Loading...');

            setState(() {
              this.progress = progress / 100;
              this.prgresss = progress;

              urlController.text = this.url;
            });
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            setState(() {
              this.url = url.toString();
              urlController.text = this.url;
            });
          },
          onConsoleMessage: (controller, consoleMessage) {
            print("LoadWeb" + consoleMessage.message.toString());
          },
        ),
      ),
    );
  }

  GetCircular123() {
    /*  if(webViewController!=null)
      {
        webViewController.getProgress().whenComplete(() async =>  {
          valuee1 = await webViewController.getProgress(),
          print("PAgeLoaded" + valuee1.toString())
        });
      }*/

    print("DFDFDF" + "sdfsdssdsffs");
  }

  void _onTaptoEditQuotation(QuotationDetails model) {
    navigateTo(context, QuotationAddEditScreen.routeName,
            arguments: AddUpdateQuotationScreenArguments(model))
        .then((value) {
      _QuotationBloc.add(QuotationListCallEvent(
          1,
          QuotationListApiRequest(
              CompanyId: CompanyID.toString(),
              LoginUserID: LoginUserID,
              pkId: "")));
    });
  }

  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLQuotationProduct();
  }

  void _OnDeleteQuotationRequest(QuotationDetails model) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Quotation ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _QuotationBloc.add(QuotationDeleteRequestCallEvent(context, model.pkID,
          QuotationDeleteRequest(CompanyID: CompanyID.toString())));
    });
  }

  void _OnDeleteQuotationSucessResponse(
      QuotationDeleteCallResponseState state) {
    navigateTo(state.context, QuotationListScreen.routeName,
        clearAllStack: true);
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
                                                                _launchWhatsAppBuz(
                                                                    customerDetails123
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

  showcustomdialogSendEmail({
    BuildContext context1,
    String Email,
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
                    "Send Email",
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
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Text("Email To.",
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
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller: EmailTO,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintText: "Tap to enter email To",
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
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Text("Email BCC",
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
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                padding: EdgeInsets.only(left: 25, right: 20),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller: EmailBCC,
                                          decoration: InputDecoration(
                                            hintText: "Tap to enter email BCC",
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
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: getCommonButton(
                            baseTheme,
                            () {
                              if (EmailTO.text != "") {
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Email TO is Required!",
                                    positiveButtonTitle: "OK");
                              }
                            },
                            "YES",
                            backGroundColor: colorPrimary,
                            textColor: colorWhite,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: getCommonButton(
                            baseTheme,
                            () {
                              Navigator.pop(context);
                            },
                            "NO",
                            backGroundColor: colorPrimary,
                            textColor: colorWhite,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
