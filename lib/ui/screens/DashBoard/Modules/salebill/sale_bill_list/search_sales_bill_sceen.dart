import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/salesbill/salesbill_bloc.dart';
import 'package:soleoserp/models/api_requests/search_sale_bill_list_by_name_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/search_sales_bill_search_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';

import 'package:soleoserp/utils/shared_pref_helper.dart';

class SearchSalesBillScreen extends BaseStatefulWidget {
  static const routeName = '/SearchSalesBillScreen';

  @override
  _SearchSalesBillScreenState createState() => _SearchSalesBillScreenState();
}

class _SearchSalesBillScreenState extends BaseState<SearchSalesBillScreen>
    with BasicScreen, WidgetsBindingObserver {
  SalesBillBloc _salesBillBloc;
  SearchSalesBillListResponse _searchSalesBillListResponse;
  int CompanyID = 0;
  String LoginUserID = "";
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _salesBillBloc = SalesBillBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _salesBillBloc,
      child: BlocConsumer<SalesBillBloc, SalesBillStates>(
        builder: (BuildContext context, SalesBillStates state) {
          if (state is SearchSalesBillListByNameCallResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is SearchSalesBillListByNameCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, SalesBillStates state) {},
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
          title: Text('Search SalesBill'),
          gradient:
          LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),

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
          "Min. 3 chars to search Quotation",
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
    if (_searchSalesBillListResponse == null) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchInquiryListItem(index);
      },
      shrinkWrap: true,
      itemCount: _searchSalesBillListResponse.details.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    SearchSalesBillListResponseSearchDetails model = _searchSalesBillListResponse.details[index];

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
              model.custoemerName+"\n"+model.invoiceNo+"\n"+model.quotationNo,
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
      _salesBillBloc.add(SearchSaleBillListByNameCallEvent(
          SearchSalesBillListByNameRequest(word: value,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID,NameOnly: "1")));
    }
  }

  void _onSearchInquiryListCallSuccess(
      SearchSalesBillListByNameCallResponseState state) {
    _searchSalesBillListResponse = state.response;
  }
}
