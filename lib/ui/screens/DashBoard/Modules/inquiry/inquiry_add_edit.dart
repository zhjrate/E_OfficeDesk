import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/inqiory_header_save_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_delete_product.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_list_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import '../../home_screen.dart';
import 'inquiry_product_list_screen.dart';

class AddUpdateInquiryScreenArguments {
  InquiryDetails editModel;

  AddUpdateInquiryScreenArguments(this.editModel);
}

class InquiryAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/InquiryAddEditScreen';
  final AddUpdateInquiryScreenArguments arguments;

  InquiryAddEditScreen(this.arguments);

  @override
  _InquiryAddEditScreenState createState() => _InquiryAddEditScreenState();
}

class _InquiryAddEditScreenState extends BaseState<InquiryAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  int _pageNo = 0;
  bool expanded = true;
  double sizeboxsize = 12;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  //CustomerSourceResponse _offlineCustomerSource;
  //InquiryStatusListResponse _offlineInquiryLeadStatusData;

  int CompanyID = 0;
  String LoginUserID = "";
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final TextEditingController edt_InquiryDate = TextEditingController();
  final TextEditingController edt_ReverseInquiryDate = TextEditingController();
  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerpkID = TextEditingController();
  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_LeadStatus = TextEditingController();
  final TextEditingController edt_LeadStatusID = TextEditingController();
  final TextEditingController edt_LeadSource = TextEditingController();
  final TextEditingController edt_LeadSourceID = TextEditingController();
  final TextEditingController edt_Reference_Name = TextEditingController();
  final TextEditingController edt_Reference_No = TextEditingController();
  final TextEditingController edt_Description = TextEditingController();
  final TextEditingController edt_FollowupNotes = TextEditingController();

  final TextEditingController edt_NextFollowupDate = TextEditingController();
  final TextEditingController edt_ReverseNextFollowupDate =
      TextEditingController();
  final TextEditingController edt_PreferedTime = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadSource = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_CloserReasonStatusType = [];

  InquiryDetails _editModel;
  bool _isForUpdate;
  String InquiryNo = "";
  int pkID = 0;
  List<InquiryProductModel> _inquiryProductList = [];
  FocusNode ReferenceFocusNode;

  // SearchInquiryListResponse _searchInquiryListResponse;
  // SearchInquiryCustomer _searchInquiryListResponse;
  SearchDetails _searchInquiryListResponse;

  final TextEditingController edt_CloserReasonStatusType =
      TextEditingController();
  final TextEditingController edt_CloserReasonStatusTypepkID =
      TextEditingController();
  bool ISDisQualified = false;
  bool ISDisQualifiedEmpty = false;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    // _offlineCustomerSource = SharedPrefHelper.instance.getCustomerSourceData();
    //  _offlineInquiryLeadStatusData = SharedPrefHelper.instance.getInquiryLeadStatus();
    // _onLeadSourceListTypeCallSuccess(_offlineCustomerSource);
    //_onLeadStatusListTypeCallSuccess(_offlineInquiryLeadStatusData);
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
    ReferenceFocusNode = FocusNode();
    FetchInquiryPriorityDetails();
    edt_LeadSource.addListener(() {
      ReferenceFocusNode.requestFocus();
    });
    edt_LeadStatus.addListener(() {
      setState(() {
        if (edt_LeadStatus.text == "Close - Lost") {
          ISDisQualified = true;
        } else {
          ISDisQualified = false;
        }
      });
    });

    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      edt_InquiryDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseInquiryDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

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

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      edt_PreferedTime.text =
          beforZeroHour + ":" + beforZerominute + " " + AM_PM;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, InquiryStates state) {
          if (state is InquiryHeaderSaveResponseState) {
            _OnHeaderSuccessResponse(state);
          }
          if (state is InquiryProductSaveResponseState) {
            _OnInquiryProductSaveResponse(state);
          }
          if (state is InquiryNotoProductResponseState) {
            _OnInquiryNoToProductListResponse(state);
          }
          if (state is InquiryNotoDeleteProductResponseState) {
            _OnInquiryNoTodeleteAllProduct(state);
          }
          if (state is InquiryLeadStatusListCallResponseState) {
            _onLeadStatusListTypeCallSuccess(state);
          }
          if (state is CustomerSourceCallEventResponseState) {
            _onLeadSourceListTypeCallSuccess(state);
          }
          if (state is CloserReasonListCallResponseState) {
            _onCloserReasonStatusListTypeCallSuccess(state);
          }
          /* if (state is SearchInquiryListByNameCallResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }*/
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is InquiryHeaderSaveResponseState ||
              currentState is InquiryProductSaveResponseState ||
              currentState is InquiryNotoProductResponseState ||
              currentState is InquiryLeadStatusListCallResponseState ||
              currentState is CustomerSourceCallEventResponseState ||
              currentState is CloserReasonListCallResponseState) {
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
          title: Text('Inquiry Details'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () async {
                  //_onTapOfLogOut();
                  await _onTapOfDeleteALLProduct();
                  navigateTo(context, HomeScreen.routeName,
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
                        _buildFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildSearchView(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        CustomDropDown1("Priority",
                            enable1: false,
                            title: "Lead Priority ",
                            hintTextvalue: "Tap to Select Lead Priority",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Priority,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Folowup_Priority),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        showcustomdialogWithID1("Lead Status",
                            enable1: false,
                            title: "Lead Status",
                            hintTextvalue: "Tap to Select Lead Status",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_LeadStatus,
                            controllerpkID: edt_LeadStatusID,
                            Custom_values1: arr_ALL_Name_ID_For_LeadStatus),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        showcustomdialogWithID1("Lead Source",
                            enable1: false,
                            title: "Lead Source *",
                            hintTextvalue: "Tap to Select Lead Source",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_LeadSource,
                            controllerpkID: edt_LeadSourceID,
                            Custom_values1: arr_ALL_Name_ID_For_LeadSource),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        RefernceName(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
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
                        _isForUpdate == false ? FollowupFields() : Container(),
                        ISDisQualified == true
                            ? Column(
                                children: [
                                  //edt_LeadStatus
                                  showcustomdialogWithID1("Closure Reason",
                                      enable1: false,
                                      title: "Closure Reason *",
                                      hintTextvalue:
                                          "Tap to Select Closer Reason",
                                      icon: Icon(Icons.arrow_drop_down),
                                      controllerForLeft:
                                          edt_CloserReasonStatusType,
                                      controllerpkID:
                                          edt_CloserReasonStatusTypepkID,
                                      Custom_values1:
                                          arr_ALL_Name_ID_For_CloserReasonStatusType),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              )
                            : Container(),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          child: getCommonButton(baseTheme, () {
                            //  _onTapOfDeleteALLContact();
                            //  navigateTo(context, InquiryProductListScreen.routeName);
                            print("INWWWE" + InquiryNo.toString());
                            navigateTo(
                                context, InquiryProductListScreen.routeName,
                                arguments: AddProductListArgument(InquiryNo));
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
                            if (ISDisQualified == true) {
                              if (edt_CloserReasonStatusType.text != "") {
                                ISDisQualifiedEmpty = true;
                              } else {
                                ISDisQualifiedEmpty = false;
                              }
                            } else {
                              ISDisQualifiedEmpty = true;
                            }

                            _onTapToSaveHeaderDetails();
                          }, "Save", width: 600),
                        ),
                        /* Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          child: getCommonButton(baseTheme, () {


                          }, "Save & Send Email", width: 600),
                        ),*/
                      ]))),
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );
  }

  Widget _buildFollowupDate() {
    return InkWell(
      onTap: () {
        _isForUpdate == false
            ? _selectDate(context, edt_InquiryDate)
            : Container();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Inquiry Date *",
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
                      edt_InquiryDate.text == null || edt_InquiryDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_InquiryDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_InquiryDate.text == null ||
                                  edt_InquiryDate.text == ""
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
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_InquiryDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseInquiryDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
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
            child: Text("Search Customer *",
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
    if (_isForUpdate == false) {
      navigateTo(context, SearchInquiryCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchInquiryListResponse = value;
          edt_CustomerName.text = _searchInquiryListResponse.label;
          edt_CustomerpkID.text = _searchInquiryListResponse.value.toString();
          /* _inquiryBloc.add(SearchInquiryListByNameCallEvent(
              SearchInquiryListByNameRequest(word:  edt_CustomerName.text,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID,needALL: "1")));
*/
          //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

        }
      });
    }
  }

  Future<bool> _onBackPressed() async {
    await _onTapOfDeleteALLProduct();
    navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
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

  Widget showcustomdialogWithID1(String Category,
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

  void _onLeadSourceListTypeCallSuccess(
      CustomerSourceCallEventResponseState state) {
    if (state.sourceResponse.details.length != 0) {
      arr_ALL_Name_ID_For_LeadSource.clear();
      for (var i = 0; i < state.sourceResponse.details.length; i++) {
        print(
            "InquiryStatus : " + state.sourceResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.sourceResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.sourceResponse.details[i].pkID;
        arr_ALL_Name_ID_For_LeadSource.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_LeadSource,
          context1: context,
          controller: edt_LeadSource,
          controllerID: edt_LeadSourceID,
          lable: "Select Source");
    }
  }

  Widget RefernceName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Reference Name",
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
                      textInputAction: TextInputAction.next,
                      focusNode: ReferenceFocusNode,
                      controller: edt_Reference_Name,
                      decoration: InputDecoration(
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

  Widget RefernceNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Reference No",
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
                      controller: edt_Reference_No,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Ref.No",
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

  void fillData() async {
    pkID = _editModel.pkID;
    edt_InquiryDate.text = _editModel.inquiryDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    edt_ReverseInquiryDate.text = _editModel.inquiryDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    edt_CustomerName.text = _editModel.customerName.toString();
    edt_CustomerpkID.text = _editModel.customerID.toString();
    edt_Priority.text = _editModel.priority;
    edt_LeadStatus.text = _editModel.inquiryStatus.toString();
    edt_LeadStatusID.text = _editModel.inquiryStatusID.toString();
    edt_LeadSourceID.text = _editModel.inquirySource.toString();
    edt_LeadSource.text = _editModel.InquirySourceName.toString();
    edt_Reference_Name.text = _editModel.referenceName.toString();
    edt_Description.text = _editModel.meetingNotes.toString();
    edt_ReverseNextFollowupDate.text = "";
    edt_PreferedTime.text = "";
    edt_FollowupNotes.text = "";
    InquiryNo = _editModel.inquiryNo;
    edt_CloserReasonStatusType.text = _editModel.closureReason;
    edt_CloserReasonStatusTypepkID.text = _editModel.closureReasonID.toString();

    if (InquiryNo != '') {
      await _onTapOfDeleteALLProduct();
      _inquiryBloc.add(InquiryNotoProductCallEvent(
          InquiryNoToProductListRequest(
              InquiryNo: InquiryNo, CompanyId: CompanyID.toString())));
    }
  }

  _onTapToSaveHeaderDetails() async {
    await getInquiryProductDetails();

    if (edt_InquiryDate.text.toString().trim() != '') {
      if (edt_CustomerName.text.toString().trim() != '') {
        if (edt_LeadSource.text.toString().trim() != '') {
          if (edt_Description.text.toString().trim() != '') {
            if (ISDisQualifiedEmpty == true) {
              if (_inquiryProductList.length != 0) {
                print("HeaderDetailsRequestParam" +
                    "InquiryDate" +
                    edt_InquiryDate.text +
                    "ReverseInquiryDate" +
                    edt_ReverseInquiryDate.text +
                    "CustomerID" +
                    edt_CustomerpkID.text +
                    " CustomerName" +
                    edt_CustomerName.text +
                    "InquiryNo " +
                    InquiryNo +
                    "MeetingNotes" +
                    edt_Description.text +
                    "InquirySourceID" +
                    edt_LeadSourceID.text +
                    "InquirySource" +
                    edt_LeadSource.text +
                    "ReferenceName" +
                    edt_Reference_Name.text +
                    "InquiryStatusID" +
                    edt_LeadStatusID.text +
                    "LoginUserID" +
                    LoginUserID +
                    "Priority" +
                    edt_Priority.text +
                    "CompanyId" +
                    CompanyID.toString());

                showCommonDialogWithTwoOptions(
                    context, "Are you sure you want to Save this Inquiry?",
                    negativeButtonTitle: "No",
                    positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
                  Navigator.of(context).pop();
                  if (InquiryNo != '') {
                    _inquiryBloc.add(InquiryNotoDeleteProductCallEvent(
                        InquiryNo,
                        InquiryNoToDeleteProductRequest(
                            InquiryNo: InquiryNo,
                            CompanyId: CompanyID.toString())));
                  }
                  _inquiryBloc.add(InquiryHeaderSaveNameCallEvent(
                      pkID,
                      InquiryHeaderSaveRequest(
                          pkID: pkID.toString(),
                          FollowupDate:
                              edt_ReverseNextFollowupDate.text.toString(),
                          CustomerID: edt_CustomerpkID.text.toString(),
                          InquiryNo: InquiryNo,
                          InquiryDate: edt_ReverseInquiryDate.text.toString(),
                          MeetingNotes: edt_Description.text.toString(),
                          InquirySource: edt_LeadSource.text
                              .toString(), //edt_LeadSourceID.text.toString(),
                          ReferenceName: edt_Reference_Name.text.toString(),
                          FollowupNotes: edt_FollowupNotes.text.toString(),
                          InquiryStatusID: edt_LeadStatusID.text.toString(),
                          LoginUserID: LoginUserID,
                          Latitude: SharedPrefHelper.instance.getLatitude(),
                          Longitude: SharedPrefHelper.instance.getLongitude(),
                          FollowupTypeID: "5",
                          PreferredTime: edt_PreferedTime.text.toString(),
                          Priority: edt_Priority.text.toString(),
                          CompanyId: CompanyID.toString(),
                          ClosureReason:
                              edt_CloserReasonStatusTypepkID.text.toString() ==
                                      null
                                  ? 0
                                  : edt_CloserReasonStatusTypepkID.text
                                      .toString())));
                });
              } else {
                showCommonDialogWithSingleOption(
                    context, "Product Details are required!",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(
                  context, "Closer Reason is required!",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(
                context, "Description is required!",
                positiveButtonTitle: "OK");
          }
        } else {
          showCommonDialogWithSingleOption(context, "Lead Source is required!",
              positiveButtonTitle: "OK");
        }
      } else {
        showCommonDialogWithSingleOption(context, "Customer Name is required!",
            positiveButtonTitle: "OK");
      }
    } else {
      showCommonDialogWithSingleOption(context, "LeadDate is required!",
          positiveButtonTitle: "OK");
    }
  }

  void _OnHeaderSuccessResponse(InquiryHeaderSaveResponseState state) {
    print("InquiryHeaderResponse" +
        state.inquiryHeaderSaveResponse.details[0].column2 +
        "\n" +
        state.inquiryHeaderSaveResponse.details[0].column3);

    updateRetrunInquiryNoToDB(
        state.inquiryHeaderSaveResponse.details[0].column3);
    _inquiryBloc.add(InquiryProductSaveCallEvent(_inquiryProductList));
  }

  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<InquiryProductModel> temp =
        await OfflineDbHelper.getInstance().getInquiryProduct();
    _inquiryProductList.addAll(temp);
    setState(() {});
  }

  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLInquiryProduct();
  }

  void updateRetrunInquiryNoToDB(String ReturnInquiryNo) {
    _inquiryProductList.forEach((element) {
      element.InquiryNo = ReturnInquiryNo;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }

  _OnInquiryProductSaveResponse(InquiryProductSaveResponseState state) async {
    print("InquiryHeaderResponse " +
        state.inquiryProductSaveResponse.details[0].column2);
    String Msg = _isForUpdate == true
        ? "Inquiry Updated Successfully"
        : "Inquiry Added Successfully";

    /* showCommonDialogWithSingleOption(context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
          navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
        });*/
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
      navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
    });
  }

  _OnInquiryNoToProductListResponse(InquiryNotoProductResponseState state) {
    for (var i = 0; i < state.inquiryNoToProductResponse.details.length; i++) {
      /* String LoginUserID="abc";
    String CompanyId="0";
    String InquiryNo="0";*/
      String ProductName =
          state.inquiryNoToProductResponse.details[i].productName;
      String ProductID =
          state.inquiryNoToProductResponse.details[i].productID.toString();
      String Quantity =
          state.inquiryNoToProductResponse.details[i].quantity.toString();
      String UnitPrice =
          state.inquiryNoToProductResponse.details[i].unitPrice.toString();
      double totamnt = double.parse(Quantity) * double.parse(UnitPrice);
      String TotalAmount = totamnt.toString();
      _onTapOfAdd(ProductName, ProductID, Quantity, UnitPrice, TotalAmount);
    }
  }

  _onTapOfAdd(String productName, String ProductID, String Quantity,
      String UnitPrice, String TotalAmount) async {
    await OfflineDbHelper.getInstance()
        .insertInquiryProduct(InquiryProductModel(
      "test",
      "0",
      "abc",
      productName,
      ProductID,
      Quantity,
      UnitPrice,
      TotalAmount,
    ));
  }

  _OnInquiryNoTodeleteAllProduct(InquiryNotoDeleteProductResponseState state) {
    print("InquiryHeaderResponse " +
        state.inquiryNoToDeleteProductResponse.details[0].column2);
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

  CreateDialogDropdown(String category) {
    if (category == "Lead Status") {
      _inquiryBloc.add(InquiryLeadStatusTypeListByNameCallEvent(
          FollowupInquiryStatusTypeListRequest(
              CompanyId: CompanyID.toString(),
              pkID: "",
              StatusCategory: "Inquiry",
              LoginUserID: LoginUserID,
              SearchKey: "")));
    } else if (category == "Closure Reason") {
      _inquiryBloc
        ..add(CloserReasonTypeListByNameCallEvent(CloserReasonTypeListRequest(
            CompanyId: CompanyID.toString(),
            pkID: "",
            StatusCategory: "DisQualifiedReason",
            LoginUserID: LoginUserID,
            SearchKey: "")));
    } else {
      _inquiryBloc.add(CustomerSourceCallEvent(CustomerSourceRequest(
          pkID: "0",
          StatusCategory: "InquirySource",
          companyId: CompanyID,
          LoginUserID: LoginUserID,
          SearchKey: "")));
    }
  }

  void _onSearchInquiryListCallSuccess(
      SearchInquiryListByNameCallResponseState state) {
    if (state.response.details.isNotEmpty) {
      for (int i = 0; i < state.response.details.length; i++) {
        int empID = state.response.details[i].createdEmployeeID;
        if (_offlineLoggedInData.details[0].employeeID == empID) {
          showCommonDialogWithSingleOption(
              context, "Customer is Already Created by ",
              positiveButtonTitle: "OK");
        }
      }
    }
  }

  void _onCloserReasonStatusListTypeCallSuccess(
      CloserReasonListCallResponseState state) {
    if (state.closerReasonListResponse.details.length != 0) {
      arr_ALL_Name_ID_For_CloserReasonStatusType.clear();
      for (var i = 0; i < state.closerReasonListResponse.details.length; i++) {
        print("CloserReasonStatus : " +
            state.closerReasonListResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.closerReasonListResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.closerReasonListResponse.details[i].pkID;
        arr_ALL_Name_ID_For_CloserReasonStatusType.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_CloserReasonStatusType,
          context1: context,
          controller: edt_CloserReasonStatusType,
          controllerID: edt_CloserReasonStatusTypepkID,
          lable: "Select DisQualified Reason");
    }
  }
}
