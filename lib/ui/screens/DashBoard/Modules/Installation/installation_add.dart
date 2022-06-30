import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/installation/installation_bloc.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_country_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_customerid_to_outwardno_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_save_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_search_customer_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_city_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_country_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_list_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_search_customer_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/state_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/save_installation_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_city_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_country_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_search_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_state_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/search_installation.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class InstallationEditArguments{
  InstallationListDetails editDetails;
  InstallationEditArguments(this.editDetails);
}

class InstallationAddScreen extends BaseStatefulWidget {
  static const routeName = '/InstallationAddScreen';
  final InstallationEditArguments arguments;

  InstallationAddScreen(this.arguments);


  @override
  _InstallationAddScreenState createState() => _InstallationAddScreenState();
}

class _InstallationAddScreenState extends BaseState<InstallationAddScreen>
    with BasicScreen, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  int saveid = 0;
  InstallationBloc installationBloc;
  double height = 45;
  double circular = 15;
  bool _MD = false;
  bool _IR = true;
  bool _TR = true;
  bool _AD = true;
  String PN = "";
  DateTime selectdate = DateTime.now();
  TimeOfDay selecttime = TimeOfDay.now();
  List<ALL_Name_ID> Place = [];
  List<ALL_Name_ID> Cooling = [];
  List<ALL_Name_ID> Stabilize = [];
  List<ALL_Name_ID> Outwardnolist = [];
  List<ALL_Name_ID> Employeelist = [];


  TextEditingController IP = TextEditingController();
  TextEditingController RC = TextEditingController();
  TextEditingController PS = TextEditingController();
  TextEditingController installationdate = TextEditingController();
  TextEditingController installationno = TextEditingController();
  TextEditingController customername = TextEditingController();
  TextEditingController customerid = TextEditingController();
  TextEditingController outwardno = TextEditingController();
  TextEditingController engineername = TextEditingController();
  TextEditingController engineerid = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController reversedate = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController statecode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController citycode = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController contact = TextEditingController();

  TextEditingController machine_serial_no = TextEditingController();
  TextEditingController ground = TextEditingController();
  TextEditingController approveddesignation = TextEditingController();
  TextEditingController approveddepartment = TextEditingController();
  TextEditingController approvedname = TextEditingController();

  TextEditingController traineequalification = TextEditingController();
  TextEditingController traineedepartment = TextEditingController();
  TextEditingController traineedesignation = TextEditingController();
  TextEditingController traineename = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController productid = TextEditingController();

  InstallationCustomerSearchDetails installationCustomerSearchDetails;
  InstallationCountryDetails installationCountryDetails;
  StateDetails stateDetails;
  InstallationCityDetails cityDetails;

  InstallationListDetails _editModel;
  bool _isForUpdate;
  String Temp;
  String Temp2;
  bool _isvisible = false;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    productname.text = "";
    _MD = false;
    _AD = false;
    _TR = false;
    _IR = false;

    productname.addListener(visiblity);
    RoomCollingDetails();
    InstallationPlaceDetails();
    PowerStabilizeDetails();
    installationBloc = InstallationBloc(baseBloc);
    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editDetails;
      fillData();
    } else {}
  }
  visiblity(){
    setState(() {
      if(productname.text=="--Not Available--"){
        _isvisible = false;
      }else{_isvisible = true;}

    });

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => installationBloc,
      child: BlocConsumer<InstallationBloc, InstallationListState>(
        builder: (BuildContext context, InstallationListState state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, InstallationListState state) {

          if(state is InstallationCustomerSearchCallResponseState){
            _onsearchcustomer(state);
          }
          if(state is InstallationCountryCallResponseState){
            _oncountrysearch(state);
          } if(state is CustomerIdToOutwardCallResponseState){
            _onoutwardnolist(state);
          }
          if(state is InstallationEmployeeCallResponseState){
            _onemployeelist(state);
          }
          if(state is SaveInstallationCallResponseState){

            _ontapofsavedetails(state);
          }
          return super.build(context);

        },
        listenWhen: (oldState, currentState) {
          if(
              currentState is InstallationCustomerSearchCallResponseState ||
                  currentState is InstallationCountryCallResponseState ||
                  currentState is CustomerIdToOutwardCallResponseState ||
                  currentState is InstallationEmployeeCallResponseState||
                  currentState is SaveInstallationCallResponseState
          ){
            return true;
          }

          return false;
        },
      ),
    );
  }

  Widget buildBody(BuildContext context1) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text("Installation"),
        gradient: LinearGradient(
          colors: [Colors.red, Colors.purple, Colors.blue],
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Installation No.*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(

              margin: EdgeInsets.only(left: 10, right: 10),
              child:Card(
                elevation: 5,
                color: colorLightGray,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: height,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(

                          child: TextField(
                              controller: installationno,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                //hintText: "DD-MM-YYYY",
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
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Installation Date*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            InkWell(
              onTap: () {
                _selectDate(context, installationdate);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      _selectDate(context, installationdate);
                    },
                    child: Card(
                      elevation: 5,
                      color: colorLightGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: height,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: installationdate,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  enabled: false,

                                  //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                  decoration: InputDecoration(
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
                              Icons.calendar_today,
                              color: colorGrayDark,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Customer/Company Name*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            InkWell(
              onTap: (){
                outwardno.clear();

                _ontapofcustomersearch();
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: customername,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                hintText: "Select Customer/Company Name",
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
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Outward No.*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  if(customername.text==null||customername.text==""){
                    showCommonDialogWithSingleOption(context, "Enter Valid Customer Name",
                        onTapOfPositiveButton: (){
                          Navigator.pop(context);
                        }
                    );
                  }
                  else {
                    if (Outwardnolist.length != 0) {
                      showcustomdialogWithMultipleID(
                          values: Outwardnolist,
                          context1: context,
                          controller: outwardno,
                          controller2: productname,
                          controllerID: productid,
                          lable: "Select OutwardNo");
                      PN = productname.text;
                    }


                    else {
                      showCommonDialogWithSingleOption(
                          context, " Enter Valid Customer Name Which have Exist Packing Details !",
                          onTapOfPositiveButton: () {
                            Navigator.pop(context);
                          }
                      );
                    }
                  }
                },


                 child:Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: outwardno,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                hintText: "Select OutwardNo",
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
                ),
              ),
            ),


            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Engineer Name",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: (){

                  installationBloc.add(InstallationEmployeeCallEvent(
                      InstallationEmployeeRequest(CompanyId:this.CompanyID.toString())
                  ));
                },
                child: Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: engineername,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                hintText: "Select Engineer Name",
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
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Address",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 5,
                color: colorLightGray,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  //width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 5),
                          child: TextField(
                              controller: address,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Tap to Enter Address",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Area",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 5,
                color: colorLightGray,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: height,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: area,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            //enabled: false,

                            //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                            decoration: InputDecoration(
                              hintText: "Tap to Enter Area",
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
            ),
            SizedBox(height: 20),

            Row(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 23),
                    child: Text("Country",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text("State",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ]), //heading
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    child: InkWell(
                      onTap: (){
                        state.clear();
                        statecode.clear();
                        _ontapofcountrysearch();
                      },
                      child: Card(
                        elevation: 5,
                        color: colorLightGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: height,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: country,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    enabled: false,

                                    //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                    decoration: InputDecoration(
                                      //hintText: "DD-MM-YYYY",
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
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      city.clear();
                      citycode.clear();
                      pincode.clear();
                      if(country.text==""||country.text==null){
                        showCommonDialogWithSingleOption(context, "First Select Country",
                        onTapOfPositiveButton: (){
                          Navigator.pop(context);
                        }
                        );
                      }else{
                      _ontapofstatesearch(installationCountryDetails.countryCode);}
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Card(
                        elevation: 5,
                        color: colorLightGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: height,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: state,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    enabled: false,

                                    //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                    decoration: InputDecoration(
                                      //hintText: "DD-MM-YYYY",
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 23),
                    child: Text("City",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text("Pincode",
                        style: TextStyle(
                            fontSize: 12,
                            color: colorPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ]), //heading
            Row(

              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    child: InkWell(
                      onTap: (){
                        if(state.text==""||state.text==null){
                          showCommonDialogWithSingleOption(context, "First Select State",onTapOfPositiveButton: (){
                            Navigator.pop(context);
                          });
                        }else{
                        _ontapofcitysearch(stateDetails.value.toString());}
                      },
                      child: Container(

                        child: Card(
                          elevation: 5,
                          color: colorLightGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            height: height,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                      controller: city,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      enabled: false,

                                      //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                      decoration: InputDecoration(
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
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Card(
                      elevation: 5,
                      color: colorLightGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: height,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: pincode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  //enabled: false,

                                  //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                  decoration: InputDecoration(
                                    hintText: "Enter Pincode",
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Contact No",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 5,
                color: colorLightGray,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: height,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: contact,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            //enabled: false,

                            //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                            decoration: InputDecoration(
                              //hintText: "DD-MM-YYYY",
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
            ),
           _isvisible?SizedBox(
              height: 20,
            ):SizedBox(height: 1,),
            _isvisible?Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 23),
                      child: Text("Product Name",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      elevation: 5,
                      color: colorLightGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: height,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: productname,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  enabled: false,

                                  //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                  decoration: InputDecoration(
                                    //hintText: "DD-MM-YYYY",
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
                  ),
                ],
              ),
            ):SizedBox(height: 1,),
            SizedBox(height: 20,),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.00,
                  color: Colors.black,
                ),
              ),
              child: InkWell(
                onTap: () {
                  _onClick1();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 5),
                  child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.circle,
                          size: 15,
                          color: colorPrimary,
                        ),
                        hintText: "Machine Details",
                        hintStyle: TextStyle(
                          fontSize: 17,
                          color: colorPrimary,
                        ),
                        suffixIcon: Icon(
                          _MD
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: colorPrimary,
//size: 30,
                        ),
                      )),
                ),
              ),
            ),
            _MD
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 1,
                  ),
            _MD
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.00,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Machine Serial No",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: height,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller: machine_serial_no,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          //enabled: false,

                                          //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                          decoration: InputDecoration(
                                            //hintText: "Tap to Enter Area",
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _onClick2();
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.00,
                    color: Colors.black,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 5),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.circle,
                        size: 15,
                        color: colorPrimary,
                      ),
                      hintText: "Installation Requirement",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: colorPrimary,
                      ),
                      suffixIcon: Icon(
                        _IR
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: colorPrimary,
//size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _IR
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 1,
                  ),
            _IR
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.00,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: CustomDropDown1(
                            "Installation Place",
                            enable1: false,
                            title: "Installation Place",
                            hintTextvalue: "Tap to Select Installation Place",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: IP,
                            Custom_values1: Place,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: CustomDropDown1(
                            "Room Cooling",
                            enable1: false,
                            title: "Room Cooling",
                            hintTextvalue: "Tap to Select Room Cooling",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: RC,
                            Custom_values1: Cooling,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: CustomDropDown1(
                            "Power Stabilizer",
                            enable1: false,
                            title: "Power Stabilizer",
                            hintTextvalue: "Tap to Select Power Stabilizer",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: PS,
                            Custom_values1: Stabilize,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Ground Earthing",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: height,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller: ground,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          //enabled: false,

                                          //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                          decoration: InputDecoration(
                                            //hintText: "Tap to Enter Area",
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
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _onClick3();
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.00,
                    color: Colors.black,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 5),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.circle,
                        size: 15,
                        color: colorPrimary,
                      ),
                      hintText: "Trainee Person Detail",
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: colorPrimary,
                      ),
                      suffixIcon: Icon(
                        _TR
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.black,
//size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _TR
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 1,
                  ),
            _TR
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.00,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Trainee Name",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: traineename,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Trainee Designation",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: traineedesignation,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Trainee Department",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: height,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                          controller: traineedepartment,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          //enabled: false,

                                          //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                          decoration: InputDecoration(
                                            //hintText: "Tap to Enter Area",
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Trainee Qualification",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: traineequalification,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                /*!_AD
                    ? Fluttertoast.showToast(
                        msg: "Scroll ↓	",
                        textColor: Colors.white,
                        fontSize: 25,
                        toastLength: Toast.LENGTH_SHORT,
                      )
                    : Container();*/
                _onClick4();
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.00,
                    color: Colors.black,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 5),
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.circle,
                                size: 15,
                                color: colorPrimary,
                              ),
                              hintText: "Approved By Details",
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: colorPrimary,
                              ),
                              suffixIcon: Icon(
                                _AD
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black,
//size: 30,
                              ),
                            ),
                          ),
                        ),
              ),
            ),
            _AD
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 1,
                  ),
            _AD
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.00,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Aproved Name",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: approvedname,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Aproved Department",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: approveddepartment,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 23),
                            child: Text("Aproved Designation",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            color: colorLightGray,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: height,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        controller: approveddesignation,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        //enabled: false,

                                        //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                                        decoration: InputDecoration(
                                          //hintText: "Tap to Enter Area",
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),

              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                child: getCommonButton(baseTheme, () {
                  /* _ontapofsave();*/
                  _ontapofsave2();
                }, "Save", width: 600),
              ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }



  void _onClick1() {
    setState(() {
      _MD = !_MD;
    });
  }

  void _onClick2() {
    setState(() {
      _IR = !_IR;
    });
  }

  void _onClick3() {
    setState(() {
      _TR = !_TR;
    });
  }

  void _onClick4() {
    setState(() {
      _AD = !_AD;
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: DateTime(2001, 2),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectdate)
      setState(() {
        selectdate = picked;
        installationdate.text = selectdate.day.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.year.toString();
        reversedate.text = selectdate.year.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.day.toString();
      });
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
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
                    height: height,
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

  RoomCollingDetails() {
    Cooling.clear();
    for (var i = 0; i < 2; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "By Fan";
      } else if (i == 1) {
        all_name_id.Name = "By Air Condition";
      }
      Cooling.add(all_name_id);
    }
  }

  InstallationPlaceDetails() {
    Place.clear();
    for (var i = 0; i < 2; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Open Environment";
      } else if (i == 1) {
        all_name_id.Name = "Closed Room";
      }
      Place.add(all_name_id);
    }
  }

  PowerStabilizeDetails() {
    Stabilize.clear();
    for (var i = 0; i < 4; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Stabilize";
      } else if (i == 1) {
        all_name_id.Name = "Offline UPS";
      } else if (i == 2) {
        all_name_id.Name = "Online UPS";
      } else if (i == 3) {
        all_name_id.Name = "Direct";
      }
      Stabilize.add(all_name_id);
    }
  }



  void _onsearchcustomer(InstallationListState state) {

  }

  Future<void> _ontapofcustomersearch() async {

    Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationSearchCustomerScreen())).then((value) {
      if (value != null) {
        installationCustomerSearchDetails = value;
        installationBloc.add(InstallationSearchCustomerCallEvent(
            InstallationCustomerSearchRequest(CompanyId:this.CompanyID, LoginUserID: this.LoginUserID,word: installationCustomerSearchDetails.label,needALL: "0")));
        customername.text = installationCustomerSearchDetails.label;
        customerid.text = installationCustomerSearchDetails.value.toString();
        country.text = installationCustomerSearchDetails.countryName;
        state.text = installationCustomerSearchDetails.stateName;
        city.text = installationCustomerSearchDetails.cityName;
        contact.text = installationCustomerSearchDetails.contactNo1;
        countrycode.text = installationCustomerSearchDetails.countryCode;
        statecode.text = installationCustomerSearchDetails.stateCode.toString();
        citycode.text = installationCustomerSearchDetails.cityCode.toString();




        installationBloc.add(CustomerIdToOutwardCallEvent(
            InstallationCustomerIdToOutwardnoRequest(CompanyId: this.CompanyID, CustomerID:customerid.text )));
      }
    }
    );

  }
  Future<void> _ontapofcountrysearch() async {

    Navigator.push(context, MaterialPageRoute(builder: (context)=>InstallationSearchCountryScreen())).then((value) {
      if (value != null) {
        installationCountryDetails = value;
        country.text = installationCountryDetails.countryName;
        countrycode.text = installationCountryDetails.countryCode;

      }
    }
    );

  }

  void _oncountrysearch(InstallationListState state) {

  }

  Future<void>  _ontapofstatesearch(String code) async{
    navigateTo(context, InstallationStateSearchScreen.routeName,
        arguments: InstallationAddScreenArguments(code))
        .then((value) {
      if (value != null) {
           stateDetails = value;
           state.text = stateDetails.label;
           statecode.text = stateDetails.value.toString();
      }
    });
  }
  Future<void>  _ontapofcitysearch(String code) async{
    navigateTo(context, InstallationCitySearch.routeName,
        arguments: InstallationCityArguments(code))
        .then((value) {
      if (value != null) {

        cityDetails = value;
        city.text = cityDetails.cityName;
        citycode.text = cityDetails.cityCode.toString();
      }
    });
  }
  void _onoutwardnolist(CustomerIdToOutwardCallResponseState state) {

    Outwardnolist.clear();

      for(int i=0;i<state.response.details.length;i++){

        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].outwardNo;
        all_name_id.pkID= state.response.details[i].finishProductID;
        all_name_id.Name1 = state.response.details[i].productName;

            Outwardnolist.add(all_name_id);
      }

    }

  void _onemployeelist(InstallationEmployeeCallResponseState state) {
    Employeelist.clear();
    for(int i=0;i<state.response.details.length;i++){
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.response.details[i].employeeName;
      all_name_id.pkID = state.response.details[i].pkID;
      Employeelist.add(all_name_id);
    }
    showcustomdialog(
        values: Employeelist,
        context1: context,
        controller: engineername,
        controller2: engineerid,
        lable: "Select Employee");
  }

  void _ontapofsave() async{
    print("save button tappaed");
    showCommonDialogWithTwoOptions(context, "Are you sure you want to save this Details?",
      negativeButtonTitle: "No",
      positiveButtonTitle: "Yes",
          onTapOfPositiveButton: (){
            Navigator.of(context).pop();
            if(contact!=""){

              Temp = contact.text;
              Temp2 = Temp.replaceAll("+", "").trim().toString();
              contact.text = Temp2;
              print(Temp2);
            }
            if(installationdate.text==""){
              showCommonDialogWithSingleOption(context, "Fill InstallationDate");
            }else if(customername.text==""){
              showCommonDialogWithSingleOption(context, "Fill Customer/CompanyName");
            }else if(outwardno.text==""){
              showCommonDialogWithSingleOption(context, "Fill OutwardNo");
            }
            else if(engineername.text==""){
              showCommonDialogWithSingleOption(context, "Fill EngineerName");
            }else if(address.text==""){
              showCommonDialogWithSingleOption(context, "Fill Address");
            }else if(area.text==""){
              showCommonDialogWithSingleOption(context, "Fill Area");
            }else if(country.text==""){
              showCommonDialogWithSingleOption(context, "Fill Country");
            }else if(state.text==""){
              showCommonDialogWithSingleOption(context, "Fill State");
            }else if(city.text==""){
              showCommonDialogWithSingleOption(context, "Fill City");
            }else if(pincode.text==""){
              showCommonDialogWithSingleOption(context, "Fill Pincode");
            }

            else{installationBloc.add(SaveInstallationCallEvent(saveid,
                SaveInstallationRequest(
                  CustomerID: customerid.text.toString(),
                  OutwardNo: outwardno.text.toString(),
                  Address:address.text.toString(),
                  Area: area.text.toString(),
                  CountryCode: countrycode.text.toString(),
                  StateCode: statecode.text.toString(),
                  CityCode: citycode.text.toString(),
                  PinCode: pincode.text.toString(),

                  ContactNo: contact.text.toString(),
                  InstallationDate: reversedate.text.toString(),
                  InstallationPlace: IP.text.toString(),
                  RoomCooling: RC.text.toString(),
                  PowerStabilize:PS.text.toString(),
                  GroundEarthing:ground.text.toString(),
                  LoginUserID: this.LoginUserID,
                  InstallationNo: installationno.text.toString(),
                  EmployeeID: engineerid.text.toString(),
                  TraineeName: traineename.text.toString(),
                  MachineSRno: machine_serial_no.text.toString(),
                  AprovedName: approvedname.text.toString(),
                  AprovedDepart: approveddepartment.text.toString(),
                  AprovedDesg:  approveddesignation.text.toString(),
                  TraineeDepart: traineedepartment.text.toString(),
                  TraineeDesg: traineedesignation.text.toString(),
                  TraineeQuali: traineequalification.text.toString(),
                  CompanyId: this.CompanyID.toString(),
                  ProductID: productid.text.toString(),
                )));
            }


  }
    );

  }
  void _ontapofsave2() async{
    if(installationdate.text==""){
      showCommonDialogWithSingleOption(context, "Fill InstallationDate");
    }else if(customername.text==""){
      showCommonDialogWithSingleOption(context, "Fill Customer/CompanyName");
    }else if(outwardno.text==""){
      showCommonDialogWithSingleOption(context, "Fill OutwardNo");
    }
    else if(engineername.text==""){
      showCommonDialogWithSingleOption(context, "Fill EngineerName");
    }else if(address.text==""){
      showCommonDialogWithSingleOption(context, "Fill Address");
    }else if(area.text==""){
      showCommonDialogWithSingleOption(context, "Fill Area");
    }else if(country.text==""){
      showCommonDialogWithSingleOption(context, "Fill Country");
    }else if(state.text==""){
      showCommonDialogWithSingleOption(context, "Fill State");
    }else if(city.text==""){
      showCommonDialogWithSingleOption(context, "Fill City");
    }else if(pincode.text==""){
      showCommonDialogWithSingleOption(context, "Fill Pincode");
    }
    else{
      showCommonDialogWithTwoOptions(context, "Are you sure you want to save this Details?",
          negativeButtonTitle: "No",
          positiveButtonTitle: "Yes",
          onTapOfPositiveButton: (){
            Navigator.of(context).pop();
            if(contact!=""){

              Temp = contact.text;
              Temp2 = Temp.replaceAll("+", "").trim().toString();
              contact.text = Temp2;
              print(Temp2);
            }
      installationBloc.add(SaveInstallationCallEvent(saveid,
          SaveInstallationRequest(
            CustomerID: customerid.text.toString(),
            OutwardNo: outwardno.text.toString(),
            Address:address.text.toString(),
            Area: area.text.toString(),
            CountryCode: countrycode.text.toString(),
            StateCode: statecode.text.toString(),
            CityCode: citycode.text.toString(),
            PinCode: pincode.text.toString(),

            ContactNo: contact.text.toString(),
            InstallationDate: reversedate.text.toString(),
            InstallationPlace: IP.text.toString(),
            RoomCooling: RC.text.toString(),
            PowerStabilize:PS.text.toString(),
            GroundEarthing:ground.text.toString(),
            LoginUserID: this.LoginUserID.toString(),
            InstallationNo: installationno.text.toString(),
            EmployeeID: engineerid.text.toString(),
            TraineeName: traineename.text.toString(),
            MachineSRno: machine_serial_no.text.toString(),
            AprovedName: approvedname.text.toString(),
            AprovedDepart: approveddepartment.text.toString(),
            AprovedDesg:  approveddesignation.text.toString(),
            TraineeDepart: traineedepartment.text.toString(),
            TraineeDesg: traineedesignation.text.toString(),
            TraineeQuali: traineequalification.text.toString(),
            CompanyId: this.CompanyID.toString(),
            ProductID: productid.text.toString(),
          )));}
            );
    }
  }
  void fillData() async {

         customername.text=_editModel.customerName.toString();
     customerid.text=_editModel.customerID.toString();
    outwardno.text=_editModel.outwardNo.toString();
    address.text=_editModel.address.toString();
     area.text=_editModel.area.toString();
    countrycode.text=_editModel.countryCode.toString();
    statecode.text=_editModel.stateCode.toString();
    state.text=_editModel.stateName.toString();
    citycode.text=_editModel.cityCode.toString();
    city.text=_editModel.cityName.toString();
    pincode.text=_editModel.pinCode.toString();

     installationdate.text = _editModel.createdDate.getFormattedDate(
         fromFormat: "yyyy-MM-ddTHH:mm:ss",
         toFormat: "dd-MM-yyyy");
    reversedate.text=_editModel.createdDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    IP.text=_editModel.installationPlace.toString();
    RC.text=_editModel.roomCooling.toString();
    PS.text=_editModel.powerStabilize.toString();
    ground.text=_editModel.groundEarthing.toString();
    installationno.text=_editModel.installationNo.toString();
    engineername.text=_editModel.employeeName.toString();
    engineerid.text = _editModel.employeeID.toString();
     traineename.text=_editModel.traineeName.toString();
     machine_serial_no.text=_editModel.machineSRno.toString();
     approvedname.text=_editModel.aprovedName.toString();
     approveddepartment.text=_editModel.aprovedDepart.toString();
      approveddesignation.text=_editModel.aprovedDesg.toString();
     traineedepartment.text=_editModel.traineeDepart.toString();
     traineedesignation.text=_editModel.traineeDesg.toString();
    traineequalification.text=_editModel.traineeQuali.toString();
    country.text=_editModel.countryName.toString();
    contact.text=_editModel.contactNo.toString();
    saveid = _editModel.pkID;
    productid.text = _editModel.productID.toString();
    productname.text = _editModel.productName.toString();
    }

  void _ontapofsavedetails(SaveInstallationCallResponseState state) {
    print("save response");
      state.response.details[0].column2;
    showCommonDialogWithSingleOption(context, state.response.details[0].column2,
    onTapOfPositiveButton: (){
      navigateTo(context,InstallationListScreen.routeName);
    }
    );
  }
  }



