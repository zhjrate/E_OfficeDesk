import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/salesorder/salesorder_bloc.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class SaleOrderNewAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/SaleOrderNewAddEditScreen';
  @override
  _SaleOrderNewAddEditScreenState createState() =>
      _SaleOrderNewAddEditScreenState();
}

class _SaleOrderNewAddEditScreenState
    extends BaseState<SaleOrderNewAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, TickerProviderStateMixin {
  SalesOrderBloc _salesOrderBloc;

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

  TextEditingController _controller_order_no = TextEditingController();
  TextEditingController _controller_customer_name = TextEditingController();
  TextEditingController _controller_order_date = TextEditingController();
  TextEditingController _controller_rev_order_date = TextEditingController();
  TextEditingController _controller_PINO = TextEditingController();
  TextEditingController _controller_PI_date = TextEditingController();
  TextEditingController _controller_rev_PI_date = TextEditingController();
  TextEditingController _controller_bank_name = TextEditingController();
  TextEditingController _controller_select_inquiry = TextEditingController();
  TextEditingController _controller_inquiry_no = TextEditingController();
  TextEditingController _controller_sales_executive = TextEditingController();
  TextEditingController _controller_reference_no = TextEditingController();
  TextEditingController _controller_reference_date = TextEditingController();
  TextEditingController _controller_work_order_date = TextEditingController();
  TextEditingController _controller_rev_work_order_date =
      TextEditingController();
  TextEditingController _controller_delivery_date = TextEditingController();
  TextEditingController _controller_rev_delivery_date = TextEditingController();
  TextEditingController _controller_rev_reference_date =
      TextEditingController();
  TextEditingController _controller_currency = TextEditingController();
  TextEditingController _controller_exchange_rate = TextEditingController();
  TextEditingController _controller_credit_days = TextEditingController();
  TextEditingController _controller_work_order_no = TextEditingController();
  TextEditingController _contrller_terms_and_condition =
      TextEditingController();
  TextEditingController _contrller_select_terms_and_condition =
      TextEditingController();
  TextEditingController _contrller_delivery_terms = TextEditingController();
  TextEditingController _contrller_payment_terms = TextEditingController();
  TextEditingController _controller_select_email_subject =
      TextEditingController();
  TextEditingController _contrller_email_subject = TextEditingController();
  TextEditingController _contrller_email_introcuction = TextEditingController();
  TextEditingController _controller_amount = TextEditingController();
  TextEditingController _controller_due_date = TextEditingController();
  TextEditingController _controller_rev_due_date = TextEditingController();

  //shipment
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

  //Image Picker
  TextEditingController _controller_image = TextEditingController();

  //Shipment Address
  TextEditingController _controller_company_name = TextEditingController();
  TextEditingController _controller_GSTNO = TextEditingController();
  TextEditingController _controller_contact_no = TextEditingController();
  TextEditingController _controller_contact_person_name =
      TextEditingController();
  TextEditingController _controller_address = TextEditingController();
  TextEditingController _controller_area = TextEditingController();
  TextEditingController _controller_country = TextEditingController();
  TextEditingController _controller_state = TextEditingController();
  TextEditingController _controller_city = TextEditingController();
  TextEditingController _controller_pincode = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Bank_Name = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Sales_Executive = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Sales_Order_Select_Currency = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Terms_And_Condition = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Email_Subject = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _salesOrderBloc = SalesOrderBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _salesOrderBloc,
      child: BlocConsumer<SalesOrderBloc, SalesOrderStates>(
        builder: (BuildContext context, SalesOrderStates state) {
          //handle states
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          return false;
        },
        listener: (BuildContext context, SalesOrderStates state) {
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
    return DefaultTabController(
      length: 7,
      child: Scaffold(
          appBar: NewGradientAppBar(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red]),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 19,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
            title: Text("Manage Sales Order"),
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
                      mandetoryDetails(),
                      space(10),
                      productDetails(),
                      space(20),
                      basicInformation(),
                      space(10),
                      termsAndCondition(),
                      space(5),
                      emailContent(),
                      space(5),
                      paymentSchedule(),
                      space(5),
                      shipmentDetail(),
                      space(5),
                      attachment(),
                      space(5),
                      shipmentAddress(),
                      space(20),
                      otherCharges(),
                      space(10),
                      save(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  } // Widget build(BuildContext context)

  Widget ProductDetails() {
    return Container(
      child: Text("Welcome To Tesla Bikes Collections"),
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

  Widget _buildPIDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, _controller_PI_date, _controller_rev_PI_date);
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
                      _controller_PI_date.text == null ||
                              _controller_PI_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_PI_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_PI_date.text == null ||
                                  _controller_PI_date.text == ""
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

  Widget _buildReferenceDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, _controller_reference_date,
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

  Widget _buildDeliveryDate() {
    return InkWell(
      onTap: () {
        _selectDate(
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
        _selectDate(context, _controller_work_order_date,
            _controller_rev_work_order_date);
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
                      _controller_work_order_date.text == null ||
                              _controller_work_order_date.text == ""
                          ? "DD-MM-YYYY"
                          : _controller_work_order_date.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _controller_work_order_date.text == null ||
                                  _controller_work_order_date.text == ""
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

  Widget _buildDueDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, _controller_due_date, _controller_rev_due_date);
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
  }

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

  Widget _buildSearchView() {
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

  Widget _imageDialog(int index) {
    return Container(
      // height: 30,
      width: 10,
      // padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.center,
        child: ListTile(
          minVerticalPadding: 0,
          horizontalTitleGap: 0,
          visualDensity: VisualDensity(vertical: -3),
          // to compact
          // leading: Container(
          //   width: 0,
          //   margin: EdgeInsets.only(top: 5),
          // child: Icon(
          //   Icons.circle,
          //   color: Colors.indigo[900],
          //   size: 15,
          // ),
          // ),
          title: Container(
            // width: 5,
            padding: const EdgeInsets.all(0.0),

            // margin: EdgeInsets.only(right: 25),
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    // child: Icon(
                    //   Icons.circle,
                    //   color: Colors.indigo[900],
                    //   size: 10,
                    // ),
                  ),
                  Text(
                    imageDialog[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigo[900],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            setState(() {
              imageDialogchoose = imageDialog[index].toString();
              _controller_image.text = imageDialogchoose;
              if (imageDialogchoose == 'Gallery') {
                _openGallery(context);
              } else if (imageDialogchoose == 'Camera') {
                _openCamera(context);
              }
              Navigator.of(context).pop();
            });
          },
        ),
      ),
    );
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
      _image = File(imageFile.path);
      fileName = imageFile.path.split('/').last;
      if (imageFile != null) {
        img_visible = true;
      }
    });

    // Navigator.pop(context);
  }

  Future _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
      _image = File(imageFile.path);
      fileName = imageFile.path.split('/').last;
      if (imageFile != null) {
        img_visible = true;
      }
    });

    // Navigator.pop(context);
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

  mandetoryDetails() {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 1),
      margin: EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(child: createTextLabel("Order No.", 10.0, 0.0)),
                  Flexible(
                    flex: 2,
                    child: createTextLabel("Order Date", 10.0, 0.0),
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
                height: 10,
              ),
              createTextLabel("Bank Name", 10.0, 0.0),
              CustomDropDown1("BankName",
                  enable1: false,
                  title: "Bank Name",
                  hintTextvalue: "Tap to Select Bank Name",
                  icon: Icon(Icons.arrow_drop_down),
                  controllerForLeft: _controller_bank_name,
                  Custom_values1: arr_ALL_Name_ID_For_Sales_Order_Bank_Name),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: createTextLabel("PI No.", 10.0, 0.0),
                  ),
                  Flexible(
                    flex: 2,
                    child: createTextLabel("PI Date", 10.0, 0.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: createTextFormField(_controller_PINO, "PI No."),
                  ),
                  Flexible(flex: 2, child: _buildPIDate())
                ],
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
        child: getCommonButton(baseTheme, () {}, "Add Product Details",
            radius: 18, backGroundColor: Color(0xff362d8b)));
  }

  basicInformation() {
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
                  "Basic Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(
                    child: Image.asset(
                      BASIC_INFORMATION,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Select Inquiry", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Inquiry No.", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              // flex: 2,
                              child: CustomDropDown1("Inquiry",
                                  enable1: false,
                                  title: "Select Option",
                                  hintTextvalue: "Tap to Select Inquiry",
                                  icon: Icon(Icons.arrow_drop_down),
                                  controllerForLeft: _controller_select_inquiry,
                                  Custom_values1:
                                      arr_ALL_Name_ID_For_Sales_Order_Select_Inquiry),
                            ),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_inquiry_no, "Inquiry No.")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        createTextLabel("Sales Executive", 10.0, 0.0),
                        SizedBox(
                          height: 3,
                        ),
                        CustomDropDown1("Sales Executive",
                            enable1: false,
                            title: "Sales Executive",
                            hintTextvalue: "Tap to Select Sales Person ",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: _controller_sales_executive,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Sales_Order_Sales_Executive),
                        SizedBox(
                          height: 10,
                        ),
                        createTextLabel("Projects", 10.0, 0.0),
                        SizedBox(
                          height: 3,
                        ),
                        CustomDropDown1("Project",
                            enable1: false,
                            title: "Select Project",
                            hintTextvalue: "Tap to Select Projects",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: _controller_currency,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Sales_Order_Select_Currency),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Reference No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Reference Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextFormField(
                                  _controller_reference_no, "Reference No."),
                            ),
                            Flexible(child: _buildReferenceDate())
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
                                  createTextLabel("Select Currency", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Delivery Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CustomDropDown1("Currency",
                                  enable1: false,
                                  title: "Select Currency",
                                  hintTextvalue: "Tap to Select Currency",
                                  icon: Icon(Icons.arrow_drop_down),
                                  controllerForLeft: _controller_currency,
                                  Custom_values1:
                                      arr_ALL_Name_ID_For_Sales_Order_Select_Currency),
                            ),
                            Flexible(child: _buildDeliveryDate())
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Work Order No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child:
                                  createTextLabel("Work Order Date", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_work_order_no,
                                    "Work Order No")),
                            Flexible(child: _buildWorkOrdereDate())
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child:
                                  createTextLabel("Exchange Rate", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Credit Days", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_exchange_rate,
                                    "Exchange Rate")),
                            Flexible(
                                child: createTextFormField(
                                    _controller_credit_days, "Credit Days"))
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

  termsAndCondition() {
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
                        CustomDropDown1("Terms & Conditions",
                            enable1: false,
                            title: "Terms & Conditions",
                            hintTextvalue: "Tap to Select Terms & Conditions",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft:
                                _contrller_select_terms_and_condition,
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
                        createTextLabel("Delivery Terms", 10.0, 0.0),
                        createTextFormField(
                            _contrller_delivery_terms, "Delivery Terms",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                        createTextLabel("Payment Terms", 10.0, 0.0),
                        createTextFormField(
                            _contrller_payment_terms, "Payment terms",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            bottom: 5,
                            keyboardInput: TextInputType.text),
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

  emailContent() {
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
                        CustomDropDown1("Email Subject",
                            enable1: false,
                            title: "Email Subject",
                            hintTextvalue: "Tap to Select Subject",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: _controller_select_email_subject,
                            Custom_values1: arr_ALL_Name_ID_For_Email_Subject),
                        SizedBox(
                          height: 10,
                        ),
                        createTextLabel("Subject", 10.0, 0.0),
                        createTextFormField(
                            _contrller_email_subject, "Email Subject",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 3,
                        ),
                        createTextLabel("Email Introduction", 10.0, 0.0),
                        createTextFormField(
                            _contrller_email_introcuction, "Email Introduction",
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

  paymentSchedule() {
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
                  "Payment Schedule",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(child: Icon(Icons.attach_money)),

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
                              child: createTextLabel("Amount", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("Due Date", 10.0, 0.0),
                            ),
                            Flexible(child: Container())
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_amount, "Enter Amount")),
                            Flexible(
                              flex: 2,
                              child: _buildDueDate(),
                            ),
                            Flexible(
                                child: getCommonButton(baseTheme, () {}, "+"))
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

  shipmentDetail() {
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

  attachment() {
    return Container();
  }

  shipmentAddress() {
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
                  "Shipment Address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                leading: Container(
                  child: ClipRRect(child: Icon(Icons.location_on)),
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
                        createTextLabel("Company Name", 10.0, 0.0),
                        createTextFormField(
                            _controller_company_name, "Company Name",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 5,
                        ),
                        createTextLabel("Contact Person Name", 10.0, 0.0),
                        createTextFormField(_controller_contact_person_name,
                            "Contact Person Name",
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("Contact No.", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("GST No.", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 2,
                                child: createTextFormField(
                                    _controller_contact_no,
                                    "Enter Contact No.")),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_GSTNO, "Enter GSTNo.")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        createTextLabel("Address", 10.0, 0.0),
                        createTextFormField(
                            _controller_address, "Enter Address",
                            minLines: 2,
                            maxLines: 5,
                            height: 70,
                            keyboardInput: TextInputType.text),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: createTextLabel("Area", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("PinCode", 10.0, 0.0),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                // flex: 2,
                                child: createTextFormField(
                                    _controller_area, "Enter Area",
                                    keyboardInput: TextInputType.text)),
                            Flexible(
                                // flex: 1,
                                child: createTextFormField(
                                    _controller_pincode, "Enter PinCode")),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: createTextLabel("City", 10.0, 0.0),
                            ),
                            Flexible(
                              child: createTextLabel("State", 10.0, 0.0),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: createTextFormField(
                                    _controller_city, "Select City")),
                            Flexible(
                                child: createTextFormField(
                                    _controller_state, "Select State"))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        createTextLabel("Country", 10.0, 0.0),
                        createTextFormField(
                            _controller_state, "Tap to Select Country")
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

  otherCharges() {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: getCommonButton(baseTheme, () {}, "Other Charges",
            radius: 18, backGroundColor: Color(0xff362d8b)));
  }

  save() {
    return // Save
        Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: getCommonButton(
              baseTheme,
              () {},
              "Save",
              backGroundColor: Color(0xff362d8b),
              radius: 18,
            ));
  }

  space(double height) {
    return SizedBox(
      height: height,
    );
  }
}