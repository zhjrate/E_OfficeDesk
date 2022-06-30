import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/packing_checklist/packing_checklist_bloc.dart';
import 'package:soleoserp/models/api_requests/packing_check_list_delete_request.dart';
import 'package:soleoserp/models/api_requests/packing_checklist_list.dart';
import 'package:soleoserp/models/api_requests/search_packingchecklist_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/packing_checking_list.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/api_responses/search_packingchecklist_label_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_checklist_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/search_packingchecklist_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class PackingChecklistScreen extends BaseStatefulWidget {
  static const routeName = '/PackingChecklistScreen';

  @override
  _PackingChecklistScreenState createState() => _PackingChecklistScreenState();
}
class _PackingChecklistScreenState extends BaseState<PackingChecklistScreen>
    with BasicScreen,WidgetsBindingObserver {

  PackingChecklistBloc packingChecklistBloc;
  int pageno = 0;
  int selected= 0;
  PackingChecklistListResponse Response;
  SearchPackingchecklistLabelDetails PC;
  int CompanyID = 0;
  String LoginUserID = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  double _fontSize_Title = 11;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    packingChecklistBloc = PackingChecklistBloc(baseBloc);
    packingChecklistBloc..add(PackingChecklistListCallEvent(1,PackingChecklistListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      packingChecklistBloc..add(PackingChecklistListCallEvent(pageno+1,PackingChecklistListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString()))),
      child: BlocConsumer<PackingChecklistBloc, PackingChecklistListState>(
        builder: (BuildContext context, PackingChecklistListState state) {
          if (state is PackingChecklistListCallResponseState) {

            packingchecklistsuccess(state);
          }if (state is SearchPackingChecklistCallResponseState) {

            searchpackingchecklistsuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is PackingChecklistListCallResponseState||
          currentState is SearchPackingChecklistCallResponseState
          ) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, PackingChecklistListState state) {
          if(state is PackingDeleteCallResponseState)
          {
            _OnDeleteQuotationSucessResponse(state);
          }

        },
        listenWhen: (oldState, currentState) {

          if(currentState is PackingDeleteCallResponseState)
            {
              return true;
            }
          return false;
        },
      ),    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(

    onWillPop: () {
      navigateTo(context, HomeScreen.routeName, clearAllStack: true);
      return new Future(() => false);
    },
      child: Scaffold(
        appBar: NewGradientAppBar(
          gradient: LinearGradient(
            colors: [Colors.red,Colors.purple,Colors.blue],
          ),
          title: Text("Packing Checklist"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName, clearAllStack: true);
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Expanded(
                child:RefreshIndicator(
                  onRefresh: ()async{
                    packingChecklistBloc.add(PackingChecklistListCallEvent(1,PackingChecklistListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));
                    PC.label="Tap to Search Customer";
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                      top: 20,
                    ),
                  child: Column(
                    children: [
                      _buildSearchView(),
                      SizedBox(height: 5,),
                      Expanded(child:_buildInquiryList()),
                    ],
                  ),

                ),),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            await _onTapOfDeleteALLProduct();

            navigateTo(context, PackingChecklistAddScreen.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context,
            UserName: "KISHAN",
            RolCode: LoginUserID.toString()),
      ),
    );
  }
  Future<void> _onTapOfDeleteALLProduct() async {
    await OfflineDbHelper.getInstance().deleteALLPackingProductAssambly();
  }

  void packingchecklistsuccess(PackingChecklistListCallResponseState state) {
    if (pageno != state.newPage || state.newPage == 1) {
      //checking if new data is arrived
      if (state.newPage == 1) {
        //resetting search
        Response = state.response;
      } else {
        Response.details.addAll(state.response.details);
      }
      pageno = state.newPage;
    }
  }
  Widget _buildInquiryList() {
    if (Response == null) {
      return Container();

    }
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (shouldPaginate(
          scrollInfo,
        )
        ){
          _onPackingCheckListPagination();
          return true;
        } else {
          return false;
        }
      },
      child: ListView.builder(
        key: Key('selected $selected'),

        itemBuilder: (context, index) {
          return _buildCustomerList(index);
        },
        shrinkWrap: true,
        itemCount: Response.details.length,
      ),
    );
  }

  ///builds row item view of inquiry list
  Widget _buildCustomerList(int index) {
    return ExpantionCustomer(context,index);

  }
  void _onPackingCheckListPagination() {
    packingChecklistBloc.add(PackingChecklistListCallEvent(pageno + 1,PackingChecklistListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));
  }

  Widget ExpantionCustomer(BuildContext context, int index) {
    PackingChecklistDetails p = Response.details[index];
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ExpansionTileCard(
            initialElevation: 5.0,
            elevation: 5.0,
            elevationCurve: Curves.easeInOut,
            shadowColor: Color(0xFF504F4F),
            baseColor: Color(0xFFFCFCFC),
            expandedColor: Color(0xFFC1E0FA),
            //Colors.deepOrange[50],ADD8E6
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
              p.customerName,
              style: TextStyle(color: Colors.black), //8A2CE2)),
            ),
            subtitle: Text(
              p.pCNo,
              style: TextStyle(
                color: Colors.black,
                fontSize: _fontSize_Title,
              ),
            ),
            children: [
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),

              Container(
                  margin: EdgeInsets.all(20),

                  child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[


                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("S/O #  ",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  p.sOno == ""
                                                      ? "N/A"
                                                      :  p.sOno ,
                                                  style: TextStyle(
                                                      color: Color(title_color),
                                                      fontSize: _fontSize_Title,
                                                      letterSpacing: .3)),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Status",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  p.status ==
                                                      "--Not Available--"
                                                      ? "N/A"
                                                      : p.status,
                                                  style: TextStyle(
                                                      color: Color(title_color),
                                                      fontSize: _fontSize_Title,
                                                      letterSpacing: .3)),
                                            ],
                                          )),
                                    ]),
                                SizedBox(
                                  height: sizeboxsize,
                                ),

                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Customer Name",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  p.customerName == ""
                                                      ? "N/A"
                                                      :  p.customerName,
                                                  style: TextStyle(
                                                      color: Color(title_color),
                                                      fontSize: _fontSize_Title,
                                                      letterSpacing: .3)),
                                            ],
                                          ))
                                    ]),
                                SizedBox(
                                  height: sizeboxsize,
                                ),

                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Date",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  p.createdDate == null
                                                      ? "N/A"
                                                      :  p.createdDate.getFormattedDate(
                                                      fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                      toFormat: "dd-MM-yyyy"),
                                                  style: TextStyle(
                                                      color: Color(title_color),
                                                      fontSize: _fontSize_Title,
                                                      letterSpacing: .3)),
                                            ],
                                          )),
