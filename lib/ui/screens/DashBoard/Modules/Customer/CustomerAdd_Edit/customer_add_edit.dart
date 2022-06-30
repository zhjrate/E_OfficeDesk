import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_add_edit_api_request.dart';
import 'package:soleoserp/models/api_requests/customer_category_request.dart';
import 'package:soleoserp/models/api_requests/customer_id_to_contact_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_id_to_delete_all_contacts_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/district_list_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_requests/taluka_api_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_category_list.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/district_api_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/api_responses/taluka_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/country_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_country_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_taluka_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/screens/contactscrud/contacts_list_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'distict_list_screen.dart';

class AddUpdateCustomerScreenArguments {
  // SearchDetails editModel;

  CustomerDetails editModel;

  AddUpdateCustomerScreenArguments(this.editModel);
}

class Customer_ADD_EDIT extends BaseStatefulWidget {
  static const routeName = '/customer_add_edit';

  //ALL_Name_ID all_name_id;
  // final CountryArguments arguments;
  final AddUpdateCustomerScreenArguments arguments;

  Customer_ADD_EDIT(this.arguments);

  @override
  _Customer_ADD_EDITState createState() => _Customer_ADD_EDITState();
}

class _Customer_ADD_EDITState extends BaseState<Customer_ADD_EDIT>
    with BasicScreen, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  FocusNode PicCodeFocus;

  CustomerBloc _CustomerBloc;
  LoginUserDetialsResponse _offlineLoggedInData;
  CompanyDetailsResponse _offlineCompanyData;
  //CustomerCategoryResponse _offlineCustomerCategoryData;
  // CustomerSourceResponse _offlineCustomerSourceData;

  int CompanyID = 0;
  String LoginUserID = "";

  final TextEditingController edt_Customer_Name = TextEditingController();
  final TextEditingController edt_Customer_Contact1_Name =
      TextEditingController();
  final TextEditingController edt_Customer_Contact2_Name =
      TextEditingController();
  final TextEditingController edt_GST_Name = TextEditingController();
  final TextEditingController edt_PAN_Name = TextEditingController();
  final TextEditingController edt_Email_Name = TextEditingController();
  final TextEditingController edt_Website_Name = TextEditingController();
  final TextEditingController edt_Address = TextEditingController();
  final TextEditingController edt_Area = TextEditingController();
  final TextEditingController edt_Category = TextEditingController();

  final TextEditingController edt_Source = TextEditingController();
  //final TextEditingController edt_Country = TextEditingController();
  //final TextEditingController edt_CountryID = TextEditingController();

  final TextEditingController edt_District = TextEditingController();
  final TextEditingController edt_DistrictID = TextEditingController();

  final TextEditingController edt_Taluka = TextEditingController();
  final TextEditingController edt_TalukaID = TextEditingController();

  final TextEditingController edt_Pincode = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchControllerState = TextEditingController();
  final TextEditingController _searchControllerDistrict =
      TextEditingController();
  final TextEditingController edt_sourceID = TextEditingController();

  String dropdownValue = 'One';
  List<String> drop = ['One', 'Two', 'Free', 'Four'];
  CustomerCategoryResponse arrcustomerCategory;
  CustomerSourceResponse arrCustomerSourceResponse;

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Category = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Source = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Country = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_State = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_District = [];

  List<ALL_Name_ID> _listFilteredCountry = [];

  List<ALL_Name_ID> _listFilteredState = [];

  List<ALL_Name_ID> _listFilteredDistrict = [];
  List<ALL_Name_ID> _listFilteredTaluka = [];
  List<ALL_Name_ID> _listFilteredCity = [];

  Function refreshList;
  SearchDetails _searchDetails;
  SearchDistrictDetails _searchDistrictDetails;
  SearchTalukaDetails _searchTalukaDetails;

  SearchDetails _searchCountryDetails;
  SearchStateDetails _searchStateDetails;
  SearchCityDetails _searchCityDetails;

  bool _isSwitched;
  bool _isForUpdate;
  CustomerDetails _editModel;
  int customerID = 0;
  List<ContactModel> _contactsList = [];

  String Token;
  double CardViewHieght = 35;

  final TextEditingController edt_QualifiedCountry = TextEditingController();
  final TextEditingController edt_QualifiedCountryCode =
      TextEditingController();

  final TextEditingController edt_QualifiedState = TextEditingController();

  final TextEditingController edt_QualifiedStateCode = TextEditingController();

  final TextEditingController edt_QualifiedCity = TextEditingController();
  final TextEditingController edt_QualifiedCityCode = TextEditingController();
  bool emailValid;
  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    //_offlineCustomerCategoryData = SharedPrefHelper.instance.getCustomerCategoryData();
    //_offlineCustomerSourceData = SharedPrefHelper.instance.getCustomerSourceData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    //getOfflineCustomerCategoryData(_offlineCustomerCategoryData);
    // onSourceSuccess(_offlineCustomerSourceData);
    emailValid = false;
    screenStatusBarColor = colorPrimary;
    _CustomerBloc = CustomerBloc(baseBloc);
    myFocusNode = FocusNode();
    PicCodeFocus = FocusNode();

    /* _CustomerBloc
      ..add(CountryCallEvent(
          CountryListRequest(CountryCode: "", CompanyID: "8033")));*/
    /* _CustomerBloc
      ..add(StateCallEvent(StateListRequest(
          CountryCode: "IND", CompanyId: "8033", word: "", Search: "1")));
    _CustomerBloc
      ..add(DistrictCallEvent(DistrictApiRequest(
          DistrictName: "", CompanyId: "8033", StateCode: "12")));
    _CustomerBloc
      ..add(TalukaCallEvent(
          TalukaApiRequest(TalukaName: "", CompanyId: "8033",DistrictCode: "12")));
    _CustomerBloc
      ..add(CityCallEvent(
          CityApiRequest(CityName: "", CompanyID: "8033",TalukaCode: "8")));*/

    /*
    _isSwitched = true;
    if (_isForUpdate !=null) {
      _editModel = widget.arguments.editModel;
      fillData();
    }*/
    edt_Source.addListener(() {
      myFocusNode.requestFocus();
    });

    /* edt_City.addListener(() {
      PicCodeFocus.requestFocus();
    });*/

    if (widget.arguments != null) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      _searchStateDetails = SearchStateDetails();

      edt_QualifiedCountry.text = "India";
      edt_QualifiedCountryCode.text = "IND";
      _searchStateDetails.value = _offlineLoggedInData.details[0].stateCode;
      edt_QualifiedState.text = _offlineLoggedInData.details[0].StateName;
      edt_QualifiedStateCode.text =
          _offlineLoggedInData.details[0].stateCode.toString();

      edt_QualifiedCity.text = _offlineLoggedInData.details[0].CityName;
      edt_QualifiedCityCode.text =
          _offlineLoggedInData.details[0].CityCode.toString();
      _isSwitched = true;

      setState(() {});
    }
  }

  ///listener to multiple states of bloc to handles api responses
  ///use only BlocListener if only need to listen to events
