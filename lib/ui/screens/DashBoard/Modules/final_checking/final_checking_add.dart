import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/final_checking/final_checking_bloc.dart';
import 'package:soleoserp/models/api_requests/checking_no_to_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_delete_all_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_header_save_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/out_word_no_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_item_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class AddUpdateFinalPackingScreenArguments {
  FinalCheckingListDetails editModel;

  AddUpdateFinalPackingScreenArguments(this.editModel);
}

class FinalCheckingAddScreen extends BaseStatefulWidget {
  static const routeName = '/FinalCheckingAddScreen';
  final AddUpdateFinalPackingScreenArguments arguments;
  FinalCheckingAddScreen(this.arguments);

  @override
  _FinalCheckingAddScreenState createState() => _FinalCheckingAddScreenState();
}

class _FinalCheckingAddScreenState extends BaseState<FinalCheckingAddScreen>
    with BasicScreen, WidgetsBindingObserver {
  FinalCheckingBloc finalCheckingBloc;
  double height = 50;
  DateTime selectdate = DateTime.now();
  TimeOfDay selecttime = TimeOfDay.now();
  TextEditingController checkingno = TextEditingController();
  TextEditingController checkingdate = TextEditingController();
  TextEditingController Reversecheckingdate = TextEditingController();

  TextEditingController pcakingno = TextEditingController();

 TextEditingController edt_CustomerName  = TextEditingController();
 TextEditingController edt_CustomerpkID  = TextEditingController();
   TextEditingController edt_FinishProductID = TextEditingController();

   TextEditingController edt_FinishProductName = TextEditingController();
  bool ischecked;


  bool _isForUpdate = false;
  SearchDetails _searchInquiryListResponse;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_OutWordList = [];
  int SavedPKID=0;
  int CompanyID = 0;
  String LoginUserID = "";
  double CardViewHeight = 45.00;
  FinalCheckingListDetails _editModel;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  List<FinalCheckingItems> arr_ALL_Name_ID_For_CheckingItems = [];


  @override
  void initState() {
    super.initState();

    finalCheckingBloc = FinalCheckingBloc(baseBloc);

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      checkingdate.text = selectdate.day.toString() +
          "-" +
          selectdate.month.toString() +
          "-" +
          selectdate.year.toString();

      Reversecheckingdate.text = selectdate.year.toString() +
          "-" +
          selectdate.month.toString() +
          "-" +
          selectdate.day.toString();
      finalCheckingBloc.add(FinalCheckingItemsRequestCallEvent(FinalCheckingItemsRequest(CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));

    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => finalCheckingBloc,
      child: BlocConsumer<FinalCheckingBloc, FinalCheckingListState>(
        builder: (BuildContext context, FinalCheckingListState state) {
          if(state is FinalCheckingItemsResponseState)
            {
              _onfinalCheckingItemsResponse(state);
            }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if(currentState is FinalCheckingItemsResponseState)
            {
              return true;

            }
          return false;
        },
        listener: (BuildContext context, FinalCheckingListState state) {

          if (state is PackingNoListResponseState) {
            _onOutWordResponse(state);
          }

          if (state is FinalCheckingDeleteAllItemResponseState) {
            _onDeleteAllCheckingItems(state);
          }

          if (state is FinalCheckingHeaderSaveResponseState) {
            _onHeaderSaveResponse(state);
          }
          if (state is FinalCheckingSubDetailsSaveResponseState) {
            _onSubDetailsSaveResponse(state);
          }

          if(state is CheckingNoToCheckingItemsResponseState)
          {
            _onCheckingNoToCheckingItemsResponse(state);
          }

          return super.build(context);

        },
        listenWhen: (oldState, currentState) {
          if (currentState is PackingNoListResponseState ||
              currentState is FinalCheckingDeleteAllItemResponseState ||
          currentState is FinalCheckingHeaderSaveResponseState ||
          currentState is FinalCheckingSubDetailsSaveResponseState ||
          currentState is CheckingNoToCheckingItemsResponseState

          )
            {
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
      title: Text("Final Checking"),
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
                child: Text("Checking No.*",
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
              height: height,
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
                        child: TextField(
                            controller: checkingno,
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
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Checking Date*",
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
                _selectDate(context, checkingdate);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      _selectDate(context, checkingdate);
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
                                  controller: checkingdate,
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
                _onTapOfSearchView();

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
                              controller: edt_CustomerName,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                hintText: "Tap to search customer",
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
                child: Text("Packing No.*",
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
                 /* showcustomdialogWithOnlyName(
                      values: Outwardnolist,
                      context1: context,
                      controller: outwardno,
                      lable: "Select OutwardNo");
*/

                  if(edt_CustomerName.text!="")
                  {
                    if(arr_ALL_Name_ID_For_OutWordList.length!=0)
                    {
                      showcustomdialogWithOnlyName(
                          values: arr_ALL_Name_ID_For_OutWordList,
                          context1: context,
                          controller: pcakingno,
                          lable: "Select Packing No");

                      setState(() {
                        edt_FinishProductName.text;
                      });
                    }
                    else
                    {
                      showCommonDialogWithSingleOption(context, " Enter Valid Customer Name Which have Created Packing !",
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
                              controller: pcakingno,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,

                              //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                              decoration: InputDecoration(
                                hintText: "Tap to select packing No.",
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
            SizedBox(height: 25,),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: getCommonButton(baseTheme, () {
                //  _onTapOfDeleteALLContact();
                //  navigateTo(context, InquiryProductListScreen.routeName);
                print("ProductNamen" + "Product Name : "+  edt_FinishProductName.text);

                if(pcakingno.text!="")
                {

                  //packingChecklistBloc.add(PackingProductAssamblyListRequestCallEvent(PackingProductAssamblyListRequest(ProductID:edt_FinishProductID.text,CompanyId: CompanyID.toString())));

                  navigateTo(context, FinalCheckingItemScreen.routeName);

                }
                else
                {
                  showCommonDialogWithSingleOption(context, "Packing No Is Required To Add Product Assembly!",
                      positiveButtonTitle: "OK",onTapOfPositiveButton: (){
                        Navigator.pop(context);

                      });
                }




                //_onTaptoSaveQuotationHeader(context);
              }, "Add Item ",
                  width: 600, backGroundColor: colorPrimary),
            ),
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: getCommonButton(baseTheme, () {
                //  _onTapOfDeleteALLContact();
                //  navigateTo(context, InquiryProductListScreen.routeName);

                _onTaptoSaveHeader(context);

               // _onTaptoSavePackingCheckingHeader(context);
              }, "Save  ",
                  width: 600, backGroundColor: colorPrimary),
            ),
            SizedBox(height: 20,),
            /*CheckboxListTile(
                value: ischecked,

            title: Text("Scanner Check"),
            ),*/
          ],
        ),
      ),
    );
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
        checkingdate.text = selectdate.day.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.year.toString();

        Reversecheckingdate.text = selectdate.year.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.day.toString();
      });
  }


  Future<void> _onTapOfSearchView() async {
    if(_isForUpdate==false ){
      navigateTo(context, SearchInquiryCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchInquiryListResponse = value;
          edt_CustomerName.text = _searchInquiryListResponse.label;
          edt_CustomerpkID.text = _searchInquiryListResponse.value.toString();
          pcakingno.text="";
          arr_ALL_Name_ID_For_OutWordList.clear();
          finalCheckingBloc.add(OutWordCallEvent(OutWordNoListRequest(CustomerID: _searchInquiryListResponse.value.toString(),CompanyId: CompanyID.toString())));

          /* _inquiryBloc.add(SearchInquiryListByNameCallEvent(
              SearchInquiryListByNameRequest(word:  edt_CustomerName.text,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID,needALL: "1")));
*/
          //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));
         // packingChecklistBloc.add(OutWordCallEvent(OutWordNoListRequest(CustomerID: _searchInquiryListResponse.value.toString(),CompanyId: CompanyID.toString())));
        }
      });
    }

  }


  void _onOutWordResponse(PackingNoListResponseState state1) {

    if(state1.packingNoListResponse.details.length!=0)
    {
      arr_ALL_Name_ID_For_OutWordList.clear();

      for(int i=0;i<state1.packingNoListResponse.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state1.packingNoListResponse.details[i].pCNo;

        arr_ALL_Name_ID_For_OutWordList.add(all_name_id);
      }
    }
    else
    {
      showCommonDialogWithSingleOption(context, " Enter Valid Customer Name Which have Created Packing !",
          positiveButtonTitle: "OK",onTapOfPositiveButton: (){
            Navigator.pop(context);
          });

    }
    print("ResponseOf OutWord" + " Details : " + state1.packingNoListResponse.details[0].pCNo);
  }

  void fillData() async {

    SavedPKID = _editModel.pkID;
    checkingno.text = _editModel.checkingNo;
    checkingdate.text = _editModel.checkingDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "dd-MM-yyyy");
    Reversecheckingdate.text = _editModel.checkingDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    edt_CustomerName.text = _editModel.customerName.toString();
    edt_CustomerpkID.text = _editModel.customerID.toString();
    pcakingno.text =_editModel.pCNo;

    finalCheckingBloc.add(OutWordCallEvent(OutWordNoListRequest(CustomerID: edt_CustomerpkID.text,CompanyId: CompanyID.toString())));
    finalCheckingBloc.add(CheckingNoToCheckingItemsRequestCallEvent(CheckingNoToCheckingItemsRequest(CheckingNo:_editModel.checkingNo,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));

  }

  void _onfinalCheckingItemsResponse(FinalCheckingItemsResponseState state) async {
    _onTapOfDeleteALLItems();

    // arr_ALL_Name_ID_For_CheckingItems.clear();
    for(int i=0;i<state.finalCheckingItemsResponse.details.length;i++)
      {

        String CheckingNo = "";
        String CustomerID = edt_CustomerpkID.text;
        String Item = state.finalCheckingItemsResponse.details[i].description;
        String Checked = "0";
        String Remarks = "";
        String SerialNo = "";
        String SRno = state.finalCheckingItemsResponse.details[i].sRNo==false?"0":"1";
        String LoginUserID123 = LoginUserID.toString();
        String CompanyId = CompanyID.toString();

        await OfflineDbHelper.getInstance().insertFinalCheckingItems(FinalCheckingItems(CheckingNo,CustomerID,Item,Checked,Remarks,SerialNo,SRno,LoginUserID123,CompanyId));

      }

  }

  void _onCheckingNoToCheckingItemsResponse(CheckingNoToCheckingItemsResponseState state) async {
    _onTapOfDeleteALLItems();

    for(int i=0;i<state.checkingNoToCheckingItemsResponse.details.length;i++)
    {
      String CheckingNo = state.checkingNoToCheckingItemsResponse.details[i].checkingNo;
      String CustomerID = edt_CustomerpkID.text;
      String Item = state.checkingNoToCheckingItemsResponse.details[i].item;
      String Checked = state.checkingNoToCheckingItemsResponse.details[i].checked==false?"0":"1";
      String Remarks = "";
      String SerialNo = state.checkingNoToCheckingItemsResponse.details[i].serialNo;
      String SRno = state.checkingNoToCheckingItemsResponse.details[i].sRno==false?"0":"1";
      String LoginUserID123 = LoginUserID;
      String CompanyId = CompanyID.toString();

      await OfflineDbHelper.getInstance().insertFinalCheckingItems(FinalCheckingItems(CheckingNo,CustomerID,Item,Checked,Remarks,SerialNo,SRno,LoginUserID123,CompanyId));

    }

  }

  void _onTaptoSaveHeader(BuildContext context) async {
    await getInquiryProductDetails();

    if(Reversecheckingdate.text!="")
      {
        if(edt_CustomerName.text!="")
          {

            if(pcakingno.text!="")
            {

              showCommonDialogWithTwoOptions(
                  context, "Are you sure you want to Save this Packing CheckList ?",
                  negativeButtonTitle: "No",
                  positiveButtonTitle: "Yes", onTapOfPositiveButton: ()
              {

                if(checkingno.text!="")
                  {
                    finalCheckingBloc.add(FinalCheckingDeleteAllItemRequestCallEvent(checkingno.text,FinalCheckingDeleteAllItemsRequest(CompanyId: CompanyID.toString())));

                  }


                finalCheckingBloc.add(FinalCheckingHeaderSaveRequestCallEvent(SavedPKID,FinalCheckingHeaderSaveRequest(
                  CheckingNo:checkingno.text==null?"":checkingno.text,
                  CustomerID:edt_CustomerpkID.text==null?"":edt_CustomerpkID.text,
                  ProductID:"",
                  CheckingDate:Reversecheckingdate.text==null?"":Reversecheckingdate.text,
                  PCNo:pcakingno.text==null?"":pcakingno.text,
                  LoginUserID:LoginUserID.toString(), 
                  CompanyId:CompanyID.toString(),
                )));

              });

            }
            else{
              showCommonDialogWithSingleOption(context, "PackingNo is required !",
                  positiveButtonTitle: "OK");
            }
          }
        else
          {
            showCommonDialogWithSingleOption(context, "CustomerName is required !",
                positiveButtonTitle: "OK");
          }
      }
    else{
      showCommonDialogWithSingleOption(context, "Checking Date is required !",
          positiveButtonTitle: "OK");
    }
  }

  void _onDeleteAllCheckingItems(FinalCheckingDeleteAllItemResponseState state) {

    print("DeleteALLChekingItems" + state.finalCheckingDeleteAllItemResponse.details[0].column1);

  }

  void _onHeaderSaveResponse(FinalCheckingHeaderSaveResponseState state) {
   /* print("InquiryHeaderResponse" +
        state.finalCheckingHeaderSaveResponse.details[0].column2 +
        "\n" +
        state.finalCheckingHeaderSaveResponse.details[0].column3);*/
    updateRetrunInquiryNoToDB(state.finalCheckingHeaderSaveResponse.details[0].column3);
    print("listSize" + arr_ALL_Name_ID_For_CheckingItems.length.toString());
    finalCheckingBloc.add(FinalCheckingSubDetailsSaveCallEvent(arr_ALL_Name_ID_For_CheckingItems));

  }

  void _onSubDetailsSaveResponse(FinalCheckingSubDetailsSaveResponseState state) async {
    String Msg = _isForUpdate == true ? "Updated Successfully" : "Added Successfully";
    await showCommonDialogWithSingleOption(Globals.context,Msg,
        positiveButtonTitle: "OK",onTapOfPositiveButton: (){
          navigateTo(context, FinalCheckingListScreen.routeName,clearAllStack: true);
        });


  }

  void updateRetrunInquiryNoToDB(String ReturnInquiryNo) {
    arr_ALL_Name_ID_For_CheckingItems.forEach((element) {
      element.CheckingNo = ReturnInquiryNo;
      element.CustomerID = edt_CustomerpkID.text==null?"":"";
      element.LoginUserID = LoginUserID;
      element.CompanyId = CompanyID.toString();
    });
  }

  Future<void> getInquiryProductDetails() async {
    arr_ALL_Name_ID_For_CheckingItems.clear();
    List<FinalCheckingItems> temp =
    await OfflineDbHelper.getInstance().getFinalCheckingItems();
    arr_ALL_Name_ID_For_CheckingItems.addAll(temp);
    setState(() {});
  }

  Future<void> _onTapOfDeleteALLItems() async {
    await OfflineDbHelper.getInstance().deleteALLFinalCheckingItems();
  }
}