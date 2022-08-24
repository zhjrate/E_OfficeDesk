import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/manage_production/production_bloc.dart';
import 'package:soleoserp/models/api_requests/ManageProductionRequest/MaterialOutward/material_outward_list_request.dart';
import 'package:soleoserp/models/api_responses/ManageProductionResponse/Material%20Outward/material_outward_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialOutward/material_outward_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';

String LoginUserID = "";
double _fontSize_Label = 11;
double _fontSize_Title = 13;

TextEditingController searched_name;

class MaterialOutwardListScreen extends BaseStatefulWidget {
  static const routeName = '/MaterialOutwardListScreen';

  @override
  _MaterialOutwardListScreenState createState() =>
      _MaterialOutwardListScreenState();
}

class _MaterialOutwardListScreenState
    extends BaseState<MaterialOutwardListScreen>
    with BasicScreen, WidgetsBindingObserver {
  ProductionBloc _manageProductionBloc;
  int _pageNo = 0;
  MaterialOutwardListResponse _materialOutwardListResponse;
  SearchDetails _searchDetails;

  List<MaterialOutwardListResponseDetails> ItemsList = [];

  TextEditingController _controller_material_outward_search =
      TextEditingController();

  List arrpagination = [];

  @override
  void initState() {
    super.initState();

    screenStatusBarColor = Colors.white;
    _manageProductionBloc = ProductionBloc(baseBloc);
    _controller_material_outward_search.text = "";

    _controller_material_outward_search.addListener(OnTextChangeds);
  }

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _manageProductionBloc
        ..add(MaterialOutwardListCallEvent(
            1,
            MaterialOutwardListRequest(
                LoginUserID: "admin",
                SearchKey: _controller_material_outward_search.text,
                CompanyId: 4132))),
      child: BlocConsumer<ProductionBloc, ProductionStates>(
        builder: (BuildContext context, ProductionStates state) {
          //handle states
          if (state is MaterialOutwardListCallResponseState) {
            _onMaterialOutwardListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is MaterialOutwardListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, ProductionStates state) {
          //handle states
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
            "Material Outward List",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
          ),
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              _manageProductionBloc
                ..add(MaterialOutwardListCallEvent(
                    1,
                    MaterialOutwardListRequest(
                        LoginUserID: 'admin',
                        SearchKey: _controller_material_outward_search.text,
                        CompanyId: 4132)));
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (shouldPaginate(
                      scrollInfo,
                    ) &&
                    _searchDetails == null) {
                  _onPagination();
                  return true;
                } else {
                  return false;
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("Search Customer",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colorBlack,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: colorLightGray,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        style: TextStyle(fontSize: 13),
                        controller: _controller_material_outward_search,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Tap to Search Customer",
                            hintStyle:
                                TextStyle(fontSize: 13, color: colorGrayDark),
                            filled: true,
                            fillColor: colorLightGray,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 14),
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
                  ),
                  _materialOutwardListResponse != null
                      ? Expanded(
                          child: ListView.builder(
                            key: Key('selected'),
                            itemBuilder: (context, index) {
                              return _buildPaginationResponseList(index);
                            },
                            shrinkWrap: true,
                            itemCount: _materialOutwardListResponse
                                .materialOutwardListResponseDetails.length,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateTo(context, MaterialOutwardAddEdit.routeName);
          },
          // tooltip: 'Increment',
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF00E676),
        ),
        drawer: build_Drawer(
            context: context,
            UserName: "KISHAN",
            RolCode: LoginUserID.toString()),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  void _onMaterialOutwardListCallSuccess(
      MaterialOutwardListCallResponseState state) {
    if (_pageNo != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        _materialOutwardListResponse = state.response;
      } else {
        _materialOutwardListResponse.materialOutwardListResponseDetails
            .addAll(state.response.materialOutwardListResponseDetails);
      }
      /*print("Details: " +
          _materialOutwardListResponse
              .MaterialOutwardListResponseDetails[0].customerName);*/
      _pageNo = state.newPage;
    } /*
    arrpagination.clear();
    for (int i = 0;
        i < state.response.MaterialOutwardListResponseDetails.length;
        i++) {
      MaterialOutwardListResponseDetails details =
          MaterialOutwardListResponseDetails();
      details.customerName =
          state.response.MaterialOutwardListResponseDetails[i].customerName;
      print("Details: " + details.customerName);
      arrpagination.add(details);
    }*/
  }

  Widget _buildPaginationResponseList(int index) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 3.0,
                      offset: Offset(1, -1),
                      spreadRadius: 0.5),
                ]),
            child: Theme(
              data: ThemeData().copyWith(
                dividerColor: Colors.white,
                iconTheme: Theme.of(context).iconTheme.copyWith(
                      color: Colors.white,
                    ),
              ),
              child: ListTileTheme(
                dense: true,
                child: ExpansionTileCard(
                  // initialElevation: 1.0,
                  // elevation: 2.0,
                  // shadowColor: Color(0xFF504F4F),
                  // baseColor: Color(0xFFFCFCFC),
                  // expandedColor: Color(0xFFC1E0FA),

                  borderRadius: BorderRadius.circular(15),
                  // initialElevation: 1.0,
                  // elevation: 2.0,
                  elevationCurve: Curves.easeInOut,
                  turnsCurve: Curves.easeInOut,
                  // shadowColor: Color(0xFF504F4F),
                  // baseColor: Color(0xFFFCFCFC),
                  baseColor: Colors.lightBlue.shade100,
                  expandedColor: Colors.lightBlue.shade100,

                  leading: CircleAvatar(
                      backgroundColor: Color(0xFF504F4F),
                      child: Image.network(
                        "http://demo.sharvayainfotech.in/images/profile.png",
                        height: 35,
                        fit: BoxFit.fill,
                        width: 35,
                      )),
                  title: Text(
                    _materialOutwardListResponse
                        .materialOutwardListResponseDetails[index].customerName,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: GestureDetector(
                    child: Text(
                      _materialOutwardListResponse
                          .materialOutwardListResponseDetails[index].contactNo1,
                      style: TextStyle(
                        color: Color(0xFF504F4F),
                        fontSize: 12,
                      ),
                    ),
                  ),

                  children: [
                    Container(
                      decoration: BoxDecoration(
                          // color: Colors.blueGrey.shade50,
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: ListTileTheme(
                                        dense: true,
                                        child: ListTile(
                                          title: Text(
                                            "Outward Date",
                                            style: TextStyle(
                                                color: Colors
                                                    .deepPurpleAccent.shade700,
                                                // // fontWeight: FontWeight.bold,
                                                fontSize: _fontSize_Label,
                                                // fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          subtitle: Text(
                                              _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .outwardDate ==
                                                          '' ||
                                                      _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .outwardDate
                                                              .toString() ==
                                                          null
                                                  ? '-'
                                                  : _materialOutwardListResponse
                                                      .materialOutwardListResponseDetails[
                                                          index]
                                                      .outwardDate
                                                      .toString()
                                                      .getFormattedDate(
                                                          fromFormat:
                                                              "yyyy-MM-ddTHH:mm:ss",
                                                          toFormat:
                                                              "dd-MM-yyyy"),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  // // fontWeight: FontWeight.bold,
                                                  fontSize: _fontSize_Title)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTileTheme(
                                        dense: true,
                                        child: ListTile(
                                          // contentPadding:
                                          // EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                          title: Text(
                                            "Outward No",
                                            style: TextStyle(
                                                color: Colors
                                                    .deepPurpleAccent.shade700,
                                                fontSize: _fontSize_Label,
                                                // fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          subtitle: Text(
                                              _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .outwardNo
                                                              .toString() ==
                                                          null ||
                                                      _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .outwardNo
                                                              .toString() ==
                                                          ''
                                                  ? "-"
                                                  : _materialOutwardListResponse
                                                      .materialOutwardListResponseDetails[
                                                          index]
                                                      .outwardNo
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  // // fontWeight: FontWeight.bold,
                                                  fontSize: _fontSize_Title)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTileTheme(
                                        dense: true,
                                        child: ListTile(
                                          // contentPadding:
                                          // EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                          title: Text(
                                            "Lead/Quot/SO No",
                                            style: TextStyle(
                                                color: Colors
                                                    .deepPurpleAccent.shade700,
                                                fontSize: _fontSize_Label,
                                                // fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          subtitle: Text(
                                              _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .orderNo
                                                              .toString() ==
                                                          null ||
                                                      _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .orderNo
                                                              .toString() ==
                                                          ''
                                                  ? "-"
                                                  : _materialOutwardListResponse
                                                      .materialOutwardListResponseDetails[
                                                          index]
                                                      .orderNo
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  // // fontWeight: FontWeight.bold,
                                                  fontSize: _fontSize_Title)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTileTheme(
                                        dense: true,
                                        child: ListTile(
                                          // contentPadding:
                                          // EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                                          title: Text(
                                            "Reference No",
                                            style: TextStyle(
                                                color: Colors
                                                    .deepPurpleAccent.shade700,
                                                fontSize: _fontSize_Label,
                                                // fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic),
                                          ),
                                          subtitle: Text(
                                              _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .referenceNo
                                                              .toString() ==
                                                          null ||
                                                      _materialOutwardListResponse
                                                              .materialOutwardListResponseDetails[
                                                                  index]
                                                              .referenceNo
                                                              .toString() ==
                                                          ''
                                                  ? "-"
                                                  : _materialOutwardListResponse
                                                      .materialOutwardListResponseDetails[
                                                          index]
                                                      .referenceNo
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  // // fontWeight: FontWeight.bold,
                                                  fontSize: _fontSize_Title)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: ListTile(
                                        title: Text(
                                          "Basic Amount",
                                          style: TextStyle(
                                              color: Colors
                                                  .deepPurpleAccent.shade700,
                                              fontSize: _fontSize_Label,
                                              // fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        subtitle: Text(
                                            _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .basicAmount
                                                            .toString() ==
                                                        null ||
                                                    _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .basicAmount
                                                            .toString() ==
                                                        ""
                                                ? "-"
                                                : _materialOutwardListResponse
                                                    .materialOutwardListResponseDetails[
                                                        index]
                                                    .basicAmount
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                // // fontWeight: FontWeight.bold,
                                                fontSize: _fontSize_Title)),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTile(
                                        title: Text(
                                          "Tax Amount",
                                          style: TextStyle(
                                              color: Colors
                                                  .deepPurpleAccent.shade700,
                                              fontSize: _fontSize_Label,
                                              // fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        subtitle: Text(
                                            _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .taxAmount
                                                            .toString() ==
                                                        null ||
                                                    _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .taxAmount
                                                            .toString() ==
                                                        ""
                                                ? "-"
                                                : _materialOutwardListResponse
                                                    .materialOutwardListResponseDetails[
                                                        index]
                                                    .taxAmount
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                // // fontWeight: FontWeight.bold,
                                                fontSize: _fontSize_Title)),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTile(
                                        title: Text(
                                          "Net Amount",
                                          style: TextStyle(
                                              color: Colors
                                                  .deepPurpleAccent.shade700,
                                              fontSize: _fontSize_Label,
                                              // fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        subtitle: Text(
                                            _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .outwardAmount
                                                            .toString() ==
                                                        null ||
                                                    _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .outwardAmount
                                                            .toString() ==
                                                        ""
                                                ? "-"
                                                : _materialOutwardListResponse
                                                    .materialOutwardListResponseDetails[
                                                        index]
                                                    .outwardAmount
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                // // fontWeight: FontWeight.bold,
                                                fontSize: _fontSize_Title)),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      child: ListTile(
                                        title: Text(
                                          "Sales Executive",
                                          style: TextStyle(
                                              color: Colors
                                                  .deepPurpleAccent.shade700,
                                              fontSize: _fontSize_Label,
                                              // fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        subtitle: Text(
                                            _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .createdEmployeeName
                                                            .toString() ==
                                                        null ||
                                                    _materialOutwardListResponse
                                                            .materialOutwardListResponseDetails[
                                                                index]
                                                            .createdEmployeeName
                                                            .toString() ==
                                                        ""
                                                ? "-"
                                                : _materialOutwardListResponse
                                                    .materialOutwardListResponseDetails[
                                                        index]
                                                    .createdEmployeeName
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                // // fontWeight: FontWeight.bold,
                                                fontSize: _fontSize_Title)),
                                      ),
                                    ),
                                  ],
                                ),
                                // flex: 1,
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 60,
                                  child: TextButton(
                                    onPressed: () {
                                      /*navigateTo(context,
                                              CustomerInsUpdScreen.routeName,
                                              arguments:
                                                  CustomerInsUpdScreenArgument(
                                                      _materialOutwardListResponse
                                                          .details[index]))
                                          .then((value) => _firstScreenBloc.add(
                                              FirstScreenCallEvent(
                                                  1,
                                                  CustomerPaginationRequest(
                                                      companyId: 4132,
                                                      loginUserID: "admin"))));*/
                                      navigateTo(context,
                                          MaterialOutwardAddEdit.routeName);
                                    },
                                    child: Column(
                                      children: [
                                        /*Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: Colors.indigo[900],
                                        ),*/
                                        ClipRRect(
                                          child: Image.asset(
                                            'assets/images/images_lgoinpage/edit.png',
                                            width: 24,
                                          ),
                                        ),
                                        Text(
                                          "Edit",
                                          style: TextStyle(
                                              color: Colors.black,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: TextButton(
                                    onPressed: () {
                                      commonalertbox("Are you Sure !", context,
                                          onTapofPositive: () {
                                        Navigator.pop(context);
                                      });

                                      print("lkjhlkjh");
                                    },
                                    child: Column(
                                      children: [
                                        // Icon(
                                        //   Icons.delete_outline,
                                        //   size: 30,
                                        // ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 2),
                                          child: ClipRRect(
                                            child: Image.asset(
                                              'assets/images/images_lgoinpage/delete.png',
                                              width: 24,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "Delete",
                                          style: TextStyle(
                                            color: Colors.black,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ], // children:
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPagination() {
    _manageProductionBloc.add(MaterialOutwardListCallEvent(
        _pageNo + 1,
        MaterialOutwardListRequest(
            LoginUserID: "admin",
            SearchKey: _controller_material_outward_search.text,
            CompanyId: 4132)));
  }

  _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Search Customer",
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            elevation: 5,
            color: Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              height: 40,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _searchDetails == null
                          ? "Tap to search customer"
                          : _searchDetails.label,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _searchDetails == null
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 14),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 18,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapOfSearchView() async {
    /* navigateTo(context, SearchCustomerScreen.routeName).then((value) {
      if (value != null) {
        SearchDetails model = value;
        _searchDetails = value;
        print(model.value.toString() + "model.value");
        _firstScreenBloc.add(SearchCustomerListByNumberCallEvent(
            CustomerSearchByIdRequest(
                companyId: 4132,
                loginUserID: "admin",
                CustomerID: model.value.toString())));
      }
    });*/
  }

  // void _onSearchbyNumberResponse(
  //     SearchCustomerListByNumberCallResponseState state) {
  //   _materialOutwardListResponse = state.response;
  // }

  void OnTextChangeds() {
    _manageProductionBloc.add(MaterialOutwardListCallEvent(
        1,
        MaterialOutwardListRequest(
            LoginUserID: 'admin',
            SearchKey: _controller_material_outward_search.text,
            CompanyId: 4132)));
  }
}
