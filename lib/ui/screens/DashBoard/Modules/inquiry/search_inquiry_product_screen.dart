
/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';*/

/*class SearchInquiryProductScreen extends BaseStatefulWidget {
  static const routeName = '/SearchInquiryProductScreen';

  @override
  _SearchInquiryProductScreenState createState() => _SearchInquiryProductScreenState();
}

class _SearchInquiryProductScreenState extends BaseState<SearchInquiryProductScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  InquiryProductSearchResponse _searchInquiryListResponse;

  final TextEditingController edt_ProductSearch = TextEditingController();


  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
    _inquiryBloc.add(InquiryProductSearchNameCallEvent(
        InquiryProductSearchRequest(SearchKey: "",CompanyId: CompanyID.toString(),ListMode: "L",pkID: "")));

  edt_ProductSearch.addListener(() {
      _inquiryBloc.add(InquiryProductSearchNameCallEvent(
          InquiryProductSearchRequest(SearchKey: edt_ProductSearch.text,CompanyId: CompanyID.toString(),ListMode: "L",pkID: "")));


    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
          if (state is InquiryProductSearchResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is SearchInquiryListByNameCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, InquiryStates state) {


        },
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
          title: Text('Search Product'),
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
        ),
        Expanded(
          child: Container(
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
          ),
        ),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Min. 3 chars to search Inquiry",
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
                    controller: edt_ProductSearch,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
 onChanged: (value) {
                      _onSearchChanged(value);
                    },

                    decoration: InputDecoration(
                      hintText: "Tap to enter customer name",
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

  ///builds inquiry list
  Widget _buildInquiryList() {
    if (_searchInquiryListResponse == null) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchInquiryListItem(index);
      },
      shrinkWrap: true,
      itemCount: _searchInquiryListResponse.details.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    ProductSearchDetails model = _searchInquiryListResponse.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(model);
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Text(
              model.productName+"\n" + model.productAlias ,
              style: baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
          ),
          margin: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  ///calls search list api
  void _onSearchChanged(String value) {
    if (value.trim().length > 2) {
      _inquiryBloc.add(InquiryProductSearchNameCallEvent(
          InquiryProductSearchRequest(SearchKey: value,CompanyId: CompanyID.toString(),ListMode: "L",pkID: "")));
    }
  }

  void _onSearchInquiryListCallSuccess(
      InquiryProductSearchResponseState state) {
    print("ProductSearchInfo"+state.inquiryProductSearchResponse.details[0].productName);
    _searchInquiryListResponse = state.inquiryProductSearchResponse;
  }
}*/


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class SearchInquiryProductScreen extends BaseStatefulWidget {
  static const routeName = '/SearchInquiryProductScreen';

  @override
  _SearchInquiryProductScreenState createState() => _SearchInquiryProductScreenState();
}

class _SearchInquiryProductScreenState extends BaseState<SearchInquiryProductScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  InquiryProductSearchResponse _searchProductListResponse;
  //CustomerSourceResponse _offlineCustomerSource;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";


  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimaryLight;
   // _offlineCustomerSource= SharedPrefHelper.instance.getCustomerSourceData();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
          if (state is InquiryProductSearchResponseState) {
            _onSearchProductListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is InquiryProductSearchResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, InquiryStates state) {},
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
        getCommonAppBar(context, baseTheme, "Search Product"),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
              top: 25,
            ),
            child: Column(
              children: [
                _buildSearchView(),
                Expanded(child: _buildProductList())
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Min. 3 chars to search Product",
            style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)          ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 5,
          color: colorGray,
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
                    autofocus:true,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      _onSearchChanged(value.trim());
                    },
                    decoration: InputDecoration(
                      hintText: "Enter product name",
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

  ///builds product list
  Widget _buildProductList() {
    if (_searchProductListResponse == null) {
      return Container();
    }
    if (_searchProductListResponse.details.isEmpty) {
      return getCommonEmptyView(message: "No products found");
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchProductListItem(index);
      },
      shrinkWrap: true,
      itemCount: _searchProductListResponse.details.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchProductListItem(int index) {
    ProductSearchDetails model = _searchProductListResponse.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(model);
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Text(
              model.productName,
              style: baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
          ),
          margin: EdgeInsets.only(top: 10),
        ),
      ),
    );
  }

  ///calls search list api
  void _onSearchChanged(String value) {
    if (value.trim().length > 2) {
      _inquiryBloc.add(InquiryProductSearchNameCallEvent(InquiryProductSearchRequest(pkID: "",CompanyId:CompanyID.toString() ,ListMode: "L",SearchKey: value)));
    }
  }

  void _onSearchProductListCallSuccess(
      InquiryProductSearchResponseState state) {
    for(var i=0;i<state.inquiryProductSearchResponse.details.length;i++)
      {
        print("InquiryProductName"+state.inquiryProductSearchResponse.details[i].productName);

      }
    _searchProductListResponse = state.inquiryProductSearchResponse;
  }
}