
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/packing_checklist/packing_checklist_bloc.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response_for_packing_checking.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class CountryArgumentsForPacking {
  String model123;

  CountryArgumentsForPacking(this.model123);
}

class SearchCountryPackingScreen extends BaseStatefulWidget {
  static const routeName = '/SearchCountryPackingScreen';
  final CountryArgumentsForPacking arguments;

  SearchCountryPackingScreen(this.arguments);

  @override
  _SearchCountryScreen createState() => _SearchCountryScreen();
}

class _SearchCountryScreen extends BaseState<SearchCountryPackingScreen>
    with BasicScreen, WidgetsBindingObserver {
  PackingChecklistBloc _CustomerBloc;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  CountryListResponseForPacking _searchCountryListResponse;
  List<ALL_Name_ID> _listFilteredCountry = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Country = [];
  Function refreshList;
  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    _CustomerBloc = PackingChecklistBloc(baseBloc);

    if (widget.arguments != null) {
      //for update
      print("objectOfCOUNTRY" + widget.arguments.model123 );
      _CustomerBloc
        ..add(CountryCallEvent(
            CountryListRequest(CountryCode: widget.arguments.model123 , CompanyID: CompanyID.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc,
      child: BlocConsumer<PackingChecklistBloc, PackingChecklistListState>(
        builder: (BuildContext context, PackingChecklistListState state) {
          if (state is CountryListEventResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is CountryListEventResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, PackingChecklistListState state) {},
        listenWhen: (oldState, currentState) {
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        NewGradientAppBar(
          title: Text('Search Country'),
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),


        ),
        Expanded(
            child:/* Container(
            padding: EdgeInsets.only(
              left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              top: 25,
            ),
            child: Column(
              children: [
                _buildSearchView(),
                Expanded(child: _buildInquiryList())
              ],
            ),
          ),*/
            Container(
              margin: EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text(
                      "Min. 3 chars to search Country",

                      style: baseTheme.textTheme.headline2.copyWith(color: colorPrimary),
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
                            child: TextFormField(
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              onChanged: (value) {
                                // _onSearchChanged(value);
                                // filterList(_searchController.text.toString().trim());
                                filterList(value.toString().trim());
                              },
                              decoration: InputDecoration(
                                hintText: "Tap to enter country name",
                                border: InputBorder.none,
                              ),
                              style: baseTheme.textTheme.subtitle2
                                  .copyWith(color: colorBlack),
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
                  /* Container(
                  margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: getCommonTextFormField(context, baseTheme,
                      title: "Search",
                      controller: _searchController, onTextChanged: (value) {
                        filterList(_searchController.text.toString().trim());
                      }),
                ),*/

                  Expanded(
                      child: Stack(
                        children: [
                          Container(
                            /*   width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,*/
                              child: _buildListView())
                        ],
                      )
                  ),


                ],
              ),
            )
        ),
      ],
    );
  }


  Widget _buildListView() {

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) myState) {
        refreshList = myState;
        return ListView.builder(
          itemBuilder: (context, index) {
            SearchCountryDetails _model = SearchCountryDetails();
            _model.countryName = _listFilteredCountry[index].Name;
            _model.countryCode = _listFilteredCountry[index].Name1;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 5),
              child:
              getCommonButton(baseTheme, () {
                /* // filterList(_searchController.text.toString().trim());
                // _onTapOfEditContact(index);
                edt_Country.text = _model.Name;
                CallStateListAPI(_model.Name1);*/
                Navigator.of(context).pop(_model);
              }, _model.countryName, width: 130,textSize: 15,backGroundColor: Colors.white,textColor: colorPrimary),
            );
          },
          shrinkWrap: true,
          itemCount: _listFilteredCountry.length,
        );
      },
    );
  }


  ///builds header and title view
  Widget _buildSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Min. 3 chars to search Country",
          style: baseTheme.textTheme.headline2.copyWith(color: colorBlack),
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
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      _onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Tap to enter Country name",
                      border: InputBorder.none,
                    ),
                    style: baseTheme.textTheme.subtitle2
                        .copyWith(color: colorBlack),
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
    );
  }




  ///calls search list api
  void _onSearchChanged(String value) {

  }

  void _onSearchInquiryListCallSuccess(
      CountryListEventResponseState state) {
    arr_ALL_Name_ID_For_Country.clear();
    for (var i = 0; i < state.countrylistresponse.details.length; i++) {
      print("CustomerCategoryResponse2 : " + state.countrylistresponse.details[i].countryName);
      ALL_Name_ID categoryResponse123 = ALL_Name_ID();
      categoryResponse123.Name = state.countrylistresponse.details[i].countryName;
      categoryResponse123.Name1 = state.countrylistresponse.details[i].countryCode;
      arr_ALL_Name_ID_For_Country.add(categoryResponse123);
      _listFilteredCountry.add(categoryResponse123);
      //children.add(new ListTile());
    }
  }

  void filterList(String query) {
    refreshList(() {
      _listFilteredCountry.clear();
      _listFilteredCountry.addAll(arr_ALL_Name_ID_For_Country
          .where((element) =>
          element.Name.toLowerCase().contains(query.toLowerCase()))
          .toList());
      print("_listFiltered.data.length - ${_listFilteredCountry.length}");
      print(
          "_listResponse.data.length - ${arr_ALL_Name_ID_For_Country.length}");
    });
    //baseBloc.refreshScreen();
  }
}
