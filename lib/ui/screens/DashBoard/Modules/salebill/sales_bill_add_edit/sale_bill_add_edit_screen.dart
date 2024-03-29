import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/blocs/other/bloc_modules/salesbill/salesbill_bloc.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sale_bill_email_content_request.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sales_bill_inq_QT_SO_NO_list_Request.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/quotation_terms_condition_request.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/sales_bill_list_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/sales_bill_table.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/sale_bill_db/sale_bill_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'module_no_list_screen.dart';

class AddUpdateSaleBillScreenArguments {
  SaleBillDetails editModel;

  AddUpdateSaleBillScreenArguments(this.editModel);
}

class SalesBillAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/SalesBillAddEditScreen';

  final AddUpdateSaleBillScreenArguments arguments;

  SalesBillAddEditScreen(this.arguments);

  @override
  _SalesBillAddEditScreenState createState() => _SalesBillAddEditScreenState();
}

class _SalesBillAddEditScreenState extends BaseState<SalesBillAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  SalesBillBloc salesBillBloc;
  final _formKey = GlobalKey<FormState>();
  bool _isForUpdate;
  SaleBillDetails _editModel;
  int pkID = 0;

  SearchDetails _searchInquiryListResponse;

  TextEditingController _controller_order_no = TextEditingController();
  TextEditingController _controller_customer_name = TextEditingController();
  TextEditingController _controller_customer_pkID = TextEditingController();

  TextEditingController _controller_order_date = TextEditingController();
  TextEditingController _controller_rev_order_date = TextEditingController();
  TextEditingController _controller_PINO = TextEditingController();
  TextEditingController _controller_PI_date = TextEditingController();
  TextEditingController _controller_rev_PI_date = TextEditingController();
  TextEditingController _controller_AC_name = TextEditingController();
  TextEditingController _controller_AC_ID = TextEditingController();
  TextEditingController _controller_bank_name = TextEditingController();
  TextEditingController _controller_bank_ID = TextEditingController();

  TextEditingController _controller_select_inquiry = TextEditingController();
  TextEditingController _controller_select_Multiinquiry =
      TextEditingController();

  TextEditingController _controller_inquiry_no = TextEditingController();
  TextEditingController _controller_sales_executive = TextEditingController();
  TextEditingController _controller_supplier_ref_no = TextEditingController();
  TextEditingController _controller_reference_date = TextEditingController();

  TextEditingController _controller_work_Due_date = TextEditingController();
  TextEditingController _controller_work_Due_date_Reverse =
      TextEditingController();
  TextEditingController _controller_delivery_date = TextEditingController();
  TextEditingController _controller_rev_delivery_date = TextEditingController();
  TextEditingController _controller_rev_reference_date =
      TextEditingController();
  TextEditingController _controller_Project = TextEditingController();
  TextEditingController _controller_CR_Days = TextEditingController();
  TextEditingController _controller_credit_days = TextEditingController();
  TextEditingController _controller_OtherRef_no = TextEditingController();
  TextEditingController _controller_docNo = TextEditingController();

  final TextEditingController edt_QualifiedState = TextEditingController();
  final TextEditingController edt_QualifiedStateCode = TextEditingController();
  final TextEditingController edt_QualifiedCity = TextEditingController();
  final TextEditingController edt_QualifiedCityCode = TextEditingController();
  TextEditingController _controller_vihical_no = TextEditingController();
  TextEditingController _controller_Delivery_Notes = TextEditingController();

  TextEditingController _contrller_terms_and_condition =
      TextEditingController();
  TextEditingController _contrller_select_terms_and_condition =
      TextEditingController();
  TextEditingController _contrller_select_terms_and_conditionID =
      TextEditingController();
  TextEditingController _controller_select_email_subject =
      TextEditingController();
  TextEditingController _controller_select_email_subject_ID =
      TextEditingController();
  TextEditingController _contrller_email_subject = TextEditingController();
  TextEditingController _contrller_email_introcuction = TextEditingController();
  TextEditingController _controller_amount = TextEditingController();
  TextEditingController _controller_transport_name = TextEditingController();

  TextEditingController _controller_place_of_rec = TextEditingController();
  TextEditingController _controller_flight_no = TextEditingController();
  TextEditingController _controller_port_of_loading = TextEditingController();
  TextEditingController _controller_port_of_dispatch = TextEditingController();
  TextEditingController _controller_port_of_destination =
      TextEditingController();
  TextEditingController _controller_container_no = TextEditingController();
  TextEditingController _controller_packages = TextEditingController();

  TextEditingController _controller_type_of_package = TextEditingController();
  TextEditingController _controller_net_weight = TextEditingController();
  TextEditingController _controller_gross_weight = TextEditingController();
  TextEditingController _controller_FOB = TextEditingController();
  TextEditingController _controller_mode_of_transfer = TextEditingController();
  TextEditingController _controller_Transporter = TextEditingController();

  TextEditingController _controller_LR_NO = TextEditingController();

  TextEditingController _controller_Remarks = TextEditingController();
  TextEditingController _controller_e_way_bill_No = TextEditingController();
  TextEditingController _controller_Mode_of_Payment = TextEditingController();
  TextEditingController _controller_DeliverTo = TextEditingController();

  TextEditingController _controller_LR_date = TextEditingController();
  TextEditingController _controller_LR_date_Reveres = TextEditingController();

  TextEditingController edt_StateCode = TextEditingController();

  TextEditingController edt_HeaderDisc = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_AC_Name = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Bank_Name = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_INQ_QT_SO_List = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_INQ_QT_SO_Filter_List = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Sales_Executive = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Select_Project = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Terms_And_Condition = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Email_Subject = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_ModeOfTransfer = [];
  List<SaleBillTable> _inquiryProductList = [];

  DateTime selectedDate = DateTime.now();

  DateTime selectedInvoiceDate = DateTime.now();
  DateTime selectedRefDate = DateTime.now();
  DateTime selectedDueDate = DateTime.now();
  DateTime selectedLRDate = DateTime.now();
  DateTime selectedDeliveryDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();
  double dateFontSize = 13;
  double CardViewHieght = 35;

  SearchStateDetails _searchStateDetails;
  SearchCityDetails _searchCityDetails;

  List<File> MultipleVideoList = [];
  final imagepicker = ImagePicker();

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  String InquiryNo = "";

  @override
  void initState() {
    super.initState();

    salesBillBloc = SalesBillBloc(baseBloc);

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _isForUpdate = widget.arguments != null;

    getAccountNameAPI();

    getSelectOptionList();

    salesBillBloc.add(QuotationBankDropDownCallEvent(BankDropDownRequest(
        CompanyID: CompanyID.toString(), LoginUserID: LoginUserID, pkID: "")));
    salesBillBloc.add(QuotationTermsConditionCallEvent(
        QuotationTermsConditionRequest(
            CompanyId: CompanyID.toString(), LoginUserID: LoginUserID)));

    salesBillBloc.add(SalesBillEmailContentRequestEvent(
        SalesBillEmailContentRequest(
            CompanyId: CompanyID.toString(), LoginUserID: LoginUserID)));

    _controller_select_inquiry.addListener(() {
      setState(() {
        if (_controller_customer_pkID.text != null ||
            _controller_customer_pkID.text != "") {
          if (_controller_select_inquiry.text == "Inquiry") {
            salesBillBloc.add(SaleBill_INQ_QT_SO_NO_ListRequestEvent(
                SaleBill_INQ_QT_SO_NO_ListRequest(
                    CompanyId: CompanyID.toString(),
                    CustomerID: _controller_customer_pkID.text.toString(),
                    ModuleType: "Inquiry")));
          } else if (_controller_select_inquiry.text == "Quotation") {
            salesBillBloc.add(SaleBill_INQ_QT_SO_NO_ListRequestEvent(
                SaleBill_INQ_QT_SO_NO_ListRequest(
                    CompanyId: CompanyID.toString(),
                    CustomerID: _controller_customer_pkID.text.toString(),
                    ModuleType: "Quotation")));
          } else if (_controller_select_inquiry.text == "SalesOrder") {
            salesBillBloc.add(SaleBill_INQ_QT_SO_NO_ListRequestEvent(
                SaleBill_INQ_QT_SO_NO_ListRequest(
                    CompanyId: CompanyID.toString(),
                    CustomerID: _controller_customer_pkID.text.toString(),
                    ModuleType: "SalesOrder")));
          }
        } else {
          showCommonDialogWithSingleOption(
              context, "Customer name is required To view Option !",
              positiveButtonTitle: "OK");
        }
      });
    });
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      _controller_order_date.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      _controller_rev_order_date.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
      edt_StateCode.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => salesBillBloc,
      child: BlocConsumer<SalesBillBloc, SalesBillStates>(
        builder: (BuildContext context, SalesBillStates state) {
          if (state is QuotationBankDropDownResponseState) {
            _OnBankDetailsSucess(state);
          }
          if (state is QuotationTermsCondtionResponseState) {
            _OnTermsAndConditionResponse(state);
          }
          if (state is SaleBillEmailContentResponseState) {
            _OnEmailContentResponse(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is QuotationBankDropDownResponseState ||
              currentState is QuotationTermsCondtionResponseState ||
              currentState is SaleBillEmailContentResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, SalesBillStates state) {
          if (state is SalesBill_INQ_QT_SO_NO_ListResponseState) {
            _OnINQ_QT_SO_NO_Response(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is SalesBill_INQ_QT_SO_NO_ListResponseState) {
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
              title: Text('Sales Bill Details'),
              gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red]),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //#CustomerInformation
                        MandatoryDetails(),
                        BasicInformation(),
                        ProductDetails(),
                        EmailContent(),
                        TermsCondition(),
                        TransportDetails(),
                        ShipmentDetails(),
                        Attachments(),
                        SizedBox(
                          height: 20,
                        ),
                        getCommonButton(baseTheme, () {}, "Save",
                            radius: 20, backGroundColor: colorPrimary)
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  void fillData() async {
    pkID = _editModel.pkID;
    print("PKID" + pkID.toString());

    _controller_order_date.text = _editModel.invoiceDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    _controller_rev_order_date.text = _editModel.invoiceDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");

    _controller_customer_name.text = _editModel.customerName.toString();
    _controller_customer_pkID.text = _editModel.customerID.toString();
  }

  Widget BasicDetails() {}

  Widget createTextFormField(
      TextEditingController _controller, String _hintText,
      {int minLines = 1,
      int maxLines = 1,
      double height = 40,
      double left = 5,
      double right = 5,
      double top = 8,
      double bottom = 10,
      TextInputType keyboardInput = TextInputType.number}) {
    return Card(
      color: colorLightGray,
      margin:
          EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          minLines: minLines,
          maxLines: maxLines,
          style: TextStyle(fontSize: 13),
          controller: _controller,
          textInputAction: TextInputAction.next,
          keyboardType: keyboardInput,
          decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: TextStyle(fontSize: 13, color: colorGrayDark),
              filled: true,
              fillColor: colorLightGray,
              contentPadding: EdgeInsets.symmetric(horizontal: 14),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              )),
        ),
      ),
    );
  }

  Widget createTextLabel(String labelName, double leftPad, double rightPad) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: leftPad, right: rightPad),
        child: Row(
          children: [
            Text(labelName,
                style: TextStyle(
                    fontSize: 10,
                    color: colorBlack,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDate() {
    return InkWell(
      onTap: () {
        _selectDate(
            context, _controller_order_date, _controller_rev_order_date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: 5,
          // ),
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _controller_order_date.text == null ||
                              _controller_order_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_order_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_order_date.text == null ||
                                  _controller_order_date.text == ""
                              ? colorGrayDark
                              : colorBlack,
                          fontSize: 15),
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
                    fontSize: 11,
                    color: colorBlack,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: _controller_customer_name,
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 7),
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
          _controller_customer_name.text = _searchInquiryListResponse.label;
          _controller_customer_pkID.text =
              _searchInquiryListResponse.value.toString();

          edt_StateCode.text = _searchInquiryListResponse.stateCode.toString();
          edt_QualifiedState.text =
              _searchInquiryListResponse.stateName.toString();
          edt_QualifiedStateCode.text =
              _searchInquiryListResponse.stateCode.toString();
          edt_QualifiedCity.text =
              _searchInquiryListResponse.CityName.toString();
          edt_QualifiedCityCode.text =
              _searchInquiryListResponse.CityCode.toString();
        }
      });
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
                /*SizedBox(
                  height: 5,
                ),*/
                Card(
                  elevation: 3,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 7),
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

  Widget CustomDropDownWithID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controllerForID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithID(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                controllerID: controllerForID,
                lable: "Select $Category"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*SizedBox(
                  height: 5,
                ),*/
                Card(
                  elevation: 3,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 7),
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

  Widget CustomDropDownWithMultiID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithMultipleID(
                values: arr_ALL_Name_ID_For_Terms_And_Condition,
                context1: context,
                controller: _contrller_select_terms_and_condition,
                controllerID: _contrller_select_terms_and_conditionID,
                controller2: _contrller_terms_and_condition,
                lable: "Select Term & Condition "),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*SizedBox(
                  height: 5,
                ),*/
                Card(
                  elevation: 3,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: _contrller_select_terms_and_condition,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 7),
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

  Widget EmailSubjectWithMultiID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithMultipleID(
                values: arr_ALL_Name_ID_For_Email_Subject,
                context1: context,
                controller: _controller_select_email_subject,
                controllerID: _controller_select_email_subject_ID,
                controller2: _contrller_email_subject,
                lable: "Select Term & Condition "),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*SizedBox(
                  height: 5,
                ),*/
                Card(
                  elevation: 3,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: _controller_select_email_subject,
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 7),
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

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedInvoiceDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedInvoiceDate = picked;
        selectedRefDate = picked;
        selectedDueDate = picked;
        selectedLRDate = picked;
        selectedDeliveryDate = picked;
        F_datecontroller.text = selectedInvoiceDate.day.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.year.toString();
        Rev_dateController.text = selectedInvoiceDate.year.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.day.toString();

        _controller_reference_date.text = selectedInvoiceDate.day.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.year.toString();
        _controller_rev_reference_date.text =
            selectedInvoiceDate.year.toString() +
                "-" +
                selectedInvoiceDate.month.toString() +
                "-" +
                selectedInvoiceDate.day.toString();
        _controller_work_Due_date.text = selectedInvoiceDate.day.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.year.toString();
        _controller_work_Due_date_Reverse.text =
            selectedInvoiceDate.year.toString() +
                "-" +
                selectedInvoiceDate.month.toString() +
                "-" +
                selectedInvoiceDate.day.toString();

        _controller_LR_date.text = selectedInvoiceDate.day.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.year.toString();
        _controller_LR_date_Reveres.text = selectedInvoiceDate.year.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.day.toString();
        _controller_delivery_date.text = selectedInvoiceDate.day.toString() +
            "-" +
            selectedInvoiceDate.month.toString() +
            "-" +
            selectedInvoiceDate.year.toString();

        _controller_rev_delivery_date.text =
            selectedInvoiceDate.year.toString() +
                "-" +
                selectedInvoiceDate.month.toString() +
                "-" +
                selectedInvoiceDate.day.toString();
      });
  }

  Future<void> _selectDueDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDueDate,
        firstDate: selectedInvoiceDate,
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDueDate = picked;
        F_datecontroller.text = selectedDueDate.day.toString() +
            "-" +
            selectedDueDate.month.toString() +
            "-" +
            selectedDueDate.year.toString();
        Rev_dateController.text = selectedDueDate.year.toString() +
            "-" +
            selectedDueDate.month.toString() +
            "-" +
            selectedDueDate.day.toString();
      });
  }

  Future<void> _selectRefDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedRefDate,
        firstDate: selectedInvoiceDate,
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedRefDate = picked;
        F_datecontroller.text = selectedRefDate.day.toString() +
            "-" +
            selectedRefDate.month.toString() +
            "-" +
            selectedRefDate.year.toString();
        Rev_dateController.text = selectedRefDate.year.toString() +
            "-" +
            selectedRefDate.month.toString() +
            "-" +
            selectedRefDate.day.toString();
      });
  }

  Future<void> _selectLRDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedLRDate,
        firstDate: selectedInvoiceDate,
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedLRDate = picked;
        F_datecontroller.text = selectedLRDate.day.toString() +
            "-" +
            selectedLRDate.month.toString() +
            "-" +
            selectedLRDate.year.toString();
        Rev_dateController.text = selectedLRDate.year.toString() +
            "-" +
            selectedLRDate.month.toString() +
            "-" +
            selectedLRDate.day.toString();
      });
  }

  Future<void> _selectDeliveryDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDeliveryDate,
        firstDate: selectedInvoiceDate,
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDeliveryDate = picked;
        F_datecontroller.text = selectedDeliveryDate.day.toString() +
            "-" +
            selectedDeliveryDate.month.toString() +
            "-" +
            selectedDeliveryDate.year.toString();
        Rev_dateController.text = selectedDeliveryDate.year.toString() +
            "-" +
            selectedDeliveryDate.month.toString() +
            "-" +
            selectedDeliveryDate.day.toString();
      });
  }

  Widget _buildReferenceDate() {
    return InkWell(
      onTap: () {
        _selectRefDate(context, _controller_reference_date,
            _controller_rev_reference_date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  SizedBox(
            height: 5,
          ),*/
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _controller_reference_date.text == null ||
                              _controller_reference_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_reference_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_reference_date.text == null ||
                                  _controller_reference_date.text == ""
                              ? colorGrayDark
                              : colorBlack,
                          fontSize: dateFontSize),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 17,
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

  Widget _buildLRDate() {
    return InkWell(
      onTap: () {
        _selectLRDate(
            context, _controller_LR_date, _controller_LR_date_Reveres);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  SizedBox(
            height: 5,
          ),*/
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _controller_LR_date.text == null ||
                              _controller_LR_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_LR_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_LR_date.text == null ||
                                  _controller_LR_date.text == ""
                              ? colorGrayDark
                              : colorBlack,
                          fontSize: dateFontSize),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 17,
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

  Widget _buildDeliveryDate() {
    return InkWell(
      onTap: () {
        _selectDeliveryDate(
            context, _controller_delivery_date, _controller_rev_delivery_date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  SizedBox(
            height: 5,
          ),*/
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _controller_delivery_date.text == null ||
                              _controller_delivery_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_delivery_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_delivery_date.text == null ||
                                  _controller_delivery_date.text == ""
                              ? colorGrayDark
                              : colorBlack,
                          fontSize: dateFontSize),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                    size: 17,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWorkOrdereDate() {
    return InkWell(
      onTap: () {
        _selectDueDate(context, _controller_work_Due_date,
            _controller_work_Due_date_Reverse);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  SizedBox(
            height: 5,
          ),*/
          Card(
            elevation: 3,
            color: colorLightGray,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _controller_work_Due_date.text == null ||
                              _controller_work_Due_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_work_Due_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_work_Due_date.text == null ||
                                  _controller_work_Due_date.text == ""
                              ? colorGrayDark
                              : colorBlack,
                          fontSize: dateFontSize),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                    size: 17,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget QualifiedState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Term.Of Del.-State",
              style: TextStyle(
                  fontSize: 11,
                  color: colorBlack,
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () => _onTapOfSearchStateView("IND"),
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

  Future<void> _onTapOfSearchStateView(String sw1) async {
    navigateTo(context, SearchStateScreen.routeName,
            arguments: StateArguments(sw1))
        .then((value) {
      if (value != null) {
        _searchStateDetails = value;
        edt_QualifiedStateCode.text = _searchStateDetails.value.toString();
        edt_QualifiedState.text = _searchStateDetails.label.toString();
      }
    });
  }

  Widget QualifiedCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Term.Of Del.-City",
              style: TextStyle(
                  fontSize: 11,
                  color: colorBlack,
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

  Future<void> _onTapOfSearchCityView(String talukaCode) async {
    navigateTo(context, SearchCityScreen.routeName,
            arguments: CityArguments(talukaCode))
        .then((value) {
      if (value != null) {
        _searchCityDetails = value;
        edt_QualifiedCityCode.text = _searchCityDetails.cityCode.toString();
        edt_QualifiedCity.text = _searchCityDetails.cityName.toString();
      }
    });
  }

  EmailContent() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.white70,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,

                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Email Content",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      EMAIL,
                      width: 27,
                      color: Colors.white,
                    ),
                  ),
                ),

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        createTextLabel("Select Subject", 10.0, 0.0),
                        SizedBox(
                          height: 3,
                        ),
                        EmailSubjectWithMultiID1("Email Subject",
                            enable1: false,
                            title: "Email Subject",
                            hintTextvalue: "Tap to Select Subject",
                            icon: Icon(Icons.arrow_drop_down),
                            Custom_values1: arr_ALL_Name_ID_For_Email_Subject),
                        SizedBox(
                          height: 10,
                        ),
                        createTextLabel("Subject", 10.0, 0.0),
                        createTextFormField(
                            _controller_select_email_subject, "Email Subject",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                        createTextLabel("Email Introduction", 10.0, 0.0),
                        createTextFormField(
                            _contrller_email_subject, "Email Introduction",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            bottom: 5,
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  TermsCondition() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.white70,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,

                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Terms & Condition",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      CREDIT_INFORMATION,
                      width: 27,
                    ),
                  ),
                ),

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        createTextLabel("Select Terms & Condition", 10.0, 0.0),
                        SizedBox(
                          height: 3,
                        ),
                        CustomDropDownWithMultiID1("Terms & Conditions",
                            enable1: false,
                            title: "Terms & Conditions",
                            hintTextvalue: "Tap to Select Terms & Conditions",
                            icon: Icon(Icons.arrow_drop_down),
                            Custom_values1:
                                arr_ALL_Name_ID_For_Terms_And_Condition),
                        SizedBox(
                          height: 10,
                        ),
                        createTextLabel("Terms & Condition", 10.0, 0.0),
                        createTextFormField(
                            _contrller_terms_and_condition, "Terms & Condition",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  BasicInformation() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,

                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Basic Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      BASIC_INFORMATION,
                      width: 28,
                    ),
                  ),
                ),

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Select Option", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Inq/QT/SO No.", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              // flex: 2,
                              child: CustomDropDown1("Option",
                                  enable1: false,
                                  title: "Select Option",
                                  hintTextvalue: "Tap to select",
                                  icon: Icon(Icons.arrow_drop_down),
                                  controllerForLeft: _controller_select_inquiry,
                                  Custom_values1:
                                      arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry),
                            ),
                            /*  Flexible(
                                // flex: 1,
                                child: CustomDropDown1("Select No.",
                                    enable1: false,
                                    title: "Select No",
                                    hintTextvalue: "Tap to select",
                                    icon: Icon(Icons.arrow_drop_down),
                                    controllerForLeft:
                                        _controller_select_Multiinquiry,
                                    Custom_values1:
                                        arr_ALL_Name_ID_For_INQ_QT_SO_List)),*/

                            Flexible(child: ModuleNo(context))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextLabel("Supp.Ref #", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Ref. Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_supplier_ref_no, "Reference No."),
                            ),
                            Flexible(child: _buildReferenceDate())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1, child: QualifiedState()),
                            Expanded(flex: 1, child: QualifiedCity()),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("Other's Ref.", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel(
                                  "Dispatch Doc. No.", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_OtherRef_no, "Other's Ref.")),
                            Flexible(
                                child: createTextFormField(
                                    _controller_docNo, "Dispatch Doc No."))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("CR Days", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Due Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_CR_Days, "CR Days")),
                            Flexible(child: _buildWorkOrdereDate())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  MandatoryDetails() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 1),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(child: createTextLabel("Invoice No.", 10.0, 0.0)),
                  Flexible(
                    flex: 2,
                    child: createTextLabel("Invoice Date", 10.0, 0.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child:
                        createTextFormField(_controller_order_no, "Order No."),
                  ),
                  Flexible(flex: 2, child: _buildOrderDate())
                ],
              ),
              SizedBox(
                width: 20,
                height: 15,
              ),
              _buildSearchView(),
              SizedBox(
                width: 20,
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text("Sales A/c*",
                    style: TextStyle(
                        fontSize: 11,
                        color: colorBlack,
                        fontWeight: FontWeight
                            .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),
              ),
              CustomDropDownWithID1("Sales A/c",
                  enable1: false,
                  title: "Sales A/c*",
                  hintTextvalue: "Tap to Select Sales A/c",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_AC_name,
                  controllerForID: _controller_AC_ID,
                  Custom_values1: arr_ALL_Name_ID_For_Sales_Order_AC_Name),
              SizedBox(
                width: 20,
                height: 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text("Bank Name",
                    style: TextStyle(
                        fontSize: 11,
                        color: colorBlack,
                        fontWeight: FontWeight
                            .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),
              ),
              CustomDropDownWithID1("Bank Name",
                  enable1: false,
                  title: "Bank Name",
                  hintTextvalue: "Tap to Select Bank",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_bank_name,
                  controllerForID: _controller_bank_ID,
                  Custom_values1: arr_ALL_Name_ID_For_Sales_Order_Bank_Name),
            ],
          ),
        ),
      ),
      // height: 60,
    );
  }

  ProductDetails() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          child: getCommonButton(baseTheme, () {
            if (_controller_customer_name.text != "") {
              // print("INWWWE" + InquiryNo.toString());

              for (int i = 0;
                  i < arr_ALL_Name_ID_For_INQ_QT_SO_Filter_List.length;
                  i++) {
                print("sldsdf" +
                    " Filter InqList : " +
                    arr_ALL_Name_ID_For_INQ_QT_SO_Filter_List[i].Name +
                    " ISChecked : " +
                    arr_ALL_Name_ID_For_INQ_QT_SO_Filter_List[i]
                        .isChecked
                        .toString());
              }
              /* navigateTo(context, SaleBillProductListScreen.routeName,
                  arguments: AddSalesBillProductListArgument(
                      InquiryNo, edt_StateCode.text, edt_HeaderDisc.text));*/
            } else {
              showCommonDialogWithSingleOption(
                  context, "Customer name is required To view Product !",
                  positiveButtonTitle: "OK");
            }
          }, "Add Product + ",
              width: 600, backGroundColor: colorPrimary, radius: 20),
        ),
        Visibility(
          visible: true,
          child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            child: getCommonButton(baseTheme, () async {
              await getInquiryProductDetails();
              if (_inquiryProductList.length != 0) {
                print("HeaderDiscll" + edt_HeaderDisc.text.toString());
                navigateTo(context, SaleBillOtherChargeScreen.routeName,
                        arguments: SaleOrderOtherChargesScreenArguments(
                            int.parse(edt_StateCode.text == null
                                ? 0
                                : edt_StateCode.text),
                            _editModel,
                            edt_HeaderDisc.text))
                    .then((value) {
                  if (value == null) {
                    print("HeaderDiscount From QTOtherCharges 0.00");
                  } else {
                    print("HeaderDiscount From QTOtherCharges $value");
                    edt_HeaderDisc.text = value;
                  }
                });
              } else {
                showCommonDialogWithSingleOption(context,
                    "Atleast one product is required to view other charges !",
                    positiveButtonTitle: "OK");
              }
            }, "Other Charges",
                width: 600, backGroundColor: colorPrimary, radius: 20),
          ),
        ),
      ],
    );
  }

  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<SaleBillTable> temp =
        await OfflineDbHelper.getInstance().getSalesBillProduct();
    _inquiryProductList.addAll(temp);
    setState(() {});
  }

  TransportDetails() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,

                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Transport Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      BASIC_INFORMATION,
                      width: 28,
                    ),
                  ),
                ),

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel(
                                  "Mode Of Transport #", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel(
                                  "Transporter Name", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              // flex: 2,
                              child: CustomDropDown1("Mode Of Transport #",
                                  enable1: false,
                                  title: "Select Mode",
                                  hintTextvalue: "Tap to select",
                                  icon: Icon(Icons.arrow_drop_down),
                                  controllerForLeft:
                                      _controller_mode_of_transfer,
                                  Custom_values1:
                                      arr_ALL_Name_ID_For_ModeOfTransfer),
                            ),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_Transporter,
                                    "Transporter Name")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("LR No./DC No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("LR Date/DC Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_LR_NO, "LR No./DC No.")),
                            Flexible(child: _buildLRDate())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        createTextLabel("Remarks", 10.0, 0.0),
                        createTextFormField(
                            _controller_Remarks, "Tap to enter remarks",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            keyboardInput: TextInputType.text),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("Vehicle No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Delivery Note", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_vihical_no, "Vehicle No.")),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_Delivery_Notes,
                                    "Delivery Note")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("e-Way Bill No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Mode Of Payment", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_e_way_bill_No, "Bill No.")),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_Mode_of_Payment,
                                    "Mode Of Payment")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("Deliver To", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Delivery Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_DeliverTo, "Deliver To")),
                            Flexible(child: _buildDeliveryDate())
                          ],
                        ),
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  Attachments() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.white70,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Attachment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                leading: Container(child: Icon(Icons.attachment)),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        AttachedFileList(),
                        SizedBox(
                          height: 5,
                        ),
                        getCommonButton(baseTheme, () async {
                          if (await Permission.storage.isDenied) {
                            //await Permission.storage.request();

                            checkPhotoPermissionStatus();
                          } else {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return SafeArea(
                                    child: Container(
                                      child: new Wrap(
                                        children: <Widget>[
                                          new ListTile(
                                              leading:
                                                  new Icon(Icons.photo_library),
                                              title: new Text('Choose Files'),
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                FilePickerResult result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  allowMultiple: true,
                                                );
                                                if (result != null) {
                                                  List<File> files = result
                                                      .paths
                                                      .map((path) => File(path))
                                                      .toList();
                                                  setState(() {
                                                    MultipleVideoList.addAll(
                                                        files);
                                                  });
                                                } else {
                                                  // User canceled the picker
                                                }
                                              }),
                                          new ListTile(
                                            leading:
                                                new Icon(Icons.photo_camera),
                                            title: new Text('Choose Image'),
                                            onTap: () async {
                                              Navigator.of(context).pop();

                                              XFile file =
                                                  await imagepicker.pickImage(
                                                source: ImageSource.camera,
                                              );
                                              setState(() {
                                                MultipleVideoList.add(
                                                    File(file.path));
                                              });
                                            },
                                          ),
                                          new ListTile(
                                            leading:
                                                new Icon(Icons.photo_camera),
                                            title: new Text('Choose Video'),
                                            onTap: () async {
                                              Navigator.of(context).pop();

                                              XFile file =
                                                  await imagepicker.pickVideo(
                                                      source:
                                                          ImageSource.camera,
                                                      maxDuration:
                                                          const Duration(
                                                              seconds: 10));
                                              setState(() {
                                                MultipleVideoList.add(
                                                    File(file.path));
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        }, "Choose File",
                            radius: 20,
                            backGroundColor: Color(0xff02b1fc),
                            textColor: colorWhite)
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  void checkPhotoPermissionStatus() async {
    bool granted = await Permission.storage.isGranted;
    bool Denied = await Permission.storage.isDenied;
    bool PermanentlyDenied = await Permission.storage.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();

      await Permission.storage.request();

/*      showCommonDialogWithSingleOption(
          context, "Location permission is required , You have to click on OK button to Allow the location access !",
          positiveButtonTitle: "OK",
      onTapOfPositiveButton: () async {
         await openAppSettings();
         Navigator.of(context).pop();

      }

      );*/

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
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.

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

  ShipmentDetails() {
    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff362d8b), borderRadius: BorderRadius.circular(20)
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, blurRadius: 3.0, offset: Offset(2, 2),
              //       spreadRadius: 1.0
              //   ),
              // ]
              ),
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.white70,
            ),
            child: ListTileTheme(
              dense: true,
              child: ExpansionTile(
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,

                // backgroundColor: Colors.grey[350],
                title: Text(
                  "Shipment Detail",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(child: Icon(Icons.local_shipping_outlined)),

                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Column(
                      children: [
                        createTextLabel(
                            "Pre Carriage By (Transporter Name)", 10.0, 0.0),
                        createTextFormField(
                            _controller_transport_name, "Enter Transport Name",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                        createTextLabel(
                            "Place Of Rec.By Pre Carrier", 10.0, 0.0),
                        createTextFormField(
                            _controller_place_of_rec, "Enter Place",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextLabel(
                                  "Vessel/Flight No", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Port Of Loading", 10.0, 0.0),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_flight_no, "Enter Flight No."),
                            ),
                            Flexible(
                              child: createTextFormField(
                                  _controller_port_of_loading,
                                  "Enter Port Of Loading",
                                  keyboardInput: TextInputType.text),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextLabel(
                                  "Port Of Dispatch", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel(
                                  "Port Of Destination", 10.0, 0.0),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_port_of_dispatch,
                                  "Enter Port Of Dispatch",
                                  keyboardInput: TextInputType.text),
                            ),
                            Flexible(
                              child: createTextFormField(
                                  _controller_port_of_destination,
                                  "Enter Port Of Destination",
                                  keyboardInput: TextInputType.text),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Container No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Packages", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_container_no,
                                  "Enter Container No."),
                            ),
                            Flexible(
                              child: createTextFormField(
                                  _controller_packages, "Enter Packages",
                                  keyboardInput: TextInputType.text),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Packages Types", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Net Weight(KGs)", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_type_of_package,
                                  "Enter packages type",
                                  keyboardInput: TextInputType.text),
                            ),
                            Flexible(
                              child: createTextFormField(
                                  _controller_net_weight, "Enter Net Weight"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextLabel(
                                  "Gross Weight(KGs)", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel(
                                  "FOB (Free Of Board)", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_gross_weight,
                                  "Enter Gross Weight"),
                            ),
                            Flexible(
                              child: createTextFormField(
                                  _controller_FOB, "Enter FOB",
                                  keyboardInput: TextInputType.text),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ], // children:
              ),
            ),
          ),
          // height: 60,
        ),
      ),
    );
  }

  AttachedFileList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showCommonDialogWithTwoOptions(context,
                          "Are you sure you want to delete this File ?",
                          negativeButtonTitle: "No", positiveButtonTitle: "Yes",
                          onTapOfPositiveButton: () {
                        Navigator.of(context).pop();
                        MultipleVideoList.removeAt(index);
                        setState(() {});
                      });
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 32,
                      color: colorPrimary,
                    ),
                  ),
                  Card(
                    elevation: 5,
                    color: colorLightGray,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      width: 300,
                      /* decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: colorLightGray,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),*/
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              OpenFile.open(MultipleVideoList[index].path);
                            },
                            child: Text(
                              MultipleVideoList[index].path.split('/').last,
                              // overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 10, color: colorPrimary),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );

            // }
          },
          shrinkWrap: true,
          itemCount: MultipleVideoList.length,
        ),
      ],
    );
  }

  void getAccountNameAPI() {
    ALL_Name_ID all_name_id = ALL_Name_ID();
    all_name_id.Name = "KISHAN RATHOD A/C";
    all_name_id.pkID = 91769;
    arr_ALL_Name_ID_For_Sales_Order_AC_Name.add(all_name_id);
  }

  void _OnBankDetailsSucess(QuotationBankDropDownResponseState state) {
    arr_ALL_Name_ID_For_Sales_Order_Bank_Name.clear();
    for (var i = 0; i < state.response.details.length; i++) {
      ALL_Name_ID all_name_id = new ALL_Name_ID();
      all_name_id.pkID = state.response.details[i].pkID;
      all_name_id.Name = state.response.details[i].bankName;
      arr_ALL_Name_ID_For_Sales_Order_Bank_Name.add(all_name_id);
    }
  }

  void _OnTermsAndConditionResponse(QuotationTermsCondtionResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_Terms_And_Condition.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].tNCHeader);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].tNCHeader;
        all_name_id.pkID = state.response.details[i].pkID;
        all_name_id.Name1 = state.response.details[i].tNCContent;

        arr_ALL_Name_ID_For_Terms_And_Condition.add(all_name_id);
      }
    }
  }

  void _OnEmailContentResponse(SaleBillEmailContentResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_Email_Subject.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].contentData);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].subject;
        all_name_id.pkID = state.response.details[i].pkID;
        all_name_id.Name1 = state.response.details[i].contentData;

        arr_ALL_Name_ID_For_Email_Subject.add(all_name_id);
      }
    }
  }

  void getSelectOptionList() {
    arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Inquiry";
      } else if (i == 1) {
        all_name_id.Name = "Quotation";
      } else if (i == 2) {
        all_name_id.Name = "SalesOrder";
      }
      arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry.add(all_name_id);
    }
  }

  void _OnINQ_QT_SO_NO_Response(
      SalesBill_INQ_QT_SO_NO_ListResponseState state) {
    arr_ALL_Name_ID_For_INQ_QT_SO_List.clear();

    if (state.response.details.length != 0) {
      for (int i = 0; i < state.response.details.length; i++) {
        print("lsdfsdf" + " Order No " + state.response.details[i].orderNo);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].orderNo;
        all_name_id.isChecked = false;
        arr_ALL_Name_ID_For_INQ_QT_SO_List.add(all_name_id);
      }
    }
  }

  ModuleNo(BuildContext context) {
    return EditText(context,
        hint: "View Module No",
        radius: 10,
        readOnly: true,
        boxheight: 40, onPressed: () {
      if (_controller_select_inquiry.text != "") {
        navigateTo(context, ModuleNoListScreen.routeName,
                arguments: AddModuleNoScreenArguments(
                    arr_ALL_Name_ID_For_INQ_QT_SO_List))
            .then((value) {
          setState(() {
            arr_ALL_Name_ID_For_INQ_QT_SO_Filter_List = value;
          });
        });
      } else {
        showCommonDialogWithSingleOption(
            context, "Customer name is required To view Option !",
            positiveButtonTitle: "OK");
      }
    },
        inputTextStyle: TextStyle(fontSize: 15),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: colorGrayDark,
          size: 32,
        ));
  }
}
