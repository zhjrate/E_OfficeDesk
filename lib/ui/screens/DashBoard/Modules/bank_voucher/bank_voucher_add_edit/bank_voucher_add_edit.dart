import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/bank_voucher/bank_voucher_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/followup/followup_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_list_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_save_request.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/followup_upload_image_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_by_customer_id_request.dart';
import 'package:soleoserp/models/api_requests/followup_save_request.dart';
import 'package:soleoserp/models/api_requests/followup_type_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/transection_mode_list_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_list_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_list/bank_voucher_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/search_followup_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/image_full_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateBankVoucherScreenArguments {
  BankVoucherDetails editModel;

  AddUpdateBankVoucherScreenArguments(this.editModel);
}

class BankVoucherAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/BankVoucherAddEditScreen';
  final AddUpdateBankVoucherScreenArguments arguments;

  BankVoucherAddEditScreen(this.arguments);

  @override
  _BankVoucherAddEditScreenState createState() =>
      _BankVoucherAddEditScreenState();
}

class _BankVoucherAddEditScreenState extends BaseState<BankVoucherAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController edt_FollowUpDate = TextEditingController();
  final TextEditingController edt_ReverseFollowUpDate = TextEditingController();
  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerpkID = TextEditingController();
  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_FollowupNotes = TextEditingController();
  final TextEditingController edt_NextFollowupDate = TextEditingController();
  final TextEditingController edt_ReverseNextFollowupDate = TextEditingController();
  final TextEditingController edt_EmployeeName = TextEditingController();
  final TextEditingController edt_EmployeeID = TextEditingController();
  final TextEditingController edt_Bank_A_C = TextEditingController();
  final TextEditingController edt_Bank_A_C_ID = TextEditingController();

  final TextEditingController edt_Voucher_Amount = TextEditingController();
  final TextEditingController edt_Portal_details = TextEditingController();
  final TextEditingController edt_Portal_details_ID = TextEditingController();

  final TextEditingController edt_CheqNo_details = TextEditingController();
  final TextEditingController edt_TransectionMode_Name = TextEditingController();
  final TextEditingController edt_TransectionMode_ID = TextEditingController();
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_EmplyeeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_TransectionModeList = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_BankDropDownList = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];


  DateTime selectedDate = DateTime.now();
  SearchDetails _searchDetails;
  BankVoucherScreenBloc _FollowupBloc;
  int savepkID = 0;
  bool _isForUpdate;
  BankVoucherDetails _editModel;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  FocusNode NotesFocusNode;
  bool SaveSucess;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData = SharedPrefHelper.instance.getFollowerEmployeeList();
    _onFollowerEmployeeListByStatusCallSuccess(_offlineFollowerEmployeeListData);
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    SaveSucess = false;
    _FollowupBloc = BankVoucherScreenBloc(baseBloc);
    NotesFocusNode = FocusNode();
    FetchFollowupPriorityDetails();
    edt_Priority.addListener(() {
      NotesFocusNode.requestFocus();
    });



    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      selectedDate = DateTime.now();
      edt_FollowUpDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
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



      setState(() {});
    }



    if (SaveSucess == true) {
      _onOldState();
    }
  }



  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
    NotesFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc,

      child: BlocConsumer<BankVoucherScreenBloc, BankVoucherScreenStates>(
        builder: (BuildContext context, BankVoucherScreenStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {

          return false;
        },
        listener: (BuildContext context, BankVoucherScreenStates state) {
          if (state is TransectionModeResponseState) {
            _onTransectionModeCallSuccess(state);
          }
          if (state is BankDropDownResponseState) {
            _onBankDropDownCallSuccess(state);
          }
          if(state is BankVoucherSaveResponseState)
            {
              _onBankVoucherSaveResponse(state);
            }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is TransectionModeResponseState || currentState is BankDropDownResponseState || currentState is BankVoucherSaveResponseState) {
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
          title: Text('Bank Voucher Details'),
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
                        CustomDropDown1("Rec./Pay.",
                            enable1: false,
                            title: "Rec./Pay.",
                            hintTextvalue: "Tap to Select Rec./Pay.",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Priority,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Folowup_Priority),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildEmplyeeListView(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),

                        _buildBankACSearchView(),


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
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Voucher Amount",
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
                            controller: edt_Voucher_Amount,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: '0.00',
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

                        showcustomdialogWithID1("Transaction Mode",
                            enable1: false,
                            title: "Transaction Mode *",
                            hintTextvalue: "Tap to Select Transaction Mode",
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorPrimary,
                            ),
                            controllerForLeft: edt_TransectionMode_Name,
                            controllerpkID: edt_TransectionMode_ID,
                            Custom_values1: arr_ALL_Name_ID_For_TransectionModeList),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        BankDropDown("Bank/Portal/Payment App. Name",
                            enable1: false,
                            title: "Bank/Portal/Payment App. Name",
                            hintTextvalue: "Tap to Select Bank Portal",
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: colorPrimary,
                            ),
                            controllerForLeft: edt_Portal_details,
                            controllerpkID: edt_Portal_details_ID,
                            Custom_values1: arr_ALL_Name_ID_For_BankDropDownList),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Transaction ID/Cheque No",
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
                            controller: edt_CheqNo_details,
                            minLines: 1,
                            maxLines: 2,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Transaction ID/Cheque No',
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
                        _buildNextFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Transaction Notes *",
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),






                        getCommonButton(baseTheme, () async {


                              if(edt_CustomerName.text!="")
                              {
                                if(edt_TransectionMode_Name.text!="")
                                {

                                  if(edt_NextFollowupDate.text!="")
                                  {
                                    if(edt_FollowupNotes.text!="")
                                    {

                                      DateTime FbrazilianDate = new DateFormat("dd-MM-yyyy").parse(edt_FollowUpDate.text);
                                      DateTime NbrazilianDate = new DateFormat("dd-MM-yyyy").parse(edt_NextFollowupDate.text);
                                      if(FbrazilianDate.isBefore(NbrazilianDate))
                                        {


                                          showCommonDialogWithTwoOptions(
                                              context,
                                              "Are you sure you want to Save this Bank Voucher ?",
                                              negativeButtonTitle: "No",
                                              positiveButtonTitle: "Yes",
                                              onTapOfPositiveButton: () {
                                                Navigator.of(context)
                                                    .pop();
                                                String Msg = _isForUpdate ==
                                                    true
                                                    ? "Bank Voucher. Updated Successfully"
                                                    : "Bank Voucher. Added Successfully";

                                                _FollowupBloc.add(BankVoucherSaveCallEvent(context,savepkID, BankVoucherSaveRequest(
                                                  VoucherType: "Bank",RecPay: edt_Priority.text==null?"Receivable":edt_Priority.text,VoucherNo: "",VoucherDate: edt_ReverseFollowUpDate.text,
                                                  AccountID: edt_Bank_A_C_ID.text==null?"":edt_Bank_A_C_ID.text,CustomerID: edt_CustomerpkID.text,
                                                    EmployeeID: edt_EmployeeID.text==null?"":edt_EmployeeID.text,
                                                  TransType: "acc",TransModeID: edt_TransectionMode_ID.text,TransID: edt_CheqNo_details.text==null?"":edt_CheqNo_details.text,
                                                  TransDate: edt_ReverseNextFollowupDate.text,VoucherAmount: edt_Voucher_Amount.text==null?"":edt_Voucher_Amount.text,
                                                  BankName: edt_Portal_details.text==null?"":edt_Portal_details.text,Remark: edt_FollowupNotes.text,
                                                  BasicAmt: "0.00",NetAmt: "0.00",CompanyID: CompanyID.toString(),LoginUserID: LoginUserID.toString()
                                                )));

                                              });

                                        }
                                      else{
                                        if(FbrazilianDate.isAtSameMomentAs(NbrazilianDate))
                                          {
                                            showCommonDialogWithTwoOptions(
                                                context,
                                                "Are you sure you want to Save this Bank Voucher ?",
                                                negativeButtonTitle: "No",
                                                positiveButtonTitle: "Yes",
                                                onTapOfPositiveButton: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                  String Msg = _isForUpdate ==
                                                      true
                                                      ? "Bank Voucher. Updated Successfully"
                                                      : "Bank Voucher. Added Successfully";

                                                  _FollowupBloc.add(BankVoucherSaveCallEvent(context,savepkID, BankVoucherSaveRequest(
                                                      VoucherType: "Bank",RecPay: edt_Priority.text==null?"Receivable":edt_Priority.text,VoucherNo: "",VoucherDate: edt_ReverseFollowUpDate.text,
                                                      AccountID: edt_Bank_A_C_ID.text==null?"":edt_Bank_A_C_ID.text,CustomerID: edt_CustomerpkID.text,EmployeeID: edt_EmployeeID.text==null?"":edt_EmployeeID.text,
                                                      TransType: "acc",TransModeID: edt_TransectionMode_ID.text,TransID: edt_CheqNo_details.text==null?"":edt_CheqNo_details.text,
                                                      TransDate: edt_ReverseNextFollowupDate.text,VoucherAmount: edt_Voucher_Amount.text==null?"":edt_Voucher_Amount.text,
                                                      BankName: edt_Portal_details.text==null?"":edt_Portal_details.text,Remark: edt_FollowupNotes.text,
                                                      BasicAmt: "0.00",NetAmt: "0.00",CompanyID: CompanyID.toString(),LoginUserID: LoginUserID.toString()
                                                  )));

                                                });
                                          }
                                        else{
                                          showCommonDialogWithSingleOption(
                                              context, "Transaction Date/Cheque Date Should be greater than Voucher Date !",
                                              positiveButtonTitle: "OK");
                                        }
                                      }

                                    }
                                    else
                                    {
                                      showCommonDialogWithSingleOption(
                                          context, "Transaction Notes is Required!",
                                          positiveButtonTitle: "OK");
                                    }
                                  }
                                  else
                                  {
                                    showCommonDialogWithSingleOption(
                                        context, "Transaction Date/Cheque Date is Required!",
                                        positiveButtonTitle: "OK");
                                  }
                                }
                                else
                                {
                                  showCommonDialogWithSingleOption(
                                      context, "Transaction Mode is Required!",
                                      positiveButtonTitle: "OK");
                                }
                              }
                              else
                              {
                                showCommonDialogWithSingleOption(
                                    context, "Customer A/c is Required!",
                                    positiveButtonTitle: "OK");
                              }


                        }, "Save"),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                      ]))),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, BankVoucherListScreen.routeName, clearAllStack: true);
  }

  Future<bool> _onOldState() {
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_FollowUpDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
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



  FetchFollowupPriorityDetails() {
    arr_ALL_Name_ID_For_Folowup_Priority.clear();
    for (var i = 0; i <= 1; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Receivable";
      } else if (i == 1) {
        all_name_id.Name = "Payable";
      }
      arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
    }
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
            child: Text("Customer A/c *",
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


  Widget _buildBankACSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfBankACSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Bank A/c",
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
                        controller: edt_Bank_A_C,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Search Bank A/c",
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


  Widget _buildFollowupDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, edt_FollowUpDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Voucher Date *",
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
                      edt_FollowUpDate.text == null ||
                              edt_FollowUpDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_FollowUpDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_FollowUpDate.text == null ||
                                  edt_FollowUpDate.text == ""
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

  Widget _buildNextFollowupDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_NextFollowupDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Transaction Date/Cheque Date *",
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
    );
  }


  Future<void> _onTapOfSearchView() async {
    if (_isForUpdate == false) {
      navigateTo(context, SearchFollowupCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchDetails = value;
          edt_CustomerpkID.text = _searchDetails.value.toString();
          edt_CustomerName.text = _searchDetails.label.toString();


          _FollowupBloc.add(SearchBankVoucherCustomerListByNameCallEvent(
              CustomerLabelValueRequest(
                  CompanyId: CompanyID.toString(),
                  LoginUserID: LoginUserID.toString(),
                  word: _searchDetails.value.toString())));


        }
        print("CustomerInfo : " +
            edt_CustomerName.text.toString() +
            " CustomerID : " +
            edt_CustomerpkID.text.toString());
      });
    }
  }


  Future<void> _onTapOfBankACSearchView() async {
    if (_isForUpdate == false) {
      navigateTo(context, SearchFollowupCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchDetails = value;
          edt_Bank_A_C_ID.text = _searchDetails.value.toString();
          edt_Bank_A_C.text = _searchDetails.label.toString();


          _FollowupBloc.add(SearchBankVoucherCustomerListByNameCallEvent(
              CustomerLabelValueRequest(
                  CompanyId: CompanyID.toString(),
                  LoginUserID:LoginUserID.toString(),
                  word: _searchDetails.value.toString())));


        }
        print("CustomerInfo : " +
            edt_Bank_A_C.text.toString() +
            " CustomerID : " +
            edt_Bank_A_C_ID.text.toString());
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
      margin: EdgeInsets.only(top: 15, bottom: 15),
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





  void fillData() {
    if (_editModel.voucherDate == "") {
      selectedDate = DateTime.now();
      edt_FollowUpDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
    } else {
      edt_FollowUpDate.text = _editModel.voucherDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseFollowUpDate.text = _editModel.voucherDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }
    if (_editModel.transDate == "") {
      selectedDate = DateTime.now();

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
    } else {
      edt_NextFollowupDate.text = _editModel.transDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseNextFollowupDate.text = _editModel.transDate
          .getFormattedDate(
              fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }




    edt_CustomerName.text = _editModel.customerName;
    edt_CustomerpkID.text = _editModel.customerID.toString();
    edt_Priority.text = _editModel.recPay;
    edt_EmployeeName.text = _editModel.employeeName;
    edt_EmployeeID.text = _editModel.employeeID.toString();
    edt_Bank_A_C.text = _editModel.accountName;
    edt_Bank_A_C_ID.text=_editModel.accountID.toString();
    edt_CustomerName.text = _editModel.customerName;
    edt_CustomerpkID.text = _editModel.customerID.toString();
    edt_Voucher_Amount.text = _editModel.voucherAmount.toString();
    edt_TransectionMode_Name.text = _editModel.transModeName.toString();
    edt_TransectionMode_ID.text = _editModel.transModeID.toString();
    edt_Portal_details.text = _editModel.bankName;
    edt_CheqNo_details.text = _editModel.transID.toString();
    edt_FollowupNotes.text = _editModel.remark;
    savepkID = _editModel.pkID.toInt();










  }















  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialogWithID(
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_EmployeeName,
            controllerID: edt_EmployeeID,
            lable: "Select Employee");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Select Employee",
                  style: TextStyle(
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight
                          .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                  ),
              Icon(
                Icons.filter_list_alt,
                color: colorPrimary,
              ),
            ]),
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
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: /* Text(
                        SelectedStatus =="" ?
                        "Tap to select Status" : SelectedStatus.Name,
                        style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),*/

                        TextField(
                      controller: edt_EmployeeName,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/
                      style: TextStyle(
                          color: Colors.black, // <-- Change this

                        fontSize: 15
                          ),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select Employee"),
                    ),
                    // dropdown()
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
    );
  }

  void _onFollowerEmployeeListByStatusCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Folowup_EmplyeeList.clear();

    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.pkID = state.details[i].pkID;
        arr_ALL_Name_ID_For_Folowup_EmplyeeList.add(all_name_id);
      }
    }
  }

  void _onTransectionModeCallSuccess(TransectionModeResponseState state) {
    arr_ALL_Name_ID_For_TransectionModeList.clear();
    for(var i=0;i<state.transectionModeListResponse.details.length;i++)
      {
        ALL_Name_ID all_name_id = new ALL_Name_ID();
        all_name_id.pkID = state.transectionModeListResponse.details[i].pkID;
        all_name_id.Name = state.transectionModeListResponse.details[i].walletName;
        arr_ALL_Name_ID_For_TransectionModeList.add(all_name_id);
      }
    showcustomdialogWithID(
        values: arr_ALL_Name_ID_For_TransectionModeList,
        context1: context,
        controller: edt_TransectionMode_Name,
        controllerID: edt_TransectionMode_ID,
        lable: "Select Transaction Mode");
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
            onTap: () => _FollowupBloc..add(TransectionModeCallEvent(
                TransectionModeListRequest(CompanyID: CompanyID.toString()))),
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
            onTap: () => _FollowupBloc..add(BankDropDownCallEvent(
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

  void _onBankDropDownCallSuccess(BankDropDownResponseState state) {
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

  void _onBankVoucherSaveResponse(BankVoucherSaveResponseState state) async {
    String Msg="";
    for(var i=0;i<state.bankVoucherSaveResponse.details.length;i++)
      {
        print("SAveSucesss"+state.bankVoucherSaveResponse.details[i].column2);
         Msg = _isForUpdate == true ? "Voucher Transaction. Updated Successfully" : "Voucher Transaction. Added Successfully";

      }
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK");

   Navigator.of(context).pop();

  }
}
