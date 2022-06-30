import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/bank_voucher/bank_voucher_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/quotation/quotation_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/cust_id_inq_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/inqiory_header_save_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_delete_product.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_header_save_request.dart';
import 'package:soleoserp/models/api_requests/quotation_kind_att_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_other_charge_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_product_delete_request.dart';
import 'package:soleoserp/models/api_requests/quotation_project_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_terms_condition_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_number_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/quotation_kind_att_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_list_response.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/models/common/other_charge_table.dart';
import 'package:soleoserp/models/common/quotationtable.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotation_general_customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_product_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/screens/contactscrud/contacts_list_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateQuotationScreenArguments {
  QuotationDetails editModel;

  AddUpdateQuotationScreenArguments(this.editModel);
}

class QuotationAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/QuotationAddEditScreen';
  final AddUpdateQuotationScreenArguments arguments;

  QuotationAddEditScreen(this.arguments);

  @override
  _QuotationAddEditScreenState createState() => _QuotationAddEditScreenState();
}

class _QuotationAddEditScreenState extends BaseState<QuotationAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  QuotationBloc _inquiryBloc;
  int _pageNo = 0;
  bool expanded = true;
  double sizeboxsize = 12;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  //CustomerSourceResponse _offlineCustomerSource;
  //InquiryStatusListResponse _offlineInquiryLeadStatusData;

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
  final TextEditingController edt_StateCode = TextEditingController();

  final TextEditingController edt_ReverseNextFollowupDate =
      TextEditingController();
  final TextEditingController edt_PreferedTime = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadSource = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_KindAttList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_ProjectList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_TermConditionList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_InqNoList = [];

  final TextEditingController edt_KindAtt = TextEditingController();
  final TextEditingController edt_KindAttID = TextEditingController();
  final TextEditingController edt_ProjectName = TextEditingController();
  final TextEditingController edt_ProjectID = TextEditingController();
  final TextEditingController edt_TermConditionHeader = TextEditingController();
  final TextEditingController edt_TermConditionHeaderID =
      TextEditingController();

  final TextEditingController edt_TermConditionFooter = TextEditingController();
  final TextEditingController edt_InquiryNo = TextEditingController();
  final TextEditingController edt_InquiryNoID = TextEditingController();
  final TextEditingController edt_InquiryNoExist = TextEditingController();


  final TextEditingController edt_ChargeID1  = TextEditingController();
  final TextEditingController edt_ChargeName1  = TextEditingController();

  final TextEditingController edt_ChargeTaxType1  = TextEditingController();
  final TextEditingController edt_ChargeGstPer1   = TextEditingController();
  final TextEditingController edt_ChargeBeforGST1 = TextEditingController();

  final TextEditingController edt_ChargeID2  = TextEditingController();
  final TextEditingController edt_ChargeName2  = TextEditingController();

  final TextEditingController edt_ChargeTaxType2  = TextEditingController();
  final TextEditingController edt_ChargeGstPer2  = TextEditingController();
  final TextEditingController edt_ChargeBeforGST2 = TextEditingController();

  final TextEditingController edt_ChargeID3  = TextEditingController();
  final TextEditingController edt_ChargeName3 = TextEditingController();

  final TextEditingController edt_ChargeTaxType3 = TextEditingController();
  final TextEditingController edt_ChargeGstPer3   = TextEditingController();
  final TextEditingController edt_ChargeBeforGST3 = TextEditingController();

  final TextEditingController edt_ChargeID4  = TextEditingController();
  final TextEditingController edt_ChargeName4  = TextEditingController();

  final TextEditingController edt_ChargeTaxType4  = TextEditingController();
  final TextEditingController edt_ChargeGstPer4   = TextEditingController();
  final TextEditingController edt_ChargeBeforGST4 = TextEditingController();

  final TextEditingController edt_ChargeID5  = TextEditingController();
  final TextEditingController edt_ChargeName5  = TextEditingController();

  final TextEditingController edt_ChargeTaxType5  = TextEditingController();
  final TextEditingController edt_ChargeGstPer5   = TextEditingController();
  final TextEditingController edt_ChargeBeforGST5 = TextEditingController();
  final TextEditingController edt_HeaderDisc = TextEditingController();



  QuotationDetails _editModel;
  bool _isForUpdate;
  String InquiryNo = "";
  int pkID = 0;
  List<QuotationTable> _inquiryProductList = [];
  FocusNode ReferenceFocusNode;

  // SearchInquiryListResponse _searchInquiryListResponse;
  // SearchInquiryCustomer _searchInquiryListResponse;
  SearchDetails _searchInquiryListResponse;

  List<ALL_Name_ID> arr_ALL_Name_ID_For_BankDropDownList = [];
  final TextEditingController edt_Portal_details = TextEditingController();
  final TextEditingController edt_Portal_details_ID = TextEditingController();

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
    _inquiryBloc = QuotationBloc(baseBloc);
    ReferenceFocusNode = FocusNode();
    edt_LeadSource.addListener(() {
      ReferenceFocusNode.requestFocus();
    });
    edt_HeaderDisc.text = "0.00";
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
      edt_StateCode.text = "";
      setState(() {
        edt_InquiryNo.text = "";
      });
    }

    edt_InquiryNo.addListener(() {
      if (edt_InquiryNo.text != "") {
        _inquiryBloc.add(InqNoToProductListCallEvent(
            InquiryNoToProductListRequest(
                InquiryNo: edt_InquiryNo.text,
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<QuotationBloc, QuotationStates>(
        builder: (BuildContext context, QuotationStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, QuotationStates state) {
          if (state is QuotationNoToProductListCallResponseState) {
            _OnQuotationNoToProductListResponse(state);
          }

          if (state is QuotationKindAttListResponseState) {
            _OnKindAttListResponseSucess(state);
          }

          if (state is QuotationProjectListResponseState) {
            _OnProjectListResponseSucess(state);
          }
          if (state is QuotationTermsCondtionResponseState) {
            _OnTermConditionListResponse(state);
          }
          if (state is CustIdToInqListResponseState) {
            _OnCustIdToInqNoListResponse(state);
          }
          if (state is InqNoToProductListResponseState) {
            _OnInqNotoProductListResponse(state);
          }
          if (state is QuotationHeaderSaveResponseState) {
            _OnQuotationHeaderSaveSucessResponse(state);
          }
          if (state is QuotationProductSaveResponseState) {
            _OnQuotationProductSaveSucessResponse(state);
          }
          if (state is QuotationProductDeleteResponseState) {
            _OnInquiryNoTodeleteAllProduct(state);
          }
         /* if(state is QuotationOtherChargeListResponseState)
          {
            _onOtherChargeListResponse(state);
          }*/

          if(state is QuotationBankDropDownResponseState)
          {
            _onBankVoucherSaveResponse(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is QuotationNoToProductListCallResponseState ||
              currentState is QuotationKindAttListResponseState ||
              currentState is QuotationProjectListResponseState ||
              currentState is QuotationTermsCondtionResponseState ||
              currentState is CustIdToInqListResponseState ||
              currentState is InqNoToProductListResponseState ||
              currentState is QuotationHeaderSaveResponseState ||
              currentState is QuotationProductSaveResponseState ||
              currentState is QuotationBankDropDownResponseState
/*
              currentState is QuotationOtherChargeListResponseState
*/
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
          title: Text('Quotation Details'),
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
                        edt_InquiryNoExist.text == "true"
                            ? InqNoList("Inquiry No.",
                                enable1: false,
                                title: "Inquiry No.",
                                hintTextvalue: "Tap to Select Inquiry No.",
                                icon: Icon(Icons.arrow_drop_down),
                                controllerForLeft: edt_InquiryNo,
                                controllerpkID: edt_InquiryNoID,
                                Custom_values1: arr_ALL_Name_ID_For_InqNoList)
                            : Container(),
                       /* KindAttList("Kind Attn.",
                            enable1: false,
                            title: "Kind Attn.",
                            hintTextvalue: "Tap to Select Kind Attn.",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_KindAtt,
                            controllerpkID: edt_KindAttID,
                            Custom_values1: arr_ALL_Name_ID_For_KindAttList),*/
                        ProjectList("Project",
                            enable1: false,
                            title: "Project",
                            hintTextvalue: "Tap to Select Project",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_ProjectName,
                            controllerpkID: edt_ProjectID,
                            Custom_values1: arr_ALL_Name_ID_For_ProjectList),


                        BankDropDown("Bank Details *",
                            enable1: false,
                            title: "Bank Details *",
                            hintTextvalue: "Tap to Select Bank Portal",
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorPrimary,
                            ),
                            controllerForLeft: edt_Portal_details,
                            controllerpkID: edt_Portal_details_ID,
                            Custom_values1: arr_ALL_Name_ID_For_BankDropDownList),

                        TermsConditionList("Select Term & Condition",
                            enable1: false,
                            title: "Select Term & Condition",
                            hintTextvalue: "Tap to Select Term & Condition",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_TermConditionHeader,
                            controllerpkID: edt_TermConditionHeaderID,
                            Custom_values1:
                                arr_ALL_Name_ID_For_TermConditionList),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Term & Condition",
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
                            controller: edt_TermConditionFooter,
                            minLines: 2,
                            maxLines: 15,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Notes',
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
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          child: getCommonButton(baseTheme, () {
                            //  _onTapOfDeleteALLContact();
                            //  navigateTo(context, InquiryProductListScreen.routeName);

                            if (edt_CustomerName.text != "") {
                              print("INWWWE" + InquiryNo.toString());
                              navigateTo(
                                  context, QuotationProductListScreen.routeName,
                                  arguments: AddQuotationProductListArgument(
                                      InquiryNo, edt_StateCode.text,edt_HeaderDisc.text));
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Customer name is required To view Product !",
                                  positiveButtonTitle: "OK");
                            }
                          }, "Add Product + ",
                              width: 600, backGroundColor: Color(0xff4d62dc)),
                        ),
                        Visibility(
                          visible: true,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.bottomCenter,
                            child: getCommonButton(baseTheme, () async {
                              //  _onTapOfDeleteALLContact();
                              //  navigateTo(context, InquiryProductListScreen.routeName);
                              await getInquiryProductDetails();
                              if (_inquiryProductList.length != 0) {

                                print("HeaderDiscll" +edt_HeaderDisc.text.toString() );
                                navigateTo(context, QuotationOtherChargeScreen.routeName,
                                    arguments: QuotationOtherChargesScreenArguments(int.parse(edt_StateCode.text==null?0:edt_StateCode.text),_editModel,edt_HeaderDisc.text)).then((value) {

                                      if(value==null)
                                        {
                                          print("HeaderDiscount From QTOtherCharges 0.00");

                                        }
                                      else
                                        {
                                          print("HeaderDiscount From QTOtherCharges $value");
                                          edt_HeaderDisc.text = value;
                                        }
                                });

                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Attlist one product is required to view other charges !",
                                    positiveButtonTitle: "OK");
                              }
                            }, "Other Charges",
                                width: 600, backGroundColor: Color(0xff4d62dc)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.bottomCenter,
                          child: getCommonButton(baseTheme, () {
                            //  _onTapOfDeleteALLContact();
                            //  navigateTo(context, InquiryProductListScreen.routeName);

                            _onTaptoSaveQuotationHeader(context);
                          }, "Save  ",
                              width: 600, backGroundColor: colorPrimary),
                        ),
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
        _selectDate(context, edt_InquiryDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Quotation Date *",
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
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
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
      await _onTapOfDeleteALLProduct();

      navigateTo(context, SearchQuotationCustomerScreen.routeName)
          .then((value) {
        if (value != null) {
          _searchInquiryListResponse = value;
          edt_CustomerName.text = _searchInquiryListResponse.label;
          edt_CustomerpkID.text = _searchInquiryListResponse.value.toString();
          setState(() {
            edt_InquiryNoExist.text = "true";
          });
          _inquiryBloc.add(CustIdToInqListCallEvent(CustIdToInqListRequest(
              CustomerID: _searchInquiryListResponse.value.toString(),
              CompanyID: CompanyID.toString())));

          if (_searchInquiryListResponse.stateCode != 0) {
            edt_StateCode.text =
                _searchInquiryListResponse.stateCode.toString();
          } else {
            showCommonDialogWithSingleOption(context,
                "Customer State is Required !\nUpdate State From Customer Module",
                positiveButtonTitle: "OK", onTapOfPositiveButton: () {
              edt_CustomerName.text = "";
              Navigator.pop(context);
            });
          }
          //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

        }
      });
    }
  }

  Future<bool> _onBackPressed() async {
    await _onTapOfDeleteALLProduct();
    navigateTo(context, QuotationListScreen.routeName, clearAllStack: true);
  }

  void fillData() async {
    pkID = _editModel.pkID;
    edt_InquiryDate.text = _editModel.quotationDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
    edt_ReverseInquiryDate.text = _editModel.quotationDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    edt_CustomerName.text = _editModel.customerName.toString();
    edt_CustomerpkID.text = _editModel.customerID.toString();
    /*  edt_Priority.text = _editModel.priority;
    edt_LeadStatus.text = _editModel.inquiryStatus.toString();
    edt_LeadStatusID.text = _editModel.inquiryStatusID.toString();
    edt_LeadSourceID.text = _editModel.inquirySource.toString();
    edt_LeadSource.text = _editModel.InquirySourceName.toString();
    edt_Reference_Name.text = _editModel.referenceName.toString();
    edt_Description.text = _editModel.meetingNotes.toString();*/
    edt_ProjectName.text = _editModel.projectName;
    edt_TermConditionHeader.text = _editModel.quotationHeader;
    edt_TermConditionFooter.text = _editModel.quotationFooter;

    edt_ReverseNextFollowupDate.text = "";
    edt_PreferedTime.text = "";
    edt_FollowupNotes.text = "";
    InquiryNo = _editModel.quotationNo;
    edt_StateCode.text = _editModel.stateCode.toString();
    int StateCode = _editModel.stateCode;
    if (InquiryNo != '') {
      await _onTapOfDeleteALLProduct();
      _inquiryBloc.add(QuotationNoToProductListCallEvent(
          StateCode,
          QuotationNoToProductListRequest(
              QuotationNo: InquiryNo, CompanyId: CompanyID.toString())));
    }
    setState(() {
      edt_InquiryNo.text = "";
    });



    edt_ChargeID1.text = _editModel.chargeID1.toString();
    edt_ChargeID2.text = _editModel.chargeID2.toString();
    edt_ChargeID3.text = _editModel.chargeID3.toString();
    edt_ChargeID4.text = _editModel.chargeID4.toString();
    edt_ChargeID5.text = _editModel.chargeID5.toString();

   /* _inquiryBloc.add(QuotationOtherChargeCallEvent(CompanyID.toString(),
        QuotationOtherChargesListRequest(pkID: "")));*/
  }

  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<QuotationTable> temp =
        await OfflineDbHelper.getInstance().getQuotationProduct();
    _inquiryProductList.addAll(temp);
    setState(() {});
  }

  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLQuotationProduct();
  }

  /* void updateRetrunInquiryNoToDB(String ReturnInquiryNo) {
    _inquiryProductList.forEach((element) {
      element.InquiryNo = ReturnInquiryNo;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }*/

  _onTapOfAdd(
      String productName,
      String ProductID,
      String Quantity,
      String UnitPrice,
      double TotalAmount,
      String specification,
      String qtNo,
      String unit,
      double disc1,
      double discAmount1,
      double netRate1,
      double amount1,
      int taxtype1,
      double taxper1,
      double taxAmount1,
      double cgstPer,
      double sgstPer,
      double igstPer,
      double cgstAmount,
      double sgstAmount,
      double igstAmount,
      int stateCode,
      double HeaderDiscAmnr
      ) async {
    int productID = int.parse(ProductID);
    double quantity = double.parse(Quantity);
    double unitPrice = double.parse(UnitPrice);
    double totalAmount = TotalAmount;
    double disc = disc1;
    double discAmount = discAmount1;
    double netRate = netRate1;
    double amount = amount1;
    double taxPer = taxper1;
    double taxAmount = taxAmount1;
    int taxtype = taxtype1;
    /*double Quantity,   double UnitRate,   double Disc,   double NetRate,   double Amount,   double TaxPer,   double TaxAmount,   double NetAmount,*/

    await OfflineDbHelper.getInstance().insertQuotationProduct(QuotationTable(
        qtNo,
        specification,
        productID,
        productName,
        unit,
        quantity,
        unitPrice,
        disc,
        discAmount,
        netRate,
        amount,
        taxPer,
        taxAmount,
        totalAmount,
        taxtype,
        cgstPer,
        sgstPer,
        igstPer,
        cgstAmount,
        sgstAmount,
        igstAmount,
        stateCode,
        0,
        LoginUserID,
        CompanyID.toString(),
        0,
        HeaderDiscAmnr));
  }

  _OnInquiryNoTodeleteAllProduct(QuotationProductDeleteResponseState state) {
    print(
        "QuotationProductDeleteResponse " + state.response.details[0].column1);
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

  void _OnQuotationNoToProductListResponse(
      QuotationNoToProductListCallResponseState state) {
    for (var i = 0; i < state.response.details.length; i++) {
      /* String LoginUserID="abc";
    String CompanyId="0";
    String InquiryNo="0";*/
      String ProductName = state.response.details[i].productName;
      String ProductID = state.response.details[i].productID.toString();
      String Unit = state.response.details[i].unit.toString();
      String Quantity = state.response.details[i].quantity.toString();
      String UnitPrice = state.response.details[i].unitRate.toString();
      double disc = state.response.details[i].discountPercent;
      double discAmount = state.response.details[i].discountAmt;

      double netRate = state.response.details[i].netRate;
      double amount = state.response.details[i].amount;
      int taxtype = state.response.details[i].taxType;
      double taxper = state.response.details[i].taxRate;
      double taxAmount = state.response.details[i].taxAmount;
      double netAmount = state.response.details[i].netAmount;
      double CGSTPer = state.response.details[i].cGSTPer;
      double SGSTPer = state.response.details[i].sGSTPer;
      double IGSTPer = state.response.details[i].iGSTPer;
      double CGSTAmount = state.response.details[i].cGSTAmt;
      double SGSTAmount = state.response.details[i].sGSTAmt;
      double IGSTAmount = state.response.details[i].iGSTAmt;
      double HeaderDiscAmnr = state.response.details[i].headerDiscAmt;

      // double totamnt = double.parse(Quantity) * double.parse(UnitPrice);
      //String TotalAmount = totamnt.toString();
      String Specification =
          state.response.details[i].productSpecification.toString();
      String QTNo = state.response.details[i].quotationNo.toString();
      int StateCode = state.StateCode;

      edt_HeaderDisc.text = state.response.details[i].headerDiscountAmt.toStringAsFixed(2);

      _onTapOfAdd(
          ProductName,
          ProductID,
          Quantity,
          UnitPrice,
          netAmount,
          Specification,
          QTNo,
          Unit,
          disc,
          discAmount,
          netRate,
          amount,
          taxtype,
          taxper,
          taxAmount,
          CGSTPer,
          SGSTPer,
          IGSTPer,
          CGSTAmount,
          SGSTAmount,
          IGSTAmount,
          StateCode,HeaderDiscAmnr);
    }
  }

  Widget InqNoList(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithID(
                values: arr_ALL_Name_ID_For_InqNoList,
                context1: context,
                controller: edt_InquiryNo,
                controllerID: edt_InquiryNoID,
                lable: "Select InquiryNo. "),
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

  Widget KindAttList(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
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
                    {
              if (edt_CustomerpkID != "")
                {
                  _inquiryBloc.add(QuotationKindAttListCallEvent(
                      QuotationKindAttListApiRequest(
                          CompanyId: CompanyID.toString(),
                          CustomerID: edt_CustomerpkID.text)))
                }
            },
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

  Widget ProjectList(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
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

                    _inquiryBloc.add(QuotationProjectListCallEvent(
                        QuotationProjectListRequest(
                            CompanyId: CompanyID.toString(),
                            LoginUserID: LoginUserID))),
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

  Widget TermsConditionList(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
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

                    _inquiryBloc.add(QuotationTermsConditionCallEvent(
                        QuotationTermsConditionRequest(
                            CompanyId: CompanyID.toString(),
                            LoginUserID: LoginUserID))),
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

  void _OnKindAttListResponseSucess(QuotationKindAttListResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_KindAttList.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].contactPerson1);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].contactPerson1;
        all_name_id.pkID = state.response.details[i].customerID;
        arr_ALL_Name_ID_For_KindAttList.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_KindAttList,
          context1: context,
          controller: edt_KindAtt,
          controllerID: edt_KindAttID,
          lable: "Select Kind Att.");
    }
  }

  void _OnProjectListResponseSucess(QuotationProjectListResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_ProjectList.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].projectName);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].projectName;
        all_name_id.pkID = state.response.details[i].pkID;
        arr_ALL_Name_ID_For_ProjectList.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_ProjectList,
          context1: context,
          controller: edt_ProjectName,
          controllerID: edt_ProjectID,
          lable: "Select Project ");
    }
  }

  void _OnTermConditionListResponse(QuotationTermsCondtionResponseState state) {
    if (state.response.details.length != 0) {
      arr_ALL_Name_ID_For_TermConditionList.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].tNCHeader);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].tNCHeader;
        all_name_id.pkID = state.response.details[i].pkID;
        all_name_id.Name1 = state.response.details[i].tNCContent;

        arr_ALL_Name_ID_For_TermConditionList.add(all_name_id);
      }
      showcustomdialogWithMultipleID(
          values: arr_ALL_Name_ID_For_TermConditionList,
          context1: context,
          controller: edt_TermConditionHeader,
          controllerID: edt_TermConditionHeaderID,
          controller2: edt_TermConditionFooter,
          lable: "Select Term & Condition ");
    }
  }

  void _OnCustIdToInqNoListResponse(CustIdToInqListResponseState state) {
    if (state.response.details.length != 0) {
      setState(() {
        edt_InquiryNoExist.text = "true";
      });

      arr_ALL_Name_ID_For_InqNoList.clear();
      for (var i = 0; i < state.response.details.length; i++) {
        print("InquiryStatus : " + state.response.details[i].inquiryNo);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].inquiryNo;
        all_name_id.pkID = state.response.details[i].customerID;

        arr_ALL_Name_ID_For_InqNoList.add(all_name_id);
      }
    } else {
      setState(() {
        edt_InquiryNoExist.text = "";
      });
      arr_ALL_Name_ID_For_InqNoList.clear();
    }
  }

  void _OnInqNotoProductListResponse(
      InqNoToProductListResponseState state) async {
    for (var i = 0; i < state.response.details.length; i++) {
      double Quantity = state.response.details[i].quantity;
      double UnitPrice = state.response.details[i].unitPrice;
      double DisPer = 0.00;
      double NetRate = 0.00;
      double Amount = 0.00;
      double TaxPer = state.response.details[i].taxRate;
      double TaxAmount = 0.00;
      int TaxType = state.response.details[i].taxType;
      double Amount1 = 0.00;
      double TaxAmount1 = 0.00;
      double TotalAmount = 0.00;
      double NetRate1 = 0.00; //(UnitPrice * DisPer) / 100;
      /* double CGSTPer1 =0.00;
      double SGSTPer1 =0.00;
      double IGSTPer1 =0.00;
      double CGSTAmount1 =0.00;
      double SGSTAmount1 =0.00;
      double IGSTAmount1 =0.00;*/
      double CGSTPer = 0.00;
      double SGSTPer = 0.00;
      double IGSTPer = 0.00;
      double CGSTAmount = 0.00;
      double SGSTAmount = 0.00;
      double IGSTAmount = 0.00;

      NetRate1 = UnitPrice;
      NetRate = NetRate1;
      if (TaxType == 1) {
        Amount1 = Quantity * NetRate1;
        Amount = Amount1;
        TaxAmount1 = (Amount1 * TaxPer) / 100;
        TaxAmount = TaxAmount1;
        TotalAmount = Amount1 + TaxAmount1;
      } else {
        Amount1 = 0.00;
        TaxAmount1 = 0.00;
        TotalAmount = 0.00;

        TaxAmount1 = ((Quantity * NetRate1) * TaxPer) / (100 + TaxPer);
        TaxAmount = getNumber(TaxAmount1, precision: 2);

        Amount1 = (Quantity * NetRate1) - getNumber(TaxAmount1, precision: 2);
        Amount = getNumber(Amount1, precision: 2);

        TotalAmount =
            (Quantity * NetRate1) + getNumber(TaxAmount1, precision: 2);
        // _totalAmountController.text = getNumber(TotalAmount,precision: 2).toString();
      }

      if (_offlineLoggedInData.details[0].stateCode ==
          int.parse(edt_StateCode.text)) {
        CGSTPer = TaxPer / 2;
        SGSTPer = TaxPer / 2;
        CGSTAmount = TaxAmount / 2;
        SGSTAmount = TaxAmount / 2;
        IGSTPer = 0.00;
        IGSTAmount = 0.00;
      } else {
        CGSTPer = 0.00;
        SGSTPer = 0.00;
        CGSTAmount = 0.00;
        SGSTAmount = 0.00;
        IGSTPer = TaxPer;
        IGSTAmount = TaxAmount;
      }

      await OfflineDbHelper.getInstance().insertQuotationProduct(QuotationTable(
          "",
          state.response.details[i].productSpecification,
          state.response.details[i].productID,
          state.response.details[i].productName,
          state.response.details[i].unit,
          Quantity,
          UnitPrice,
          0.00,
          0.00,
          NetRate,
          Amount,
          TaxPer,
          TaxAmount,
          TotalAmount,
          TaxType,
          CGSTPer,
          SGSTPer,
          IGSTPer,
          CGSTAmount,
          SGSTAmount,
          IGSTAmount,
          int.parse(edt_StateCode.text),
          0,
          LoginUserID,
          CompanyID.toString(),
          0,
          0.00));
    }
  }

  double getNumber(double input, {int precision = 2}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  void _onTaptoSaveQuotationHeader(BuildContext context) async {
    await getInquiryProductDetails();
    List<QT_OtherChargeTable> tempOtherCharges = await OfflineDbHelper.getInstance().getQuotationOtherCharge();

    if (edt_InquiryDate.text != "") {
      if (edt_CustomerName.text != "") {
        if (_inquiryProductList.length != 0) {
          showCommonDialogWithTwoOptions(
              context, "Are you sure you want to Save this Quotation ?",
              negativeButtonTitle: "No",
              positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
            Navigator.of(context).pop();

            if (InquiryNo != '') {
              _inquiryBloc.add(QuotationDeleteProductCallEvent(
                  InquiryNo,
                  QuotationProductDeleteRequest(
                      CompanyId: CompanyID.toString())));
            } else {}

            double tot_basicAmount = 0.00;
            double tot_CGSTAmount = 0.00;
            double tot_SGSTAmount = 0.00;
            double tot_IGSTAmount = 0.00;
            double tot_DiscountAmount = 0.00;
            double tot_NetAmount = 0.00;

            for (int i = 0; i < _inquiryProductList.length; i++) {
              tot_basicAmount = tot_basicAmount + _inquiryProductList[i].Amount;
              tot_DiscountAmount =
                  tot_DiscountAmount + _inquiryProductList[i].DiscountAmt;
              tot_NetAmount = tot_NetAmount + _inquiryProductList[i].NetAmount;

              if (_offlineLoggedInData.details[0].stateCode ==
                  int.parse(edt_StateCode.text)) {
                tot_CGSTAmount =
                    tot_CGSTAmount + _inquiryProductList[i].CGSTAmt;
                tot_SGSTAmount =
                    tot_SGSTAmount + _inquiryProductList[i].SGSTAmt;
                tot_IGSTAmount = 0.00;
              } else {
                tot_IGSTAmount =
                    tot_IGSTAmount + _inquiryProductList[i].IGSTAmt;
                tot_CGSTAmount = 0.00;
                tot_SGSTAmount = 0.00;
              }


            }



           String ChargeID1        ="";
           String ChargeAmt1       ="";
           String ChargeBasicAmt1  ="";
           String ChargeGSTAmt1    ="";
           String ChargeID2        ="";
           String ChargeAmt2       ="";
           String ChargeBasicAmt2  ="";
           String ChargeGSTAmt2    ="";
           String ChargeID3        ="";
           String ChargeAmt3       ="";
           String ChargeBasicAmt3  ="";
           String ChargeGSTAmt3    ="";
           String ChargeID4        ="";
           String ChargeAmt4       ="";
           String ChargeBasicAmt4  ="";
           String ChargeGSTAmt4    ="";
           String ChargeID5        ="";
           String ChargeAmt5       ="";
           String ChargeBasicAmt5  ="";
           String ChargeGSTAmt5    ="";


           if(tempOtherCharges.length!=0)
             {
               for(int i=0;i<tempOtherCharges.length;i++)
               {

                 print("Cjkdfj"+" ChargeId : " + tempOtherCharges[i].ChargeID1.toString());
                 ChargeID1       =tempOtherCharges[i].ChargeID1.toString();
                 ChargeAmt1      =tempOtherCharges[i].ChargeAmt1.toStringAsFixed(2);
                 ChargeBasicAmt1 =tempOtherCharges[i].ChargeBasicAmt1.toStringAsFixed(2);
                 ChargeGSTAmt1   =tempOtherCharges[i].ChargeGSTAmt1.toStringAsFixed(2);
                 ChargeID2       =tempOtherCharges[i].ChargeID2.toString();
                 ChargeAmt2      =tempOtherCharges[i].ChargeAmt2.toStringAsFixed(2);
                 ChargeBasicAmt2 =tempOtherCharges[i].ChargeBasicAmt2.toStringAsFixed(2);
                 ChargeGSTAmt2   =tempOtherCharges[i].ChargeGSTAmt2.toStringAsFixed(2);
                 ChargeID3       =tempOtherCharges[i].ChargeID3.toString();
                 ChargeAmt3      =tempOtherCharges[i].ChargeAmt3.toStringAsFixed(2);
                 ChargeBasicAmt3 =tempOtherCharges[i].ChargeBasicAmt3.toStringAsFixed(2);
                 ChargeGSTAmt3   =tempOtherCharges[i].ChargeGSTAmt3.toStringAsFixed(2);
                 ChargeID4       =tempOtherCharges[i].ChargeID4.toString();
                 ChargeAmt4      =tempOtherCharges[i].ChargeAmt4.toStringAsFixed(2);
                 ChargeBasicAmt4 =tempOtherCharges[i].ChargeBasicAmt4.toStringAsFixed(2);
                 ChargeGSTAmt4   =tempOtherCharges[i].ChargeGSTAmt4.toStringAsFixed(2);
                 ChargeID5       =tempOtherCharges[i].ChargeID5.toString();
                 ChargeAmt5      =tempOtherCharges[i].ChargeAmt5.toStringAsFixed(2);
                 ChargeBasicAmt5 =tempOtherCharges[i].ChargeBasicAmt5.toStringAsFixed(2);
                 ChargeGSTAmt5   =tempOtherCharges[i].ChargeGSTAmt5.toStringAsFixed(2);

               }
             }
           else
             {
               ChargeID1        ="";
               ChargeAmt1       ="";
               ChargeBasicAmt1  ="";
               ChargeGSTAmt1    ="";
               ChargeID2        ="";
               ChargeAmt2       ="";
               ChargeBasicAmt2  ="";
               ChargeGSTAmt2    ="";
               ChargeID3        ="";
               ChargeAmt3       ="";
               ChargeBasicAmt3  ="";
               ChargeGSTAmt3    ="";
               ChargeID4        ="";
               ChargeAmt4       ="";
               ChargeBasicAmt4  ="";
               ChargeGSTAmt4    ="";
               ChargeID5        ="";
               ChargeAmt5       ="";
               ChargeBasicAmt5  ="";
               ChargeGSTAmt5    ="";
             }

            _inquiryBloc.add(QuotationHeaderSaveCallEvent(context,
                pkID,
                QuotationHeaderSaveRequest(
                    pkID: pkID.toString(),
                    InquiryNo:
                    edt_InquiryNo.text == null ? "" : edt_InquiryNo.text,
                    QuotationNo: InquiryNo,
                    QuotationDate: edt_ReverseInquiryDate.text,
                    CustomerID: edt_CustomerpkID.text,
                    ProjectName: edt_ProjectName.text,
                    QuotationSubject: "",
                    QuotationHeader: edt_TermConditionHeader.text,
                    QuotationFooter: edt_TermConditionFooter.text,
                    LoginUserID: LoginUserID,
                    Latitude:  SharedPrefHelper.instance.getLatitude(),
                    Longitude:  SharedPrefHelper.instance.getLongitude(),
                    DiscountAmt: tot_DiscountAmount.toString(),
                    SGSTAmt: tot_SGSTAmount.toString(),
                    CGSTAmt: tot_CGSTAmount.toString(),
                    IGSTAmt: tot_IGSTAmount.toString(),
                    ChargeID1: ChargeID1,
                    ChargeAmt1: ChargeAmt1,
                    ChargeBasicAmt1: ChargeBasicAmt1,
                    ChargeGSTAmt1: ChargeGSTAmt1,
                    ChargeID2: ChargeID2,
                    ChargeAmt2: ChargeAmt2,
                    ChargeBasicAmt2: ChargeBasicAmt2,
                    ChargeGSTAmt2: ChargeGSTAmt2,
                    ChargeID3: ChargeID3,
                    ChargeAmt3: ChargeAmt3,
                    ChargeBasicAmt3: ChargeBasicAmt3,
                    ChargeGSTAmt3:ChargeGSTAmt3,
                    ChargeID4: ChargeID4,
                    ChargeAmt4: ChargeAmt4,
                    ChargeBasicAmt4: ChargeBasicAmt4,
                    ChargeGSTAmt4: ChargeGSTAmt4,
                    ChargeID5: ChargeID5,
                    ChargeAmt5: ChargeAmt5,
                    ChargeBasicAmt5: ChargeBasicAmt5,
                    ChargeGSTAmt5: ChargeGSTAmt5,
                    NetAmt: tot_NetAmount.toString(),
                    BasicAmt: tot_basicAmount.toString(),
                    ROffAmt: "0.00",
                    ChargePer1: "0.00",
                    ChargePer2: "0.00",
                    ChargePer3: "0.00",
                    ChargePer4: "0.00",
                    ChargePer5: "0.00",
                    CompanyId: CompanyID.toString())));

          });
        } else {
          showCommonDialogWithSingleOption(
              context, "Quotation Product is required !",
              positiveButtonTitle: "OK");
        }
      } else {
        showCommonDialogWithSingleOption(context, "Customer name is required !",
            positiveButtonTitle: "OK");
      }
    } else {
      showCommonDialogWithSingleOption(context, "Quotation date is required !",
          positiveButtonTitle: "OK");
    }
  }

  void _OnQuotationHeaderSaveSucessResponse(
      QuotationHeaderSaveResponseState state) {
    int returnPKID = 0;
    String retrunQT_No = "";
    for (int i = 0; i < state.response.details.length; i++) {
      returnPKID = state.response.details[i].column3;
      retrunQT_No = state.response.details[i].column4;
    }
    updateRetrunInquiryNoToDB(state.context,returnPKID, retrunQT_No);
  }

  void _OnQuotationProductSaveSucessResponse(
      QuotationProductSaveResponseState state) async {
    String Msg = _isForUpdate == true
        ? "Quotation Updated Successfully"
        : "Quotation Added Successfully";

    /* showCommonDialogWithSingleOption(context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
          navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
        });*/
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");
    Navigator.of(context).pop();
  }

  void updateRetrunInquiryNoToDB(BuildContext context1,int pkID, String ReturnQT_No) async {

   await getInquiryProductDetails();


    _inquiryProductList.forEach((element) {
      element.pkID = pkID;
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
    _inquiryBloc
        .add(QuotationProductSaveCallEvent(context1,ReturnQT_No, _inquiryProductList));
  }

  void _onOtherChargeListResponse(QuotationOtherChargeListResponseState state) {

    int chrID1=0;int chrID2=0;int chrID3=0;int chrID4=0;int chrID5=0;

    for(int i=0;i<state.quotationOtherChargesListResponse.details.length;i++)
      {
        if(edt_ChargeID1.text==state.quotationOtherChargesListResponse.details[i].pkId.toString())
          {
            chrID1 = state.quotationOtherChargesListResponse.details[i].pkId;
            edt_ChargeID1.text = chrID1.toString();

             edt_ChargeName1.text  = state.quotationOtherChargesListResponse.details[i].chargeName;

            edt_ChargeTaxType1.text = state.quotationOtherChargesListResponse.details[i].taxType.toString();
            edt_ChargeGstPer1.text = state.quotationOtherChargesListResponse.details[i].gSTPer.toString();
            edt_ChargeBeforGST1.text = state.quotationOtherChargesListResponse.details[i].beforeGST.toString();
          }



        else if(edt_ChargeID2.text==state.quotationOtherChargesListResponse.details[i].pkId.toString())
          {
            chrID2 = state.quotationOtherChargesListResponse.details[i].pkId;
            edt_ChargeID2.text = chrID2.toString();
            edt_ChargeName2.text  = state.quotationOtherChargesListResponse.details[i].chargeName;

            edt_ChargeTaxType2.text = state.quotationOtherChargesListResponse.details[i].taxType.toString();
            edt_ChargeGstPer2.text = state.quotationOtherChargesListResponse.details[i].gSTPer.toString();
            edt_ChargeBeforGST2.text = state.quotationOtherChargesListResponse.details[i].beforeGST.toString();
          }


        else if(edt_ChargeID3.text==state.quotationOtherChargesListResponse.details[i].pkId.toString())
          {
            chrID3 = state.quotationOtherChargesListResponse.details[i].pkId;
            edt_ChargeID3.text = chrID3.toString();
            edt_ChargeName3.text  = state.quotationOtherChargesListResponse.details[i].chargeName;

            edt_ChargeTaxType3.text = state.quotationOtherChargesListResponse.details[i].taxType.toString();
            edt_ChargeGstPer3.text = state.quotationOtherChargesListResponse.details[i].gSTPer.toString();
            edt_ChargeBeforGST3.text = state.quotationOtherChargesListResponse.details[i].beforeGST.toString();
          }
        else if(edt_ChargeID4.text==state.quotationOtherChargesListResponse.details[i].pkId.toString()) {
          chrID4 = state.quotationOtherChargesListResponse.details[i].pkId;
          edt_ChargeID4.text = chrID4.toString();
          edt_ChargeName4.text  = state.quotationOtherChargesListResponse.details[i].chargeName;

          edt_ChargeTaxType4.text =
              state.quotationOtherChargesListResponse.details[i].taxType
                  .toString();
          edt_ChargeGstPer4.text =
              state.quotationOtherChargesListResponse.details[i].gSTPer
                  .toString();
          edt_ChargeBeforGST4.text =
              state.quotationOtherChargesListResponse.details[i].beforeGST
                  .toString();
        }
        else if(edt_ChargeID5.text==state.quotationOtherChargesListResponse.details[i].pkId.toString())
          {
            chrID5 = state.quotationOtherChargesListResponse.details[i].pkId;
            edt_ChargeID5.text = chrID5.toString();
            edt_ChargeName5.text  = state.quotationOtherChargesListResponse.details[i].chargeName;

            edt_ChargeTaxType5.text = state.quotationOtherChargesListResponse.details[i].taxType.toString();
            edt_ChargeGstPer5.text = state.quotationOtherChargesListResponse.details[i].gSTPer.toString();
            edt_ChargeBeforGST5.text = state.quotationOtherChargesListResponse.details[i].beforeGST.toString();
          }

      }

  }


  Widget BankDropDown(String Category,
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
            onTap: () => _inquiryBloc..add(QuotationBankDropDownCallEvent(
                BankDropDownRequest(CompanyID: CompanyID.toString(),LoginUserID: LoginUserID,pkID: ""))),
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

  void _onBankVoucherSaveResponse(QuotationBankDropDownResponseState state) {
    arr_ALL_Name_ID_For_BankDropDownList.clear();
    for(var i=0;i<state.response.details.length;i++)
    {
      ALL_Name_ID all_name_id = new ALL_Name_ID();
      all_name_id.pkID = state.response.details[i].pkID;
      all_name_id.Name = state.response.details[i].bankName;
      arr_ALL_Name_ID_For_BankDropDownList.add(all_name_id);
    }
    showcustomdialogWithID(
        values: arr_ALL_Name_ID_For_BankDropDownList,
        context1: context,
        controller: edt_Portal_details,
        controllerID: edt_Portal_details_ID,
        lable: "Select Bank Portal");
  }





}
