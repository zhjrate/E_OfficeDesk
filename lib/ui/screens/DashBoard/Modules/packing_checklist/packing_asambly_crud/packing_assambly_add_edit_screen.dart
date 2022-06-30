import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/packing_checklist/packing_checklist_bloc.dart';
import 'package:soleoserp/blocs/other/firstscreen/first_screen_bloc.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_requests/product_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/product_group_drop_down_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/models/common/packingProductAssamblyTable.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/app_constants.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class PackingAssamblyAddEditScreenArguments {
  PackingProductAssamblyTable model;


  PackingAssamblyAddEditScreenArguments(this.model);
}

class PackingAssamblyAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/PackingAssamblyAddEditScreen';
  final PackingAssamblyAddEditScreenArguments arguments;

  PackingAssamblyAddEditScreen(this.arguments);

  @override
  _PackingAssamblyAddEditScreenState createState() => _PackingAssamblyAddEditScreenState();
}

class _PackingAssamblyAddEditScreenState extends BaseState<PackingAssamblyAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  //DesignationApiResponse _offlineCustomerDesignationData;


  TextEditingController _quantityController = TextEditingController();
  TextEditingController _unitPriceController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();

  TextEditingController _productGroupNameController = TextEditingController();
  TextEditingController _productGroupIDController = TextEditingController();

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productIDController = TextEditingController();

  TextEditingController _productUnitController = TextEditingController();

  TextEditingController _productQuanitityController = TextEditingController();
  TextEditingController _productRemarksController = TextEditingController();

  FocusNode QuantityFocusNode;

  final _formKey = GlobalKey<FormState>();
  bool isForUpdate = false;
  bool isProductExist = false;
  PackingChecklistBloc _inquiryBloc;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Designation = [];
  ProductSearchDetails _searchDetails;
  double airFlow;
  double velocity;
  double valueFinal;
  String sam, sam2;
  String airFlowText, velocityText, finalText;
  List<PackingProductAssamblyTable> _inquiryProductList = [];

  double CardViewHieght = 50;

  List<ALL_Name_ID> arr_ProductGruopList = [];
  List<ALL_Name_ID> arr_ProductList = [];


  int CompanyID = 0;
  String LoginUserID = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;



  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    QuantityFocusNode = FocusNode();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;


    // _offlineCustomerDesignationData = SharedPrefHelper.instance.getCustomerDesignationData();
    if (widget.arguments != null) {
      //for update
      isForUpdate = true;
      _productGroupNameController.text = widget.arguments.model.ProductGroupName.toString();
      _productGroupIDController.text = widget.arguments.model.ProductGroupID.toString();
      _productNameController.text = widget.arguments.model.ProductName;
      _productIDController.text = widget.arguments.model.ProductID.toString();
      _productUnitController.text = widget.arguments.model.Unit;
      _productQuanitityController.text = widget.arguments.model.Quantity.toStringAsFixed(2);
      _productRemarksController.text = widget.arguments.model.ProductSpecification;
      //_totalAmountController.text = _quantityController.text +_unitPriceController.text ;
    }
    // _totalAmountController.text = totalCalculated();

    _inquiryBloc = PackingChecklistBloc(baseBloc);
    //_onDesignationCallSuccess(_offlineCustomerDesignationData);
    /* _productNameController.addListener(() {
      QuantityFocusNode.requestFocus();
    });*/
  }

  /* String totalCalculated() {
    airFlowText = _quantityController.text;
    velocityText = _unitPriceController.text;
    finalText = _totalAmountController.text;

    if (airFlowText != '' && velocityText != '') {
      sam = (airFlow * velocity).toString();
      _totalAmountController.value = _totalAmountController.value.copyWith(
        text: sam.toString(),
      );
    }
    return sam;
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<PackingChecklistBloc, PackingChecklistListState>(
        builder: (BuildContext context, PackingChecklistListState state) {
          //handle states
          /*  if (state is In) {
            _onDesignationCallSuccess(state);
          }
*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          /* if (currentState is DesignationListEventResponseState) {
            return true;
          }*/
          return false;
        },
        listener: (BuildContext context, PackingChecklistListState state) {

          if(state is ProductGroupDropDownResponseState)
            {
              _onProductGroupDropDownAPIResponse(state);
            }

          if(state is ProductDropDownResponseState)
          {
            _onProductDropDownAPIResponse(state);
          }
          return super.build(context);

        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          /* if (currentState is StateListEventResponseState) {
            return true;
          }
          if (currentState is DistrictListEventResponseState) {
            return true;
          }*/

          if(currentState is ProductGroupDropDownResponseState || currentState is ProductDropDownResponseState)
            {
              return true;

            }

          return false;
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
    QuantityFocusNode.dispose();

  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        getCommonAppBar(
            context, baseTheme, "${isForUpdate ? "Update" : "Add"} Product",
            showBack: true,showHome:true),
        Expanded(
          child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildProductGroupListView(),
                     SizedBox(
                        height: 20,
                      ),
                      //Quantity(),
                      _buildProductListView(),
                      SizedBox(
                        height: 20,
                      ),
                      Unit(),
                      SizedBox(
                        height: 20,
                      ),
                      Quantity(),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text("Remarks",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: colorPrimary,
                                    fontWeight: FontWeight
                                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 7, right: 7, top: 10),
                            child: TextFormField(
                              controller: _productRemarksController,
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please enter this field";
                                }
                                return null;
                              },
                              minLines: 2,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Enter Details',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      getCommonButton(baseTheme, () {
                        _onTapOfAdd();

                      }, isForUpdate ? "Update" : "Add")
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }

  _onTapOfAdd() async {
    await getInquiryProductDetails();
    if (_formKey.currentState.validate()) {
      //checkExistProduct();
      print("BoolProductValue"+" IsExist : " + isProductExist.toString() + "ISUpdate : " + isForUpdate.toString());
      if(isProductExist==false)
      {
        if (isForUpdate) {
          /*await OfflineDbHelper.getInstance().updateInquiryProduct(InquiryProductModel(
              "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
              _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text,
              id: widget.arguments.model.id));*/
          int GroupID = int.parse(_productGroupIDController.text==""?0:_productGroupIDController.text);
          int ProductID = int.parse(_productIDController.text==""?0:_productIDController.text);
          double Quantity = double.parse(_productQuanitityController.text==""?0.00:_productQuanitityController.text);
          await OfflineDbHelper.getInstance().updatePackingProductAssambly(PackingProductAssamblyTable("",0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text,_productRemarksController.text,"","",id:  widget.arguments.model.id));

        } else {
         /* await OfflineDbHelper.getInstance().insertInquiryProduct(InquiryProductModel(
            "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
            _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text.toString(),
          ));*/

          int GroupID = int.parse(_productGroupIDController.text==""?0:_productGroupIDController.text);
          int ProductID = int.parse(_productIDController.text==""?0:_productIDController.text);
          double Quantity = double.parse(_productQuanitityController.text==""?0.00:_productQuanitityController.text);
          //await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable(0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text));
          await OfflineDbHelper.getInstance().insertPackingProductAssambly(PackingProductAssamblyTable("",0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text,_productRemarksController.text,"",""));

        }
        Navigator.of(context).pop();


      }
      else{
        if(isForUpdate)
        {
         /* await OfflineDbHelper.getInstance().updateInquiryProduct(InquiryProductModel(
              "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
              _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text,
              id: widget.arguments.model.id));*/

          int GroupID = int.parse(_productGroupIDController.text==""?0:_productGroupIDController.text);
          int ProductID = int.parse(_productIDController.text==""?0:_productIDController.text);
          double Quantity = double.parse(_productQuanitityController.text==""?0.00:_productQuanitityController.text);
          //await OfflineDbHelper.getInstance().updatePackingProductAssambly(PackingProductAssamblyTable(0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text,id:  widget.arguments.model.id));
          await OfflineDbHelper.getInstance().updatePackingProductAssambly(PackingProductAssamblyTable("",0,"",GroupID,_productGroupNameController.text,ProductID,_productNameController.text,_productUnitController.text,Quantity,_productRemarksController.text,_productRemarksController.text,"","",id:  widget.arguments.model.id));

          Navigator.of(context).pop();
        }
        else
        {
          showCommonDialogWithSingleOption(context, "Duplicate Product Group Not Allowed..!!",
              positiveButtonTitle: "OK");
        }

      }
    }
  }

  void _onDesignationCallSuccess(DesignationApiResponse state) {
    arr_ALL_Name_ID_For_Designation.clear();
    for (var i = 0; i < state.details.length; i++) {
      print("DesignationDetails : " +
          state.details[i].designation);
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.details[i].designation;
      all_name_id.Name1 = state.details[i].desigCode;
      arr_ALL_Name_ID_For_Designation.add(all_name_id);
    }
  }
  Widget _buildProductGroupListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);

        _inquiryBloc.add(ProductGroupDropDownRequestCallEvent(ProductGroupDropDownRequest(pkID: "",CompanyId: CompanyID.toString())));


      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Product Group Name *",
                      style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

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
              height: CardViewHieght,
              child: Row(
                children: [
                  Expanded(
                    child:/* Text(
                        SelectedStatus =="" ?
                        "Tap to select Status" : SelectedStatus.Name,
                        style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),*/

                    TextField(
                      controller: _productGroupNameController,
                      //controller: edt_EmployeeName,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/  style: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 12, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select"
                      ),),
                    // dropdown()
                  ),
                  /*  Icon(
                    Icons.arrow_drop_down,
                    color: colorGrayDark,
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildProductListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        /* showcustomdialogWithID(
            values: arr_ALL_Name_ID_For_Folowup_EmplyeeList,
            context1: context,
            controller: edt_EmployeeName,
            controllerID: edt_EmployeeID ,
            lable: "Assign To");*/
        if(_productGroupIDController.text!="")
          {
            _inquiryBloc.add(ProductDropDownRequestCallEvent(ProductDropDownRequest(pkID: _productGroupIDController.text,CompanyId: CompanyID.toString())));

          }
        else
          {
            _inquiryBloc.add(ProductDropDownRequestCallEvent(ProductDropDownRequest(pkID: "",CompanyId: CompanyID.toString())));

          }

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Product Group Name *",
                      style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

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
              height: CardViewHieght,
              child: Row(
                children: [
                  Expanded(
                    child:/* Text(
                        SelectedStatus =="" ?
                        "Tap to select Status" : SelectedStatus.Name,
                        style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                    ),*/

                    TextField(
                      controller: _productNameController,
                      enabled: false,
                      /*  onChanged: (value) => {
                    print("StatusValue " + value.toString() )
                },*/  style: TextStyle(
                        color: Colors.black, // <-- Change this
                        fontSize: 12, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select"
                      ),),
                    // dropdown()
                  ),
                  /*  Icon(
                    Icons.arrow_drop_down,
                    color: colorGrayDark,
                  )*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  Widget Unit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Unit",
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
                  child: TextFormField(
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: _productUnitController,

                      decoration: InputDecoration(
                        hintText: "Tap to enter Unit",
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
                  Icons.style,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget Quantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Quantity",
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
                  child: TextFormField(
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _productQuanitityController,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Quantity",
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
                  Icons.style,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }





  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<PackingProductAssamblyTable> temp =
    await OfflineDbHelper.getInstance().getPackingProductAssambly();
    _inquiryProductList.addAll(temp);
    if(_inquiryProductList.length !=0)
    {
      for(var i=0;i<_inquiryProductList.length;i++)
      {
        if(_inquiryProductList[i].ProductGroupID.toString() ==_productGroupIDController.text.toString())
        {
          isProductExist = true;
          break;
        }
        else
        {
          isProductExist = false;
        }
      }
    }
    else
    {
      isProductExist = false;

    }
    setState(() {});
  }

  bool checkExistProduct() {
    if(_inquiryProductList.length !=0)
    {
      for(var i=0;i<_inquiryProductList.length;i++)
      {
        if(_inquiryProductList[i].ProductGroupID.toString()  ==_productGroupIDController.text.toString())
        {
          return isProductExist = true;
        }
        else
        {
          return isProductExist = false;
        }
      }
    }
    else
    {
      return isProductExist = false;

    }
    setState(() {

    });

  }

  void _onProductGroupDropDownAPIResponse(ProductGroupDropDownResponseState state) {
    arr_ProductGruopList.clear();
    for(int i=0;i<state.productGroupDropDownResponse.details.length;i++)
      {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.productGroupDropDownResponse.details[i].productGroupName;
        all_name_id.pkID = state.productGroupDropDownResponse.details[i].pkID;
        arr_ProductGruopList.add(all_name_id);
      }
    showcustomdialogWithLargeNameID(
            values: arr_ProductGruopList,
            context1: context,
            controller: _productGroupNameController,
            controllerID: _productGroupIDController ,
            lable: "Product Group");
  }

  void _onProductDropDownAPIResponse(ProductDropDownResponseState state) {
    arr_ProductList.clear();
    for(int i=0;i<state.productDropDownResponse.details.length;i++)
    {
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.productDropDownResponse.details[i].productName;
      all_name_id.pkID = state.productDropDownResponse.details[i].pkID;
      arr_ProductList.add(all_name_id);
    }
    showcustomdialogWithLargeNameID(
        values: arr_ProductList,
        context1: context,
        controller: _productNameController,
        controllerID: _productIDController ,
        lable: "Product Group");

  }


}
