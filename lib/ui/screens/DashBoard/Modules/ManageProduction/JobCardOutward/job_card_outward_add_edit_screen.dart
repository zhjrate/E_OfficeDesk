import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/manage_production/production_bloc.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class JobCardOutwardAddEditScreen extends BaseStatefulWidget {
  static const routeName = 'JobCardOutwardAddEditScreen';

  @override
  JobCardOutwardAddEditScreenState createState() =>
      JobCardOutwardAddEditScreenState();
}

class JobCardOutwardAddEditScreenState
    extends BaseState<JobCardOutwardAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  ProductionBloc _manageProductionBloc;

  /*************************************Text Editing Controllers*************************************/

  // Basic Information
  TextEditingController _outward_no = TextEditingController();
  TextEditingController _outward_no_ID = TextEditingController();
  TextEditingController _outward_date = TextEditingController();
  TextEditingController _rev_outward_date = TextEditingController();
  TextEditingController _outward_date_ID = TextEditingController();
  TextEditingController _customer_name = TextEditingController();
  TextEditingController _customer_name_ID = TextEditingController();
  TextEditingController _select_sales_order = TextEditingController();
  TextEditingController _select_sales_order_ID = TextEditingController();

  // Transport Details
  TextEditingController _select_transport_mode = TextEditingController();
  TextEditingController _transport_name = TextEditingController();
  TextEditingController _vehicle_no = TextEditingController();
  TextEditingController _delivery_note = TextEditingController();
  TextEditingController _lr_no = TextEditingController();
  TextEditingController _lr_date = TextEditingController();
  TextEditingController _rev_lr_date = TextEditingController();
  TextEditingController _dc_no = TextEditingController();
  TextEditingController _dc_date = TextEditingController();
  TextEditingController _rev_dc_date = TextEditingController();

  @override
  void initState() {
    _manageProductionBloc = ProductionBloc(baseBloc);
    super.initState();
  }

  Widget Build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _manageProductionBloc,
      child: BlocConsumer<ProductionBloc, ProductionStates>(
        builder: (BuildContext context, ProductionStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, ProductionStates state) {
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          return false;
        },
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                  navigateTo(context, HomeScreen.routeName, clearAllStack: true);
                })
          ],
          title: Text(
            "Inspection Details",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                basicDetails(),
                space(10.0, 0.0),
                productDetails(),
                space(10.0, 0.0),
                transportDetails(),
                space(20.0, 0.0),
                save()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }
  Widget basicDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: customTextLabel("Outward No.",
                      leftPad: 10.0, bottomPad: 2.0)),
              Flexible(
                  flex: 2,
                  child: customTextLabel("Outward Date *",
                      leftPad: 10.0, bottomPad: 2.0)),
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: EditText(context,
                      inputTextStyle: TextStyle(fontSize: 14),
                      hint: "0",
                      radius: 15,
                      controller: _outward_no,
                      boxheight: 40,
                      keyboardType: TextInputType.number)),
              Flexible(
                  flex: 2,
                  child: EditText(context,
                      inputTextStyle: TextStyle(fontSize: 14),
                      hint: "DD-MM-YYYY",
                      radius: 15,
                      controller: _outward_date,
                      boxheight: 40,
                      readOnly: true,
                      suffixIcon: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.calendar_today,
                            size: 15,
                            color: colorGrayVeryDark,
                          )))),
            ],
          ),
          space(15.0, 0.0),
          customTextLabel("Customer Name", leftPad: 10.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Search Customer Name",
              radius: 15,
              controller: _customer_name,
              boxheight: 40,
              keyboardType: TextInputType.text),
          space(15.0, 0.0),
          customTextLabel("Sales Order", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              hint: "Select Sales Order",
              controller: _select_sales_order,
              suffixIcon: Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
              readOnly: true,
              radius: 15,
              boxheight: 40)
        ],
      ),
    );
  }

  Widget productDetails() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: double.maxFinite,
      height: COMMON_BUTTON_HEIGHT,
      child: TextButton(
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
            Container(
                margin: EdgeInsets.only(left: 8),
                child: Icon(Icons.production_quantity_limits,
                    size: 20, color: colorWhite)),
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
            space(10.0, 50.0),
            Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(Icons.add, size: 20, color: colorWhite)),
          ],
        ),
      ),
    );
  }

  transportDetails() {
    return customExpansionTileType1(
        "Transport Details",
        Column(
          children: [
            space(10, 0),
            customTextLabel("Mode of Transport*", leftPad: 9, bottomPad: 2),
            // space(4, 0),
            EditText(context,
                title: "Mode Of Transport",
                hint: "Tap to Select Mode Of Transport",
                controller: _select_transport_mode,
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                readOnly: true,
                radius: 15,
                boxheight: 40),
            space(10, 0),
            customTextLabel("Transport Name *", leftPad: 9, bottomPad: 2),
            // space(3.0, 0.0),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 14),
                hint: "Transport Name",
                radius: 15,
                controller: _transport_name,
                boxheight: 40,
                keyboardType: TextInputType.text),
            space(10, 0),
            Row(
              children: [
                Flexible(
                    child: customTextLabel("Vehicle No.",
                        leftPad: 9, bottomPad: 2)),
                Flexible(
                    child: customTextLabel("LR No.", leftPad: 9, bottomPad: 2)),
                Flexible(
                    child: customTextLabel("DC No.", leftPad: 9, bottomPad: 2)),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Vehicle No.",
                        radius: 15,
                        controller: _vehicle_no,
                        boxheight: 40,
                        keyboardType: TextInputType.number)),
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "l.r No.",
                        radius: 15,
                        controller: _lr_no,
                        boxheight: 40,
                        keyboardType: TextInputType.number)),
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "d.c No.",
                        radius: 15,
                        controller: _dc_no,
                        boxheight: 40,
                        keyboardType: TextInputType.number)),
              ],
            ),
            space(10, 0),
            Row(
              children: [
                Flexible(
                  child: customTextLabel("LR Date", leftPad: 9, bottomPad: 2),
                ),
                Flexible(
                  child: customTextLabel("DC Date", leftPad: 9, bottomPad: 2),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "DD-MM-YYYY",
                        radius: 15,
                        controller: _lr_date,
                        boxheight: 40,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        suffixIcon: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.calendar_today,
                              size: 15,
                              color: colorGrayVeryDark,
                            )) /*containerLeftPad: 15*/
                        )),
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "DD-MM-YYYY",
                        radius: 15,
                        controller: _dc_date,
                        boxheight: 40,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        suffixIcon: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.calendar_today,
                              size: 15,
                              color: colorGrayVeryDark,
                            )) /*containerLeftPad: 15*/
                        ))
              ],
            ),
            space(10, 0),
            customTextLabel("Delivery Note", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 14),
                hint: "Delivery Note.",
                radius: 15,
                controller: _delivery_note,
                boxheight: 70,
                maxLines: 3,
                keyboardType: TextInputType.text),
            space(10, 0),
          ],
        ),
        Icon(
          Icons.location_on,
          size: 20,
        ));
  }

  Widget save() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: getCommonButton(baseTheme, () {}, "Save"));
  }
}
