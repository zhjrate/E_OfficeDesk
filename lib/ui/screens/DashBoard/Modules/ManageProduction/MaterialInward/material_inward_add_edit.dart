import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:soleoserp/blocs/other/bloc_modules/manage_production/production_bloc.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class MaterialInwardAddEdit extends BaseStatefulWidget {
  static const routeName = '/MaterialInwardAddEdit';
  @override
  _MaterialInwardAddEditState createState() => _MaterialInwardAddEditState();
}

class _MaterialInwardAddEditState extends BaseState<MaterialInwardAddEdit>
    with BasicScreen, WidgetsBindingObserver, TickerProviderStateMixin {
  ProductionBloc _rAndDBloc;

  bool _isForUpdate;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  double dateFontSize = 13;

  static const List<Tab> SalesOrderTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  PickedFile imageFile = null;
  File _image;
  bool img_visible = false;
  String fileName;
  double _rating;

  String imageDialogchoose = '';
  List imageDialog = [
    'Gallery',
    'Camera',
  ];

  // TabController tabControllerSalesOrder = TabController(length: 7, vsync: this);

  //Inward Details
  TextEditingController _controller_inward_no = TextEditingController();
  TextEditingController _controller_supplier_name = TextEditingController();
  TextEditingController _controller_inward_date = TextEditingController();
  TextEditingController _controller_rev_inward_date = TextEditingController();
  TextEditingController _controller_location = TextEditingController();
  TextEditingController _controller_select_po = TextEditingController();
  TextEditingController _controller_select_po_product = TextEditingController();

  //Product Details
  TextEditingController _controller_product_name = TextEditingController();
  TextEditingController _controller_quantity = TextEditingController();
  TextEditingController _controller_unit = TextEditingController();
  TextEditingController _controller_unit_rate = TextEditingController();
  TextEditingController _controller_discount = TextEditingController();
  TextEditingController _controller_net_rate = TextEditingController();
  TextEditingController _controller_amount = TextEditingController();
  TextEditingController _controller_tax_rate = TextEditingController();
  TextEditingController _controller_tax_amount = TextEditingController();
  TextEditingController _controller_net_amount = TextEditingController();
  TextEditingController _controller_order_no = TextEditingController();
  TextEditingController _controller_select_order_no = TextEditingController();
  TextEditingController _controller_basic_amount = TextEditingController();
  TextEditingController _controller_total_gst = TextEditingController();
  TextEditingController _controller_round_off = TextEditingController();

  // Transport Details
  TextEditingController _controller_select_transport_mode =
      TextEditingController();
  TextEditingController _controller_ = TextEditingController();
  TextEditingController _controller_transport_name = TextEditingController();
  TextEditingController _controller_vehicle_no = TextEditingController();
  TextEditingController _controller_lr_no = TextEditingController();
  TextEditingController _controller_lr_date = TextEditingController();
  TextEditingController _controller_rev_lr_date = TextEditingController();
  TextEditingController _controller_remark = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Supplier_Name = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Location = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_PO = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_PO_Product = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Order_No = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Mode_Of_Transport = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rAndDBloc = ProductionBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _rAndDBloc,
      child: BlocConsumer<ProductionBloc, ProductionStates>(
        builder: (BuildContext context, ProductionStates state) {
          //handle states
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          return false;
        },
        listener: (BuildContext context, ProductionStates state) {
          return super.build(context);
          //handle states
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called

          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient:
            LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.water_damage_sharp,
                color: colorWhite,
                size: 20,
              ),
              onPressed: () {
                //_onTapOfLogOut();
                navigateTo(context, HomeScreen.routeName, clearAllStack: true);
              })
        ],
        title: Text(
          "Material Inward Information",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
        ),
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
                  BasicInwardDetails(),
                  poDetails(),
                  space(10),
                  productDetails(),
                  space(10),
                  TransportDetails(),
                  space(10),
                  save()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } // Widget build(BuildContext context)

  Widget _buildInwardDate() {
    return InkWell(
      onTap: () {
        _selectDate(
            context, _controller_inward_date, _controller_rev_inward_date);
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
                      _controller_inward_date.text == null ||
                              _controller_inward_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_inward_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_inward_date.text == null ||
                                  _controller_inward_date.text == ""
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

  Widget _buildLRDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, _controller_lr_date, _controller_rev_lr_date);
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
                      _controller_lr_date.text == null ||
                              _controller_lr_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_lr_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_lr_date.text == null ||
                                  _controller_lr_date.text == ""
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

  /*Widget _buildDueDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, _controller_due_date, _controller_rev_due_date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      _controller_due_date.text == null ||
                              _controller_due_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_due_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_due_date.text == null ||
                                  _controller_due_date.text == ""
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
  }*/

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController F_datecontroller,
      TextEditingController Rev_dateController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        F_datecontroller.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        Rev_dateController.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  /*Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createTextLabel("Search Customer *", 10.0, 0.0),
          createTextFormField(_controller_customer_name, "Search Customer")
        ],
      ),
    );
  }*/

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
                              hintStyle:
                                  TextStyle(fontSize: 13, color: colorGrayDark),
                              labelStyle: TextStyle(
                                color: Color(0xFF000000),
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF000000),
                            ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                            ,
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

  showcustomdialogWithOnlyName(
      {List<ALL_Name_ID> values,
      BuildContext context1,
      TextEditingController controller,
      String lable}) async {
    await showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (BuildContext context123) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          title: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: colorBlack, //                   <--- border color
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                        15.0) //                 <--- border radius here
                    ),
              ),
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    lable,
                    style: TextStyle(
                        color: colorBlack, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          children: [
            SizedBox(
                width: MediaQuery.of(context123).size.width,
                child: Column(
                  children: [
                    SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(children: <Widget>[
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context1).pop();
                                  controller.text = values[index].Name;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 25, top: 10, bottom: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: colorBlack), //Change color
                                        width: 10.0,
                                        height: 10.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 1.5),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        values[index].Name,
                                        style: TextStyle(color: colorBlack),
                                      ),
                                    ],
                                  ),
                                ),
                              );

                              /* return SimpleDialogOption(
                              onPressed: () => {
                                controller.text = values[index].Name,
                                controller2.text = values[index].Name1,
                              Navigator.of(context1).pop(),
                            },
                              child: Text(values[index].Name),
                            );*/
                            },
                            itemCount: values.length,
                          ),
                        ])),
                  ],
                )),
            /*Center(
            child: Container(
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Color(0xFFF27442),
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0xFFF27442))),
              //color: Color(0xFFF27442),
              child: GestureDetector(
                child: Text(
                  "Close",
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),*/
          ],
        );
      },
    );
  }

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

  Future<void> _onTapOfSearchView() async {
    /*if (_isForUpdate == false) {
    navigateTo(context, SearchInquiryCustomerScreen.routeName).then((value) {
      if (value != null) {
        _searchInquiryListResponse = value;
        _controller_customer_name.text = _searchInquiryListResponse.label;
        _controller_customer_pkID.text = _searchInquiryListResponse.value.toString();
      }
    });
  }*/
  }

  BasicInwardDetails() {
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
                  Flexible(child: createTextLabel("Inward No.", 10.0, 0.0)),
                  Flexible(
                    flex: 2,
                    child: createTextLabel("Inward Date", 10.0, 0.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: createTextFormField(
                        _controller_inward_no, "Inward No."),
                  ),
                  Flexible(flex: 2, child: _buildInwardDate())
                ],
              ),
              space(3),
              createTextLabel("Supplier Name", 10.0, 0.0),
              CustomDropDown1("Supplier Name",
                  enable1: false,
                  title: "Supplier Name",
                  hintTextvalue: "Tap to Select Supplier Name",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_supplier_name,
                  Custom_values1: arr_ALL_Name_ID_For_Supplier_Name),
              space(10),
              createTextLabel("Location", 10.0, 0.0),
              CustomDropDown1("Location",
                  enable1: false,
                  title: "Bank Name",
                  hintTextvalue: "Tap to Select Location",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_supplier_name,
                  Custom_values1: arr_ALL_Name_ID_For_Location),
            ],
          ),
        ),
      ),
      // height: 60,
    );
  }

  poDetails() {
    return Container(
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
              createTextLabel("Select PO", 10.0, 0.0),
              CustomDropDown1("PO",
                  enable1: false,
                  title: "PO",
                  hintTextvalue: "Tap to Select PO",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_select_po,
                  Custom_values1: arr_ALL_Name_ID_For_PO),
              space(10),
              createTextLabel("Select PO Product", 10.0, 0.0),
              CustomDropDown1("PO Product",
                  enable1: false,
                  title: "PO Product",
                  hintTextvalue: "Tap to Select PO Product",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_select_po_product,
                  Custom_values1: arr_ALL_Name_ID_For_PO_Product),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 15, bottom: 10),
                width: 150,
                height: 30,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  child: getCommonButton(baseTheme, () {}, "Load Product",
                      backGroundColor: Color(0xff362d8b), textSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
      // height: 60,
    );
  }

  productDetails() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: double.maxFinite,
      height: COMMON_BUTTON_HEIGHT,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          onSurface: Color(0xff362d8b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          elevation: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.production_quantity_limits, size: 20),
            // space(0.0, width: 30),
            Text(
              "Add Product Details",
              textAlign: TextAlign.center,
              style: baseTheme.textTheme.button.copyWith(
                  color: colorWhite,
                  fontSize: 16,
                  fontFamily: 'Sans Serif',
                  fontWeight: FontWeight.normal),
            ),
            space(0.0, width: 50),
            Icon(Icons.add, size: 20),
          ],
        ),
      ),
    );
  }

  ProductDetailsList() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
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
                "Product Detail",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              leading: Container(
                child: ClipRRect(child: Icon(Icons.production_quantity_limits)),
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
                        children: [
                          Flexible(
                              child:
                                  createTextLabel("Product Name *", 10.0, 0.0)),
                          Flexible(
                            flex: 2,
                            child: createTextLabel("Quantity", 10.0, 0.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: createTextFormField(
                                _controller_product_name, "Product Name"),
                          ),
                          Flexible(
                            flex: 2,
                            child: createTextFormField(
                                _controller_quantity, "Quantity"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(child: createTextLabel("Unit", 10.0, 0.0)),
                          Flexible(
                            child: createTextLabel("Unit Rate *", 10.0, 0.0),
                          ),
                          Flexible(
                            child: createTextLabel("Disc. %", 10.0, 0.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child:
                                createTextFormField(_controller_unit, "Unit"),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_unit_rate, "Unit Rate"),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_discount, "Discount"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: createTextLabel("Net Rate", 10.0, 0.0)),
                          Flexible(
                            child: createTextLabel("Amount", 10.0, 0.0),
                          ),
                          Flexible(
                            child: createTextLabel("Tax Rate", 10.0, 0.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: createTextFormField(
                                _controller_net_rate, "Net Rate"),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_amount, "Amount"),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_tax_rate, "Tax Rate"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                              child: createTextLabel("Tax Amount", 10.0, 0.0)),
                          Flexible(
                            child: createTextLabel("Net Amount", 10.0, 0.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: createTextFormField(
                                _controller_tax_amount, "Tax Amount"),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_net_amount, "Net Amount"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      createTextLabel("Select Order No.", 10.0, 0.0),
                      CustomDropDown1("Order No.",
                          enable1: false,
                          title: "Order No.",
                          hintTextvalue: "Tap to Select Order No.",
                          icon: Icon(Icons.arrow_drop_down),
                          controllerForLeft: _controller_select_order_no,
                          Custom_values1: arr_ALL_Name_ID_For_Order_No),
                    ],
                  ),
                ),
              ], // children:
            ),
          ),
        ),
        // height: 60,
      ),
    );
  }

  TransportDetails() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
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
            visualDensity: VisualDensity(horizontal: -1.5, vertical: -1.5),
            dividerColor: Colors.white70,
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
                  fontSize: 16,
                ),
              ),

              leading: Container(
                child: ClipRRect(
                    child: Icon(
                  Icons.location_on,
                  size: 20,
                )),
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
                      createTextLabel("Select Mode Of Transport", 10.0, 0.0),
                      CustomDropDown1("Mode Of Transport",
                          enable1: false,
                          title: "Mode Of Transport",
                          hintTextvalue: "Tap to Select Mode Of Transport",
                          icon: Icon(Icons.arrow_drop_down),
                          controllerForLeft: _controller_select_transport_mode,
                          Custom_values1:
                              arr_ALL_Name_ID_For_Mode_Of_Transport),
                      space(10),
                      createTextLabel("Transport Name *", 10.0, 0.0),
                      createTextFormField(
                          _controller_transport_name, "Enter Transport Name",
                          keyboardInput: TextInputType.text),
                      space(5),
                      Row(
                        children: [
                          Flexible(
                              child: createTextLabel("Vehicle No.", 10.0, 0.0)),
                          Flexible(
                            child: createTextLabel("LR No.", 10.0, 0.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: createTextFormField(
                                _controller_vehicle_no, "Vehicle No."),
                          ),
                          Flexible(
                            child: createTextFormField(
                                _controller_lr_no, "LR NO."),
                          ),
                        ],
                      ),
                      createTextLabel("LR Date", 10.0, 0.0),
                      _buildLRDate(),
                      space(10),
                      createTextLabel("Remark", 10.0, 0.0),
                      createTextFormField(_controller_remark, "Remark.",
                          keyboardInput: TextInputType.text, height: 70),
                    ],
                  ),
                ),
              ], // children:
            ),
          ),
        ),
        // height: 60,
      ),
    );
  }

  loadProduct() {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: getCommonButton(baseTheme, () {}, "Add Product +", radius: 18));
  }

  save() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          onSurface: Color(0xff362d8b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          elevation: 3,
        ),
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: baseTheme.textTheme.button.copyWith(
              color: colorWhite,
              fontSize: 18,
              fontFamily: 'Sans Serif',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    ;
  }

  space(double height, {double width}) {
    return SizedBox(
      height: height,
    );
  }
}
