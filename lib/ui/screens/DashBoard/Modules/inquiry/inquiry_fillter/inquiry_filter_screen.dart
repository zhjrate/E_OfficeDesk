import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_fillter_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response_for_packing_checking.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_country_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/region/country_list_for_packing.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class SearchInquiryScreenFilter extends BaseStatefulWidget {
  static const routeName = '/SearchInquiryScreenFilter';

  @override
  _SearchInquiryScreenFilterState createState() =>
      _SearchInquiryScreenFilterState();
}

class _SearchInquiryScreenFilterState
    extends BaseState<SearchInquiryScreenFilter>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  InquiryListResponse _searchInquiryListResponse;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];

  final TextEditingController edt_customerName = TextEditingController();

  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_InquiryNo = TextEditingController();

  final TextEditingController edt_QualifiedCountry = TextEditingController();
  final TextEditingController edt_QualifiedCountryCode = TextEditingController();

  final TextEditingController edt_QualifiedState = TextEditingController();

  final TextEditingController edt_QualifiedStateCode = TextEditingController();

  final TextEditingController edt_QualifiedCity = TextEditingController();
  final TextEditingController edt_QualifiedCityCode = TextEditingController();

  final TextEditingController _productNameController = TextEditingController();

  final TextEditingController _productIDController = TextEditingController();

  double CardViewHieght = 35;
  SearchCountryDetails _searchCountryDetails;
  SearchStateDetails _searchStateDetails;
  SearchCityDetails _searchCityDetails;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Country = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_State = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_City = [];
  List<ALL_Name_ID> _listFilteredCountry = [];
  List<ALL_Name_ID> _listFilteredState = [];
  List<ALL_Name_ID> _listFilteredCity = [];
  ProductSearchDetails _searchDetails;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    FetchInquiryPriorityDetails();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    edt_QualifiedCountry.text = "India";
    edt_QualifiedCountryCode.text = "IND";
    edt_QualifiedState.text = _offlineLoggedInData.details[0].StateName;
    edt_QualifiedStateCode.text =
        _offlineLoggedInData.details[0].stateCode.toString();
    edt_QualifiedCity.text = _offlineLoggedInData.details[0].CityName;
    edt_QualifiedCityCode.text =
        _offlineLoggedInData.details[0].CityCode.toString();

    _inquiryBloc = InquiryBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
         /* if (state is SearchInquiryListByNameCallResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
         /* if (currentState is SearchInquiryListByNameCallResponseState) {
            return true;
          }*/
          return false;
        },
        listener: (BuildContext context, InquiryStates state) {
          if (state is CountryListEventResponseState) {
            _onCountryListSuccess(state);
          }
          if (state is StateListEventResponseState) {
            _onStateListSuccess(state);
          }

          if (state is CityListEventResponseState) {
            _onCityListSuccess(state);
          }
          if(state is SearchInquiryFillterResponseState)
            {
              _OnSearchedResultResponse(state);
            }
        },
        listenWhen: (oldState, currentState) {
          if (currentState is CountryListEventResponseState ||
              currentState is StateListEventResponseState ||
              currentState is CityListEventResponseState ||
              currentState is SearchInquiryFillterResponseState
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
    return Column(
      children: [
        NewGradientAppBar(
          title: Text('Search Customer'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              top: 25,
            ),
            child: Column(
              children: [
                //_buildSearchView(),
                _searchInquiryListResponse == null?Container():Expanded(flex : 1,child: _buildInquiryList()),


                Expanded(
                    flex: 2,
                    child: _buildSearchView()),
    /*if (_searchInquiryListResponse == null) {
    return Container();
    }*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {

    return SingleChildScrollView(
        child: Container(
            padding:EdgeInsets.all(8) ,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
            ),
       // margin: EdgeInsets.all(Constant.CONTAINERMARGIN),
    child: Form(
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 20),
          child: Text("Min. 3 chars to search Inquiry",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight.bold)),
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
                  child: TextFormField(
                    autofocus: true,
                    controller: edt_customerName,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    /* onChanged: (value) {
                      _onSearchChanged(value);
                    },*/
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10),
                      hintText: "Tap to enter customer name",
                      border: InputBorder.none,
                    ),
                    style: baseTheme.textTheme.subtitle2
                        .copyWith(color: colorBlack),
                  ),
                ),
                /*Icon(
                  Icons.search,
                  color: colorGrayDark,
                )*/
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),

        /*  Container(
          padding: EdgeInsets.only(left: 10, right: 20),
          child: Text(
              "Inquiry No.",
              style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)        ),
        ),
        SizedBox(
          height: 3,
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
                  child: TextFormField(
                    autofocus:true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,

                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10),
                      hintText: "Tap to enter Inquiry No.",
                      border: InputBorder.none,
                    ),
                    style: baseTheme.textTheme.subtitle2
                        .copyWith(color: colorBlack),
                  ),
                ),

              ],
            ),
          ),
        ),*/
        CustomDropDown1("Priority",
            enable1: false,
            title: "Lead Priority ",
            hintTextvalue: "Tap to Select Lead Priority",
            icon: Icon(Icons.arrow_drop_down),
            controllerForLeft: edt_Priority,
            Custom_values1: arr_ALL_Name_ID_For_Folowup_Priority),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(flex: 1, child: InquiryNo()),
            Expanded(flex: 1, child: QualifiedCountry()),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(flex: 1, child: QualifiedState()),
            Expanded(flex: 1, child: QualifiedCity()),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        _buildProductSearchView(),
        SizedBox(
          height: 20,
        ),
        getCommonButton(baseTheme, () {

          String CompanyId = CompanyID.toString();
          String CustomerName = edt_customerName.text==null?"":edt_customerName.text;
          String ProductName = _productNameController.text==null?"":_productNameController.text;
          String InquiryNo = edt_InquiryNo.text==null?"":edt_InquiryNo.text;
          String StateCode = edt_QualifiedStateCode.text==null?"":edt_QualifiedStateCode.text;
          String CityCode = edt_QualifiedCityCode.text==null?"":edt_QualifiedCityCode.text;
          String CountryCode = edt_QualifiedCountryCode.text==null?"":edt_QualifiedCountryCode.text;
          String Priority = edt_Priority.text==null?"":edt_Priority.text;
          String NameOnly = "1";
          String Word = "";

          _inquiryBloc.add(SearchInquiryListFillterByNameRequestEvent(
              SearchInquiryListFillterByNameRequest(
                  CompanyId: CompanyId,
                  CustomerName: CustomerName,
                  ProductName: ProductName,
                  InquiryNo: InquiryNo,
                  StateCode: StateCode,
                  CityCode: CityCode,
                  CountryCode: CountryCode,
                  Priority: Priority,
                  NameOnly: NameOnly,
                  Word: Word)));


        }, "Apply Filters", height: 40),
      ],
    ))));



  }

  ///builds inquiry list
  Widget _buildInquiryList() {

    /*child: Text("No Result Found.."),*/
    return _searchInquiryListResponse.details.length!=0?Container(
      padding:EdgeInsets.all(8) ,
      decoration: BoxDecoration(
          border: Border.all(color: colorYellow)
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _buildSearchInquiryListItem(index);
        },
        shrinkWrap: true,
        itemCount: _searchInquiryListResponse.details.length,
      ),
    ):Container(child: Text("No Result Found..!"));
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    InquiryDetails model = _searchInquiryListResponse.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(model);
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Text(
              model.customerName,
              style: baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
          ),
          margin: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  ///calls search list api
  void _onSearchChanged(String value) {
    if (value.trim().length > 2) {
      /*_inquiryBloc.add(SearchInquiryListByNameCallEvent(
          SearchInquiryListByNameRequest(word: value,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID,needALL: "1")));*/
    }
  }

 /* void _onSearchInquiryListCallSuccess(
      SearchInquiryListByNameCallResponseState state) {
    _searchInquiryListResponse = state.response;
  }*/

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

  Widget CustomDropDown1(String Category,
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

  Widget InquiryNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("InquiryNo.",
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
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: edt_InquiryNo,
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(bottom: 10),
                        contentPadding: EdgeInsets.only(bottom: 10),

                        hintText: "InquiryNo",
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
          onTap: () => _onTapOfSearchCityView(edt_QualifiedStateCode.text == null
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

  /* _onTapOfSearchCountryView(String sw) {
    navigateTo(context, SearchCountryScreen.routeName,
        arguments: CountryArguments(sw))
        .then((value) {
      if (value != null) {
        _searchCountryDetails = SearchCountryDetails();
        _searchCountryDetails = value;
        print("CountryName IS From SearchList" + _searchCountryDetails.countryCode);
        edt_QualifiedCountryCode.text = */ /*_searchDetails.countryCode*/ /*"";
        edt_QualifiedCountry.text = _searchCountryDetails.countryName;
        _inquiryBloc.add(CountryCallEvent(CountryListRequest(
            CountryCode: */ /*_searchDetails.countryCode*/ /*"IND",
            CompanyID: CompanyID.toString())));
      }
    });
  }*/

  Future<void> _onTapOfSearchCountryView(String sw) async {
    navigateTo(context, SearchCountryPackingScreen.routeName,
            arguments: CountryArgumentsForPacking(sw))
        .then((value) {
      if (value != null) {
        _searchCountryDetails = SearchCountryDetails();
        _searchCountryDetails = value;
        print("CountryName IS From SearchList" +
            _searchCountryDetails.countryCode);
        edt_QualifiedCountryCode.text = _searchCountryDetails.countryCode;
        edt_QualifiedCountry.text = _searchCountryDetails.countryName;
        _inquiryBloc.add(CountryCallEvent(CountryListRequest(
            CountryCode: _searchCountryDetails.countryCode,
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
        _inquiryBloc.add(StateCallEvent(StateListRequest(
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
        edt_QualifiedCityCode.text = _searchCityDetails.cityCode.toString();
        edt_QualifiedCity.text = _searchCityDetails.cityName.toString();
        _inquiryBloc.add(CityCallEvent(CityApiRequest(
            CityName: "",
            CompanyID: CompanyID.toString(),
            StateCode: talukaCode)));
      }
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
    arr_ALL_Name_ID_For_City.clear();
    for (var i = 0; i < responseState.cityApiRespose.details.length; i++) {
      print("CustomerCategoryResponse2 : " +
          responseState.cityApiRespose.details[i].cityName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name =
          responseState.cityApiRespose.details[i].cityName;
      categoryResponse123.pkID =
          responseState.cityApiRespose.details[i].cityCode;
      arr_ALL_Name_ID_For_City.add(categoryResponse123);
      _listFilteredCity.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  Widget _buildProductSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Search Product",
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
                    child: /*TextField(
                      _searchDetails == null
                          ? "Tap to search inquiry"
                          : _searchDetails.productName,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _searchDetails == null
                              ? colorGrayDark
                              : colorBlack),
                    ),
                    */
                        TextFormField(
                            validator: (value) {
                              if (value.toString().trim().isEmpty) {
                                return "Please enter this field";
                              }
                              return null;
                            },
                            onTap: () {
                              _onTapOfSearchView();
                            },
                            readOnly: true,
                            controller: _productNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: "Tap to search Product",
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
    /* navigateTo(context, SearchInquiryProductScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        _inquiryBloc.add(InquiryProductSearchNameCallEvent(InquiryProductSearchRequest(pkID: "",CompanyId: "10032",ListMode: "L",SearchKey: value)));
       print("ProductDetailss345"+_searchDetails.productName +"Alias"+ _searchDetails.productAlias);
      }
    });*/
    navigateTo(
      context,
      SearchInquiryProductScreen.routeName,
    ).then((value) {
      if (value != null) {
        _searchDetails = value;
        _productNameController.text = _searchDetails.productName.toString();
        _productIDController.text = _searchDetails.pkID.toString();
        //_totalAmountController.text = ""

      }
    });
  }

  void _OnSearchedResultResponse(SearchInquiryFillterResponseState state) {

    _searchInquiryListResponse = state.response;
    setState(() {

    });


  }
}