/*
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("CreatedDate",
                                                style: TextStyle(
                                                    fontStyle:
                                                    FontStyle.italic,
                                                    color: Color(label_color),
                                                    fontSize: _fontSize_Label,
                                                    letterSpacing: .3)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                               model
                                                    .birthDate ==
                                                    null
                                                    ? "N/A"
                                                    : model.birthDate.getFormattedDate(
                                                   fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                   toFormat: "dd/MM/yyyy") ??
                                                   "-",
                                                style: TextStyle(
                                                    color: Color(title_color),
                                                    fontSize: _fontSize_Title,
                                                    letterSpacing: .3)),
                                          ],
                                        )),
*/
                                    ]),
                                SizedBox(
                                  height: sizeboxsize,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),

              ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        _onTapOfEditCustomer(p);
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
                        _onTapOfDeleteInquiry(p.pkID);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: colorPrimary,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: colorPrimary),
                          ),
                        ],
                      ),
                    )


                  ]),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
 /* Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: EdgeInsets.only(left: 5,right: 5),
            child: Card(
              elevation: 5,
              color: Color(0xffE0E0E0),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          PC == null
                              ? "Tap to search customer"
                              : PC.label,
                          style: TextStyle(
                            fontFamily: "Quicksand",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: colorGrayDark,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }*/

  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Search Packing CheckList",
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
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      PC == null
                          ? "Tap to search customer"
                          : PC.label,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: PC == null
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.search,
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

  Future<void> _onTapOfSearchView() async {

  /*  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPackingChecklistScreen())).then((value) {
      if (value != null) {
        PC = value;
        packingChecklistBloc.add(SearchPackingChecklistCallEvent(
            SearchPackingChecklistRequest(CompanyId: "11051",word: PC.label,LoginUserID: "admin",needALL: "0")));
        //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

      }
    });*/

    navigateTo(context, SearchPackingChecklistScreen.routeName).then((value) {
      if (value != null) {
        PC = value;
        /* _inquiryBloc.add(SearchInquiryListByNumberCallEvent(
            SearchInquiryListByNumberRequest(
                searchKey: _searchDetails.label,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString())));*/
        packingChecklistBloc.add(SearchPackingChecklistCallEvent(
            SearchPackingChecklistRequest(CompanyId: CompanyID.toString(),word: PC.pCNo,LoginUserID: LoginUserID.toString(),needALL: "0")));
      }
    });
  }



  void searchpackingchecklistsuccess(SearchPackingChecklistCallResponseState state) {
    Response = state.response;
  }

  void _onTapOfDeleteInquiry(int pkID) {
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Quotation ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
      packingChecklistBloc.add(PackingDeleteRequestCallEvent(context,pkID,PackingCheckListDeleteRequest(CompanyId:CompanyID.toString())));

    });
  }

  void _OnDeleteQuotationSucessResponse(PackingDeleteCallResponseState state) {

    navigateTo(state.context, PackingChecklistScreen.routeName,
        clearAllStack: true);
  }

  void _onTapOfEditCustomer(model) {

    navigateTo(context, PackingChecklistAddScreen.routeName,
        arguments: AddUpdatePackingScreenArguments(model))
        .then((value) {
      packingChecklistBloc..add(PackingChecklistListCallEvent(1,PackingChecklistListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));

    });
  }



}

