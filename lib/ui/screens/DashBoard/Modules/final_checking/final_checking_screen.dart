import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/final_checking/final_checking_bloc.dart';
import 'package:soleoserp/models/api_requests/final_checking_delete_all_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_list_request.dart';
import 'package:soleoserp/models/api_requests/search_finalchecking_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/search_finalchecking_label_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/search_finalchecking.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class FinalCheckingListScreen extends BaseStatefulWidget {
  static const routeName = '/FinalCheckingListScreen';
  @override
  _FinalCheckingListScreenState createState() => _FinalCheckingListScreenState();
}
class _FinalCheckingListScreenState extends BaseState<FinalCheckingListScreen>
    with BasicScreen,WidgetsBindingObserver {

  FinalCheckingBloc finalCheckingBloc;
  int pageno = 0;
  int selected = 0;
  FinalCheckingListResponse Response;
  SearchFinalcheckingLabelDetails FD;
  double _fontSize_Title = 11;
  double _fontSize_Label = 9;

  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID=0;
  String LoginUserID="";

  @override
  void initState() {
    super.initState();

    finalCheckingBloc = FinalCheckingBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    finalCheckingBloc..add(FinalCheckingListCallEvent(
        1, FinalCheckingListRequest(CompanyId: CompanyID.toString(), LoginUserID: LoginUserID.toString())));


     _onTapOfDeleteALLItems();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      finalCheckingBloc..add(FinalCheckingListCallEvent(pageno + 1,
          FinalCheckingListRequest(CompanyId: CompanyID.toString(), LoginUserID: LoginUserID.toString()))),
      child: BlocConsumer<FinalCheckingBloc, FinalCheckingListState>(
        builder: (BuildContext context, FinalCheckingListState state) {
          if (state is FinalCheckingListCallResponseState) {
            finalcheckinglistsuccess(state);
          }if (state is SearchFinalCheckingCallResponseState) {
            searchsuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is FinalCheckingListCallResponseState||
          currentState is SearchFinalCheckingCallResponseState
          ) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, FinalCheckingListState state) {

          if(state is FinalCheckingDeleteResponseState)
            {
              _OnDeleteItemsResponse(state,context);
            }

        },
        listenWhen: (oldState, currentState) {
          if(currentState is FinalCheckingDeleteResponseState)
            {
              return true;

            }
          return false;
        },
      ),);
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
          title: Text("Final Checking"),
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
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                child:RefreshIndicator(
                  onRefresh: ()async{
                    finalCheckingBloc..add(FinalCheckingListCallEvent(
                        1, FinalCheckingListRequest(CompanyId: CompanyID.toString(), LoginUserID: LoginUserID.toString())));
                    FD.label="Tap to Search Customer";
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
          onPressed: ()  async {
            // Add your onPressed code here!
            baseBloc.emit(ShowProgressIndicatorState(true));
            await _onTapOfDeleteALLItems();
            baseBloc.emit(ShowProgressIndicatorState(false));


            navigateTo(context, FinalCheckingAddScreen.routeName);

          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        drawer: build_Drawer(
            context: context,
            UserName: "",
            RolCode: ""),
      ),
    );
  }


  void finalcheckinglistsuccess(FinalCheckingListCallResponseState state) {
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
        ) {
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
    return ExpantionCustomer(context, index);
  }

  void _onPackingCheckListPagination() {
    finalCheckingBloc.add(FinalCheckingListCallEvent(pageno + 1,
        FinalCheckingListRequest(CompanyId: CompanyID.toString(), LoginUserID: LoginUserID.toString())));
  }

  Widget ExpantionCustomer(BuildContext context, int index) {
    FinalCheckingListDetails f = Response.details[index];
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
              f.customerName,
              style: TextStyle(color: Colors.black), //8A2CE2)),
            ),
            subtitle: Text(
              f.pCNo,
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

                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text("Name",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  f.customerName == ""
                                                      ? "N/A"
                                                      :  f.customerName ,
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
                                              Text("Checking No",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  f.checkingNo == null
                                                      ? "N/A"
                                                      :  f.checkingNo,
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
                                              Text("Checking Date",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  f.checkingDate== ""
                                                      ? "N/A"
                                                      :  f.checkingDate,
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
                                              Text("PC No",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  f.pCNo == null
                                                      ? "N/A"
                                                      :  f.pCNo ,
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
                      onPressed: () async {


                        _onTapOfEditCustomer(f);

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
                        _onTapOfDeleteInquirymain(f.pkID);
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
            child: Text("Search Installation List",
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
                      FD == null
                          ? "Tap to search customer"
                          : FD.label,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: FD == null
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

   /* Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchFinalCheckingScreen())).then((value) {
      if (value != null) {
        FD = value;
        print("WordOfLoan"+FD.pCNo.toString());
        finalCheckingBloc.add(SearchFinalCheckingCallEvent(
            SearchFinalCheckingRequest(CompanyId: "11051",word: FD.pCNo,LoginUserID: "admin",needALL: "0")));
        //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

      }
    });*/
    navigateTo(context, SearchFinalCheckingScreen.routeName).then((value)  {

    if (value != null) {
        FD = value;
        print("WordOfLoan"+FD.pCNo.toString());

        finalCheckingBloc.add(SearchFinalCheckingCallEvent(SearchFinalCheckingRequest(CompanyId: CompanyID.toString(),word: FD.pCNo,LoginUserID: LoginUserID.toString(),needALL: "0")));
    //  _CustomerBloc.add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: 8033,loginUserID: "admin",CustomerID: "",ListMode: "L")));

    }
    });
  }

  void searchsuccess(SearchFinalCheckingCallResponseState state) {
    Response = state.response;
  }


  void _onTapOfEditCustomer(FinalCheckingListDetails model)  {
    navigateTo(context, FinalCheckingAddScreen.routeName,
        arguments: AddUpdateFinalPackingScreenArguments(model))
        .then((value) {
      finalCheckingBloc..add(FinalCheckingListCallEvent(
          1, FinalCheckingListRequest(CompanyId: CompanyID.toString(), LoginUserID: LoginUserID.toString())));
    });
  }

  Future<void> _onTapOfDeleteALLItems() async {
    await OfflineDbHelper.getInstance().deleteALLFinalCheckingItems();
  }

  void _onTapOfDeleteInquirymain(int pkID) {

    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Item ?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      //_collapse();
       finalCheckingBloc.add(FinalCheckingDeleteCallEvent(pkID,FinalCheckingDeleteAllItemsRequest(CompanyId: CompanyID.toString())));

      // _CustomerBloc..add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: CompanyID,loginUserID: LoginUserID,CustomerID: "",ListMode: "L")));
    });
  }

  void _OnDeleteItemsResponse(FinalCheckingDeleteResponseState state, BuildContext context123) {

    navigateTo(context123, FinalCheckingListScreen.routeName,
        clearAllStack: true);
  }
}