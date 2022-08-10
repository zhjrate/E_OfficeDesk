import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';

import 'add_contact_screen.dart';

class ContactsListScreen extends BaseStatefulWidget {
  static const routeName = '/_contactsListListScreen';

  @override
  _ContactsListScreenState createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends BaseState<ContactsListScreen>
    with BasicScreen, WidgetsBindingObserver {
  List<ContactModel> _contactsList = [];
  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  CustomerDetails _editModel;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;

    getContacts();
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Column(
        children: [
          getCommonAppBar(context, baseTheme, "Contacts List", showBack: true,
              onTapOfBack: () {
            //Navigator.pop(_contactsList);
            //Navigator.pop(context);
            //Navigator.of(context).pop(_editModel);
            Navigator.pop(context, _editModel);
            /*  navigateTo(context, Customer_ADD_EDIT.routeName,
                    arguments: AddUpdateCustomerScreenArguments(_editModel))
                .then((value) {});*/
          }),
          Expanded(
            child: Stack(
              children: [
                _buildContactsListView(),
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: colorPrimary,
                    onPressed: () async {
                      await navigateTo(
                        context,
                        AddContactScreen.routeName,
                      );
                      getContacts(); //right now calling again get contacts, later it can be optimized
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    // Your back press code here...
    // CommonUtils.showToast(context, "Back presses");
    // Navigator.defaultRouteName.
    //   navigateTo(context, Customer_ADD_EDIT.routeName);
    //navigateTo(context, Customer_ADD_EDIT.routeName, useRootNavigator: false);
    // Navigator.of(context).pop("_model");

    // _editModel

    /*navigateTo(context, Customer_ADD_EDIT.routeName,
            arguments: AddUpdateCustomerScreenArguments(_editModel))
        .then((value) {});*/

    //Navigator.of(context).pop(_editModel);
    Navigator.pop(context, _editModel);

    // Navigator.of(context, rootNavigator: true).pop(context);
    return Future.value(false);
  }

  Widget _buildContactsListView() {
    if (_contactsList.length != 0) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return _buildInquiryListItem(index);
/*
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Container(
              margin: EdgeInsets.all(20),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID:${_contactsList[index].id}"),
                      Text("Name: ${_contactsList[index].ContactPerson1}"),
                      Text("Mobile: ${_contactsList[index].ContactNumber1}"),
                      Text("Email: ${_contactsList[index].ContactEmail1}"),
                     Text("Designation: ${_contactsList[index].ContactDesignationName}"),
                      //Text("DesignationCode: ${_contactsList[index].ContactDesigCode1}"),

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
        );
*/
        },
        shrinkWrap: true,
        itemCount: _contactsList.length,
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

  Future<void> getContacts() async {
    _contactsList.clear();
    _contactsList.addAll(await OfflineDbHelper.getInstance().getContacts());
    setState(() {});
  }

  Future<void> _onTapOfEditContact(int index) async {
    await navigateTo(context, AddContactScreen.routeName,
        arguments: AddContactScreenArguments(_contactsList[index]));

    getContacts(); //right now calling again get contacts, later it can be optimized
  }

  Future<void> _onTapOfDeleteContact(int index) async {
    await OfflineDbHelper.getInstance().deleteContact(_contactsList[index].id);
    setState(() {
      _contactsList.removeAt(index);
    });
  }

  Widget _buildInquiryListItem(int index) {
    return ExpantionCustomer(context, index);
  }

  ExpantionCustomer(BuildContext context, int index) {
    ContactModel model = _contactsList[index];

    return Container(
        padding: EdgeInsets.all(15),
        child: ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          elevation: 5.0,
          elevationCurve: Curves.easeInOut,

          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: Color(0xFFC1E0FA), //Colors.deepOrange[50],ADD8E6
          leading: CircleAvatar(
              backgroundColor: Color(0xFF504F4F),
              child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/ Image
                  .network(
                "http://demo.sharvayainfotech.in/images/profile.png",
                height: 35,
                fit: BoxFit.fill,
                width: 35,
              )),
          title: Text(
            model.ContactPerson1,
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
                    margin: EdgeInsets.all(20),
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
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
                                                Text("Contact No.  ",
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
                                                    model.ContactNumber1 == ""
                                                        ? "N/A"
                                                        : model.ContactNumber1,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
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
                                                Text("Email",
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
                                                    model.ContactEmail1 == ""
                                                        ? "N/A"
                                                        : model.ContactEmail1,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            )),
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
                                                Text("Designation",
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
                                                    model.ContactDesignationName ==
                                                            ""
                                                        ? "N/A"
                                                        : model
                                                            .ContactDesignationName,
                                                    style: TextStyle(
                                                        color:
                                                            Color(title_color),
                                                        fontSize:
                                                            _fontSize_Title,
                                                        letterSpacing: .3)),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
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
                      _onTapOfEditContact(index);
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
                      showCommonDialogWithTwoOptions(context,
                          "Are you sure you want to Delete This Contact Details ?",
                          negativeButtonTitle: "No", positiveButtonTitle: "Yes",
                          onTapOfPositiveButton: () async {
                        Navigator.of(context).pop();
                        _onTapOfDeleteContact(index);
                      });
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
}
