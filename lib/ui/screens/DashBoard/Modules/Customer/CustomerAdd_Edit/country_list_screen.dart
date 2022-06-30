import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/customer_add_edit.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class CountryListScreen extends BaseStatefulWidget {
  static const routeName = '/CountryListScreen';
  CountryListScreen();

  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends BaseState<CountryListScreen>
    with BasicScreen, WidgetsBindingObserver {
 /* PaginationDemoScreenBloc _paginationDemoScreenBloc;
  PaginationDemoListResponse _listResponse;
  List<Data> _listFiltered = [];
  int _page = 0;*/

  CustomerBloc _CustomerStates;

  TextEditingController _searchController = TextEditingController();
  Function refreshList;
  List<ALL_Name_ID> _listFilteredCountry = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Country = [];
  LoginUserDetialsResponse _offlineLoggedInData;
  CompanyDetailsResponse _offlineCompanyData;
  int CompanyID = 0;
  String LoginUserID = "";

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _CustomerStates = CustomerBloc(baseBloc);
    _CustomerStates
      ..add(CountryCallEvent(
          CountryListRequest(CountryCode: "", CompanyID: CompanyID.toString())));
  }

  ///listener to multiple states of bloc to handles api responses
  ///use only BlocListener if only need to listen to events
/*
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaginationDemoScreenBloc, PaginationDemoScreenStates>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, PaginationDemoScreenStates state) {
        if (state is PaginationDemoScreenResponseState) {
          _onPaginationDemoScreenCallSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }
*/

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      _CustomerStates,
      child: BlocConsumer<CustomerBloc, CustomerStates>(
        builder: (BuildContext context, CustomerStates state) {
          //handle states

          if (state is CountryListEventResponseState) {
            _onCountryListSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          if (currentState is CountryListEventResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, CustomerStates state) {
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

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child:  Padding(
                padding: const EdgeInsets.all(18.0),
                child: getCommonTextFormField(context, baseTheme,
                    title: "Search",
                    controller: _searchController, onTextChanged: (value) {
                      filterList(_searchController.text.toString().trim());
                    }),
              ),
              ),

              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,

                child:  Padding(
                padding: const EdgeInsets.all(18.0),
                child: getCommonButton(baseTheme, () {
                  filterList(_searchController.text.toString().trim());
                }, "Search", width: 130,textSize: 15),
              ),
              ),

            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) myState) {
        refreshList = myState;

          return  ListView.builder(
              itemBuilder: (context, index) {
                ALL_Name_ID _model = _listFilteredCountry[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child:
                 getCommonButton(baseTheme, () {
                // filterList(_searchController.text.toString().trim());
                _onTapOfEditContact(index);

                }, _listFilteredCountry[index].Name, width: 130,textSize: 15,backGroundColor: Colors.white,textColor: Colors.black),
                );
              },
              shrinkWrap: true,
              itemCount: _listFilteredCountry.length,
            );

    });
  }



  void filterList(String query) {
    refreshList(() {
      _listFilteredCountry.clear();
      _listFilteredCountry.addAll(arr_ALL_Name_ID_For_Country
          .where((element) =>
          element.Name.toLowerCase().contains(query.toLowerCase()))
          .toList());
      print("_listFiltered.data.length - ${_listFilteredCountry.length}");
      print("_listResponse.data.length - ${arr_ALL_Name_ID_For_Country.length}");
    });
    //baseBloc.refreshScreen();
  }

  void _onCountryListSuccess(CountryListEventResponseState countrylistresponse) {
    arr_ALL_Name_ID_For_Country.clear();
    for (var i = 0; i < countrylistresponse.countrylistresponse.details.length; i++) {
      print("Coutry : " + countrylistresponse.countrylistresponse.details[i].countryName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name = countrylistresponse.countrylistresponse.details[i].countryName;
      categoryResponse123.Name1 = countrylistresponse.countrylistresponse.details[i].countryCode;
      arr_ALL_Name_ID_For_Country.add(categoryResponse123);
      _listFilteredCountry.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  Future<void> _onTapOfEditContact(int index) async {
   /* await navigateTo(context, Customer_ADD_EDIT.routeName,
        arguments: CountryArguments(_listFilteredCountry[index]),clearSingleStack:true);*/
   /*  await navigateTo(context, Customer_ADD_EDIT.routeName,
        arguments: CountryArguments(_listFilteredCountry[index]),ispop:false);*/
  //  getContacts(); //right now calling again get contacts, later it can be optimized
  }


}
