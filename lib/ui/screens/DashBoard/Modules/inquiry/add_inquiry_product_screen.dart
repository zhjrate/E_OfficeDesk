import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/blocs/other/firstscreen/first_screen_bloc.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
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

class AddInquiryProductScreenArguments {
  InquiryProductModel model;

  AddInquiryProductScreenArguments(this.model);
}

class AddInquiryProductScreen extends BaseStatefulWidget {
  static const routeName = '/AddInquiryProductScreen';
  final AddInquiryProductScreenArguments arguments;

  AddInquiryProductScreen(this.arguments);

  @override
  _AddInquiryProductScreenState createState() => _AddInquiryProductScreenState();
}

class _AddInquiryProductScreenState extends BaseState<AddInquiryProductScreen>
    with BasicScreen, WidgetsBindingObserver {
  //DesignationApiResponse _offlineCustomerDesignationData;

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productIDController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _unitPriceController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();
  FocusNode QuantityFocusNode;

  final _formKey = GlobalKey<FormState>();
  bool isForUpdate = false;
  bool isProductExist = false;
  InquiryBloc _inquiryBloc;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Designation = [];
  ProductSearchDetails _searchDetails;
  double airFlow;
  double velocity;
  double valueFinal;
  String sam, sam2;
  String airFlowText, velocityText, finalText;
  List<InquiryProductModel> _inquiryProductList = [];

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    QuantityFocusNode = FocusNode();

   // _offlineCustomerDesignationData = SharedPrefHelper.instance.getCustomerDesignationData();
    if (widget.arguments != null) {
      //for update
      isForUpdate = true;
      _productNameController.text = widget.arguments.model.ProductName;
      _productIDController.text = widget.arguments.model.ProductID;
      _quantityController.text = widget.arguments.model.Quantity;
      _unitPriceController.text = widget.arguments.model.UnitPrice;
      _totalAmountController.text = widget.arguments.model.TotalAmount;

      //_totalAmountController.text = _quantityController.text +_unitPriceController.text ;
    }
   // _totalAmountController.text = totalCalculated();
    _quantityController.addListener(TotalAmountCalculation);
    _unitPriceController.addListener(TotalAmountCalculation);
    _totalAmountController.addListener(TotalAmountCalculation);
    _inquiryBloc = InquiryBloc(baseBloc);
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
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
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
        listener: (BuildContext context, InquiryStates state) {},
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          /* if (currentState is StateListEventResponseState) {
            return true;
          }
          if (currentState is DistrictListEventResponseState) {
            return true;
          }*/

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
                      _buildSearchView(),
                      SizedBox(
                        height: 20,
                      ),
                      Quantity(),

                      SizedBox(
                        height: 20,
                      ),
                      UnitPrice(),

                      SizedBox(
                        height: 20,
                      ),
                      TotalAmount(),
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
            await OfflineDbHelper.getInstance().updateInquiryProduct(InquiryProductModel(
                "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
                _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text,
                id: widget.arguments.model.id));
          } else {
            await OfflineDbHelper.getInstance().insertInquiryProduct(InquiryProductModel(
              "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
              _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text.toString(),
            ));
        }
          Navigator.of(context).pop();


      }
      else{
        if(isForUpdate)
          {
            await OfflineDbHelper.getInstance().updateInquiryProduct(InquiryProductModel(
                "test","0","abc",_productNameController.text.toString(),_productIDController.text.toString(),
                _quantityController.text.toString(),_unitPriceController.text.toString(),_totalAmountController.text,
                id: widget.arguments.model.id));
            Navigator.of(context).pop();
          }
        else
          {
            showCommonDialogWithSingleOption(context, "Duplicate Product Not Allowed..!!",
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
            height: 60,
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
                      focusNode: QuantityFocusNode,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _quantityController,
                      onChanged: (_quantityController) {
                        setState(() {
                          airFlow = double.parse(_quantityController.toString());
                        });
                      },
                      onTap: () {
                        setState(() {
                          _quantityController.clear();
                          _totalAmountController.clear();
                        });
                      },
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
  Widget UnitPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("UnitPrice",
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
                  child: TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _unitPriceController,
                      onChanged: (_unitPriceController) {
                        setState(() {
                          velocity  = double.parse(_unitPriceController.toString());
                        });
                      },
                      onTap: () {
                        setState(() {
                          _unitPriceController.clear();
                          _totalAmountController.clear();

                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Tap to enter UnitPrice",
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
                Image.network(
                  "https://www.freeiconspng.com/uploads/rupees-symbol-png-10.png",
                  height: 18,
                  width: 18,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget TotalAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("NetAmount",
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
                  child: TextFormField(
                     // key: Key(totalCalculated()),

                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        }
                        return null;
                      },
                      enabled: false,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      controller: _totalAmountController,
                      onChanged: (value) {
                        setState(() {
                          _totalAmountController.value = _totalAmountController.value.copyWith(
                            text: value.toString(),
                          );
                        });
                      },
                      onTap: () {
                        setState(() {
                          _totalAmountController.clear();
                          _totalAmountController.value = _totalAmountController.value.copyWith(
                            text: '',
                          );
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "0.00",
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
                Image.network(
                  "https://www.freeiconspng.com/uploads/rupees-symbol-png-10.png",
                  height: 18,
                  width: 18,
                )
              ],
            ),
          ),
        )
      ],
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
          Text(

              "Search Product",
              style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

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
                        onTap: (){
                          _onTapOfSearchView();
                        },
                        readOnly: true,
                        controller: _productNameController,
                        decoration: InputDecoration(
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
        _unitPriceController.text = _searchDetails.unitPrice.toString();
        //_totalAmountController.text = ""
        if(_productNameController.text == _searchDetails.productName.toString())
          {
            QuantityFocusNode.requestFocus();

          }
      }
    });
  }

   TotalAmountCalculation() {

    if(_quantityController.text.toString()!=null && _unitPriceController.text.toString()!=null)
      {
        double Quantity = double.parse(_quantityController.text.toString());
        double UnitPrice = double.parse(_unitPriceController.text.toString());
        double TotalAmount = Quantity * UnitPrice;
        _totalAmountController.text = TotalAmount.toString();
      }


   }
  Future<void> getInquiryProductDetails() async {
    _inquiryProductList.clear();
    List<InquiryProductModel> temp =
    await OfflineDbHelper.getInstance().getInquiryProduct();
    _inquiryProductList.addAll(temp);
    if(_inquiryProductList.length !=0)
    {
      for(var i=0;i<_inquiryProductList.length;i++)
      {
        if(_inquiryProductList[i].ProductID ==_productIDController.text.toString())
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
        if(_inquiryProductList[i].ProductID ==_productIDController.text.toString())
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

}
