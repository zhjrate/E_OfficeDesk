import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/packing_checklist/packing_checklist_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/delete_all_packing_assambly_request.dart';
import 'package:soleoserp/models/api_requests/out_word_no_list_request.dart';
import 'package:soleoserp/models/api_requests/packing_assambly_edit_mode_request.dart';
import 'package:soleoserp/models/api_requests/packing_productassambly_list_request.dart';
import 'package:soleoserp/models/api_requests/packing_save_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response_for_packing_checking.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/packing_checking_list.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/models/common/packingProductAssamblyTable.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_country_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_asambly_crud/packing_assambly_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_checklist_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/region/country_list_for_packing.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class AddUpdatePackingScreenArguments {
  PackingChecklistDetails editModel;

  AddUpdatePackingScreenArguments(this.editModel);
}

class PackingChecklistAddScreen extends BaseStatefulWidget {
  static const routeName = '/PackingChecklistAddScreen';
  final AddUpdatePackingScreenArguments arguments;
  PackingChecklistAddScreen(this.arguments);

  @override
  _PackingChecklistAddScreenState createState() => _PackingChecklistAddScreenState();
}

class _PackingChecklistAddScreenState
    extends BaseState<PackingChecklistAddScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  PackingChecklistBloc packingChecklistBloc;
  PackingChecklistDetails _editModel;


  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  //ExpenseTypeResponse _offlineExpenseType;

  int CompanyID = 0;
  String LoginUserID = "";
  double CardViewHeight = 45.00;

  int SavedPKID=0;

  final TextEditingController edt_PackingNo = TextEditingController();
  final TextEditingController edt_Packing_List_Date = TextEditingController();
  final TextEditingController edt_Packing_List_Date_Reverse = TextEditingController();

  final TextEditingController edt_Machine_Finalize_date = TextEditingController();
  final TextEditingController edt_Machine_Finalize_dateReverse = TextEditingController();

  final TextEditingController edt_Machine_Dispatch_date = TextEditingController();
  final TextEditingController edt_Machine_Dispatch_dateReverse = TextEditingController();

  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerpkID = TextEditingController();


  final TextEditingController edt_Country_Name = TextEditingController();
  final TextEditingController edt_Country_Code = TextEditingController();
  final TextEditingController edt_State_Name = TextEditingController();
  final TextEditingController edt_State_ID = TextEditingController();
  final TextEditingController edt_City_Name = TextEditingController();
  final TextEditingController edt_City_ID = TextEditingController();

  final TextEditingController edt_PinCode = TextEditingController();

  final TextEditingController edt_S_O_No= TextEditingController();
  final TextEditingController edt_Address = TextEditingController();
  final TextEditingController edt_Area = TextEditingController();
  final TextEditingController edt_Application = TextEditingController();
  final TextEditingController edt_FinishProductID = TextEditingController();

  final TextEditingController edt_FinishProductName = TextEditingController();
  final TextEditingController edt_EmployeeName = TextEditingController();
  final TextEditingController edt_EmployeeID = TextEditingController();


  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];

  DateTime selectedDate = DateTime.now();
  bool _isForUpdate = false;
  SearchDetails _searchInquiryListResponse;

  SearchCountryDetails _searchCountryDetails;
  SearchStateDetails _searchStateDetails;
  SearchCityDetails _searchCityDetails;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Country = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_State = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_District = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_OutWordList = [];

  List<ALL_Name_ID> _listFilteredCountry = [];

  List<ALL_Name_ID> _listFilteredState = [];

  List<ALL_Name_ID> _listFilteredDistrict = [];
  List<ALL_Name_ID> _listFilteredTaluka = [];
  List<ALL_Name_ID> _listFilteredCity = [];

  ALL_EmployeeList_Response _offlineFollowerEmployeeListData;
  List<PackingProductAssamblyTable> _inquiryProductList = [];


  @override
  void initState() {
    super.initState();

    packingChecklistBloc = PackingChecklistBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData = SharedPrefHelper.instance.getALLEmployeeList();
    _onFollowerEmployeeListByStatusCallSuccess(_offlineFollowerEmployeeListData);
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    edt_FinishProductName.text ="";


    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      _searchStateDetails = SearchStateDetails();

      edt_Packing_List_Date.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_Packing_List_Date_Reverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      edt_Machine_Finalize_date.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_Machine_Finalize_dateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
      edt_Machine_Dispatch_date.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_Machine_Dispatch_dateReverse.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      edt_Country_Name.text = "India";
      edt_Country_Code.text = "IND";
      _searchStateDetails.value = _offlineLoggedInData.details[0].stateCode;
      edt_State_Name.text = _offlineLoggedInData.details[0].StateName;
      edt_State_ID.text = _offlineLoggedInData.details[0].stateCode.toString();

      edt_City_Name.text = _offlineLoggedInData.details[0].CityName;
      edt_City_ID.text = _offlineLoggedInData.details[0].CityCode.toString();
      edt_EmployeeName.text = "";
      edt_EmployeeID.text ="0";

    }

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      packingChecklistBloc,
      /*..add(ExpenseTypeByNameCallEvent(
            ExpenseTypeAPIRequest(CompanyId: CompanyID.toString()))),*/
      /* ..add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
            CompanyId: "8033", pkID: "", StatusCategory: "FollowUp"))),*/

      child: BlocConsumer<PackingChecklistBloc, PackingChecklistListState>(
        builder: (BuildContext context, PackingChecklistListState state) {
          /*  if(state is LeaveRequestTypeResponseState)
          {
            _onLeaveRequestTypeSuccessResponse(state);
          }
          if(state is LeaveRequestEmployeeListResponseState)
          {
            _onFollowerEmployeeListByStatusCallSuccess(state);
          }*/
          if (state is CountryListEventResponseState) {
            _onCountryListSuccess(state);
          }
          if (state is StateListEventResponseState) {
            _onStateListSuccess(state);
          }

          if (state is CityListEventResponseState) {
            _onCityListSuccess(state);
          }

          if (state is PackingAssamblyEditModeResponseState) {
            _OnPackingAssamblyEditMode(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is CountryListEventResponseState) {
            return true;
          } else if (currentState is StateListEventResponseState) {
            return true;
          } else if (currentState is CityListEventResponseState) {
            return true;
          } else if (currentState is PackingAssamblyEditModeResponseState) {
            return true;
          }


          return false;
        },
        listener: (BuildContext context, PackingChecklistListState state) {

          if (state is OutWordResponseState) {
            _onOutWordResponse(state);
          }

          if (state is PackingProductAssamblyListResponseState) {
            _onpackingAssamblyResponse(state);
          }
          if (state is PackingSaveResponseState) {
            _onHeaderSaveResponse(state);
          }
          if(state is PackingAssamblySaveResponseState)
            {
              _onPackingAssamblySaveResponse(state);
            }

          if(state is DeleteAllPackingAssamblyResponseState)
          {
            _OnDeleteAllAssamblyResponse(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is OutWordResponseState ||
              currentState is PackingProductAssamblyListResponseState ||
              currentState is PackingSaveResponseState ||
              currentState is PackingAssamblySaveResponseState ||
              currentState is DeleteAllPackingAssamblyResponseState

          ) {
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
        title: Text('Packing Checking List Details'),
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
                navigateTo(context, PackingChecklistScreen.routeName,
                    clearAllStack: true);
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
                      Row(
                        children: [
                          Expanded(flex: 1, child: PackingNo()),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(flex: 1, child: PackingListDate()),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: Machine_Finalize_date()),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(flex: 1, child: Machine_Dispatch_date()),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      _buildSearchView(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      CustomDropDown1("SO No.",
                          enable1: true,
                          title: "SO No. ",
                          hintTextvalue: "Tap to Select SO No.",
                          icon: Icon(Icons.arrow_drop_down),
                          controllerForLeft: edt_S_O_No,
                          controllerforFinishProduct : edt_FinishProductName,
                          Custom_values1:
                          arr_ALL_Name_ID_For_OutWordList),
                      _isForUpdate==true? Column(children: [
                        SizedBox(
                          width: 20,
                          height: 10,
                        ),
                        CustomDropDownEmployeeList("Select Employee.",
                            enable1: true,
                            title: "Select Employee. ",
                            hintTextvalue: "Tap to Select Employee.",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_EmployeeName,
                            controllerforFinishProduct : edt_EmployeeID,
                            Custom_values1:
                            arr_ALL_Name_ID_For_Folowup_EmplyeeList),
                      ],) : Container(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Application(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Address(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Area(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: QualifiedCountry()),
                          Expanded(flex: 1, child: QualifiedState()),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(flex: 1, child: QualifiedCity()),
                          Expanded(flex: 1, child: QualifiedPinCode()),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                    // Text(edt_FinishProductName.text,style: TextStyle(fontSize: 12,color: colorPrimary),),
                      ProductName(),
                      SizedBox(
                        width: 20,
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.bottomCenter,
                        child: getCommonButton(baseTheme, () async {
                          //  _onTapOfDeleteALLContact();
                          //  navigateTo(context, InquiryProductListScreen.routeName);
                          print("ProductNamen" + "Product Name : "+  edt_FinishProductName.text);

                          if(edt_S_O_No.text!="")
                            {
                              //await OfflineDbHelper.getInstance().deleteALLPackingProductAssambly();

                              if(_isForUpdate==true)
                              {
                                navigateTo(
                                    context, PackingAssamblyListScreen.routeName,
                                    arguments: AddPackingAssamblyListArgument(edt_FinishProductID.text));
                              }
                              else
                                {
                                   navigateTo(
                                      context, PackingAssamblyListScreen.routeName,
                                      arguments: AddPackingAssamblyListArgument(edt_FinishProductID.text));
                                }

                            }
                          else
                            {
                              showCommonDialogWithSingleOption(context, "So No Is Required To Add Product Assembly!",
                                  positiveButtonTitle: "OK",onTapOfPositiveButton: (){
                                    Navigator.pop(context);

                                  });
                            }




                          //_onTaptoSaveQuotationHeader(context);
                        }, "Add Product Assembly ",
                            width: 600, backGroundColor: colorPrimary),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.bottomCenter,
                        child: getCommonButton(baseTheme, () {
                          //  _onTapOfDeleteALLContact();
                          //  navigateTo(context, InquiryProductListScreen.routeName);

                          //_onTaptoSaveQuotationHeader(context);

                          _onTaptoSavePackingCheckingHeader(context);
                        }, "Save  ",
                            width: 600, backGroundColor: colorPrimary),
                      ),


                    ]))),
      ),
    ),
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
                      controller: edt_Address,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 10),

                        hintText: "Tap to enter details",
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
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: edt_Area,
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

  Widget Application() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Application",
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
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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

  Widget ProductName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("ProductName",
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
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                      controller: edt_FinishProductName,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "",
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
            onTap: () {
              _onTapOfSearchCountryView(_searchCountryDetails == null ? "" : _searchCountryDetails.countryCode);
    } ,//isAllEditable==true?_onTapOfSearchCountryView(_searchDetails == null ? "" : /*_searchDetails.countryCode*/""):Container(),
            child: Card(
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
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: edt_Country_Name,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(bottom: 10),

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

  Future<void> _onTapOfSearchCountryView(String sw) async {
    navigateTo(context, SearchCountryPackingScreen.routeName,
        arguments: CountryArgumentsForPacking(sw))
        .then((value) {
      if (value != null) {
        _searchCountryDetails = SearchCountryDetails();
        _searchCountryDetails = value;
        print("CountryName IS From SearchList" + _searchCountryDetails.countryCode);
        edt_Country_Code.text = _searchCountryDetails.countryCode;
        edt_Country_Name.text = _searchCountryDetails.countryName;
        packingChecklistBloc.add(CountryCallEvent(CountryListRequest(
            CountryCode: _searchCountryDetails.countryCode, CompanyID: CompanyID.toString())));
      }
    });
  }

  Widget QualifiedState() {
    return InkWell(
     onTap: (){
       _onTapOfSearchStateView(_searchCountryDetails == null ? "" : _searchCountryDetails.countryCode);
     },
      child: Column(
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
            onTap: () => {
            _onTapOfSearchStateView(_searchCountryDetails == null ? "" : _searchCountryDetails.countryCode)

          },//isAllEditable==true?_onTapOfSearchStateView(_searchDetails == null ? "" : /*_searchDetails.countryCode*/"IND"):Container(),
            child: Card(
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
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: edt_State_Name,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(bottom: 10),

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
      ),
    );
  }

  Future<void> _onTapOfSearchStateView(String sw1) async {
    navigateTo(context, SearchStateScreen.routeName,
        arguments: StateArguments(sw1))
        .then((value) {
      if (value != null) {
        _searchStateDetails = value;
        edt_State_ID.text = _searchStateDetails.value.toString();
        edt_State_Name.text = _searchStateDetails.label.toString();
        packingChecklistBloc.add(StateCallEvent(StateListRequest(
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
        edt_City_ID.text = _searchCityDetails.cityCode.toString();
        edt_City_Name.text = _searchCityDetails.cityName.toString();
        packingChecklistBloc.add(CityCallEvent(CityApiRequest(
              CityName: "",
              CompanyID: CompanyID.toString(),
              StateCode: talukaCode)));
      }
    });
  }

  Widget QualifiedCity() {
    return InkWell(
      onTap: (){
        _onTapOfSearchCityView(_searchStateDetails == null
            ? ""
            : _searchStateDetails.value.toString());
      },
      child: Column(
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
            onTap: () => {
            _onTapOfSearchCityView(_searchStateDetails == null
            ? ""
                : _searchStateDetails.value.toString())
            },//isAllEditable==true?_onTapOfSearchCityView(_searchStateDetails == null ? "" : _searchStateDetails.value.toString()):Container(),
            child: Card(
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
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: edt_City_Name,
                          decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(bottom: 10),

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
      ),
    );
  }

  Widget QualifiedPinCode() {
    return Column(
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
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: edt_PinCode,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 10),
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
    );
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
        Icon icon,
        String title,
        String hintTextvalue,
        TextEditingController controllerForLeft,
        TextEditingController controllerforFinishProduct,
        List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {

              if(_isForUpdate!=true)
                {


              if(edt_CustomerName.text!="")
                {
                  if(arr_ALL_Name_ID_For_OutWordList.length!=0)
                    {
                      showSONocustomdialogWithMultipleID(
                          values: arr_ALL_Name_ID_For_OutWordList,
                          context1: context,
                          controller: edt_S_O_No,
                          controller2: edt_FinishProductName ,
                          controllerID: edt_FinishProductID,
                          lable: "Select OutWord No");

                      setState(() {
                        edt_FinishProductName.text;
                      });
                    }
                  else
                    {
                      showCommonDialogWithSingleOption(context, " Enter Valid Customer Name Which have Created SalesOrder !",
                          positiveButtonTitle: "OK",onTapOfPositiveButton: (){
                            Navigator.pop(context);
                          });
                    }

                }
              else
                {
                  showCommonDialogWithSingleOption(context, "CustomerName Is Required !",
                      positiveButtonTitle: "OK",onTapOfPositiveButton: (){
                        Navigator.pop(context);

                      });
                }
                }
    } /*showcustomdialogWithOnlyName(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $Category"),*/



            ,
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
                    height: CardViewHeight,
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

  Widget CustomDropDownEmployeeList(String Category,
      {bool enable1,
        Icon icon,
        String title,
        String hintTextvalue,
        TextEditingController controllerForLeft,
        TextEditingController controllerforFinishProduct,
        List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showcustomdialogWithID(
                  values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
                  context1: context,
                  controller: edt_EmployeeName,
                  controllerID: edt_EmployeeID,
                  lable: "Select OutWord No");

              setState(() {
                edt_EmployeeName.text;
              });
            }







            ,
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
                    height: CardViewHeight,
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


  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Customer/Company Name*",
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
              height: CardViewHeight,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: edt_CustomerName,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Search customer",
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

  Future<void> _onTapOfSearchView() async {
    if(_isForUpdate==false ){
      navigateTo(context, SearchInquiryCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchInquiryListResponse = value;
          edt_CustomerName.text = _searchInquiryListResponse.label;
          edt_CustomerpkID.text = _searchInquiryListResponse.value.toString();
          /* _inquiryBloc.add(SearchInquiryListByNameCallEvent(
              SearchInquiryListByNameRequest(word:  edt_CustomerName.text,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID,needALL: "1")));
*/
          //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

          edt_S_O_No.text="";
          arr_ALL_Name_ID_For_OutWordList.clear();
          packingChecklistBloc.add(OutWordCallEvent(OutWordNoListRequest(CustomerID: _searchInquiryListResponse.value.toString(),CompanyId: CompanyID.toString())));
        }
      });
    }

  }

  Widget PackingNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Packing No.",
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
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      enabled: false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: edt_PackingNo,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 10),

                        hintText: "",
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

  Widget PackingListDate() {

    return InkWell(
      onTap: () {
        _selectDateForPackingListDate(context, edt_Packing_List_Date);
      },      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Packing List Date*",
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
              height: CardViewHeight,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: edt_Packing_List_Date,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(bottom: 10),

                          hintText: "DD-MM-YYYY",
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
                    Icons.calendar_today_outlined,
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



  Future<bool> _onBackPressed() {


    navigateTo(context, PackingChecklistScreen.routeName, clearAllStack: true);

  }

  Widget Machine_Finalize_date() {
    return InkWell(
      onTap: (){
        _selectDateForMachineFinalizeDate(context, edt_Machine_Finalize_date);

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Machine Finalize date*",
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
              height: CardViewHeight,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: edt_Machine_Finalize_date,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(bottom: 10),

                          hintText: "DD-MM-YYYY",
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
                    Icons.calendar_today_outlined,
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

  Widget Machine_Dispatch_date() {
    return InkWell(
      onTap: (){
        _selectDateForMachineDispatchDate(context, edt_Machine_Dispatch_date);

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Machine Dispatch date*",
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
              height: CardViewHeight,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: edt_Machine_Dispatch_date,
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(bottom: 10),

                          hintText: "DD-MM-YYYY",
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
                    Icons.calendar_today_outlined,
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

  Future<void> _selectDateForPackingListDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_Packing_List_Date.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_Packing_List_Date_Reverse.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectDateForMachineFinalizeDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_Machine_Finalize_date.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_Machine_Finalize_dateReverse.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }
  Future<void> _selectDateForMachineDispatchDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_Machine_Dispatch_date.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_Machine_Dispatch_dateReverse.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  void _onCountryListSuccess(CountryListEventResponseState state) {
    arr_ALL_Name_ID_For_Country.clear();
    for (var i = 0; i < state.countrylistresponse.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          state.countrylistresponse.details[i].countryName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          state.countrylistresponse.details[i].countryName;
      categoryResponse123.Name1 =
          state.countrylistresponse.details[i].countryCode;
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

  void _onTaptoSavePackingCheckingHeader(BuildContext context) async {
    await getInquiryProductDetails();

    if(edt_Packing_List_Date.text!="")
      {
        if(edt_CustomerName.text!="")
        {
          if(edt_S_O_No.text!="")
            {
              if(edt_Machine_Finalize_date.text!="")
              {
                if(edt_Machine_Dispatch_date.text!="")
                {
                  if(edt_Country_Name.text!="")
                  {
                    if(edt_State_Name.text!="")
                    {
                      if(edt_City_Name.text!="")
                      {

                         print("SaveRequest" +" PCNO : " + edt_PackingNo.text+ " CustomerID : " + edt_CustomerpkID.text + " PCNo : " + edt_PackingNo.text + " EmployeeID : " + "0" +
                    " PCdate : " + edt_Packing_List_Date_Reverse.text + " FinalizeDate : " + edt_Machine_Finalize_dateReverse.text + " DispatchDate : " +edt_Machine_Dispatch_dateReverse.text +
                        " Address : " + edt_Address.text + " Area : " + edt_Area.text + " CityCode : " + edt_City_ID.text + " StateCode : " +  edt_State_ID.text +
                        " CountryCode : " + edt_Country_Code.text + " SoNo : " + edt_S_O_No.text + " SoDate : " + " " + " FinishProductID : " + edt_FinishProductID.text+
                             " Application : " + " LoginUserID : " + LoginUserID + " CompanyID : " + CompanyID.toString()

                    );


                         showCommonDialogWithTwoOptions(
                             context, "Are you sure you want to Save this Packing CheckList ?",
                             negativeButtonTitle: "No",
                             positiveButtonTitle: "Yes", onTapOfPositiveButton: ()
                         {
                           Navigator.of(context).pop();


                           if(edt_PackingNo.text!="")
                             {
                               packingChecklistBloc.add(DeleteALLPackingAssamblyCallEvent(edt_PackingNo.text,DeleteAllPakingAssamblyRequest(CompanyId: CompanyID.toString())));
                             }

                           packingChecklistBloc.add(PackingSaveCallEvent(
                               SavedPKID, PackingSaveRequest(
                               CustomerID: edt_CustomerpkID.text == null
                                   ? "0"
                                   : edt_CustomerpkID.text,
                               PCNo: edt_PackingNo.text == null
                                   ? ""
                                   : edt_PackingNo.text,
                               EmployeeID: edt_EmployeeID.text == null
                                   ? ""
                                   : edt_EmployeeID.text,
                               PCdate: edt_Packing_List_Date_Reverse.text ==
                                   null ? "" : edt_Packing_List_Date_Reverse
                                   .text,
                               FinalizeDate: edt_Machine_Finalize_dateReverse
                                   .text == null
                                   ? ""
                                   : edt_Machine_Finalize_dateReverse.text,
                               DispatchDate: edt_Machine_Dispatch_dateReverse
                                   .text == null
                                   ? ""
                                   : edt_Machine_Dispatch_dateReverse.text,
                               Address: edt_Address.text == null
                                   ? ""
                                   : edt_Address.text,
                               Area: edt_Area.text == null ? "" : edt_Area.text,
                               CityCode: edt_City_ID.text == null
                                   ? ""
                                   : edt_City_ID.text,
                               StateCode: edt_State_ID.text == null
                                   ? ""
                                   : edt_State_ID.text,
                               CountryCode: edt_Country_Code.text == null
                                   ? ""
                                   : edt_Country_Code.text,
                               SoNo: edt_S_O_No.text == null ? "" : edt_S_O_No
                                   .text,
                               SoDate: "",
                               FinishProductID: edt_FinishProductID.text == null
                                   ? ""
                                   : edt_FinishProductID.text,
                               Application: edt_Application.text == null
                                   ? ""
                                   : edt_Application.text,
                               LoginUserID: LoginUserID,
                               CompanyId: CompanyID.toString()

                           )));
                         });

                      }
                      else
                      {
                        showCommonDialogWithSingleOption(context, "City is required !",
                            positiveButtonTitle: "OK");
                      }
                    }
                    else
                    {
                      showCommonDialogWithSingleOption(context, "State is required !",
                          positiveButtonTitle: "OK");
                    }
                  }
                  else
                  {
                    showCommonDialogWithSingleOption(context, "Country is required !",
                        positiveButtonTitle: "OK");
                  }
                }
                else
                {
                  showCommonDialogWithSingleOption(context, "Machine Dispatch date is required !",
                      positiveButtonTitle: "OK");
                }
              }
              else
              {
                showCommonDialogWithSingleOption(context, "Machine Finalize date is required !",
                    positiveButtonTitle: "OK");
              }
            }
          else
            {
              showCommonDialogWithSingleOption(context, "SO No is required !",
                  positiveButtonTitle: "OK");
            }

        }
        else
        {
          showCommonDialogWithSingleOption(context, "CustomerName is required !",
              positiveButtonTitle: "OK");
        }
      }
    else
      {
        showCommonDialogWithSingleOption(context, "Packing Date is required !",
            positiveButtonTitle: "OK");
      }

  }

  void _onOutWordResponse(OutWordResponseState state1) {
    if(state1.outWordNoListResponse.details.length!=0)
      {
        arr_ALL_Name_ID_For_OutWordList.clear();

        for(int i=0;i<state1.outWordNoListResponse.details.length;i++)
          {
            ALL_Name_ID all_name_id = ALL_Name_ID();
            all_name_id.Name = state1.outWordNoListResponse.details[i].orderNo;
            all_name_id.Name1 = state1.outWordNoListResponse.details[i].productName;
            all_name_id.pkID = state1.outWordNoListResponse.details[i].productID;
            arr_ALL_Name_ID_For_OutWordList.add(all_name_id);
          }
      }
    else
      {
        showCommonDialogWithSingleOption(context, " Enter Valid Customer Name Which have Created SalesOrder !",
            positiveButtonTitle: "OK",onTapOfPositiveButton: (){
              Navigator.pop(context);
            });

      }
    print("ResponseOf OutWord" + " Details : " + state1.outWordNoListResponse.details[0].productName);
  }

  void _onpackingAssamblyResponse(PackingProductAssamblyListResponseState state) async {

    baseBloc.emit(ShowProgressIndicatorState(true));

    int finishProductID=0;
    String finishProductName="";
    int productGroupID=0;
    String productGroupName="";
    int productID=0;
    String productName="";
    String unit="";
    double quantity=0.00;
    String ProductSpecification="";



    if(edt_FinishProductID.text!="")
      {

        for(int i=0;i<state.packingProductAssamblyListResponse.details.length;i++)
        {
          int finishProductID=state.packingProductAssamblyListResponse.details[i].finishProductID;
          String finishProductName=state.packingProductAssamblyListResponse.details[i].finishProductName;
          int productGroupID=state.packingProductAssamblyListResponse.details[i].productGroupID;
          String productGroupName=state.packingProductAssamblyListResponse.details[i].productGroupName;
          int productID=state.packingProductAssamblyListResponse.details[i].productID;
          String productName=state.packingProductAssamblyListResponse.details[i].productName;
          String unit=state.packingProductAssamblyListResponse.details[i].unit;
          double quantity=state.packingProductAssamblyListResponse.details[i].quantity;
          String ProductSpecification="";

          //await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable(0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text));
          await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable("",0,"",productGroupID,productGroupName,productID,productName,unit,quantity,ProductSpecification,ProductSpecification,"",""));

          //await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable(finishProductID,finishProductName,productGroupID,productGroupName,productID,productName,unit,quantity,ProductSpecification));
        }
        baseBloc.emit(ShowProgressIndicatorState(false));


      }
    else
      {

        baseBloc.emit(ShowProgressIndicatorState(false));



      }




  }

  void fillData() async {
    SavedPKID = _editModel.pkID;
    edt_PackingNo.text = _editModel.pCNo;
    edt_Packing_List_Date.text = _editModel.pCdate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "dd-MM-yyyy");
    edt_Packing_List_Date_Reverse.text = _editModel.pCdate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    edt_Machine_Finalize_date.text = _editModel.finalizeDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "dd-MM-yyyy");
    edt_Machine_Finalize_dateReverse.text = _editModel.finalizeDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    edt_Machine_Dispatch_date.text = _editModel.dispatchDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "dd-MM-yyyy");
    edt_Machine_Dispatch_dateReverse.text = _editModel.dispatchDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    edt_CustomerName.text = _editModel.customerName;
    edt_CustomerpkID.text = _editModel.customerID.toString();
    edt_Country_Name.text = "India";
    edt_Country_Code.text = "IND";
    edt_State_Name.text = _editModel.stateName;
    edt_State_ID.text = _editModel.stateCode.toString();
    edt_City_Name.text =  _editModel.cityName.toString();
    edt_City_ID.text =  _editModel.cityCode.toString();
    edt_PinCode.text = "";
    edt_S_O_No.text = _editModel.sOno;
    edt_Address.text = _editModel.address;
    edt_Area.text = _editModel.area;
    edt_Application.text = _editModel.application;
    edt_FinishProductID.text = _editModel.finishProductID.toString();
    edt_FinishProductName.text = _editModel.finishProductName.toString();
    edt_EmployeeName.text = _editModel.employeeName.toString()=="--Not Available--"?"":_editModel.employeeName.toString();
    edt_EmployeeID.text =_editModel.employeeID.toString();

    await OfflineDbHelper.getInstance().deleteALLPackingProductAssambly();

    packingChecklistBloc.add(PackingAssamblyEditModeRequestCallEvent(PackingAssamblyEditModeRequest(PCNo: _editModel.pCNo,CompanyId: CompanyID.toString())));

    //packingChecklistBloc.add(OutWordCallEvent(OutWordNoListRequest(CustomerID:edt_CustomerpkID.text,CompanyId: CompanyID.toString())));

  }

  void _onFollowerEmployeeListByStatusCallSuccess(ALL_EmployeeList_Response offlineFollowerEmployeeListData1) {

    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if(offlineFollowerEmployeeListData1.details!=null)
    {
      for(var i=0;i<offlineFollowerEmployeeListData1.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = offlineFollowerEmployeeListData1.details[i].employeeName;
        // all_name_id.Name1 = state.details[i].;
        all_name_id.pkID = offlineFollowerEmployeeListData1.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  void _onHeaderSaveResponse(PackingSaveResponseState state) {
    print("InquiryHeaderResponse" +
        state.packingSaveResponse.details[0].column2 +
        "\n" +
        state.packingSaveResponse.details[0].column3);
    updateRetrunInquiryNoToDB(state.packingSaveResponse.details[0].column3);
    packingChecklistBloc.add(PackingAssamblySaveCallEvent(_inquiryProductList));
  }

  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<PackingProductAssamblyTable> temp =
    await OfflineDbHelper.getInstance().getPackingProductAssambly();
    _inquiryProductList.addAll(temp);
    setState(() {});
  }

  void updateRetrunInquiryNoToDB(String ReturnInquiryNo) {
    _inquiryProductList.forEach((element) {
      element.FinishProductID = int.parse(edt_FinishProductID.text==""?0:edt_FinishProductID.text);
      element.FinishProductName = edt_FinishProductName.text;
      element.PCNo = ReturnInquiryNo;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }

  void _onPackingAssamblySaveResponse(PackingAssamblySaveResponseState state) async {

    //state.packingAssamblySaveResponse
    print("InquiryHeaderResponse " +
        state.packingAssamblySaveResponse.details[0].column2);
    String Msg = _isForUpdate == true ? "Updated Successfully" : "Added Successfully";

    /* showCommonDialogWithSingleOption(context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
          navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
        });*/
    await showCommonDialogWithSingleOption(Globals.context,state.packingAssamblySaveResponse.details[0].column2,
        positiveButtonTitle: "OK");
    Navigator.of(context).pop();
  }

  void _OnDeleteAllAssamblyResponse(DeleteAllPackingAssamblyResponseState state) {

    print("DeleteAllAssamblyResponse" + state.delete_all_assambly_response.details[0].column1.toString());
  }

  void _OnPackingAssamblyEditMode(PackingAssamblyEditModeResponseState state) async {


    int finishProductID=0;
    String finishProductName="";
    int productGroupID=0;
    String productGroupName="";
    int productID=0;
    String productName="";
    String unit="";
    double quantity=0.00;
    String ProductSpecification="";
    await OfflineDbHelper.getInstance().deleteALLPackingProductAssambly();

    for(int i=0;i<state.packingAssamblyEditModeResponse.details.length;i++)
      {

        productGroupID = state.packingAssamblyEditModeResponse.details[i].productGroupID;
        productGroupName = state.packingAssamblyEditModeResponse.details[i].productGroupName;
        productID = state.packingAssamblyEditModeResponse.details[i].productID;
        productName = state.packingAssamblyEditModeResponse.details[i].productName;
        unit = state.packingAssamblyEditModeResponse.details[i].unit;
        quantity= state.packingAssamblyEditModeResponse.details[i].quantity;
        ProductSpecification= state.packingAssamblyEditModeResponse.details[i].productSpecification;



        await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable("",0,"",productGroupID,productGroupName,productID,productName,unit,quantity,ProductSpecification,ProductSpecification,"",""));

      }
    baseBloc.emit(ShowProgressIndicatorState(false));

  }

  showSONocustomdialogWithMultipleID(
      {List<ALL_Name_ID> values,
        BuildContext context1,
        TextEditingController controller,
        TextEditingController controllerID,
        TextEditingController controller2,
        String lable}) async {
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
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () async {
                                  Navigator.of(context1).pop();
                                  controller.text = values[index].Name;
                                  controllerID.text =
                                      values[index].pkID.toString();
                                  controller2.text =
                                      values[index].Name1.toString();
                                  await OfflineDbHelper.getInstance().deleteALLPackingProductAssambly();
                                  packingChecklistBloc.add(PackingProductAssamblyListRequestCallEvent(PackingProductAssamblyListRequest(ProductID:values[index].pkID.toString(),CompanyId: CompanyID.toString())));


                                  print(
                                      "IDSS : " + values[index].pkID.toString());
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorPrimary), //Change color
                                        width: 10.0,
                                        height: 10.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 1.5),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        values[index].Name,
                                        style: TextStyle(color: colorPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),


                            },
                              child: Text(values[index].Name),
                            );*/
                            },
                            itemCount: values.length,
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

}