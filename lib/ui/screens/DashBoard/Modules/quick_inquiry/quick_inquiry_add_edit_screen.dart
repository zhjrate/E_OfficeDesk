import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/blocs/other/bloc_modules/quick_inquiry/quick_inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_add_edit_api_request.dart';
import 'package:soleoserp/models/api_requests/customer_category_request.dart';
import 'package:soleoserp/models/api_requests/customer_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/inqiory_header_save_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
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
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_country_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_product_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_inquiry/search_quick_inquiry_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
/*
class AddUpdateCustomerScreenArguments {
  // SearchDetails editModel;

  CustomerDetails editModel;

  AddUpdateCustomerScreenArguments(this.editModel);
}*/

class QuickInquiryScreen extends BaseStatefulWidget {
  static const routeName = '/QuickInquiryScreen';

  //ALL_Name_ID all_name_id;
  // final CountryArguments arguments;
  /* final AddUpdateCustomerScreenArguments arguments;

  QuickInquiryScreen(this.arguments);*/

  @override
  _QuickInquiryScreenState createState() => _QuickInquiryScreenState();
}

class _QuickInquiryScreenState extends BaseState<QuickInquiryScreen>
    with BasicScreen, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode;
  FocusNode PicCodeFocus;

  QuickInquiryBloc _CustomerBloc;
  LoginUserDetialsResponse _offlineLoggedInData;
  CompanyDetailsResponse _offlineCompanyData;
  //CustomerCategoryResponse _offlineCustomerCategoryData;
  // CustomerSourceResponse _offlineCustomerSourceData;

  int CompanyID = 0;
  String LoginUserID = "";

  final TextEditingController edt_Customer_Name = TextEditingController();
  final TextEditingController edt_Customer_ID = TextEditingController();

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
  final TextEditingController edt_Country = TextEditingController();
  final TextEditingController edt_CountryID = TextEditingController();

  final TextEditingController edt_State = TextEditingController();
  final TextEditingController edt_StateID = TextEditingController();

  final TextEditingController edt_District = TextEditingController();
  final TextEditingController edt_DistrictID = TextEditingController();

  final TextEditingController edt_Taluka = TextEditingController();
  final TextEditingController edt_TalukaID = TextEditingController();

  final TextEditingController edt_City = TextEditingController();
  final TextEditingController edt_CityID = TextEditingController();

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
  SearchStateDetails _searchStateDetails;
  SearchDistrictDetails _searchDistrictDetails;
  SearchTalukaDetails _searchTalukaDetails;
  SearchCityDetails _searchCityDetails;
  bool _isSwitched;
  bool _isForUpdate;
  CustomerDetails _editModel;
  int customerID = 0;
  List<ContactModel> _contactsList = [];

  String Token;
  bool emailValid;

  ///------------------------------------------------Inquiry Intialized___________________

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_LeadStatus = TextEditingController();
  final TextEditingController edt_LeadStatusID = TextEditingController();
  final TextEditingController edt_Description = TextEditingController();
  final TextEditingController edt_FollowupNotes = TextEditingController();
  final TextEditingController edt_NextFollowupDate = TextEditingController();
  final TextEditingController edt_ReverseNextFollowupDate =
      TextEditingController();
  final TextEditingController edt_PreferedTime = TextEditingController();

  List<InquiryProductModel> _inquiryProductList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];

  bool FollowupExist = false;

  String Latitude;
  String Longitude;
  bool is_LocationService_Permission;
  final Geolocator geolocator123 = Geolocator()..forceAndroidLocationManager;
  Location location = new Location();
  double CardViewHeight = 45.00;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    emailValid = false;
    checkPermissionStatus();
    screenStatusBarColor = colorPrimary;
    _CustomerBloc = QuickInquiryBloc(baseBloc);
    myFocusNode = FocusNode();
    PicCodeFocus = FocusNode();
    FetchInquiryPriorityDetails();

    edt_Source.addListener(() {
      myFocusNode.requestFocus();
    });

    edt_NextFollowupDate.text = selectedDate.day.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.year.toString();
    edt_ReverseNextFollowupDate.text = selectedDate.year.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.day.toString();

    TimeOfDay selectedTime1234 = TimeOfDay.now();
    String AM_PM123 =
        selectedTime1234.periodOffset.toString() == "12" ? "PM" : "AM";
    String beforZeroHour123 = selectedTime1234.hourOfPeriod <= 9
        ? "0" + selectedTime1234.hourOfPeriod.toString()
        : selectedTime1234.hourOfPeriod.toString();
    String beforZerominute123 = selectedTime1234.minute <= 9
        ? "0" + selectedTime1234.minute.toString()
        : selectedTime1234.minute.toString();
    edt_PreferedTime.text =
        beforZeroHour123 + ":" + beforZerominute123 + " " + AM_PM123;
    //clearInquiryProductList();
    _onTapOfDeleteALLProduct();
    edt_Country.text = "India";
    edt_CountryID.text = "IND";
    edt_State.text = _offlineLoggedInData.details[0].StateName;
    edt_StateID.text = _offlineLoggedInData.details[0].stateCode.toString();
    edt_City.text = _offlineLoggedInData.details[0].CityName;
    edt_CityID.text = _offlineLoggedInData.details[0].CityCode.toString();
  }

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
      child: BlocConsumer<QuickInquiryBloc, QuickInquiryStates>(
        builder: (BuildContext context, QuickInquiryStates state) {
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
          if (state is SearchCustomerListByNumberCallResponseState) {
            _onInquiryListByNumberCallSuccess(state);
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
          } else if (currentState
              is SearchCustomerListByNumberCallResponseState) {
            return true;
          }

          return false;
        },
        listener: (BuildContext context, QuickInquiryStates state) {
          //handle states

          if (state is StateListEventResponseState) {
            _onStateListSuccess(state);
          }
          if (state is CustomerAddEditEventResponseState) {
            _onCustomerAddEditSuccess(state);
          }
          if (state is InquiryHeaderSaveResponseState) {
            _OnHeaderSuccessResponse(state);
          }
          if (state is InquiryProductSaveResponseState) {
            _OnInquiryProductSaveResponse(state);
          }

          if (state is CustomerCategoryCallEventResponseState) {
            _OnCustomerCategoryCallEventResponse(state);
          }

          if (state is CustomerSourceCallEventResponseState) {
            _onSourceSuccess(state);
          }
          if (state is InquiryLeadStatusListCallResponseState) {
            _onLeadStatusListTypeCallSuccess(state);
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
          } else if (currentState is CustomerCategoryCallEventResponseState) {
            return true;
          } else if (currentState is CustomerSourceCallEventResponseState) {
            return true;
          } else if (currentState is InquiryLeadStatusListCallResponseState) {
            return true;
          } else if (currentState is InquiryHeaderSaveResponseState) {
            return true;
          } else if (currentState is InquiryProductSaveResponseState) {
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
          title: Text('Quick Inquiry'),
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
                    CustomDropDown1("Category", "Lead Source *",
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
                    CustomDropDownCountry("Country", "State",
                        enable1: false,
                        enable2: false,
                        icon: Icon(Icons.arrow_drop_down),
                        controllerForLeft: edt_Country,
                        controllerForRight: edt_State,
                        Custom_values1: _listFilteredCountry,
                        Custom_values2: _listFilteredState),
                    SizedBox(height: Constant.SIZEBOXHEIGHT),
                    CustomDropDown("City", "PinCode",
                        enable1: false,
                        enable2: true,
                        icon: Icon(Icons.pin_drop_sharp),
                        controllerForLeft: edt_City,
                        controllerForRight: edt_Pincode),
                    SizedBox(
                      height: Constant.SIZEBOXHEIGHT,
                    ),
                    Container(
                      child: Text(
                        "~~~ Inquiry Details ~~~",
                        style: TextStyle(
                            color: colorPrimary, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: Constant.SIZEBOXHEIGHT,
                    ),
                    CustomDropDownPriority("Priority",
                        enable1: false,
                        title: "Lead Priority ",
                        hintTextvalue: "Tap to Select Lead Priority",
                        icon: Icon(Icons.arrow_drop_down),
                        controllerForLeft: edt_Priority,
                        Custom_values1: arr_ALL_Name_ID_For_Folowup_Priority),
                    SizedBox(
                      width: 20,
                      height: 15,
                    ),
                    showcustomdialogWithIDLead("Lead Status",
                        enable1: false,
                        title: "Lead Status",
                        hintTextvalue: "Tap to Select Lead Status",
                        icon: Icon(Icons.arrow_drop_down),
                        controllerForLeft: edt_LeadStatus,
                        controllerpkID: edt_LeadStatusID,
                        Custom_values1: arr_ALL_Name_ID_For_LeadStatus),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text("Description * ",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                              fontWeight: FontWeight
                                  .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7, right: 7, top: 10),
                      child: TextFormField(
                        controller: edt_Description,
                        minLines: 2,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: 'Tap to Enter Description',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      height: 15,
                    ),
                    FollowupFields(),
                    SizedBox(
                      width: 20,
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      child: getCommonButton(baseTheme, () {
                        //  _onTapOfDeleteALLContact();
                        //  navigateTo(context, InquiryProductListScreen.routeName);
                        //print("INWWWE" + InquiryNo.toString());
                        navigateTo(context, InquiryProductListScreen.routeName,
                            arguments: AddProductListArgument(""));
                      }, "Add Product + ",
                          width: 600, backGroundColor: Color(0xff4d62dc)),
                    ),
                    SizedBox(
                      width: 20,
                      height: 15,
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
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget FollowupFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Followup Notes *",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 7, right: 7, top: 10),
          child: TextFormField(
            controller: edt_FollowupNotes,
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Enter Notes',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
          ),
        ),
        SizedBox(
          width: 20,
          height: 15,
        ),
        InkWell(
          onTap: () {
            _selectNextFollowupDate(context, edt_NextFollowupDate);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text("Next FollowUp Date *",
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
                        child: Text(
                          edt_NextFollowupDate.text == null ||
                                  edt_NextFollowupDate.text == ""
                              ? "DD-MM-YYYY"
                              : edt_NextFollowupDate.text,
                          style: baseTheme.textTheme.headline3.copyWith(
                              color: edt_NextFollowupDate.text == null ||
                                      edt_NextFollowupDate.text == ""
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
          width: 20,
          height: 15,
        ),
        InkWell(
          onTap: () {
            _selectTime(context, edt_PreferedTime);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text("Preferred Time",
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
                        child: Text(
                          edt_PreferedTime.text == null ||
                                  edt_PreferedTime.text == ""
                              ? "HH:MM:SS"
                              : edt_PreferedTime.text,
                          style: baseTheme.textTheme.headline3.copyWith(
                              color: edt_PreferedTime.text == null ||
                                      edt_PreferedTime.text == ""
                                  ? colorGrayDark
                                  : colorBlack),
                        ),
                      ),
                      Icon(
                        Icons.watch_later_outlined,
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
          width: 20,
          height: 15,
        ),
      ],
    );
  }

  Future<void> _selectNextFollowupDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_NextFollowupDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseNextFollowupDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;

        String AM_PM =
            selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = selectedTime.hourOfPeriod <= 9
            ? "0" + selectedTime.hourOfPeriod.toString()
            : selectedTime.hourOfPeriod.toString();
        String beforZerominute = selectedTime.minute <= 9
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        edt_PreferedTime.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
      });
  }

  FetchInquiryPriorityDetails() {
    if (_offlineLoggedInData.details[0].serialKey.toLowerCase() ==
        "dol2-6uh7-ph03-in5h") {
      arr_ALL_Name_ID_For_Folowup_Priority.clear();
      for (var i = 0; i < 3; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();

        if (i == 0) {
          all_name_id.Name = "Hot";
        } else if (i == 1) {
          all_name_id.Name = "Cold";
        } else if (i == 2) {
          all_name_id.Name = "Warm";
        }
        arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
      }
    } else {
      arr_ALL_Name_ID_For_Folowup_Priority.clear();
      for (var i = 0; i < 3; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();

        if (i == 0) {
          all_name_id.Name = "High";
        } else if (i == 1) {
          all_name_id.Name = "Medium";
        } else if (i == 2) {
          all_name_id.Name = "Low";
        }
        arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
      }
    }
  }

  Future<void> _onTapOfLogOut() async {
    //await SharedPrefHelper.instance.clear();
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    // CommonUtils.showToast(context, "Back presses");
    // Navigator.defaultRouteName.
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
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
            onTap: () => _CustomerBloc.add(CustomerSourceCallEvent(
                CustomerSourceRequest(
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
                  child: Text("Lead Source *",
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
                              onChanged: (value) => {
                                    myFocusNode.requestFocus()
                                  }, //myFocusNode.requestFocus(),
                              controller: controllerForRight,
                              enabled: false,
                              decoration: InputDecoration(
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

  Widget CustomDropDownPriority(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
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

  Widget showcustomdialogWithIDLead(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap:
                () => /*showcustomdialogWithID(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                controllerID: controllerpkID,
                lable: "Select $Category")*/
                    CreateDialogDropdown(Category),
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

  CreateDialogDropdown(String category) {
    if (category == "Lead Status") {
      _CustomerBloc.add(InquiryLeadStatusTypeListByNameCallEvent(
          FollowupInquiryStatusTypeListRequest(
              CompanyId: CompanyID.toString(),
              pkID: "",
              StatusCategory: "Inquiry",
              LoginUserID: LoginUserID,
              SearchKey: "")));
    } else {
      _CustomerBloc.add(CustomerSourceCallEvent(CustomerSourceRequest(
          pkID: "0",
          StatusCategory: "InquirySource",
          companyId: CompanyID,
          LoginUserID: LoginUserID,
          SearchKey: "")));
    }
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
                              maxLength: 6,
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
                height: 60,
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
                height: 60,
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
                height: 60,
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
                        ), // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                        onChanged: (value) {
                          if (value.length == 15) {
                            edt_PAN_Name.text =
                                value.substring(2, value.length - 3);
                          } else {
                            edt_PAN_Name.text = "";
                          }
                        },
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
                height: 60,
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
                height: 60,
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
                height: 60,
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

  void filterList(String query) {
    refreshList(() {
      _listFilteredCountry.clear();
      _listFilteredCountry.addAll(arr_ALL_Name_ID_For_Country
          .where((element) =>
              element.Name.toLowerCase().contains(query.toLowerCase()))
          .toList());
      print("_listFiltered.data.length - ${_listFilteredCountry.length}");
      print(
          "_listResponse.data.length - ${arr_ALL_Name_ID_For_Country.length}");
    });
    //baseBloc.refreshScreen();
  }

  Future<void> _onTapOfSearchCountryView(String sw) async {
    navigateTo(context, SearchCountryScreen.routeName,
            arguments: CountryArguments(sw))
        .then((value) {
      if (value != null) {
        _searchDetails = SearchDetails();
        _searchDetails = value;
        print("CountryName IS From SearchList" + _searchDetails.countryCode);
        edt_CountryID.text = _searchDetails.countryCode;
        edt_Country.text = _searchDetails.countryName;
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
        edt_StateID.text = _searchStateDetails.value.toString();
        edt_State.text = _searchStateDetails.label.toString();
        _CustomerBloc.add(StateCallEvent(StateListRequest(
            CountryCode: sw1,
            CompanyId: CompanyID.toString(),
            word: "",
            Search: "1")));
      }
    });
  }

  Future<void> _onTapOfSearchCityView(String talukaCode) async {
    navigateTo(context, SearchCityScreen.routeName,
            arguments: CityArguments(talukaCode))
        .then((value) {
      if (value != null) {
        _searchCityDetails = value;
        edt_CityID.text = _searchCityDetails.cityCode.toString();
        edt_City.text = _searchCityDetails.cityName.toString();
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
        /*InkWell(
          onTap: ()=> _onTapOfSearchCompanyView(),
          child:*/
        Card(
          elevation: 5,
          color: colorLightGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      enabled: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: edt_Customer_Name,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 10),

                        hintText: "Tap to enter name",
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
        /*  )*/
      ],
    );
  }

  Future<void> _onTapOfSearchCompanyView() async {
    navigateTo(context, SearchCustomerQuickInquiryScreen.routeName,
            arguments: SearchCustomerQuickInquiryScreenArguments(
                edt_Customer_Name.text))
        .then((value) {
      if (value != null) {
        ALL_Name_ID searchDetails123 = new ALL_Name_ID();
        searchDetails123 = value;
        edt_Customer_Name.text = searchDetails123.Name.toString();
        //edt_PrimaryContact.text=searchDetails123.Name1.toString();
        //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

        if (searchDetails123.pkID != 0) {
          _CustomerBloc.add(SearchCustomerListByNumberCallEvent(
              CustomerSearchByIdRequest(
                  companyId: CompanyID,
                  loginUserID: LoginUserID,
                  CustomerID: searchDetails123.pkID.toString())));
        }
      }
    });
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
            height: 60,
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
    await getInquiryProductDetails();

    int nofollowupvalue = 1;
    emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(edt_Email_Name.text);
    if (_isSwitched == false) {
      nofollowupvalue = 0;
    } else {
      nofollowupvalue = 1;
    }

    print("CustomerAddEdit : " +
        "CountryCode : " +
        edt_CountryID.text +
        " StateCode : " +
        edt_StateID.text +
        " DistrictCode : " +
        edt_DistrictID.text +
        " TalukaCode : " +
        edt_TalukaID.text +
        " CityCode : " +
        edt_CityID.text +
        " SourceID : " +
        edt_sourceID.text +
        "");

    if (edt_Customer_Name.text != "") {
      if (edt_Category.text != "") {
        if (edt_Customer_Contact1_Name.text != "") {
          if (emailValid == true ||
              edt_Email_Name.text.toString().trim() == "") {
            if (edt_GST_Name.text.toString().trim() == "" ||
                edt_GST_Name.text.toString().trim().length == 15) {
              if (edt_Country.text != "") {
                if (edt_State.text != "") {
                  if (edt_City.text != "") {
                    if (edt_Pincode.text.toString().trim() == "" ||
                        edt_Pincode.text.toString().trim().length == 6) {
                      if (edt_Source.text != '') {
                        if (edt_Description.text != '') {
                          if (_inquiryProductList.length != 0) {
                            if (edt_FollowupNotes.text != "") {
                              FollowupExist = true;
                              showCommonDialogWithTwoOptions(context,
                                  "Are you sure you want to Save this Customer?",
                                  negativeButtonTitle: "No",
                                  positiveButtonTitle: "Yes",
                                  onTapOfPositiveButton: () {
                                Navigator.of(context).pop();
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
                                        contactNo1:
                                            edt_Customer_Contact1_Name.text,
                                        contactNo2:
                                            edt_Customer_Contact2_Name.text,
                                        emailAddress: edt_Email_Name.text,
                                        websiteAddress: edt_Website_Name.text,
                                        latitude: Latitude,
                                        longitude: Longitude,
                                        loginUserID: LoginUserID,
                                        countryCode: edt_CountryID.text,
                                        blockCustomer:
                                            nofollowupvalue.toString(),
                                        customerSourceID: edt_sourceID.text,
                                        companyId: CompanyID.toString(),
                                        stateCode: edt_StateID.text,
                                        cityCode: edt_CityID.text)));
                              });
                            } else {
                              FollowupExist = false;

                              showCommonDialogWithTwoOptions(context,
                                  "Are you sure you want to Save Quick Inquiry ?",
                                  negativeButtonTitle: "No",
                                  positiveButtonTitle: "Yes",
                                  onTapOfPositiveButton: () {
                                Navigator.of(context).pop();
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
                                        contactNo1:
                                            edt_Customer_Contact1_Name.text,
                                        contactNo2:
                                            edt_Customer_Contact2_Name.text,
                                        emailAddress: edt_Email_Name.text,
                                        websiteAddress: edt_Website_Name.text,
                                        latitude: Latitude,
                                        longitude: Longitude,
                                        loginUserID: LoginUserID,
                                        countryCode: edt_CountryID.text,
                                        blockCustomer:
                                            nofollowupvalue.toString(),
                                        customerSourceID: edt_sourceID.text,
                                        companyId: CompanyID.toString(),
                                        stateCode: edt_StateID.text,
                                        cityCode: edt_CityID.text)));
                              });
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "Product Details are required!",
                                positiveButtonTitle: "OK");
                          }
                        } else {
                          showCommonDialogWithSingleOption(
                              context, "Description is required!",
                              positiveButtonTitle: "OK");
                        }
                      } else {
                        showCommonDialogWithSingleOption(
                            context, "Lead Source is required!",
                            positiveButtonTitle: "OK");
                      }
                    } else {
                      showCommonDialogWithSingleOption(
                          context, "PinCode is not Valid !",
                          positiveButtonTitle: "OK");
                    }
                  } else {
                    showCommonDialogWithSingleOption(
                        context, "City is required!",
                        positiveButtonTitle: "OK");
                  }
                } else {
                  showCommonDialogWithSingleOption(
                      context, "State is required!",
                      positiveButtonTitle: "OK");
                }
              } else {
                showCommonDialogWithSingleOption(
                    context, "Country is required!",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(context, "GSTNo. is not Valid !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(context, "Email is not Valid !",
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

  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<InquiryProductModel> temp =
        await OfflineDbHelper.getInstance().getInquiryProduct();
    _inquiryProductList.addAll(temp);
    setState(() {});
  }

  _onCustomerAddEditSuccess(CustomerAddEditEventResponseState state) async {
    DateTime selectedDate123 = DateTime.now();
    String CurrentDate = selectedDate123.year.toString() +
        "-" +
        selectedDate123.month.toString() +
        "-" +
        selectedDate123.day.toString();
    String Msg = "";
    print("CustomerResultMsg" +
        " Resp : " +
        state.customerAddEditApiResponse.details[0].column2 +
        " Testttt " +
        state.customerAddEditApiResponse.details[0].column1.toString());

    if (state.customerAddEditApiResponse.details[0].column2 ==
        "Customer Information Added Successfully") {
      /*  await showCommonDialogWithSingleOption(Globals.context, state.customerAddEditApiResponse.details[0].column2,
            positiveButtonTitle: "OK");
        Navigator.of(context).pop();*/
      //CustomerID = state.customerAddEditApiResponse.details[0].column1
      if (FollowupExist == false) {
        _CustomerBloc.add(InquiryHeaderSaveNameCallEvent(
            0,
            InquiryHeaderSaveRequest(
              pkID: "0",
              FollowupDate: "",
              CustomerID: state.customerAddEditApiResponse.details[0].column1
                  .toString(),
              InquiryNo: "",
              InquiryDate: CurrentDate,
              MeetingNotes: edt_Description.text.toString(),
              InquirySource: edt_Source.text
                  .toString(), //edt_LeadSourceID.text.toString(),
              ReferenceName: "",
              FollowupNotes: "",
              InquiryStatusID: edt_LeadStatusID.text.toString(),
              LoginUserID: LoginUserID,
              Longitude: Longitude,
              Latitude: Latitude,
              FollowupTypeID: "5",
              PreferredTime: edt_PreferedTime.text.toString(),
              Priority: edt_Priority.text.toString(),
              CompanyId: CompanyID.toString(),
            )));
      } else {
        _CustomerBloc.add(InquiryHeaderSaveNameCallEvent(
            0,
            InquiryHeaderSaveRequest(
              pkID: "0",
              FollowupDate: edt_ReverseNextFollowupDate.text.toString(),
              CustomerID: state.customerAddEditApiResponse.details[0].column1
                  .toString(),
              InquiryNo: "",
              InquiryDate: CurrentDate,
              MeetingNotes: edt_Description.text.toString(),
              InquirySource: edt_Source.text
                  .toString(), //edt_LeadSourceID.text.toString(),
              ReferenceName: "",
              FollowupNotes: edt_FollowupNotes.text.toString(),
              InquiryStatusID: edt_LeadStatusID.text.toString(),
              LoginUserID: LoginUserID,
              Longitude: Longitude,
              Latitude: Latitude,
              FollowupTypeID: "5",
              PreferredTime: edt_PreferedTime.text.toString(),
              Priority: edt_Priority.text.toString(),
              CompanyId: CompanyID.toString(),
            )));
      }
    } else {
      await showCommonDialogWithSingleOption(
          Globals.context, state.customerAddEditApiResponse.details[0].column2,
          positiveButtonTitle: "OK");
      // Navigator.of(context).pop();

    }
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
    edt_Country.text = _editModel.countryName;
    edt_CountryID.text = _editModel.countryCode;
    edt_State.text = _editModel.stateName;
    edt_StateID.text = _editModel.stateCode.toString();
    edt_City.text = _editModel.cityName;
    edt_CityID.text = _editModel.cityCode.toString();
    _searchStateDetails = SearchStateDetails();
    _searchStateDetails.value = _editModel.stateCode;
    _searchStateDetails.label = _editModel.stateName;
    _isSwitched = _editModel.blockCustomer;

    print("BlockCustomer" + _editModel.blockCustomer.toString());
  }

  void _OnCustomerCategoryCallEventResponse(
      CustomerCategoryCallEventResponseState state) {
    arr_ALL_Name_ID_For_Category.clear();
    if (state.categoryResponse.details != 0) {
      for (var i = 0; i < state.categoryResponse.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.categoryResponse.details[i].categoryName;
        all_name_id.Name1 = state.categoryResponse.details[i].categoryName;
        all_name_id.pkID = state.categoryResponse.details[i].pkID;
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

  void _onLeadStatusListTypeCallSuccess(
      InquiryLeadStatusListCallResponseState state) {
    if (state.inquiryStatusListResponse.details.length != 0) {
      arr_ALL_Name_ID_For_LeadStatus.clear();
      for (var i = 0; i < state.inquiryStatusListResponse.details.length; i++) {
        print("InquiryStatus : " +
            state.inquiryStatusListResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.inquiryStatusListResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.inquiryStatusListResponse.details[i].pkID;
        arr_ALL_Name_ID_For_LeadStatus.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_LeadStatus,
          context1: context,
          controller: edt_LeadStatus,
          controllerID: edt_LeadStatusID,
          lable: "Select Status");
    }
  }

  void clearInquiryProductList() async {
    await _onTapOfDeleteALLProduct();
  }

  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLInquiryProduct();
  }

  void _OnHeaderSuccessResponse(InquiryHeaderSaveResponseState state) {
    print("InquiryHeaderResponse" +
        state.inquiryHeaderSaveResponse.details[0].column2 +
        "\n" +
        state.inquiryHeaderSaveResponse.details[0].column3);

    updateRetrunInquiryNoToDB(
        state.inquiryHeaderSaveResponse.details[0].column3);
    _CustomerBloc.add(InquiryProductSaveCallEvent(_inquiryProductList));
  }

  void updateRetrunInquiryNoToDB(String ReturnInquiryNo) {
    _inquiryProductList.forEach((element) {
      element.InquiryNo = ReturnInquiryNo;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }

  void _OnInquiryProductSaveResponse(
      InquiryProductSaveResponseState state) async {
    print("InquiryHeaderResponse " +
        state.inquiryProductSaveResponse.details[0].column2);
    String Msg =
        "Quick Inquiry Added Successfully !"; //_isForUpdate == true ? "Inquiry Updated Successfully" : "Inquiry Added Successfully";
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  void checkPermissionStatus() async {
    bool granted = await Permission.location.isGranted;
    bool Denied = await Permission.location.isDenied;
    bool PermanentlyDenied = await Permission.location.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();
      is_LocationService_Permission = false;
/*      showCommonDialogWithSingleOption(context,
          "Location permission is required , You have to click on OK button to Allow the location access !",
          positiveButtonTitle: "OK", onTapOfPositiveButton: () async {
        await openAppSettings();
        Navigator.of(context).pop();
      });*/
      await Permission.storage.request();

      // await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (PermanentlyDenied == true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_LocationService_Permission = false;
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.
      is_LocationService_Permission = true;
      _getCurrentLocation();

      /*if (serviceLocation == true) {
        // Use location.
        _serviceEnabled=false;

         location.requestService();


      }
      else{
        _serviceEnabled=true;
        _getCurrentLocation();



      }*/
    }
  }

  _getCurrentLocation() {
    geolocator123
        .getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best)
        .then((Position position) async {
      Longitude = position.longitude.toString();
      Latitude = position.latitude.toString();
    }).catchError((e) {
      print(e);
    });

    location.onLocationChanged.listen((LocationData currentLocation) async {
      // Use current location
      print("OnLocationChange" +
          " Location : " +
          currentLocation.latitude.toString());
      //  placemarks = await placemarkFromCoordinates(currentLocation.latitude,currentLocation.longitude);
      // final coordinates = new Coordinates(currentLocation.latitude,currentLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;
      //  print("${first.featureName} : ${first.addressLine}");
      Latitude = currentLocation.latitude.toString();
      Longitude = currentLocation.longitude.toString();

      //  Address = "${first.featureName} : ${first.addressLine}";
    });

    // _FollowupBloc.add(LocationAddressCallEvent(LocationAddressRequest(key:"",latlng:Latitude+","+Longitude)));
  }

  void _onInquiryListByNumberCallSuccess(
      SearchCustomerListByNumberCallResponseState state) {
    for (int i = 0; i < state.response.details.length; i++) {
      print("MobileNo" +
          " MobileNo Is : " +
          state.response.details[i].contactNo1);
      customerID = state.response.details[i].customerID;
      edt_Category.text = state.response.details[i].customerType;
      edt_Source.text = state.response.details[i].customerSourceName;
      edt_StateID.text = state.response.details[i].customerSourceID.toString();
      edt_Customer_Contact1_Name.text = state.response.details[i].contactNo1;
      edt_Customer_Contact2_Name.text = state.response.details[i].contactNo2;
      edt_Email_Name.text = state.response.details[i].emailAddress;
      edt_GST_Name.text = state.response.details[i].gSTNO;
    }
  }
}
