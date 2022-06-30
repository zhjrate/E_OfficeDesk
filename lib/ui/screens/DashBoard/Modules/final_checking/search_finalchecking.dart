


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/final_checking/final_checking_bloc.dart';
import 'package:soleoserp/models/api_requests/search_finalchecking_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/search_finalchecking_label_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class SearchFinalCheckingScreen extends BaseStatefulWidget {
  static const routeName = '/SearchFinalCheckingScreen';

  @override
  _SearchFinalCheckingScreenState createState() => _SearchFinalCheckingScreenState();
}

class _SearchFinalCheckingScreenState extends BaseState<SearchFinalCheckingScreen>
    with BasicScreen, WidgetsBindingObserver {
  FinalCheckingBloc finalCheckingBloc;
  int CompanyID = 0;
  String LoginUserID = "";
  SearchFinalCheckingLabelResponse Response1;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    finalCheckingBloc = FinalCheckingBloc(baseBloc);

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => finalCheckingBloc,
      child: BlocConsumer<FinalCheckingBloc, FinalCheckingListState>(
        builder: (BuildContext context, FinalCheckingListState state) {
          if (state is SearchFinalCheckingLabelCallResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is SearchFinalCheckingLabelCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, FinalCheckingListState state) {},
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
          title: Text('Search Customer'),
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
              "Min. 3 chars to search Customer",
              style:TextStyle(fontFamily: "QuickSand",fontSize: 12,color: colorPrimary,fontWeight: FontWeight.bold)     ),
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
                  child: TextFormField(
                    autofocus:true,
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
    if (Response1 == null) {
      return Container();
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchInquiryListItem(index);
      },
      shrinkWrap: true,
      itemCount: Response1.details.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    SearchFinalcheckingLabelDetails cs = Response1.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(cs);
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Text(
              cs.label + "\n" + cs.checkingNo,
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
      finalCheckingBloc.add(SearchFinalCheckingLabelCallEvent(
          SearchFinalCheckingRequest(word: value,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID.toString(),needALL:'1' )));
    }
  }

  void _onSearchInquiryListCallSuccess(
      SearchFinalCheckingLabelCallResponseState state) {
    Response1 = state.response;
  }
}
