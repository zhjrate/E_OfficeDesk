import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/salesorder/salesorder_bloc.dart';
import 'package:soleoserp/models/api_requests/sales_order_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/salesorder_list_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_number_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/salesorder_list_response.dart';
import 'package:soleoserp/models/api_responses/search_salesorder_list_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/search_salesorder_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home_screen.dart';

class SalesOrderListScreen extends BaseStatefulWidget {
  static const routeName = '/SalesOrderListScreen';

  @override
  _SalesOrderListScreenState createState() => _SalesOrderListScreenState();
}

class _SalesOrderListScreenState extends BaseState<SalesOrderListScreen>
    with BasicScreen, WidgetsBindingObserver {
  SalesOrderBloc _SalesOrderBloc;
  int _pageNo = 0;
  SalesOrderListResponse _SalesOrderListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F;//0x66666666;
  int title_color = 0xFF000000;
  SearchDetails _searchDetails;
  int CompanyID = 0;
  String LoginUserID = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  String SiteURL="";
  String Password="";
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
  final urlController = TextEditingController();
  String url = "";
  bool isLoading=true;
  int prgresss = 0;
  double progress = 0;

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
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    SiteURL = _offlineCompanyData.details[0].siteURL;
    Password= _offlineLoggedInData.details[0].userPassword;
    _SalesOrderBloc = SalesOrderBloc(baseBloc);
    baseBloc.emit(ShowProgressIndicatorState(true));

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      _SalesOrderBloc..add(SalesOrderListCallEvent(_pageNo + 1,SalesOrderListApiRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID))),
      child: BlocConsumer<SalesOrderBloc, SalesOrderStates>(
        builder: (BuildContext context, SalesOrderStates state) {
          if (state is SalesOrderListCallResponseState) {
            _onInquiryListCallSuccess(state);
          }
          if (state is SearchSalesOrderListByNumberCallResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is SalesOrderListCallResponseState ||
              currentState is SearchSalesOrderListByNumberCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, SalesOrderStates state) {

          if (state is SalesOrderPDFGenerateResponseState) {
            _onGenerateQuotationPDFCallSuccess(state);
          }

        },
        listenWhen: (oldState, currentState) {
          if (currentState is SalesOrderPDFGenerateResponseState) {
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
        appBar:NewGradientAppBar(
          title: Text('SalesOrder List'),
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
                    _SalesOrderBloc.add(SalesOrderListCallEvent(1,SalesOrderListApiRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
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
          onPressed: () {
            // Add your onPressed code here!

          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
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
          Text(

              "Search SalesOrder",
              style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

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
                          ? "Tap to search SalesOrder"
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
    return ExpantionCustomer(context,index);

  }

  ///builds inquiry row items title and value's common view
  Widget _buildTitleWithValueView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style:TextStyle(fontSize: _fontSize_Label,color: Color(0xFF504F4F),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
            value,
            style:TextStyle(fontSize: _fontSize_Title,color: colorPrimary)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
        )
      ],
    );
  }
  Widget _buildLabelWithValueView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style:TextStyle(fontSize: 12,color: Color(0xff030303))// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
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
  void _onInquiryListCallSuccess(SalesOrderListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _searchDetails = null;
        _SalesOrderListResponse = state.response;
      } else {
        _SalesOrderListResponse.details.addAll(state.response.details);
      }
      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    if (_SalesOrderListResponse.details.length < _SalesOrderListResponse.totalCount) {
      _SalesOrderBloc.add(SalesOrderListCallEvent(_pageNo + 1,SalesOrderListApiRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID)));
    }
  }

  ExpantionCustomer(BuildContext context, int index) {
    SalesOrderDetails model = _SalesOrderListResponse.details[index];

    return Container(
      padding: EdgeInsets.all(15),
      child :  ExpansionTileCard(

        initialElevation: 5.0,
        elevation: 5.0,
        elevationCurve: Curves.easeInOut,
        shadowColor: Color(0xFF504F4F),
        baseColor: Color(0xFFFCFCFC),
        expandedColor: Color(0xFFC1E0FA),//Colors.deepOrange[50],ADD8E6
        leading: CircleAvatar(

            backgroundColor: Color(0xFF504F4F),
            child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/Image
                .network("http://demo.sharvayainfotech.in/images/profile.png",
              height: 35, fit: BoxFit.fill, width: 35,)),             /* title: Text("Customer",style:TextStyle(fontSize: 12,color: Color(0xFF504F4F),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),
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
        title: Text(model.customerName,style: TextStyle(
            color: Colors.black
        ),),
        subtitle: Text(model.orderNo,style: TextStyle(
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Expanded(
                        child: _buildTitleWithValueView(
                            "Order Date",
                            model.orderDate.getFormattedDate(
                                fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                toFormat: "dd/MM/yyyy") ??
                                "-"),
                      ),

                      Expanded(
                        child: _buildTitleWithValueView(
                            "Order #", model.orderNo ?? "-"),
                      ),
                      Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {

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
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                            ),

                          ])
                    ]),

                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Quot.#", model.quotationNo??"-"),
                      ),

                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),
                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView(
                            "Lead.#", model.inquiryNo??"-"),
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
                        "Project Name", /*model.referenceName ?? "-" */ model.projectName == "" || model.projectName == null ? '-' : model.projectName),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),

                    Row(children: [
                      Expanded(
                        child: _buildTitleWithValueView("Order Amount.", model.orderAmount.toString() ?? "-"),
                      ),
                     /* Expanded(
                        child: _buildTitleWithValueView("NetAmt.", model.netAmt.toString() ?? "-"),
                      ),*/
                    ]),
                    SizedBox(
                      height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
                    ),

                    _buildTitleWithValueView("Sales Exec.", model.createdBy),
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
                FlatButton(
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
                      Icon(Icons.delete,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Text('Delete',style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ]),
        ],
      ),);
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen
  Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchSalesOrderScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        _SalesOrderBloc.add(SearchSalesOrderListByNumberCallEvent(_searchDetails.value,
            SearchSalesOrderListByNumberRequest(CompanyId: CompanyID.toString(),OrderNo: _searchDetails.salesOrderNo,pkID: "",LoginUserID: LoginUserID)));
      }
    });
  }

  ///updates data of inquiry list
  void _onInquiryListByNumberCallSuccess(
      SearchSalesOrderListByNumberCallResponseState state) {
    _SalesOrderListResponse = state.response;
  }

  Future<void> _showMyDialog(SalesOrderDetails model) async {
    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context123) {

        return AlertDialog(
          title: Text('Do You want to Generate SaleOrder ? '),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Visibility(
                  visible: true,
                  child: GenerateQT(model,context123),

                )
                //GetCircular123(),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),//  We can return any object from here
                child: Text('NO')),
            /* prgresss!=100 ? CircularProgressIndicator() :*/ FlatButton(
                onPressed: () => {
                  Navigator.of(context).pop(),
                  _SalesOrderBloc.add(SalesOrderPDFGenerateCallEvent(SalesOrderPDFGenerateRequest(CompanyId: CompanyID.toString(),OrderNo: model.orderNo)))

                }, //  We can return any object from here
                child: Text('YES'))
          ],


        );
      },
    );


  }


  GenerateQT(SalesOrderDetails model, BuildContext context123) {

    print("Servrg" + SiteURL+"SalesOrder.aspx?MobilePdf=yes&userid="+LoginUserID+"&password="+Password+"&pQuotID="+model.pkID.toString());
    return Container(
      height: 200,
      child: Visibility(
        visible: true,
        child: InAppWebView(
          //                        webView.loadUrl(SiteURL+"/Quotation.aspx?MobilePdf=yes&userid="+userName123+"&password="+UserPassword+"&pQuotID="+contactListFiltered.get(position).getPkID() + "");
          // initialUrlRequest:urlRequest == null ? URLRequest(url: Uri.parse("http://122.169.111.101:3346/Default.aspx")) :urlRequest ,
          initialUrlRequest : URLRequest(url: Uri.parse(SiteURL+"/SalesOrder.aspx?MobilePdf=yes&userid="+LoginUserID+"&password="+Password+"&pQuotID="+model.pkID.toString())),
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
          shouldOverrideUrlLoading: (controller, navigationAction) async
          {
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
            print("LoadWeb"+consoleMessage.message.toString());
          },

        ),
      ),
    );
  }

  void _onGenerateQuotationPDFCallSuccess(SalesOrderPDFGenerateResponseState state) {

    _launchURL(state.response.details[0].column1.toString());

  }


  _launchURL(String pdfURL) async {
    var url123 = pdfURL;
    if (await canLaunch(url123)) {
      await launch(url123);
    } else {
      throw 'Could not launch $url123';
    }
  }
}