/*
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenStates>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, HomeScreenStates state) {
        if (state is HomeScreenResponseState) {
          _onHomeScreenCallSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }
*/

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
    myFocusNode.dispose();
    PicCodeFocus.dispose();
  }

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc,
      child: BlocConsumer<CustomerBloc, CustomerStates>(
        builder: (BuildContext context, CustomerStates state) {
          //handle states

          if (state is CountryListEventResponseState) {
            _onCountryListSuccess(state);
          }
          if (state is StateListEventResponseState) {
            _onStateListSuccess(state);
          }
          if (state is DistrictListEventResponseState) {
            _onDistrictListSuccess(state);
          }
          if (state is TalukaListEventResponseState) {
            _onTalukaListSuccess(state);
          }
          if (state is CityListEventResponseState) {
            _onCityListSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          if (currentState is CountryListEventResponseState) {
            return true;
          } else if (currentState is StateListEventResponseState) {
            return true;
          } else if (currentState is DistrictListEventResponseState) {
            return true;
          } else if (currentState is TalukaListEventResponseState) {
            return true;
          } else if (currentState is CityListEventResponseState) {
            return true;
          }

          return false;
        },
        listener: (BuildContext context, CustomerStates state) {
          //handle states

          if (state is StateListEventResponseState) {
            _onStateListSuccess(state);
          }
          if (state is CustomerAddEditEventResponseState) {
            _onCustomerAddEditSuccess(state);
          }
          if (state is CustomerContactSaveResponseState) {
            _OnCustomerContactSucess(state);
          }
          if (state is CustomerIdToCustomerListResponseState) {
            _OnCustomerIdToFetchContactDetails(state);
          }
          if (state is CustomerIdToDeleteAllContactResponseState) {
            _OnCustomerIdToDeleteAllContactResponse(state);
          }
          if (state is CustomerCategoryCallEventResponseState) {
            _OnCustomerCategoryCallEventResponse(state);
          }

          if (state is CustomerSourceCallEventResponseState) {
            _onSourceSuccess(state);
          }

          /*  if (state is DistrictListEventResponseState) {
            _onDistrictListSuccess(state);
          }
          if (state is TalukaListEventResponseState) {
            _onTalukaListSuccess(state);
          }*/
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          /* if (currentState is StateListEventResponseState) {
            return true;
          }
          if (currentState is DistrictListEventResponseState) {
            return true;
          }*/

          if (currentState is CustomerAddEditEventResponseState) {
            return true;
          } else if (currentState is CustomerContactSaveResponseState) {
            return true;
          } else if (currentState is CustomerIdToCustomerListResponseState) {
            return true;
          } else if (currentState
              is CustomerIdToDeleteAllContactResponseState) {
            return true;
          } else if (currentState is CustomerCategoryCallEventResponseState) {
            return true;
          } else if (currentState is CustomerSourceCallEventResponseState) {
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
          title: Text('Customer Details'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () {
                  _onTapOfLogOut();
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(Constant.CONTAINERMARGIN),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerName(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    CustomDropDown1("Category", "Source",
                        enable1: false,
                        enable2: false,
                        icon: Icon(Icons.arrow_drop_down),
                        controllerForLeft: edt_Category,
                        controllerForRight: edt_Source,
                        Custom_values1: arr_ALL_Name_ID_For_Category,
                        Custom_values2: arr_ALL_Name_ID_For_Source),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    SwitchNoFollowup(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    ContactCollapse(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    EmailWebSite(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    GSTPAN(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    Address(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    Area(),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    /*   CustomDropDown1("City", "State",enable1: false,enable2: false,icon: Icon(Icons.arrow_drop_down)
                        ,controllerForLeft: edt_City,controllerForRight: edt_State,Custom_values1 : _listFilteredCountry,Custom_values2: arr_ALL_Name_ID_For_Source
                    ),*/
                    /* CustomDropDownCountry("Country", "State",
                        enable1: false,
                        enable2: false,
                        icon: Icon(Icons.arrow_drop_down),
                        controllerForLeft: edt_Country,
                        controllerForRight: edt_State,
                        Custom_values1: _listFilteredCountry,
                        Custom_values2: _listFilteredState),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    */ /* CustomDropDownDistrictTaluka("District", "Taluka",
                        enable1: false,
                        enable2: false,
                        icon: Icon(Icons.pin_drop_sharp),
                        controllerForLeft: edt_District,
                        controllerForRight: edt_Taluka),*/ /*
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    CustomDropDown("City", "PinCode",
                        enable1: false,
                        enable2: true,
                        icon: Icon(Icons.pin_drop_sharp),
                        controllerForLeft: edt_City,
                        controllerForRight: edt_Pincode),*/

                    Row(
                      children: [
                        Expanded(flex: 1, child: QualifiedCountry()),
                        Expanded(flex: 1, child: QualifiedState()),
                      ],
                    ),
                    SizedBox(
                      height: Constant.SIZEBOXHEIGHT,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 1, child: QualifiedCity()),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text("PinCode",
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Container(
                                      height: CardViewHieght,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                                controller: edt_Pincode,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 6,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 10),
                                                  counterText: "",
                                                  hintText: "PinCode",
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
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: Constant.SIZEBOXHEIGHT,
                    ),
                    SizedBox(
                      height: Constant.SIZEBOXHEIGHT,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: getCommonButton(baseTheme, () {
                        //  _onTapOfDeleteALLContact();
                        navigateTo(context, ContactsListScreen.routeName);
                      }, "Add Contact + ",
                          width: 600, backGroundColor: Color(0xff4d62dc)),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: getCommonButton(baseTheme, () {
                        // getContactarray();
                        _onTapOfSaveCustomerAPICall();
                        // navigateTo(context, ContactsListScreen.routeName);
                      }, "Save", width: 600),
                    ),
                    /* FlatButton(onPressed: (){
                      FirebaseMessaging.instance.getToken().then((token){
                        print(token);
                        setState(() {
                          Token = token;

                        });
                      });
                    },
                        child: Text("Token")),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: SelectableText(
                        "$Token",
                        style: const TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                        textAlign: TextAlign.center,
                        onTap: () => print('Tapped'),
                        toolbarOptions: const ToolbarOptions(copy: true, selectAll: true,),
                        showCursor: true,
                        cursorWidth: 2,
                        cursorColor: Colors.red,
                        cursorRadius: const Radius.circular(5),

                      ),
                    ),*/
                    /* ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                        minimumSize: Size(double.infinity, 50), // double.infinity is the width and 30 is the height
                      ),
                      onPressed: () {},
                      child: Text('Save'),
                    )*/
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapOfLogOut() async {
    //await SharedPrefHelper.instance.clear();
    await _onTapOfDeleteALLContact();
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  Future<void> _onTapOfCustomer() async {
    //await SharedPrefHelper.instance.clear();
    navigateTo(context, CountryListScreen.routeName, clearAllStack: true);
  }

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    // CommonUtils.showToast(context, "Back presses");
    // Navigator.defaultRouteName.
    await _onTapOfDeleteALLContact();
    navigateTo(context, CustomerListScreen.routeName);
  }

  Widget CustomDropDown1(String Category, String Source,
      {bool enable1,
      bool enable2,
      Icon icon,
      TextEditingController controllerForLeft,
      TextEditingController controllerForRight,
      List<ALL_Name_ID> Custom_values1,
      List<ALL_Name_ID> Custom_values2}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _CustomerBloc.add(CustomerCategoryCallEvent(
                CustomerCategoryRequest(
                    pkID: "", CompanyID: CompanyID.toString()))),

            /*showcustomdialog(
    values: Custom_values1,
    context1: context,
    controller: controllerForLeft,
    lable: "Select $Category"),*/

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Category *",
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
                    height: CardViewHieght,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                hintText: "Tap to select category",
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
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () =>
                /* showcustomdialog(
                    values: Custom_values2,
                    context1: context,
                    controller: controllerForRight,
                    controller2: edt_sourceID,
                    lable: "Select $Source")*/
                _CustomerBloc.add(CustomerSourceCallEvent(CustomerSourceRequest(
                    pkID: "0",
                    StatusCategory: "InquirySource",
                    companyId: CompanyID,
                    LoginUserID: LoginUserID,
                    SearchKey: ""))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Source",
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
                    height: CardViewHieght,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              onChanged: (value) => {
                                    myFocusNode.requestFocus()
                                  }, //myFocusNode.requestFocus(),
                              controller: controllerForRight,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                hintText: "Tap to select source",
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

  Widget CustomDropDownCountry(String Category, String Source,
      {bool enable1,
      bool enable2,
      Icon icon,
      TextEditingController controllerForLeft,
      TextEditingController controllerForRight,
      List<ALL_Name_ID> Custom_values1,
      List<ALL_Name_ID> Custom_values2}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _onTapOfSearchCountryView(
                _searchDetails == null ? "" : _searchDetails.countryCode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Country *",
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
                          child:
                              /*Text(
                            _searchDetails == null
                                ? "Tap to search country"
                                : _searchDetails.countryName,
                            style: baseTheme.textTheme.headline3.copyWith(
                                color: _searchDetails == null
                                    ? colorGrayDark
                                    : colorBlack,
                                fontSize: 15),
                          ),*/
                              TextField(
                                  controller: controllerForLeft,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "Tap to Search Country",
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
                          Icons.location_city_outlined,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            /*Container(
                child:
                    Text(
                  _searchDetails == null
                      ? "search country"
                      : _searchDetails.countryName,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color:
                          _searchDetails == null ? colorGrayDark : colorBlack),
                ),
              ),*/
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => _onTapOfSearchStateView(
                _searchDetails == null ? "" : _searchDetails.countryCode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("State *",
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
                          child:
                              /*Text(
                            _searchStateDetails == null
                                ? "Tap to search state"
                                : _searchStateDetails.label,
                            style: baseTheme.textTheme.headline3.copyWith(
                                color: _searchStateDetails == null
                                    ? colorGrayDark
                                    : colorBlack,
                                fontSize: 15),
                          ),*/
                              TextField(
                                  controller: controllerForRight,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: "Tap to Search State",
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
                          Icons.location_city_outlined,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            /*Container(
                child:
                    Text(
                  _searchDetails == null
                      ? "search country"
                      : _searchDetails.countryName,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color:
                          _searchDetails == null ? colorGrayDark : colorBlack),
                ),
              ),*/
          ),

          /*   GestureDetector(
              onTap:
                  () =>
                      _onTapOfSearchStateView(_searchDetails == null
                          ? ""
                          : _searchDetails.countryCode),
              child: Container(
                child:
                    Text(
                  _searchStateDetails == null
                      ? "search State"
                      : _searchStateDetails.label,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color: _searchStateDetails == null
                          ? colorGrayDark
                          : colorBlack),
                ),
              ),
            ),*/
        ],
      ),
    );
  }

  Widget CustomDropDownDistrictTaluka(String District, String Taluka,
      {bool enable1,
      bool enable2,
      Icon icon,
      TextEditingController controllerForLeft,
      TextEditingController controllerForRight,
      List<ALL_Name_ID> Custom_values1,
      List<ALL_Name_ID> Custom_values2}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _onTapOfSearchDistrictView(_searchStateDetails == null
                ? ""
                : _searchStateDetails.value.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("District *",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
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
                                hintText: "Tap to search district",
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
                          Icons.location_city_outlined,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            /*Container(
                child:
                    Text(
                  _searchDetails == null
                      ? "search country"
                      : _searchDetails.countryName,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color:
                          _searchDetails == null ? colorGrayDark : colorBlack),
                ),
              ),*/
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => _onTapOfSearchTalukaView(_searchDistrictDetails == null
                ? ""
                : _searchDistrictDetails.districtCode.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Taluka *",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
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
                              controller: controllerForRight,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Tap to search Taluka",
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
                          Icons.location_city_outlined,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            /*Container(
                child:
                    Text(
                  _searchDetails == null
                      ? "search country"
                      : _searchDetails.countryName,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color:
                          _searchDetails == null ? colorGrayDark : colorBlack),
                ),
              ),*/
          ),
        ],
      ),
    );
  }

  Widget CustomDropDown(String Category, String Source,
      {bool enable1,
      bool enable2,
      Icon icon,
      TextEditingController controllerForLeft,
      TextEditingController controllerForRight}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _onTapOfSearchCityView(_searchStateDetails == null
                ? ""
                : _searchStateDetails.value.toString()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("City *",
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
                                hintText: "Tap to search city",
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
                          Icons.location_city_outlined,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

            /*Container(
                child:
                    Text(
                  _searchDetails == null
                      ? "search country"
                      : _searchDetails.countryName,
                  style: baseTheme.textTheme.headline3.copyWith(
                      color:
                          _searchDetails == null ? colorGrayDark : colorBlack),
                ),
              ),*/
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("PinCode",
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
                              focusNode: PicCodeFocus,
                              controller: controllerForRight,
                              keyboardType: TextInputType.number,
                              maxLength: 14,
                              decoration: InputDecoration(
                                counterText: "",
                                hintText: "Tap to enter PinCode",
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
                          Icons.pin_drop_sharp,
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

  Widget ContactCollapse() {
    return Container(
        child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("Contact No.1 *",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_Customer_Contact1_Name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: myFocusNode,
                          maxLength: 14,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter Contact No.1",
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
                      Icons.phone_android,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: Constant.SIZEBOXHEIGHT,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("Contact No.2",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_Customer_Contact2_Name,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          maxLength: 14,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter Contact No.2",
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
                      Icons.phone_android,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    ));
  }

  Widget GSTPAN() {
    return Container(
        child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("GST No.",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_GST_Name,
                          keyboardType: TextInputType.text,
                          maxLength: 15,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter Gst No.",
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
                      Icons.admin_panel_settings,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: Constant.SIZEBOXHEIGHT,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("PAN No.",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_PAN_Name,
                          keyboardType: TextInputType.text,
                          maxLength: 14,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter PAN No.",
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
                      Icons.admin_panel_settings,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    ));

/*
    return Container(
        child: Container(
            child: Row(
      children: [
        Expanded(
          child: buildUserNameTextFiled(
              userName_Controller: edt_GST_Name,
              labelName: "GST No",
              icon: Icon(Icons.web),
              maxline: 1,
              baseTheme: baseTheme),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: buildUserNameTextFiled(
              userName_Controller: edt_PAN_Name,
              labelName: "Pan No",
              icon: Icon(Icons.web),
              maxline: 1,
              baseTheme: baseTheme),
        ),
      ],
    )));
*/
  }

  Widget EmailWebSite() {
    return Container(
        child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("Email",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_Email_Name,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter email",
                            labelStyle: TextStyle(
                              color: Color(0xFF000000),
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF000000),
                          )),
                    ),
                    Icon(
                      Icons.email,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: Constant.SIZEBOXHEIGHT,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text("WebSite",
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
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: edt_Website_Name,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 10),
                            counterText: "",
                            hintText: "Tap to enter website",
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
                      Icons.phone_android,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    ));

    /* return Container(
        child: Column(
      children: [
        buildUserNameTextFiled(
            userName_Controller: edt_Email_Name,
            labelName: "Email ID",
            icon: Icon(Icons.email),
            maxline: 1,
            baseTheme: baseTheme),
        SizedBox(
          height: Constant.SIZEBOXHEIGHT,
        ),
        buildUserNameTextFiled(
            userName_Controller: edt_Website_Name,
            labelName: "Web Site",
            icon: Icon(Icons.web),
            maxline: 1,
            baseTheme: baseTheme),
      ],
    ));*/
  }

  /* void _onCategoryCallSuccess(
      CustomerCategoryCallEventResponseState categoryResponse) {
    arr_ALL_Name_ID_For_Category.clear();
    for (var i = 0; i < categoryResponse.categoryResponse.details.length; i++) {
      print("CustomerCategoryResponse1 : " +
          categoryResponse.categoryResponse.details[i].categoryName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          categoryResponse.categoryResponse.details[i].categoryName;
      categoryResponse123.pkID =
          categoryResponse.categoryResponse.details[i].pkID;
      arr_ALL_Name_ID_For_Category.add(categoryResponse123);

      //children.add(new ListTile());
    }
  }*/

  void onSourceSuccess(CustomerSourceResponse response) {
    arr_ALL_Name_ID_For_Source.clear();
    for (var i = 0; i < response.details.length; i++) {
      print("CustomerCategoryResponse2 : " + response.details[i].inquiryStatus);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name = response.details[i].inquiryStatus;
      categoryResponse123.Name1 = response.details[i].pkID.toString();
      arr_ALL_Name_ID_For_Source.add(categoryResponse123);

      //children.add(new ListTile());
    }
  }

  void _onCountryListSuccess(CountryListEventResponseState responseState) {
    arr_ALL_Name_ID_For_Country.clear();
    for (var i = 0; i < responseState.countrylistresponse.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.countrylistresponse.details[i].countryName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.countrylistresponse.details[i].countryName;
      categoryResponse123.Name1 =
          responseState.countrylistresponse.details[i].countryCode;
      arr_ALL_Name_ID_For_Country.add(categoryResponse123);
      _listFilteredCountry.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  void _onStateListSuccess(StateListEventResponseState responseState) {
    arr_ALL_Name_ID_For_State.clear();
    for (var i = 0; i < responseState.statelistresponse.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.statelistresponse.details[i].label);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.statelistresponse.details[i].label;
      categoryResponse123.pkID =
          responseState.statelistresponse.details[i].value;
      arr_ALL_Name_ID_For_State.add(categoryResponse123);
      _listFilteredState.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  void _onDistrictListSuccess(DistrictListEventResponseState responseState) {
    arr_ALL_Name_ID_For_District.clear();
    for (var i = 0;
        i < responseState.districtApiResponseList.details.length;
        i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.districtApiResponseList.details[i].districtName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.districtApiResponseList.details[i].districtName;
      categoryResponse123.pkID =
          responseState.districtApiResponseList.details[i].districtCode;
      arr_ALL_Name_ID_For_District.add(categoryResponse123);
      _listFilteredDistrict.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  void _onTalukaListSuccess(TalukaListEventResponseState responseState) {
    arr_ALL_Name_ID_For_District.clear();
    for (var i = 0; i < responseState.talukaApiRespose.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.talukaApiRespose.details[i].talukaName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.talukaApiRespose.details[i].talukaName;
      categoryResponse123.pkID =
          responseState.talukaApiRespose.details[i].talukaCode;
      arr_ALL_Name_ID_For_District.add(categoryResponse123);
      _listFilteredTaluka.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  void _onCityListSuccess(CityListEventResponseState responseState) {
    arr_ALL_Name_ID_For_District.clear();
    for (var i = 0; i < responseState.cityApiRespose.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.cityApiRespose.details[i].cityName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.cityApiRespose.details[i].cityName;
      categoryResponse123.pkID =
          responseState.cityApiRespose.details[i].cityCode;
      arr_ALL_Name_ID_For_District.add(categoryResponse123);
      _listFilteredCity.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  Future<void> _onTapOfSearchCountryView(String sw) async {
    navigateTo(context, SearchCountryScreen.routeName,
            arguments: CountryArguments(sw))
        .then((value) {
      if (value != null) {
        _searchDetails = SearchDetails();
        _searchDetails = value;
        print("CountryName IS From SearchList" + _searchDetails.countryCode);
        edt_QualifiedCountryCode.text = _searchDetails.countryCode;
        edt_QualifiedCountry.text = _searchDetails.countryName;
        _CustomerBloc.add(CountryCallEvent(CountryListRequest(
            CountryCode: _searchDetails.countryCode,
            CompanyID: CompanyID.toString())));
      }
    });
  }

  Future<void> _onTapOfSearchStateView(String sw1) async {
    navigateTo(context, SearchStateScreen.routeName,
            arguments: StateArguments(sw1))
        .then((value) {
      if (value != null) {
        _searchStateDetails = value;
        edt_QualifiedStateCode.text = _searchStateDetails.value.toString();
        edt_QualifiedState.text = _searchStateDetails.label.toString();
        _CustomerBloc.add(StateCallEvent(StateListRequest(
            CountryCode: sw1,
            CompanyId: CompanyID.toString(),
            word: "",
            Search: "1")));
      }
    });
  }

  Future<void> _onTapOfSearchDistrictView(String stateCode) async {
    navigateTo(context, SearchDistrictScreen.routeName,
            arguments: DistrictArguments(stateCode))
        .then((value) {
      if (value != null) {
        _searchDistrictDetails = value;
        edt_DistrictID.text = _searchDistrictDetails.districtCode.toString();
        edt_District.text = _searchDistrictDetails.districtName.toString();
        _CustomerBloc
          ..add(DistrictCallEvent(DistrictApiRequest(
              DistrictName: "",
              CompanyId: CompanyID.toString(),
              StateCode: stateCode)));
      }
    });
  }

  Future<void> _onTapOfSearchTalukaView(String districtCode) async {
    navigateTo(context, SearchTalukaScreen.routeName,
            arguments: TalukaArguments(districtCode))
        .then((value) {
      if (value != null) {
        _searchTalukaDetails = value;
        edt_TalukaID.text = _searchTalukaDetails.talukaCode.toString();
        edt_Taluka.text = _searchTalukaDetails.talukaName.toString();
        _CustomerBloc
          ..add(TalukaCallEvent(TalukaApiRequest(
              TalukaName: "",
              CompanyId: CompanyID.toString(),
              DistrictCode: districtCode)));
      }
    });
  }

  Future<void> _onTapOfSearchCityView(String talukaCode) async {
    navigateTo(context, SearchCityScreen.routeName,
            arguments: CityArguments(talukaCode))
        .then((value) {
      if (value != null) {
        _searchCityDetails = value;
        edt_QualifiedCityCode.text = _searchCityDetails.cityCode.toString();
        edt_QualifiedCity.text = _searchCityDetails.cityName.toString();
        _CustomerBloc
          ..add(CityCallEvent(CityApiRequest(
              CityName: "",
              CompanyID: CompanyID.toString(),
              StateCode: talukaCode)));
      }
    });
  }

  Widget CustomerName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Customer Name *",
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
            height: CardViewHieght,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: edt_Customer_Name,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        hintText: "Tap to enter Name",
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
                  Icons.person,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget Address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Address",
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
            height: 100,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      minLines: 3,
                      maxLines: null,
                      controller: edt_Address,
                      decoration: InputDecoration(
                        hintText: "Tap to enter address",
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
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget Area() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Area",
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
            height: CardViewHieght,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: edt_Area,
                      onSubmitted: (_) => PicCodeFocus.requestFocus(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        hintText: "Tap to enter Area",
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
                  Icons.house,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _onTapOfSaveCustomerAPICall() async {
    if (edt_Email_Name.text != "") {
      emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(edt_Email_Name.text);
    } else {
      emailValid =
          false; //RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(edt_Email_Name.text);

    }
    await getContacts();

    int nofollowupvalue = 1;

    if (_isSwitched == false) {
      nofollowupvalue = 0;
    } else {
      nofollowupvalue = 1;
    }

    print("CustomerAddEdit : " +
        "CountryCode : " +
        edt_QualifiedCountryCode.text +
        " StateCode : " +
        edt_QualifiedStateCode.text +
        " DistrictCode : " +
        edt_DistrictID.text +
        " TalukaCode : " +
        edt_TalukaID.text +
        " CityCode : " +
        edt_QualifiedCityCode.text +
        " SourceID : " +
        edt_sourceID.text +
        "");

    if (edt_Customer_Name.text != "") {
      if (edt_Category.text != "") {
        if (edt_Customer_Contact1_Name.text != "") {
          if (emailValid == true) {
            if (edt_QualifiedCountry.text != "") {
              if (edt_QualifiedState.text != "") {
                if (edt_QualifiedCity.text != "") {
                  showCommonDialogWithTwoOptions(
                      context, "Are you sure you want to Save this Customer?",
                      negativeButtonTitle: "No",
                      positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
                    Navigator.of(context).pop();

                    /*if (customerID != 0 || customerID != null) {
                    _CustomerBloc.add(CustomerIdToDeleteAllContactCallEvent(
                        customerID,
                        CustomerIdToDeleteAllContactRequest(
                            CompanyId: CompanyID.toString())));
                  }*/

                    _CustomerBloc.add(CustomerAddEditCallEvent(
                        CustomerAddEditApiRequest(
                            customerID: customerID.toString(),
                            customerName: edt_Customer_Name.text,
                            customerType: edt_Category.text,
                            address: edt_Address.text,
                            area: edt_Area.text,
                            pinCode: edt_Pincode.text,
                            gSTNo: edt_GST_Name.text,
                            pANNo: edt_PAN_Name.text,
                            contactNo1: edt_Customer_Contact1_Name.text,
                            contactNo2: edt_Customer_Contact2_Name.text,
                            emailAddress: edt_Email_Name.text,
                            websiteAddress: edt_Website_Name.text,
                            latitude: SharedPrefHelper.instance.getLatitude(),
                            longitude: SharedPrefHelper.instance.getLongitude(),
                            loginUserID: LoginUserID,
                            countryCode: edt_QualifiedCountryCode.text,
                            blockCustomer: nofollowupvalue.toString(),
                            customerSourceID: edt_sourceID.text,
                            companyId: CompanyID.toString(),
                            stateCode: edt_QualifiedStateCode.text,
                            cityCode: edt_QualifiedCityCode.text)));
                  });
                  //_CustomerBloc.add(CustomerContactSaveCallEvent(_contactsList));

                  /*

                _CustomerBloc.add(CustomerContactSaveCallEvent([ContactModel(
                  "0","51506","Satyam1","10032","Satyam1","98256458952","infsatyamo@testapi.com","admin"
                )]));

                 */

                } else {
                  showCommonDialogWithSingleOption(context, "City is required!",
                      positiveButtonTitle: "OK");
                }
              } else {
                showCommonDialogWithSingleOption(context, "State is required!",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(context, "Country is required!",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(context, "Enter valid email !",
                positiveButtonTitle: "OK");
          }
        } else {
          showCommonDialogWithSingleOption(context, "Contact No.1 is required!",
              positiveButtonTitle: "OK");
        }
      } else {
        showCommonDialogWithSingleOption(context, "Category is required!",
            positiveButtonTitle: "OK");
      }
    } else {
      showCommonDialogWithSingleOption(context, "Customer Name is required!",
          positiveButtonTitle: "OK");
    }

    /*  _CustomerBloc
      ..add(CustomerAddEditCallEvent(
          CustomerAddEditApiRequest(customerID: "",customerName: edt_Customer_Name.text,
              customerType:edt_Category.text,address: edt_Address.text,area:edt_Area.text,
              pinCode: edt_Pincode.text,address1: "",area1: "",cityCode1: "",pinCode1: "",gSTNo: edt_GST_Name.text,pANNo: edt_PAN_Name.text,
              cINNo: "",contactNo1: edt_Customer_Contact1_Name.text,contactNo2: edt_Customer_Contact2_Name.text,
            emailAddress: edt_Email_Name.text,websiteAddress: edt_Website_Name.text,latitude: "123.000",longitude: "321.000",birthDate: "",
            anniversaryDate: "",loginUserID: "admin",countryCode: edt_CountryID.text,countryCode1:"",blockCustomer: "1",
              customerSourceID: edt_sourceID.text,districtCode: edt_DistrictID.text,
              talukaCode: edt_TalukaID.text
              ,districtCode1: "",talukaCode1: "",companyId: "8033",stateCode:edt_StateID.text,stateCode1:"",cityCode: edt_CityID.text
          )));*/
  }

  _onCustomerAddEditSuccess(CustomerAddEditEventResponseState state) async {
    String Msg = "";
    print("CustomerResultMsg" +
        " Resp : " +
        state.customerAddEditApiResponse.details[0].column2 +
        " Testttt " +
        state.customerAddEditApiResponse.details[0].column1.toString());

    // if(state.customerAddEditApiResponse.details[0].column2 !="Duplicate Customer Name")
    //  {
    if (_contactsList.length != 0) {
      if (state.customerAddEditApiResponse.details[0].column2 ==
              "Customer Information Added Successfully" ||
          state.customerAddEditApiResponse.details[0].column2 ==
              "Customer Information Updated Successfully") {
        if (customerID != 0 || customerID != null) {
          _CustomerBloc.add(CustomerIdToDeleteAllContactCallEvent(
              customerID,
              CustomerIdToDeleteAllContactRequest(
                  CompanyId: CompanyID.toString())));
        }

        updateCustomerId(
            state.customerAddEditApiResponse.details[0].column1.toString());
        _CustomerBloc.add(CustomerContactSaveCallEvent(_contactsList));
      } else {
        await showCommonDialogWithSingleOption(Globals.context,
            state.customerAddEditApiResponse.details[0].column2,
            positiveButtonTitle: "OK");
        //Navigator.of(context).pop();

        if (state.customerAddEditApiResponse.details[0].column2 ==
                "Customer Information Added Successfully" ||
            state.customerAddEditApiResponse.details[0].column2 ==
                "Customer Information Updated Successfully") {
          navigateTo(context, CustomerListScreen.routeName,
              clearAllStack: true);
        }
      }
    } else {
      /*showCommonDialogWithSingleOption(context, state.customerAddEditApiResponse.details[0].column2 ,
              positiveButtonTitle: "OK", onTapOfPositiveButton: () {
                navigateTo(context, CustomerListScreen.routeName, clearAllStack: true);
              });*/
      //String Msg = _isForUpdate == true ? "Followup Information. Updated Successfully" : "Followup Information. Added Successfully";
      await showCommonDialogWithSingleOption(
          Globals.context, state.customerAddEditApiResponse.details[0].column2,
          positiveButtonTitle: "OK");

      if (state.customerAddEditApiResponse.details[0].column2 ==
              "Customer Information Added Successfully" ||
          state.customerAddEditApiResponse.details[0].column2 ==
              "Customer Information Updated Successfully") {
        navigateTo(context, CustomerListScreen.routeName, clearAllStack: true);
      }
    }
    //  }
    /* else
      {
        await showCommonDialogWithSingleOption(Globals.context, state.customerAddEditApiResponse.details[0].column2+",Customer Contact No is already Exists !",
            positiveButtonTitle: "OK");
        Navigator.of(context).pop();

      }*/
  }

  Widget SwitchNoFollowup() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Active Status",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(children: [
              Container(
                child: Text("InActive",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorGrayDark,
                        fontWeight: FontWeight.w100)),
              ),
              Container(
                child: Container(
                  child: Switch(
                    value: _isSwitched,
                    activeColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    onChanged: (value) {
                      print("_isSwitchedVALUE : $value");
                      setState(() {
                        _isSwitched = value;
                      });
                    },
                  ),
                ),
              ),
              Container(
                child: Text("Active",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorGrayDark,
                        fontWeight: FontWeight.w100)),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void fillData() async {
    customerID = _editModel.customerID;
    edt_Customer_Name.text = _editModel.customerName;
    edt_Category.text = _editModel.customerType;
    edt_Address.text = _editModel.address;
    edt_Area.text = _editModel.area;
    edt_Pincode.text = _editModel.pinCode;
    edt_GST_Name.text = _editModel.gSTNO;
    edt_PAN_Name.text = _editModel.pANNO;
    edt_Customer_Contact1_Name.text = _editModel.contactNo1;
    edt_Customer_Contact2_Name.text = _editModel.contactNo2;
    edt_Email_Name.text = _editModel.emailAddress;
    edt_Website_Name.text = _editModel.websiteAddress;
    edt_sourceID.text = _editModel.customerSourceID.toString();
    edt_Source.text = _editModel.customerSourceName;

    edt_QualifiedCountry.text = _editModel.countryName;
    edt_QualifiedCountryCode.text = _editModel.countryCode;
    edt_QualifiedState.text = _editModel.stateName;
    edt_QualifiedStateCode.text = _editModel.stateCode.toString();
    edt_QualifiedCity.text = _editModel.cityName;
    edt_QualifiedCityCode.text = _editModel.cityCode.toString();
    _searchStateDetails = SearchStateDetails();
    _searchStateDetails.value = _editModel.stateCode;
    _searchStateDetails.label = _editModel.stateName;
    _isSwitched = _editModel.blockCustomer;

    print("BlockCustomer" + _editModel.blockCustomer.toString());
    if (customerID != null) {
      await _onTapOfDeleteALLContact();

      _CustomerBloc.add(CustomerIdToCustomerListCallEvent(
          CustomerIdToCustomerListRequest(
              CustomerID: customerID.toString(),
              CompanyId: CompanyID.toString())));
    }

    /* if (_editModel.blockCustomer == _editModel.blockCustomer) {
      _isSwitched = false;
    } else {
      _isSwitched = true;
    }*/

    /*

    customerID: "",
                          customerName: edt_Customer_Name.text,
                          customerType: edt_Category.text,
                          address: edt_Address.text,
                          area: edt_Area.text,
                          pinCode: edt_Pincode.text,
                          address1: "",
                          area1: "",
                          cityCode1: "",
                          pinCode1: "",
                          gSTNo: edt_GST_Name.text,
                          pANNo: edt_PAN_Name.text,
                          cINNo: "",
                          contactNo1: edt_Customer_Contact1_Name.text,
                          contactNo2: edt_Customer_Contact2_Name.text,
                          emailAddress: edt_Email_Name.text,
                          websiteAddress: edt_Website_Name.text,
                          latitude: "123.000",
                          longitude: "321.000",
                          birthDate: "",
                          anniversaryDate: "",
                          loginUserID: "admin",
                          countryCode: edt_CountryID.text,
                          countryCode1: "",
                          blockCustomer: nofollowupvalue.toString(),
                          customerSourceID: edt_sourceID.text,
                          districtCode: edt_DistrictID.text,
                          talukaCode: edt_TalukaID.text,
                          districtCode1: "",
                          talukaCode1: "",
                          companyId: "8033",
                          stateCode: edt_StateID.text,
                          stateCode1: "",
                          cityCode: edt_CityID.text

    */
  }

  Future<void> getContacts() async {
    _contactsList.clear();
    List<ContactModel> temp = await OfflineDbHelper.getInstance().getContacts();
    _contactsList.addAll(temp);
    setState(() {});
  }

  void getOfflineCustomerCategoryData(
      CustomerCategoryResponse offlineCustomerCategoryData123) {
    for (var i = 0; i < offlineCustomerCategoryData123.details.length; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = offlineCustomerCategoryData123.details[i].categoryName;
      all_name_id.pkID = offlineCustomerCategoryData123.details[i].pkID;
      arr_ALL_Name_ID_For_Category.add(all_name_id);
    }
  }

  Future<void> _onTapOfDeleteALLContact() async {
    await OfflineDbHelper.getInstance().deleteContactTable();
  }

  void _OnCustomerContactSucess(CustomerContactSaveResponseState state) async {
    print("CustomerResultMsg1234" +
        " Resp : " +
        state.contactSaveResponse.details[0].column2 +
        " Testttt " +
        state.contactSaveResponse.details[0].column2.toString());
    navigateTo(context, CustomerListScreen.routeName, clearAllStack: true);

    //Navigator.of(context).pop();
  }

  void updateCustomerId(String ReturnCustomerID) {
    _contactsList.forEach((element) {
      element.CustomerID = ReturnCustomerID;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }

  _OnCustomerIdToFetchContactDetails(
      CustomerIdToCustomerListResponseState state) {
    for (var i = 0;
        i < state.customerIdToContactListResponse.details.length;
        i++) {
      String CustomerID = state
          .customerIdToContactListResponse.details[i].customerID
          .toString();
      String ContactDesignationName =
          state.customerIdToContactListResponse.details[i].desigName;
      String ContactDesigCode1 = state
          .customerIdToContactListResponse.details[i].contactDesigCode1
          .toString();
      String ContactPerson1 =
          state.customerIdToContactListResponse.details[i].contactPerson1;
      String ContactNumber1 =
          state.customerIdToContactListResponse.details[i].contactNumber1;
      String ContactEmail1 =
          state.customerIdToContactListResponse.details[i].contactEmail1;

      _OnTaptoAddContactDetails(CustomerID, ContactDesignationName,
          ContactDesigCode1, ContactPerson1, ContactNumber1, ContactEmail1);
    }
  }

  _OnTaptoAddContactDetails(
      String CustomerID,
      String ContactDesignationName,
      String ContactDesigCode1,
      String ContactPerson1,
      String ContactNumber1,
      String ContactEmail1) async {
    await OfflineDbHelper.getInstance().insertContact(ContactModel(
        "0",
        CustomerID,
        ContactDesignationName,
        ContactDesigCode1,
        "0",
        ContactPerson1,
        ContactNumber1,
        ContactEmail1,
        "admin"));
  }

  _OnCustomerIdToDeleteAllContactResponse(
      CustomerIdToDeleteAllContactResponseState state) {
    print("CustomerDeletteAllContact" +
        " Resp : " +
        state.response.details[0].column2.toString());
  }

  void _OnCustomerCategoryCallEventResponse(
      CustomerCategoryCallEventResponseState state) {
    arr_ALL_Name_ID_For_Category.clear();
    if (state.categoryResponse.details != 0) {
      for (var i = 0; i < state.categoryResponse.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.categoryResponse.details[i].categoryName;
        arr_ALL_Name_ID_For_Category.add(all_name_id);
      }

      if (arr_ALL_Name_ID_For_Category.length != 0) {
        showcustomdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Category,
            context1: context,
            controller: edt_Category,
            lable: "Select Category");
      }
    }
  }

  void _onSourceSuccess(CustomerSourceCallEventResponseState state) {
    arr_ALL_Name_ID_For_Source.clear();
    if (state.sourceResponse.details.length != 0) {
      for (var i = 0; i < state.sourceResponse.details.length; i++) {
        ALL_Name_ID categoryResponse123 = ALL_Name_ID();
        categoryResponse123.Name =
            state.sourceResponse.details[i].inquiryStatus;
        categoryResponse123.pkID = state.sourceResponse.details[i].pkID;
        arr_ALL_Name_ID_For_Source.add(categoryResponse123);
      }

      if (arr_ALL_Name_ID_For_Source.length != 0) {
        showcustomdialogWithID(
            values: arr_ALL_Name_ID_For_Source,
            context1: context,
            controller: edt_Source,
            controllerID: edt_sourceID,
            lable: "Select Source");
      }
    }
  }

  Widget QualifiedCountry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Country *",
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
        InkWell(
            onTap: () => _onTapOfSearchCountryView(_searchCountryDetails == null
                ? ""
                : /*_searchDetails.countryCode*/ ""),
            child: Card(
              elevation: 5,
              color: colorLightGray,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: CardViewHieght,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: edt_QualifiedCountry,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(bottom: 10),
                            contentPadding: EdgeInsets.only(bottom: 10),

                            hintText: "Country",
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
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget QualifiedState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("State * ",
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
        InkWell(
          onTap: () => _onTapOfSearchStateView(_searchCountryDetails == null
              ? ""
              : _searchCountryDetails.countryCode),
          child: Card(
            elevation: 5,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: CardViewHieght,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: edt_QualifiedState,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          hintText: "State",
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
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget QualifiedCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("City * ",
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
        InkWell(
          onTap: () => _onTapOfSearchCityView(
              edt_QualifiedStateCode.text == null
                  ? ""
                  : edt_QualifiedStateCode.text.toString()),
          child: Card(
            elevation: 5,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: CardViewHieght,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: edt_QualifiedCity,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          hintText: "City",
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
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
