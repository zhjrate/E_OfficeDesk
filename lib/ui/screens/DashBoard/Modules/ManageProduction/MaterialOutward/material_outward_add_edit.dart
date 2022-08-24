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

class MaterialOutwardAddEdit extends BaseStatefulWidget {
  static const routeName = '/MaterialOutwardAddEdit';
  @override
  _MaterialOutwardAddEditState createState() => _MaterialOutwardAddEditState();
}

class _MaterialOutwardAddEditState extends BaseState<MaterialOutwardAddEdit>
    with BasicScreen, WidgetsBindingObserver, TickerProviderStateMixin {
  ProductionBloc _rAndDBloc;

  //Outward Details
  TextEditingController _outward_no = TextEditingController();
  TextEditingController _customer_name = TextEditingController();
  TextEditingController _outward_date = TextEditingController();
  TextEditingController _rev_outward_date = TextEditingController();
  TextEditingController _select_sales_order = TextEditingController();
  TextEditingController _select_so_status = TextEditingController();

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
          "Material Outward Detail",
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
                  BasicOutwardDetails(),
                  soDetails(),
                  space(20, 0.0),
                  ProductDetails(),
                  space(10, 0.0),
                  TransportDetails(),
                  space(20, 0.0),
                  save()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } // Widget build(BuildContext context)

  BasicOutwardDetails() {
    return Container(
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
                  Flexible(
                      child: customTextLabel("Outward No.",
                          leftPad: 9, bottomPad: 2)),
                  Flexible(
                    flex: 2,
                    child: customTextLabel("Outward Date",
                        leftPad: 9, bottomPad: 2),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Order No.",
                        radius: 15,
                        controller: _outward_no,
                        boxheight: 40,
                        keyboardType: TextInputType.number),
                  ),
                  Flexible(
                      flex: 2,
                      child: EditText(context,
                          inputTextStyle: TextStyle(fontSize: 14),
                          hint: "DD-MM-YYYY",
                          radius: 15,
                          controller: _outward_date,
                          boxheight: 40,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          suffixIcon: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.calendar_today,
                                size: 15,
                                color: colorGrayVeryDark,
                              ))))
                ],
              ),
              space(10, 0),
              customTextLabel("Customer Name", leftPad: 9, bottomPad: 2),
              EditText(context,
                  title: "Customer Name",
                  hint: "Tap to Select Customer Name",
                  controller: _customer_name,
                  suffixIcon:
                      Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                  readOnly: true,
                  radius: 15,
                  boxheight: 40)
            ],
          ),
        ),
      ),
      // height: 60,
    );
  }

  soDetails() {
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
              customTextLabel("Sales Order", leftPad: 9, bottomPad: 2),
              EditText(context,
                  title: "Sales Order",
                  hint: "Tap to Select Sales Executive",
                  controller: _select_sales_order,
                  suffixIcon:
                      Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                  readOnly: true,
                  radius: 15,
                  boxheight: 40),
              space(10.0, 0.0),
              customTextLabel("SO Status", leftPad: 9, bottomPad: 2),
              EditText(context,
                  title: "SO",
                  hint: "Tap to Select SO Status",
                  controller: _select_so_status,
                  suffixIcon:
                      Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                  readOnly: true,
                  radius: 15,
                  boxheight: 40)
            ],
          ),
        ),
      ),
      // height: 60,
    );
  }

  Widget ProductDetails() {
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

  TransportDetails() {
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
