


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/quick_inquiry/quick_inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class SearchCustomerQuickInquiryScreenArguments {
  String  editModel;


  SearchCustomerQuickInquiryScreenArguments(this.editModel);
}

class SearchCustomerQuickInquiryScreen extends BaseStatefulWidget {
  static const routeName = '/SearchCustomerQuickInquiryScreen';
  final SearchCustomerQuickInquiryScreenArguments arguments;
  SearchCustomerQuickInquiryScreen(this.arguments);

  @override
  _SearchCustomerQuickInquiryScreenState createState() => _SearchCustomerQuickInquiryScreenState();
}

class _SearchCustomerQuickInquiryScreenState extends BaseState<SearchCustomerQuickInquiryScreen>
    with BasicScreen, WidgetsBindingObserver {
  QuickInquiryBloc _CustomerBloc;
  CustomerLabelvalueRsponse _searchCustomerListResponse;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  TextEditingController edt_CustomerName= TextEditingController();
  bool IsDoneVisible=false;

  String _editModel;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    screenStatusBarColor = colorPrimary;
    _CustomerBloc = QuickInquiryBloc(baseBloc);

    _editModel = widget.arguments.editModel;
    edt_CustomerName.text = _editModel;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc,
      child: BlocConsumer<QuickInquiryBloc, QuickInquiryStates>(
        builder: (BuildContext context, QuickInquiryStates state) {
          if (state is CustomerListByNameCallResponseState) {
            _onSearchInquiryListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is CustomerListByNameCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, QuickInquiryStates state) {},
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
                    controller: edt_CustomerName,
                    autofocus:true,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      _onSearchChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Tap to enter Customer name",
                      border: InputBorder.none,
                    ),
                    style: baseTheme.textTheme.subtitle2
                        .copyWith(color: colorBlack),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: colorGrayDark,
                ),

              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        /* IsDoneVisible==true?*/Container(
          alignment: Alignment.center,
          height: 43,
          child: getCommonButton(baseTheme, (){

            ALL_Name_ID all_name_id = new ALL_Name_ID();
            all_name_id.Name = edt_CustomerName.text;
            all_name_id.Name1 = "";
            all_name_id.pkID = 0;

            /* SearchDetails model = new SearchDetails();
            model.label = edt_CustomerName.text;
            model.value = 0;*/
            Navigator.of(context).pop(all_name_id);

          }, "Done",width: 100),
        )/*: Container()*/,
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
    SearchDetails model = _searchCustomerListResponse.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          ALL_Name_ID all_name_id = new ALL_Name_ID();
          all_name_id.Name = model.label;
          all_name_id.Name1 = model.ContactNo1;
          all_name_id.pkID = model.value;
          Navigator.of(context).pop(all_name_id);
        },
        child: Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Text(
              model.label+"\n"+ model.ContactNo1,
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
      _CustomerBloc.add(SearchCustomerListByNameCallEvent(
          CustomerLabelValueRequest(word: value,CompanyId:CompanyID.toString(),LoginUserID: LoginUserID)));
    }
  }

  void _onSearchInquiryListCallSuccess(
      CustomerListByNameCallResponseState state) {
    _searchCustomerListResponse = state.response;
    if(state.response.details.length!=0)
    {
      IsDoneVisible=false;
    }
    else
    {
      IsDoneVisible=true;

    }
  }
}
