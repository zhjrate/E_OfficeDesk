import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/models/common/quotationtable.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/add_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_product_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddQuotationProductListArgument {
  String quotation_No;
  String stateCode;
  String HeaderDiscAmnt;

  AddQuotationProductListArgument(this.quotation_No,this.stateCode,this.HeaderDiscAmnt);
}

class QuotationProductListScreen extends BaseStatefulWidget {
  static const routeName = '/QuotationProductListScreen';
  final AddQuotationProductListArgument arguments;
  QuotationProductListScreen(this.arguments);
  @override
  _QuotationProductListScreenState createState() => _QuotationProductListScreenState();
}

class _QuotationProductListScreenState extends BaseState<QuotationProductListScreen>
    with BasicScreen, WidgetsBindingObserver {
  List<QuotationTable> _productList = [];
  List<QuotationTable> _TempinquiryProductList = [];


  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F;//0x66666666;
  int title_color = 0xff362d8b;
  int _StateCode = 0;
  String QuotationNo ="";
  QuotationTable qtModel;
  String _HeaderDiscAmnt="0.00";

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  String LoginUserID;
  String CompanyID;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    LoginUserID = _offlineLoggedInData.details[0].userID;
    CompanyID = _offlineCompanyData.details[0].pkId.toString();
    if (widget.arguments != null) {
      print("GetINQNOFRomList"+widget.arguments.quotation_No);
      QuotationNo = widget.arguments.quotation_No;
      _StateCode = int.parse(widget.arguments.stateCode);
      _HeaderDiscAmnt = widget.arguments.HeaderDiscAmnt;

    }
    //getContacts();
    getProduct();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: /*PreferredSizeWidget(getCommonAppBar(context, baseTheme, "Quotation Product List", showBack: true)),*/
      AppBar(
          backgroundColor:colorPrimary,
        title: Text("Quotation Product List"),
      ),
      body: _buildContactsListView(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

         /* FloatingActionButton(
            backgroundColor: colorPrimary,
            onPressed: () async {
              *//* await navigateTo(
                          context,
                          AddQuotationProductScreen.routeName,
                        );*//*
              await navigateTo(context, QuotationOtherChargeScreen.routeName,
                  arguments: QuotationOtherChargesScreenArguments(qtModel,_StateCode));
              getProduct();
            },
            child: Icon(Icons.filter_alt_rounded),
          ),
          SizedBox(height: 10,),*/
          FloatingActionButton(
            backgroundColor: colorPrimary,
            onPressed: () async {
              /* await navigateTo(
                          context,
                          AddQuotationProductScreen.routeName,
                        );*/
              await navigateTo(context, AddQuotationProductScreen.routeName,
                  arguments: AddQuotationProductScreenArguments(qtModel,_StateCode,_HeaderDiscAmnt));
              getProduct(); //right now calling again get contacts, later it can be optimized
            },
            child: Icon(Icons.add),
          ),

        ],
      ),
    );
  }

  Widget _buildContactsListView() {
    if(_productList.length !=0)
    {
      return ListView.builder(

        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);

          /* return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID:${_productList[index].id}"),
                          Text("InquiryNo: ${_productList[index].InquiryNo}"),
                          Text("ProductID:${_productList[index].ProductID}"),
                          Text("ProductName: ${_productList[index].ProductName}"),
                          Text("Quantity: ${_productList[index].Quantity}"),
                          Text("UnitPrice: ${_productList[index].UnitPrice}"),

                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _onTapOfEditContact(index);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  _onTapOfDeleteContact(index);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      )
                    ],
                  )),
            );*/
        },
        shrinkWrap: true,
        itemCount: _productList.length,
      );
    }
    else
    {
      return Container(
        alignment: Alignment.center,
        child:   Lottie.asset(
            NO_DATA_ANIMATED
          /*height: 200,
              width: 200*/
        ),);
    }
  }

  Future<void> getProduct() async {

    _productList.clear();
    _productList.addAll(await OfflineDbHelper.getInstance().getQuotationProduct());
    await UpdateAfterHeaderDiscountToDB();
    _productList.clear();
    _productList.addAll(await OfflineDbHelper.getInstance().getQuotationProduct());
    setState(() {});
  }


  Future<void> UpdateAfterHeaderDiscountToDB() async {

    double tot_amnt_net = 0.00;

    double Tot_NetAmt = 0.00;

    _TempinquiryProductList.clear();
    _TempinquiryProductList.addAll(_productList);

    await OfflineDbHelper.getInstance().deleteALLQuotationProduct();

    for(int i=0;i<_TempinquiryProductList.length;i++)
    {
      print("_inquiryProductList[i].NetAmount234" + " Tot_NetAmt : "+ _TempinquiryProductList[i].NetAmount.toString());

      tot_amnt_net = tot_amnt_net +  _TempinquiryProductList[i].NetAmount;

    }
    print("Tot_NetAmtTot_NetAmt" + " Tot_NetAmt : "+ tot_amnt_net.toString());


    double HeaderDisAmnt = double.parse(_HeaderDiscAmnt == null ? 0.00 : _HeaderDiscAmnt);
    double ExclusiveItemWiseHeaderDisAmnt = 0.00;
    double ExclusiveItemWiseAmount = 0.00;
    double ExclusiveNetAmntAfterHeaderDisAmnt = 0.00;
    double ExclusiveItemWiseTaxAmnt =0.00;
    double ExclusiveTaxPluse100 = 0.00;
    double ExclusiveFinalNetAmntAfterHeaderDisAmnt = 0.00;

    double ExclusiveTotalNetAmntAfterHeaderDisAmnt = 0.00;

    double InclusiveItemWiseHeaderDisAmnt = 0.00;
    double InclusiveItemWiseAmount = 0.00;
    double InclusiveNetAmntAfterHeaderDisAmnt = 0.00;
    double InclusiveItemWiseTaxAmnt =0.00;
    double InclusiveTaxPluse100 = 0.00;
    double InclusiveFinalNetAmntAfterHeaderDisAmnt = 0.00;

    double InclusiveTotalNetAmntAfterHeaderDisAmnt = 0.00;
    double ExTotalBasic = 0.00;
    double ExTotalGSTamt=0.00;
    double ExTotalNetAmnt=0.00;
    double InTotalBasic = 0.00;
    double InTotalGSTamt=0.00;
    double InTotalNetAmnt=0.00;

    for(int i=0;i<_TempinquiryProductList.length;i++)
    {
      if(_TempinquiryProductList[i].TaxType==1)
      {
        ExclusiveItemWiseHeaderDisAmnt = (_TempinquiryProductList[i].NetAmount * HeaderDisAmnt)/tot_amnt_net;
        ExclusiveItemWiseAmount =_TempinquiryProductList[i].Quantity * _TempinquiryProductList[i].NetRate;
        ExclusiveNetAmntAfterHeaderDisAmnt = ExclusiveItemWiseAmount-ExclusiveItemWiseHeaderDisAmnt;
        ExclusiveItemWiseTaxAmnt = (ExclusiveNetAmntAfterHeaderDisAmnt * _TempinquiryProductList[i].TaxRate)/100;
        ExclusiveFinalNetAmntAfterHeaderDisAmnt = ExclusiveNetAmntAfterHeaderDisAmnt;
        ExclusiveTotalNetAmntAfterHeaderDisAmnt = ExclusiveItemWiseAmount + ExclusiveItemWiseTaxAmnt;

        var CGSTPer = 0.00;
        var CGSTAmount = 0.00;var SGSTPer = 0.00;var SGSTAmount = 0.00;var IGSTPer = 0.00;var IGSTAmount = 0.00;
        if(_offlineLoggedInData.details[0].stateCode==int.parse(_TempinquiryProductList[i].StateCode.toString()))
        {
          CGSTPer = _TempinquiryProductList[i].TaxRate/ 2;
          SGSTPer = _TempinquiryProductList[i].TaxRate/2;
          CGSTAmount = ExclusiveItemWiseTaxAmnt/2;
          SGSTAmount = ExclusiveItemWiseTaxAmnt/2;
          IGSTPer = 0.00;
          IGSTAmount = 0.00;
        }
        else
        {
          IGSTPer = _TempinquiryProductList[i].TaxRate;
          IGSTAmount = ExclusiveItemWiseTaxAmnt;
          CGSTPer = 0.00;
          SGSTPer = 0.00;
          CGSTAmount = 0.00;
          SGSTAmount = 0.00;
        }

        await OfflineDbHelper.getInstance().insertQuotationProduct(QuotationTable(
            _TempinquiryProductList[i].QuotationNo,_TempinquiryProductList[i].ProductSpecification,_TempinquiryProductList[i].ProductID,_TempinquiryProductList[i].ProductName,_TempinquiryProductList[i].Unit,_TempinquiryProductList[i].Quantity,_TempinquiryProductList[i].UnitRate,_TempinquiryProductList[i].DiscountPercent,
            _TempinquiryProductList[i].DiscountAmt,_TempinquiryProductList[i].NetRate,ExclusiveFinalNetAmntAfterHeaderDisAmnt,_TempinquiryProductList[i].TaxRate,ExclusiveItemWiseTaxAmnt,ExclusiveTotalNetAmntAfterHeaderDisAmnt,_TempinquiryProductList[i].TaxType,CGSTPer,SGSTPer,IGSTPer,
            CGSTAmount,SGSTAmount,IGSTAmount,_TempinquiryProductList[i].StateCode,_TempinquiryProductList[i].pkID,LoginUserID,CompanyID.toString(),0,ExclusiveItemWiseHeaderDisAmnt
        ));


      }
      else
      {
        InclusiveItemWiseHeaderDisAmnt =  (_TempinquiryProductList[i].NetAmount * HeaderDisAmnt)/tot_amnt_net;
        InclusiveItemWiseAmount =_TempinquiryProductList[i].Quantity * _TempinquiryProductList[i].NetRate;
        InclusiveNetAmntAfterHeaderDisAmnt = InclusiveItemWiseAmount-InclusiveItemWiseHeaderDisAmnt;
        InclusiveTaxPluse100 = 100+_TempinquiryProductList[i].TaxRate;
        InclusiveItemWiseTaxAmnt = (InclusiveNetAmntAfterHeaderDisAmnt * _TempinquiryProductList[i].TaxRate)/InclusiveTaxPluse100;
        InclusiveFinalNetAmntAfterHeaderDisAmnt = InclusiveNetAmntAfterHeaderDisAmnt-InclusiveItemWiseTaxAmnt;
        InclusiveTotalNetAmntAfterHeaderDisAmnt = InclusiveNetAmntAfterHeaderDisAmnt + InclusiveItemWiseTaxAmnt;

        var CGSTPer = 0.00;
        var CGSTAmount = 0.00;var SGSTPer = 0.00;var SGSTAmount = 0.00;var IGSTPer = 0.00;var IGSTAmount = 0.00;
        if(_offlineLoggedInData.details[0].stateCode==int.parse(_TempinquiryProductList[i].StateCode.toString()))
        {
          CGSTPer = _TempinquiryProductList[i].TaxRate/ 2;
          SGSTPer = _TempinquiryProductList[i].TaxRate/2;
          CGSTAmount = InclusiveItemWiseTaxAmnt/2;
          SGSTAmount = InclusiveItemWiseTaxAmnt/2;
          IGSTPer = 0.00;
          IGSTAmount = 0.00;
        }
        else
        {
          IGSTPer = _TempinquiryProductList[i].TaxRate;
          IGSTAmount = InclusiveItemWiseTaxAmnt;
          CGSTPer = 0.00;
          SGSTPer = 0.00;
          CGSTAmount = 0.00;
          SGSTAmount = 0.00;
        }

        await OfflineDbHelper.getInstance().insertQuotationProduct(QuotationTable(
            _TempinquiryProductList[i].QuotationNo,_TempinquiryProductList[i].ProductSpecification,_TempinquiryProductList[i].ProductID,_TempinquiryProductList[i].ProductName,_TempinquiryProductList[i].Unit,_TempinquiryProductList[i].Quantity,_TempinquiryProductList[i].UnitRate,_TempinquiryProductList[i].DiscountPercent,
            _TempinquiryProductList[i].DiscountAmt,_TempinquiryProductList[i].NetRate,InclusiveFinalNetAmntAfterHeaderDisAmnt,_TempinquiryProductList[i].TaxRate,InclusiveItemWiseTaxAmnt,InclusiveTotalNetAmntAfterHeaderDisAmnt,_TempinquiryProductList[i].TaxType,CGSTPer,SGSTPer,IGSTPer,
            CGSTAmount,SGSTAmount,IGSTAmount,_TempinquiryProductList[i].StateCode,_TempinquiryProductList[i].pkID,LoginUserID,CompanyID.toString(),0,InclusiveItemWiseHeaderDisAmnt
        ));
      }
    }
  }


  Future<void> _onTapOfEditContact(int index) async {

    print("fjdj"+_HeaderDiscAmnt);
    await navigateTo(context, AddQuotationProductScreen.routeName,
        arguments: AddQuotationProductScreenArguments(_productList[index],_StateCode,_HeaderDiscAmnt));
    getProduct(); //right now calling again get contacts, later it can be optimized
  }

  Future<void> _onTapOfDeleteContact(int index) async {
    await OfflineDbHelper.getInstance().deleteQuotationProduct(_productList[index].id);
    setState(() {
      _productList.removeAt(index);
    });
  }

  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context,index);

  }
  ExpantionCustomer(BuildContext context, int index) {
    QuotationTable model = _productList[index];

    return Container(

        padding: EdgeInsets.all(15),
        child : ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          elevationCurve: Curves.easeInOut,

          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: Color(0xFFC1E0FA),//Colors.deepOrange[50],ADD8E6
          leading: CircleAvatar(

              backgroundColor: Color(0xFF504F4F),
              child: Image.asset(PRODUCT_ICON,height: 48,width: 48,)),//Image.network("https://cdn-icons.flaticon.com/png/512/4785/premium/4785452.png?token=exp=1639741267~hmac=4fc9726eef0cf39128308a40039ea5ca", height: 35, fit: BoxFit.fill,width: 35,)),
          title: Text(model.ProductName,style: TextStyle(
              color: Colors.black
          ),),



          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Unit",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model
                                                            .Unit==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .Unit.toString(),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Quantity.  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model.Quantity.toString() == "" ? "N/A"
                                                            :model
                                                            .Quantity.toString(),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),


                                    ],
                                  ),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Unit Rate.  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model.UnitRate.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .UnitRate.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Dis.%",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model
                                                            .DiscountPercent.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .DiscountPercent.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),

                                    ],
                                  ),

                                  SizedBox(
                                    height: sizeboxsize,
                                  ),



                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Net Rate.  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model.NetRate.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .NetRate.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Amount",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model
                                                            .Amount.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .Amount.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),

                                    ],
                                  ),

                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[

                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Tax.%  ",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model.TaxRate.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .TaxRate.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),
                                      Expanded(child:  Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Tax Amount",
                                                        style: TextStyle(
                                                            fontStyle:
                                                            FontStyle.italic,
                                                            color: Color(label_color),
                                                            fontSize: _fontSize_Label,
                                                            letterSpacing: .3)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        model
                                                            .TaxAmount.toString()==
                                                            ""
                                                            ? "N/A"
                                                            :model
                                                            .TaxAmount.toStringAsFixed(2),
                                                        style: TextStyle(
                                                            color: Color(title_color),
                                                            fontSize: _fontSize_Title,
                                                            letterSpacing: .3)),
                                                  ],
                                                )),
                                          ]),),

                                    ],
                                  ),

                                  SizedBox(
                                    height: sizeboxsize,
                                  ),

                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Net Amount",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    model
                                                        .NetAmount.toString() ==
                                                        ""
                                                        ? "N/A"
                                                        :model
                                                        .NetAmount.toStringAsFixed(2),
                                                    style: TextStyle(
                                                        color: Color(title_color),
                                                        fontSize: _fontSize_Title,fontWeight: FontWeight.bold,
                                                        letterSpacing: .3)),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Specification",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color: Color(label_color),
                                                        fontSize: _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    model
                                                        .NetAmount.toString() ==
                                                        ""
                                                        ? "N/A"
                                                        :model
                                                        .ProductSpecification.toString(),
                                                    style: TextStyle(
                                                        color: Color(title_color),
                                                        fontSize: _fontSize_Title,fontWeight: FontWeight.bold,
                                                        letterSpacing: .3)),
                                              ],
                                            ))
                                      ]),

                                ],
                              ),
                            ),
                          ],
                        ))),
              ),
            ),
            ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {

                      _onTapOfEditContact(index);

                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.edit,color: colorPrimary,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Edit',style: TextStyle(color: colorPrimary),),
                      ],
                    ),
                  ),
                  FlatButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {


                      _onTapOfDeleteContact(index);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.delete,color: colorPrimary,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Delete',style: TextStyle(color: colorPrimary),),
                      ],
                    ),
                  ),




                ]),

          ],
        ));

  }

  void _ontaptoSpecificationADDEdit(QuotationTable model) {


  }

}
