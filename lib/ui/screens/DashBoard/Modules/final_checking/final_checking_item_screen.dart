/*FinalCheckingItemScreen*/
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';
import 'package:soleoserp/models/common/packingProductAssamblyTable.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/editable_list_tile.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/add_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_asambly_crud/packing_assambly_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';

class FinalCheckingItemScreen extends BaseStatefulWidget {
  static const routeName = '/FinalCheckingItemScreen';

  @override
  _FinalCheckingItemScreenState createState() =>
      _FinalCheckingItemScreenState();
}

class _FinalCheckingItemScreenState extends BaseState<FinalCheckingItemScreen>
    with BasicScreen, WidgetsBindingObserver {
  List<FinalCheckingItems> _productList = [];
  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;
  double CardViewHeight = 45.00;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;

    //getContacts();
    getProduct();
  }

  final TextEditingController edt_Application = TextEditingController();
  final TextEditingController edt_SerialNo = TextEditingController();


  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: colorWhite,
      child: Column(
        children: [
          getCommonAppBar(context, baseTheme, "Product List", showBack: true),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _buildContactsListView()),
                InkWell(
                  onTap: () async {

                    List<FinalCheckingItems> tempArrayList = [];
                    tempArrayList.addAll(_productList);

                     await OfflineDbHelper.getInstance().deleteALLFinalCheckingItems();
                    for (int i = 0; i < tempArrayList.length; i++) {

                      await OfflineDbHelper.getInstance().insertFinalCheckingItems(FinalCheckingItems(
                        tempArrayList[i].CheckingNo,
                        tempArrayList[i].CustomerID,
                        tempArrayList[i].Item,
                        tempArrayList[i].Checked,
                        tempArrayList[i].Remarks,
                        tempArrayList[i].SerialNo,
                        tempArrayList[i].SRno,
                        tempArrayList[i].LoginUserID,
                        tempArrayList[i].CompanyId
                      ));
                    }

                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: colorPrimary),
                    child: Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(color: colorWhite),
                    )),
                  ),
                )
                /* Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: colorPrimary,
                    onPressed: () async {
                      await navigateTo(
                        context,
                        PackingAssamblyAddEditScreen.routeName,
                      );
                      getProduct(); //right now calling again get contacts, later it can be optimized
                    },
                    child: Text("Save",style: TextStyle(fontSize: 12),),
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsListView() {
    if (_productList.length != 0) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);

          /* return EditableListTile(
            model: _productList[index],
            onChanged: (FinalCheckingItems updatedModel) {
              //
              _productList[index] = updatedModel;
            },
          );*/
        },
        shrinkWrap: true,
        itemCount: _productList.length,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Lottie.asset(NO_DATA_ANIMATED
            /*height: 200,
              width: 200*/
            ),
      );
    }
  }

  Future<void> getProduct() async {
    _productList.clear();
    _productList
        .addAll(await OfflineDbHelper.getInstance().getFinalCheckingItems());
    setState(() {});
  }

  /* Future<void> _onTapOfEditContact(int index) async {
    await navigateTo(context, PackingAssamblyAddEditScreen.routeName,
        arguments: PackingAssamblyAddEditScreenArguments(_productList[index]));
    getProduct(); //right now calling again get contacts, later it can be optimized
  }*/

  Future<void> _onTapOfDeleteContact(int index) async {
    await OfflineDbHelper.getInstance()
        .deleteFinalCheckingItems(_productList[index].id);
    setState(() {
      _productList.removeAt(index);
    });
  }

  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context, index);
  }

  ExpantionCustomer(BuildContext context, int index) {
    FinalCheckingItems model = _productList[index];

    /*return Container(

        padding: EdgeInsets.all(15),
        child :  InkWell(
          onTap: () {
          },
          child: CheckboxListTile(
            value: model.Checked == "0" ? false : true,
            onChanged: (value) {
              setState(
                    () {
                 // bool ischecked =  value;
                  model.Checked = value==false?"0":"1";
                  //arrinquiryShareModel[index] = model;
                },
              );
            },
            title:
            Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(model.Item,style: TextStyle(fontSize: 12),)),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(model.SerialNo,style: TextStyle(fontSize: 12),)),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),

        ),

    );*/

    return Container(
        padding: EdgeInsets.all(15),
        child: ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          elevationCurve: Curves.easeInOut,

          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: Color(0xFFC1E0FA),
          //Colors.deepOrange[50],ADD8E6
          leading: CircleAvatar(
              backgroundColor: Color(0xFF504F4F),
              child: Image.asset(
                PRODUCT_ICON,
                height: 48,
                width: 48,
              )),
          //Image.network("https://cdn-icons.flaticon.com/png/512/4785/premium/4785452.png?token=exp=1639741267~hmac=4fc9726eef0cf39128308a40039ea5ca", height: 35, fit: BoxFit.fill,width: 35,)),
          title: Text(
            model.Item,
            style: TextStyle(color: Colors.black),
          ),

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
                    margin: EdgeInsets.all(10),
                    child: Container(

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
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
                                                Text("Item.  ",
                                                    style: TextStyle(
                                                        fontStyle:
                                                        FontStyle.italic,
                                                        color:
                                                        Color(label_color),
                                                        fontSize:
                                                        _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CheckboxListTile(
                                                  value: model.Checked == "0"
                                                      ? false
                                                      : true,
                                                  onChanged: (value) {
                                                    setState(
                                                          () {
                                                        // bool ischecked =  value;
                                                        model.Checked =
                                                        value == false
                                                            ? "0"
                                                            : "1";
                                                        //arrinquiryShareModel[index] = model;
                                                      },
                                                    );
                                                  },
                                                  title: Text(model.Item),
                                                ),
                                               /* Text(
                                                    model.Item == ""
                                                        ? "N/A"
                                                        : model.Item,
                                                    style: TextStyle(
                                                        color:
                                                        Color(title_color),
                                                        fontSize:
                                                        _fontSize_Title,
                                                        letterSpacing: .3)),*/
                                              ],
                                            )),
                                      ]),



                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  model.SRno=="1"?Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("SerialNo",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color:
                                                            Color(label_color),
                                                        fontSize:
                                                            _fontSize_Label,
                                                        letterSpacing: .3)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    model.SerialNo == ""
                                                        ? "N/A"
                                                        : model.SerialNo,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
                                      ]):Container(),

                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
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
                      // _onTapOfEditContact(index);
                      edt_Application.text = model.Item;
                      edt_SerialNo.text = model.SerialNo;

                      showcustomdialog(
                          context1: context,
                          finalCheckingItems: model,
                          index1: index);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          color: colorPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(color: colorPrimary),
                        ),
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
                        Icon(
                          Icons.delete,
                          color: colorPrimary,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text(
                          'Delete',
                          style: TextStyle(color: colorPrimary),
                        ),
                      ],
                    ),
                  ),
                ]),
          ],
        ));
  }

  Widget Application(String serialNo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Item",
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
            height: CardViewHeight,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      enabled: false,
                      controller: edt_Application,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Application",
                        labelStyle: TextStyle(
                          color: Color(0xFF000000),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF000000),
                      ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  showcustomdialog({
    BuildContext context1,
    FinalCheckingItems finalCheckingItems,
    int index1,
  }) async {
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
                  color: colorPrimary, //                   <--- border color
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                        15.0) //                 <--- border radius here
                    ),
              ),
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: colorPrimary, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          children: [
            SizedBox(
                width: MediaQuery.of(context123).size.width,
                child: Column(
                  children: [
                    /* TextField(
                        controller: edt_Application,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Tap to enter Application",
                          labelStyle: TextStyle(
                            color: Color(0xFF000000),
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF000000),
                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                    ),*/
                    Container(
                      margin: EdgeInsets.all(5),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text("Item",
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: CardViewHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                        enabled: true,
                                        controller: edt_Application,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: "Tap to enter Application",
                                          labelStyle: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF000000),
                                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    finalCheckingItems.SRno=="1"?Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text("Serial No",
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: CardViewHeight,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(

                                        enabled: true,
                                        controller: edt_SerialNo,
                                        decoration: InputDecoration(
                                          hintText: "Tap to enter SerialNo",
                                          labelStyle: TextStyle(
                                            color: Color(0xFF000000),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF000000),
                                        ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ):Container(),

                    FlatButton(
                      color: colorPrimary,
                        onPressed: () {
                          setState(() {
                            finalCheckingItems.Item = edt_Application.text;
                            finalCheckingItems.SerialNo = edt_SerialNo.text;

                          });
                          // _productList[index1].SerialNo = edt_Application.text;
                          Navigator.pop(context123);
                        },
                        child: Text("Edit",style: TextStyle(color: colorWhite),))
                  ],
                )),
          ],
        );
      },
    );
  }
}
