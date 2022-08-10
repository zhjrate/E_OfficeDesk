import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/bank_voucher/bank_voucher_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/maintenance/maintenance_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/maintenance_list_request.dart';
import 'package:soleoserp/models/api_requests/maintenance_search_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_list_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/maintenance_list_response.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_add_edit/bank_voucher_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/maintenance/maintenance_list/maintenance_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:url_launcher/url_launcher.dart';

///import 'package:whatsapp_share/whatsapp_share.dart';

class MaintenanceListScreen extends BaseStatefulWidget {
  static const routeName = '/MaintenanceListScreen';

  @override
  _MaintenanceListScreenState createState() => _MaintenanceListScreenState();
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

class _MaintenanceListScreenState extends BaseState<MaintenanceListScreen>
    with BasicScreen, WidgetsBindingObserver {
  MaintenanceScreenBloc _CustomerBloc;
  int _pageNo = 0;
  MaintenanceListResponse _inquiryListResponse;
  bool expanded = true;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;
  MaintenanceDetails _searchDetails;
  int _key;
  String foos = 'One';
  int selected = 0; //attention
  bool isExpand = false;

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  List<ContactModel> _contactsList = [];

  bool _hasCallSupport = false;
  Future<void> _launched;
  String _phone = '';
  //var _url = "https://api.whatsapp.com/send?phone=91";
  var _url = "https://wa.me/91";
  bool isDeleteVisible = true;
/*
  bool _hasPermission;
*/

  @override
  void initState() {
    super.initState();
/*
    _askPermissions();
*/

    screenStatusBarColor = colorDarkYellow;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _CustomerBloc = MaintenanceScreenBloc(baseBloc);
    isExpand = false;
    getContacts();

    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
    isDeleteVisible = viewvisiblitiyAsperClient(
        SerailsKey: _offlineLoggedInData.details[0].serialKey,
        RoleCode: _offlineLoggedInData.details[0].roleCode);
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

  Future<void> _makeSms(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'smsto',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc
        ..add(MaintenanceListCallEvent(
            _pageNo + 1,
            MaintenanceListRequest(
                pkID: "",
                CompanyID: CompanyID.toString(),
                LoginUserID: LoginUserID))),
      child: BlocConsumer<MaintenanceScreenBloc, MaintenanceScreenStates>(
        builder: (BuildContext context, MaintenanceScreenStates state) {
          if (state is MaintenanceListResponseState) {
            _onInquiryListCallSuccess(state);
          }
          /*  if (state is BankVoucherSearchByIDCallResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }*/
          if (state is MaintenanceSearchResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is MaintenanceListResponseState ||
              currentState is MaintenanceSearchResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, MaintenanceScreenStates state) {
          if (state is MaintenanceDeleteResponseState) {
            _onCustomerDeleteCallSucess(state, context);
          }
          /* if (state is BankVoucherDeleteResponseState) {
            _onCustomerDeleteCallSucess(state, context);
          }*/
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is MaintenanceDeleteResponseState) {
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
          title: Text('Maintenance List'),
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
        /* AppBar(
          backgroundColor: colorPrimary,
          title: Text("Customer List"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.water_damage_sharp,color: colorWhite,),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                })
          ],
        ),*/
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _CustomerBloc.add(MaintenanceListCallEvent(
                        1,
                        MaintenanceListRequest(
                            pkID: "",
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
        /* floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            await _onTapOfDeleteALLContact();
            navigateTo(context, BankVoucherAddEditScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),*/
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
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
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Search Customer",
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
            color: Color(0xffE0E0E0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _searchDetails == null
                          ? "Tap to search Customer"
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
        key: Key('selected $selected'),
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

  ///updates data of inquiry list
  void _onInquiryListCallSuccess(MaintenanceListResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _searchDetails = null;
        _inquiryListResponse = state.maintenanceListResponse;
      } else {
        _inquiryListResponse.details
            .addAll(state.maintenanceListResponse.details);
      }
      _pageNo = state.newPage;
    }
  }

  ///checks if already all records are arrive or not
  ///calls api with new page
  void _onInquiryListPagination() {
    _CustomerBloc.add(MaintenanceListCallEvent(
        _pageNo + 1,
        MaintenanceListRequest(
            pkID: "",
            CompanyID: CompanyID.toString(),
            LoginUserID: LoginUserID)));

    /*if (_inquiryListResponse.details.length < _inquiryListResponse.totalCount) {
    }*/
  }

  ExpantionCustomer(BuildContext context, int index) {
    MaintenanceDetails model = _inquiryListResponse.details[index];

    return Container(
        padding: EdgeInsets.all(15),
        child: ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          elevationCurve: Curves.easeInOut,
          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: Color(0xFFC1E0FA),
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
            style: TextStyle(color: Colors.black),
          ),
          subtitle: GestureDetector(
            child: Text(
              model.inquiryNo.toString(),
              style: TextStyle(
                color: Color(0xFF504F4F),
                fontSize: _fontSize_Title,
              ),
            ),
          ),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Contract Type",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Color(label_color),
                                                fontSize: _fontSize_Label,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            model.contractType == ""
                                                ? "N/A"
                                                : model.contractType.toString(),
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
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Total Amount",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              model.totalAmount == 0.00
                                                  ? "N/A"
                                                  : model.totalAmount
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          SizedBox(
                            height: sizeboxsize,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Start Date",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Color(label_color),
                                            fontSize: _fontSize_Label,
                                            letterSpacing: .3)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        model.startDate.toString() == ""
                                            ? "N/A"
                                            : model.startDate.getFormattedDate(
                                                    fromFormat:
                                                        "yyyy-MM-ddTHH:mm:ss",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("End Date	",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Color(label_color),
                                                fontSize: _fontSize_Label,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            model.endDate == null
                                                ? "N/A"
                                                : model.endDate.getFormattedDate(
                                                        fromFormat:
                                                            "yyyy-MM-ddTHH:mm:ss",
                                                        toFormat:
                                                            "dd-MM-yyyy") ??
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Sales Executive",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Color(label_color),
                                                fontSize: _fontSize_Label,
                                                letterSpacing: .3)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                            model.contactPerson == null
                                                ? "N/A"
                                                : model.contactPerson
                                                    .toString(),
                                            style: TextStyle(
                                                color: Color(title_color),
                                                fontSize: _fontSize_Title,
                                                letterSpacing: .3)),
                                      ],
                                    )),
                              ]),
                        ],
                      ),
                    ),
                  ],
                ))),
            ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  /* FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                      //_onTapOfEditCustomer(model);
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
                  ),*/

                  isDeleteVisible == true
                      ? FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          onPressed: () {
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

  void _onTapOfDeleteInquiry(int id) {
    print("CUSTID" + id.toString());
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Customer ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      _CustomerBloc.add(MaintenanceDeleteCallEvent(
          id, BankVoucherDeleteRequest(CompanyID: CompanyID.toString())));
      // _CustomerBloc..add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: CompanyID,loginUserID: LoginUserID,CustomerID: "",ListMode: "L")));
    });
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  ///navigates to search list screen
  Future<void> _onTapOfSearchView() async {
    navigateTo(context, SearchMaintenanceScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        /*_CustomerBloc.add(BankVoucherSearchByIDCallEvent(value.value,
            BankVoucherSearchByIDRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID)));*/
        _CustomerBloc.add(MaintenanceSearchCallEvent(MaintenanceSearchRequest(
            pkID: "",
            LoginUserID: LoginUserID,
            SearchKey: _searchDetails.customerName.toString(),
            CompanyID: CompanyID.toString())));
      }
    });
  }

  ///updates data of inquiry list
  void _onInquiryListByNumberCallSuccess(
      BankVoucherSearchByIDCallResponseState state) {
    //_inquiryListResponse = state.bankVoucherListResponse;
  }

  void _onCustomerDeleteCallSucess(
      MaintenanceDeleteResponseState state, BuildContext context) {
    /* _inquiryListResponse.details
        .removeWhere((element) => element.customerID == state.id);*/

    print("CustomerDeleted" +
        state.bankVoucherDeleteResponse.details[0].column1.toString() +
        "");
    //baseBloc.refreshScreen();

    if (state.bankVoucherDeleteResponse.details[0].column1.toString() ==
        "Sorry ! Payroll Entry Exists for such period of Loan Date !") {
      showCommonDialogWithSingleOption(context,
          state.bankVoucherDeleteResponse.details[0].column1.toString(),
          positiveButtonTitle: "OK");
    } else {
      navigateTo(context, MaintenanceListScreen.routeName, clearAllStack: true);
    }
  }

  void _onTapOfEditCustomer(BankVoucherDetails model) {
    navigateTo(context, BankVoucherAddEditScreen.routeName,
            arguments: AddUpdateBankVoucherScreenArguments(model))
        .then((value) {
      setState(() {
        // baseBloc.refreshScreen();
        /* _CustomerBloc.add(BankVoucherListCallEvent(1,
            BankVoucherListRequest(
              CompanyID: CompanyID.toString(),
              LoginUserID: LoginUserID,)));*/
      });
    });
  }

  Future<void> getContacts() async {
    _contactsList.clear();
    _contactsList.addAll(await OfflineDbHelper.getInstance().getContacts());
    setState(() {});
  }

  Future<void> _onTapOfDeleteALLContact() async {
    await OfflineDbHelper.getInstance().deleteContactTable();
  }

  void _launchURL(txt, String urltest) async => await canLaunch(urltest + txt)
      ? await launch(urltest + txt)
      : throw 'Could not Launch $urltest';
  Future<void> onButtonTap(Share share, CustomerDetails customerDetails) async {
    String msg =
        ""; //"Thank you for contacting us! We will be in touch shortly";
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
    /*await WhatsappShare.share(
        text: 'Whatsapp share text',
        linkUrl: 'https://flutter.dev/',
        phone: "91"+contactNo1,
        package: Package.businessWhatsapp
    );*/
  }

  void _onSearchInquiryListCallSuccess(MaintenanceSearchResponseState state) {
    _inquiryListResponse = state.maintenanceListResponse;
  }
}
