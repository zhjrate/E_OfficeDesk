

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/installation/installation_bloc.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_delete_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_list_request.dart';

import 'package:soleoserp/models/api_requests/search_installation_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/search_installation_label_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/search_installation_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/search_installation.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class InstallationListScreen extends BaseStatefulWidget {
  static const routeName = '/InstallationListScreen';
  @override
  _InstallationListScreenState createState() => _InstallationListScreenState();
}
class _InstallationListScreenState extends BaseState<InstallationListScreen>
    with BasicScreen,WidgetsBindingObserver {

  InstallationBloc installationBloc;
  int pageno = 0;
  int selected = 0;
  //SearchInstallationResponse
  InstallationListResponse Response;
  SearchInstallationResponse Response1;
  SearchInstallationLabelDetails SD;
  SearchInstallationLabelResponse Response2;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  double _fontSize_Title = 11;
  double _fontSize_Label = 9;



  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    installationBloc = InstallationBloc(baseBloc);
    installationBloc..add(InstalltionListCallEvent(
        1, InstallationListRequest(CompanyId: this.CompanyID.toString(), LoginUserID: this.LoginUserID)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      installationBloc..add(InstalltionListCallEvent(pageno + 1,
          InstallationListRequest(CompanyId: this.CompanyID.toString(), LoginUserID: this.LoginUserID))),
      child: BlocConsumer<InstallationBloc, InstallationListState>(
        builder: (BuildContext context, InstallationListState state) {
          if (state is InstallationListCallResponseState) {
            installtionlistsuccess(state);
          }

          if (state is SearchInstallationCallResponseState) {
            searchlistsuccess1(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is InstallationListCallResponseState||
           currentState is SearchInstallationCallResponseState


          ) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, InstallationListState state) {
          if(state is DeleteInstallationCallResponseState){
            _onTapOfDeleteInquiry(state,context);
          }
          return super.build(context);

        },
        listenWhen: (oldState, currentState) {
          if(currentState is DeleteInstallationCallResponseState){
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
          title: Text("Installation"),
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
                    installationBloc.add(InstalltionListCallEvent(1,InstallationListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));
                    SD.label="Tap to Search Customer";
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
                        SizedBox(height: 10,),
                        Expanded(child:_buildInquiryList()),
                      ],
                    ),

                  ),),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
            // Add your onPressed code here!
            navigateTo(context, InstallationAddScreen.routeName);
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


  void installtionlistsuccess(InstallationListCallResponseState state) {
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
    installationBloc.add(InstalltionListCallEvent(pageno + 1,
        InstallationListRequest(CompanyId: CompanyID.toString(),LoginUserID: LoginUserID.toString())));
  }

  Widget ExpantionCustomer(BuildContext context, int index) {
      InstallationListDetails ID = Response.details[index];
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
              ID.customerName,
              style: TextStyle(color: Colors.black), //8A2CE2)),
            ),
            subtitle: Text(
              Response.details[index].installationNo,
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
                                              Text("Installation No#",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  Response.details[index].installationNo == ""
                                                      ? "N/A"
                                                      :  Response.details[index].installationNo ,
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
                                              Text("Installation Date",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  Response.details[index].installationDate == null
                                                      ? "N/A"
                                                      :  Response.details[index].installationDate.getFormattedDate(
                                                      fromFormat: "yyyy-MM-ddTHH:mm:ss",
                                                      toFormat: "dd-MM-yyyy"),
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
                                                  Response.details[index].customerName == ""
                                                      ? "N/A"
                                                      :  Response.details[index].customerName,
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
                                              Text("Outward No",
                                                  style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Color(label_color),
                                                      fontSize: _fontSize_Label,
                                                      letterSpacing: .3)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  Response.details[index].outwardNo == null
                                                      ? "N/A"
                                                      :  Response.details[index].outwardNo,
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
                      onPressed: () {
                        _onTapOfEditInstallation(ID);
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
                        _onTapOfDeleteInquirymain(Response.details[index].customerID);
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
              height: 50,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      SD == null
                          ? "Tap to search customer"
                          : SD.label,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: SD == null
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

   /* Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchInstallationScreen())).then((value) {
      if (value != null) {
        SD = value;
        installationBloc.add(SearchInstallationCallEvent(
            SearchInstallationRequest(CompanyId: this.CompanyID.toString(), LoginUserID: this.LoginUserID,word: SD.installationNo,needALL: "0")));
      }
    });*/

    navigateTo(context, SearchInstallationScreen.routeName).then((value) {
      if (value != null) {
        /*SD = value;*/

        print("DetailsOfInstalltion"+value.toString());
       installationBloc.add(SearchInstallationCallEvent(SearchInstallationRequest(CompanyId: this.CompanyID.toString(), LoginUserID: this.LoginUserID,word: value,needALL: "0")));
      }
    } );
  }
  void searchlistsuccess1(SearchInstallationCallResponseState state) {
    Response = state.response;

  }


    void _onTapOfDeleteInquirymain(int id) {
      print("CUSTID" + id.toString());
      showCommonDialogWithTwoOptions(
          context, "Are you sure you want to delete this Customer?",
          negativeButtonTitle: "No",
          positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
        Navigator.of(context).pop();
        //_collapse();
        installationBloc.add(DeleteInstallationCallEvent(
            id, InstallationDeleteRequest(CompanyID: CompanyID.toString())));
        // _CustomerBloc..add(CustomerListCallEvent(1,CustomerPaginationRequest(companyId: CompanyID,loginUserID: LoginUserID,CustomerID: "",ListMode: "L")));
      });
    }

  void _onTapOfDeleteInquiry(DeleteInstallationCallResponseState state, BuildContext context) {
    navigateTo(context, InstallationListScreen.routeName, clearAllStack: true);
  }

  void _onTapOfEditInstallation(InstallationListDetails model) {
    navigateTo(context, InstallationAddScreen.routeName,
        arguments: InstallationEditArguments(model))
        .then((value) {
      installationBloc..add(InstalltionListCallEvent(
          1, InstallationListRequest(CompanyId: this.CompanyID.toString(), LoginUserID: this.LoginUserID)));
    });
  }

}



