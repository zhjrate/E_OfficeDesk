import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/PettyCashVoucher/petty_cash_voucher_bloc.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class PettyCashVoucherAddEditScreen extends BaseStatefulWidget {
  static const routeName = "/PettyCashVoucherAddEditScreen";

  @override
  _PettyCashVoucherAddEditScreenState createState() =>
      _PettyCashVoucherAddEditScreenState();
}

class _PettyCashVoucherAddEditScreenState
    extends BaseState<PettyCashVoucherAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  PettyCashVoucherBloc _pettyCashVoucherBloc;

  /***************************************TextEditing Controllers***************************************/

  //Basic Information
  TextEditingController _voucher_date = TextEditingController();
  TextEditingController _voucher_date_ID = TextEditingController();
  TextEditingController _voucher_no = TextEditingController();
  TextEditingController _voucher_no_ID = TextEditingController();

  // Cash Information
  TextEditingController _petty_cash_ac = TextEditingController();
  TextEditingController _petty_cash_ac_ID = TextEditingController();
  TextEditingController _expn_ac = TextEditingController();
  TextEditingController _expn_ac_ID = TextEditingController();
  TextEditingController _voucher_amount = TextEditingController();
  TextEditingController _voucher_amount_ID = TextEditingController();

  //Transaction Notes
  TextEditingController _transaction_note = TextEditingController();
  TextEditingController _transaction_note_ID = TextEditingController();

  @override
  void initState() {
    _pettyCashVoucherBloc = PettyCashVoucherBloc(baseBloc);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _pettyCashVoucherBloc,
      child: BlocConsumer<PettyCashVoucherBloc, PettyCashVoucherStates>(
        builder: (BuildContext context, PettyCashVoucherStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, PettyCashVoucherStates state) {
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
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                })
          ],
          title: Text(
            "Manage Petty Cash Voucher",
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
                transactionNotes(),
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
          customTextLabel("Petty Cash Account *", leftPad: 9, bottomPad: 2),
          EditText(
            context,
            inputTextStyle: TextStyle(fontSize: 13),
            hint: "Tap to Search Petty Cash Account",
            radius: 15,
            controller: _petty_cash_ac,
            boxheight: 40,
          ),
          space(15, 0),
          customTextLabel("Expn. A/c *", leftPad: 9, bottomPad: 2),
          EditText(
            context,
            inputTextStyle: TextStyle(fontSize: 13),
            hint: "Tap to Search Expn. A/c",
            radius: 15,
            controller: _expn_ac,
            boxheight: 40,
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
        ],
      ),
    );
  }

  Widget transactionNotes() {
    return customExpansionTileType1(
        "Transaction Notes *",
        Column(children: [
          customTextLabel("Transaction Notes", leftPad: 9, bottomPad: 2),
          EditText(
            context,
            inputTextStyle: TextStyle(fontSize: 13),
            hint: "Transaction Notes",
            radius: 15,
            controller: _transaction_note,
            boxheight: 70,
            maxLines: 3,
          ),
        ]),
        Icon(Icons.note_alt),
        image: CREDIT_INFORMATION);
  }

  Widget save() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: getCommonButton(baseTheme, () {}, "Save"));
  }
}
