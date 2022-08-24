import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/JournalVoucher/journal_vouhcer_bloc.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class JournalVoucherAddEditScreen extends BaseStatefulWidget {
  static const routeName = "/JournalVoucherAddEditScreen";

  @override
  _JournalVoucherAddEditScreenState createState() =>
      _JournalVoucherAddEditScreenState();
}

class _JournalVoucherAddEditScreenState
    extends BaseState<JournalVoucherAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  JournalVoucherBloc _journalVoucherBloc;

  /***************************************TextEditing Controllers***************************************/

  //Basic Information
  TextEditingController _voucher_date = TextEditingController();
  TextEditingController _voucher_date_ID = TextEditingController();
  TextEditingController _voucher_no = TextEditingController();
  TextEditingController _voucher_no_ID = TextEditingController();
  TextEditingController _voucher_amount = TextEditingController();
  TextEditingController _voucher_amount_ID = TextEditingController();
  TextEditingController _remarks = TextEditingController();
  TextEditingController _remarks_ID = TextEditingController();

  @override
  void initState() {
    _journalVoucherBloc = JournalVoucherBloc(baseBloc);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _journalVoucherBloc,
      child: BlocConsumer<JournalVoucherBloc, JournalVoucherStates>(
        builder: (BuildContext context, JournalVoucherStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, JournalVoucherStates state) {
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
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
            "Manage Journal Voucher(Contra)",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                space(10, 0),
                basicDetails(),
                space(20, 0),
                productDetails(),
                space(20, 0),
                save(),
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
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child:
                      customTextLabel("Voucher No.", leftPad: 9, bottomPad: 2)),
              Flexible(
                  child:
                      customTextLabel("Voucher Date", leftPad: 9, bottomPad: 2))
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: EditText(context,
                      inputTextStyle: TextStyle(fontSize: 13),
                      hint: "Voucher No.",
                      radius: 15,
                      controller: _voucher_no,
                      boxheight: 40,
                      keyboardType: TextInputType.number,
                      readOnly: true)),
              Flexible(
                child: EditText(context,
                    inputTextStyle: TextStyle(fontSize: 13),
                    hint: "DD-MM-YYYY",
                    radius: 15,
                    controller: _voucher_date,
                    boxheight: 40,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    suffixIcon: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.calendar_today,
                          size: 15,
                          color: colorGrayVeryDark,
                        ))),
              ),
            ],
          ),
          space(15, 0),
          customTextLabel("Voucher Amount", leftPad: 9, bottomPad: 2),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 13),
              title: "Bill No.",
              hint: "Tap to Select Voucher Amount",
              controller: _voucher_amount,
              radius: 15,
              boxheight: 40),
          space(15, 0),
          customTextLabel("Remarks", leftPad: 9, bottomPad: 2),
          EditText(
            context,
            inputTextStyle: TextStyle(fontSize: 13),
            hint: "Remarks",
            radius: 15,
            controller: _remarks,
            boxheight: 70,
            maxLines: 3,
          ),
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
          onPrimary: Color(0xff362d8b),
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

  Widget save() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: getCommonButton(baseTheme, () {}, "Save"));
  }
}
