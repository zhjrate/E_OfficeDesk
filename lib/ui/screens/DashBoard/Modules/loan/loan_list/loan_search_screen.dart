import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/bank_voucher/bank_voucher_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/employee/employee_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/loan/loan_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/employee_search_request.dart';
import 'package:soleoserp/models/api_requests/loan_search_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/employee_list_response.dart';
import 'package:soleoserp/models/api_responses/loan_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class SearchLoanScreen extends BaseStatefulWidget {
  static const routeName = '/SearchLoanScreen';

  @override
  _SearchLoanScreenState createState() => _SearchLoanScreenState();
}

class _SearchLoanScreenState extends BaseState<SearchLoanScreen>
    with BasicScreen, WidgetsBindingObserver {
  LoanScreenBloc _CustomerBloc;
  LoanListResponse _searchCustomerListResponse;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";


  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    screenStatusBarColor = colorPrimary;
    _CustomerBloc = LoanScreenBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc,
      child: BlocConsumer<LoanScreenBloc, LoanScreenStates>(
        builder: (BuildContext context, LoanScreenStates state) {
          if (state is LoanSearchResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is LoanSearchResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, LoanScreenStates state) {},
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
          title: Text('Search Employee'),
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
        Container(
          padding: EdgeInsets.only(left: 10, right: 20),
          child: Text(
              "Min. 3 chars to search Employee",
              style:TextStyle(fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)     ),
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
                    autofocus:true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      _onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Tap to enter employee name",
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
    if (_searchCustomerListResponse == null) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchInquiryListItem(index);
      },
      shrinkWrap: true,
      itemCount: _searchCustomerListResponse.details.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    LoanDetails model = _searchCustomerListResponse.details[index];

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
              model.employeeName+"\n"+ model.loanAmount.toString(),
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
      _CustomerBloc.add(LoanSearchCallEvent(
          LoanSearchRequest(pkID:"",LoginUserID: LoginUserID,SearchKey: value,CompanyID:CompanyID.toString())));
    }
  }

  void _onSearchInquiryListCallSuccess(
      LoanSearchResponseState state) {
    _searchCustomerListResponse = state.employeeListResponse;
  }
}
