import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/cash_voucher/cash_voucher_bloc.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class CashVoucherAddEditScreen extends BaseStatefulWidget {
  static const routeName = "/CashVoucherAddEditScreen";

  @override
  _CashVoucherAddEditScreenState createState() =>
      _CashVoucherAddEditScreenState();
}

class _CashVoucherAddEditScreenState extends BaseState<CashVoucherAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  CashVoucherScreenBloc _cashVoucherScreenBloc;

  /***************************************TextEditing Controllers***************************************/

  //Basic Information
  TextEditingController _voucher_date = TextEditingController();
  TextEditingController _voucher_rev_date = TextEditingController();
  TextEditingController _voucher_ID = TextEditingController();
  TextEditingController _voucher_no = TextEditingController();
  TextEditingController _voucher_no_ID = TextEditingController();
  TextEditingController _select_rec_pay = TextEditingController();
  TextEditingController _select_rec_pay_ID = TextEditingController();
  TextEditingController _select_employee = TextEditingController();
  TextEditingController _select_employee_ID = TextEditingController();

  // Cash Information
  TextEditingController _cash_ac = TextEditingController();
  TextEditingController _cash_ac_ID = TextEditingController();
  TextEditingController _customer_ac = TextEditingController();
  TextEditingController _customer_ac_ID = TextEditingController();
  TextEditingController _voucher_amount = TextEditingController();
  TextEditingController _voucher_amount_ID = TextEditingController();
  TextEditingController _select_transaction_mode = TextEditingController();
  TextEditingController _select_transaction_mode_ID = TextEditingController();

  // Calculation
  TextEditingController _select_termination_of_delivery =
      TextEditingController();
  TextEditingController _select_termination_of_delivery_ID =
      TextEditingController();
  TextEditingController _rd = TextEditingController();
  TextEditingController _rd_ID = TextEditingController();
  TextEditingController _urd = TextEditingController();
  TextEditingController _urd_ID = TextEditingController();
  TextEditingController _tax_percentage = TextEditingController();
  TextEditingController _tax_percentage_ID = TextEditingController();
  TextEditingController _basic_amount = TextEditingController();
  TextEditingController _basic_amount_ID = TextEditingController();
  TextEditingController _gst_amount = TextEditingController();
  TextEditingController _gst_amount_ID = TextEditingController();
  TextEditingController _net_amount = TextEditingController();
  TextEditingController _net_amount_ID = TextEditingController();

  // Transaction Notes
  TextEditingController _transaction_notes = TextEditingController();
  TextEditingController _transaction_notes_ID = TextEditingController();

  // Bill
  TextEditingController _select_invoice_no = TextEditingController();
  TextEditingController _select_invoice_no_ID = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _amount_ID = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cashVoucherScreenBloc = CashVoucherScreenBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _cashVoucherScreenBloc,
      child: BlocConsumer<CashVoucherScreenBloc, CashVoucherScreenStates>(
        builder: (BuildContext context, CashVoucherScreenStates state) {
          //handle states
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          return false;
        },
        listener: (BuildContext context, CashVoucherScreenStates state) {
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
  buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: customAppBar(context, "Manage Cash Voucher"),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                basicInformation(),
                accountInformation(),
                space(10.0, 0.0),
                calculation(),
                space(10.0, 0.0),
                transactionNotes(),
                space(10.0, 0.0),
                payment(),
                space(15.0, 0.0),
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

  Widget basicInformation() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
                      keyboardType: TextInputType.number)),
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
          customTextLabel("Rec./Pay.", leftPad: 9, bottomPad: 2),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 13),
              title: "Rec./Pay.",
              hint: "Tap to Select Rec./Pay.",
              controller: _select_rec_pay,
              suffixIcon: Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
              readOnly: true,
              radius: 15,
              boxheight: 40),
          space(15, 0),
          customTextLabel("Select Employee", leftPad: 9, bottomPad: 2),
          EditText(context,
              title: "Employee",
              inputTextStyle: TextStyle(fontSize: 13),
              hint: "Tap to Select Employee",
              controller: _select_employee,
              suffixIcon: Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
              readOnly: true,
              radius: 15,
              boxheight: 40),
        ],
      ),
    );
  }

  Widget accountInformation() {
    return customExpansionTileType1(
        "Account Information",
        Column(
          children: [
            space(10, 0),
            customTextLabel("Cash A/c", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Cash A/c",
                radius: 15,
                controller: _cash_ac,
                boxheight: 40,
                keyboardType: TextInputType.number),
            space(15, 0),
            customTextLabel("Customer A/c", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Customer A/c",
                radius: 15,
                controller: _customer_ac,
                boxheight: 40,
                keyboardType: TextInputType.number),
            space(15, 0),
            customTextLabel("Voucher Amount", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Voucher Amount",
                radius: 15,
                controller: _voucher_amount,
                boxheight: 40,
                keyboardType: TextInputType.number),
            space(15, 0),
            customTextLabel("Transaction Mode", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Tap to Select Transaction Mode",
                controller: _select_transaction_mode,
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                readOnly: true,
                radius: 15,
                boxheight: 40),
            space(10, 0),
          ],
        ),
        Icon(Icons.account_circle_rounded));
  }

  Widget calculation() {
    return customExpansionTileType1(
        "Calculation",
        Column(
          children: [
            space(10, 0),
            customTextLabel("Termination of Delivery *",
                leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Tap to Select Termination of Delivery",
                controller: _select_termination_of_delivery,
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                readOnly: true,
                radius: 15,
                boxheight: 40),
            space(15, 0),
            customTextLabel("RD/URD", leftPad: 9, bottomPad: 2),
            Row(
              children: [
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 13),
                        hint: "RD",
                        radius: 15,
                        controller: _rd,
                        boxheight: 40,
                        readOnly: true)),
                Flexible(
                    child: EditText(context,
                        inputTextStyle: TextStyle(fontSize: 13),
                        hint: "URD",
                        radius: 15,
                        controller: _urd,
                        boxheight: 40,
                        readOnly: true)),
              ],
            ),
            space(15, 0),
            customTextLabel("Tax", leftPad: 9, bottomPad: 2),
            EditText(context,
                hint: "Tap to Tax",
                inputTextStyle: TextStyle(fontSize: 13),
                controller: _tax_percentage,
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                readOnly: true,
                radius: 15,
                boxheight: 40),
            space(15, 0),
            customTextLabel("Basic Amount", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Basic Amount",
                radius: 15,
                controller: _basic_amount,
                boxheight: 40,
                keyboardType: TextInputType.number),
            space(15, 0),
            customTextLabel("GST Amount", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "GST Amount",
                radius: 15,
                controller: _gst_amount,
                boxheight: 40,
                keyboardType: TextInputType.number),
            space(15, 0),
            customTextLabel("Net Amount", leftPad: 9, bottomPad: 2),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Tap to Select Net Amount",
                controller: _net_amount,
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                readOnly: true,
                radius: 15,
                boxheight: 40),
            space(10, 0),
          ],
        ),
        Icon(Icons.calculate));
  }

  Widget transactionNotes() {
    return customExpansionTileType1(
        "Transaction Notes",
        Column(
          children: [
            customTextLabel("Transaction Notes", leftPad: 9, bottomPad: 2),
            space(2, 0),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 13),
                hint: "Transaction Notes",
                radius: 15,
                controller: _transaction_notes,
                boxheight: 70,
                keyboardType: TextInputType.text,
                maxLines: 3),
          ],
        ),
        Icon(Icons.note_alt));
  }

  Widget payment() {
    return customExpansionTileType1(
        "Payment",
        Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: customTextLabel("Invoice No.", leftPad: 10.0),
                ),
                Flexible(
                  flex: 2,
                  child: customTextLabel("Amount", leftPad: 10.0),
                ),
                Flexible(child: Container())
              ],
            ),
            space(3.0, 0.0),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: EditText(context,
                      inputTextStyle: TextStyle(fontSize: 13),
                      hint: "Tap to Select Invoice No.",
                      controller: _select_invoice_no,
                      suffixIcon:
                          Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
                      readOnly: true,
                      radius: 15,
                      boxheight: 40),
                ),
                Flexible(
                  flex: 2,
                  child: EditText(
                    context,
                    inputTextStyle: TextStyle(fontSize: 13),
                    hint: "Amount",
                    radius: 15,
                    controller: _amount,
                    boxheight: 40,
                    keyboardType: TextInputType.number, /*containerLeftPad: 15*/
                  ),
                ),
                space(0.0, 5),
                Flexible(child: getCommonButton(baseTheme, () {}, "+"))
              ],
            ),
            space(5.0, 0.0)
          ],
        ),
        Icon(Icons.running_with_errors));
  }

  Widget save() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: double.maxFinite,
      height: 50,
      child: TextButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          onPrimary: Color(0xff362d8b),
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
  }
}
