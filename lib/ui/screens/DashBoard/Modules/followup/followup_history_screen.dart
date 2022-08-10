import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/followup/followup_bloc.dart';
import 'package:soleoserp/models/api_requests/followup_history_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/followup_history_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class FollowupHistoryScreenArguments {
  String InqNo, CustomerID;
  FollowupHistoryScreenArguments(this.InqNo, this.CustomerID);
}

class FollowupHistoryScreen extends BaseStatefulWidget {
  static const routeName = '/FollowupHistoryScreen';
  final FollowupHistoryScreenArguments arguments;

  FollowupHistoryScreen(this.arguments);
  @override
  _FollowupHistoryScreenState createState() => _FollowupHistoryScreenState();
}

class _FollowupHistoryScreenState extends BaseState<FollowupHistoryScreen>
    with BasicScreen, WidgetsBindingObserver {
  FollowupBloc _FollowupBloc;
  FollowupHistoryListResponse _searchCustomerListResponse;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  String InqNo;
  String CustomerID;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  double _fontSize_Title = 11;
  int label_color = 0xFF504F4F; //0x66666666;
  int title_color = 0xFF000000;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;

    screenStatusBarColor = colorPrimary;
    _FollowupBloc = FollowupBloc(baseBloc);
    InqNo = widget.arguments.InqNo;
    CustomerID = widget.arguments.CustomerID;
    _FollowupBloc
      ..add(FollowupHistoryListRequestCallEvent(FollowupHistoryListRequest(
          InquiryNo: InqNo,
          CompanyId: CompanyID.toString(),
          CustomerID: CustomerID)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc,
      child: BlocConsumer<FollowupBloc, FollowupStates>(
        builder: (BuildContext context, FollowupStates state) {
          if (state is FollowupHistoryListResponseState) {
            _onSearchInquiryListCallSuccess(state.followupHistoryListResponse);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is FollowupHistoryListResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, FollowupStates state) {},
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
          title: Text('Followup History'),
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
              children: [Expanded(child: _buildInquiryList())],
            ),
          ),
        ),
      ],
    );
  }

  ///builds header and title view

  ///builds inquiry list
  Widget _buildInquiryList() {
    if (_searchCustomerListResponse != null) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return _buildSearchInquiryListItem(index);
        },
        shrinkWrap: true,
        itemCount: _searchCustomerListResponse.details.length,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Lottie.asset(NO_DATA_ANIMATED
            /*height: 200,
              width: 200*/
            ),
      );
    }
  }

  ///builds row item view of inquiry list
  Widget _buildSearchInquiryListItem(int index) {
    FollowupHistoryDetails model = _searchCustomerListResponse.details[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Color(0xffffff8d),
                Color(0xffffff8d),
                Color(0xffb9f6ca),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Contact No1.",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Color(label_color),
                              fontSize: _fontSize_Label,
                              letterSpacing: .3)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.contactNo1 == "" ? "N/A" : model.contactNo1,
                          style: TextStyle(
                              color: Color(title_color),
                              fontSize: _fontSize_Title,
                              letterSpacing: .3))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: _buildTitleWithValueView(
                    "Followup Date",
                    model.followupDate.getFormattedDate(
                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                            toFormat: "dd-MM-yyyy") ??
                        "-"),
              ),
              Expanded(
                child: _buildTitleWithValueView(
                    "Next Followup Date",
                    model.nextFollowupDate.getFormattedDate(
                            fromFormat: "yyyy-MM-ddTHH:mm:ss",
                            toFormat: "dd-MM-yyyy") ??
                        "-"),
              ),
            ]),
            SizedBox(
              height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
            ),
            Row(children: [
              Expanded(
                child: _buildTitleWithValueView(
                    "Followup Type", model.inquiryStatus ?? "-"),
              ),
              Expanded(
                child: _buildTitleWithValueView(
                    "Lead #",
                    model.inquiryNo == "" || model.inquiryNo == null
                        ? '-'
                        : model.inquiryNo),
              ),
            ]),
            SizedBox(
              height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
            ),
            _buildTitleWithValueView(
                "Notes",
                /*model.referenceName ?? "-" */
                model.meetingNotes == "" || model.meetingNotes == null
                    ? '-'
                    : model.meetingNotes),
            SizedBox(
              height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
            ),
            /* Row(children: [
                  Expanded(
                   // child: _buildTitleWithValueView("No Followup", model.noFollowup.toString()),
                    child: _buildTitleWithValueView("No Followup", model.noFollowup.toString() == "false" ? 'no' : "yes"),
                  ),
                  Expanded(
                    child: _buildTitleWithValueView(
                        "Closer Reason", */ /*model.noFollClosureName ?? "-" */ /*
                        model.noFollClosureName == "--Not Available--" ||
                            model.noFollClosureName == null ? '-' : model
                            .noFollClosureName),
                  ),
                ]), */
            _buildTitleWithValueView(
                "Created By",
                /*model.referenceName ?? "-" */
                model.employeeName == "" || model.employeeName == null
                    ? '-'
                    : model.employeeName),
            SizedBox(
              height: DEFAULT_HEIGHT_BETWEEN_WIDGET,
            ),
          ]),
        ),
      ),
    );
  }

  ///calls search list api

  Widget _buildTitleWithValueView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: _fontSize_Label,
                color: Color(0xFF504F4F),
                /*fontWeight: FontWeight.bold,*/ fontStyle: FontStyle
                    .italic) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            ),
        SizedBox(
          height: 3,
        ),
        Text(value,
            style: TextStyle(
                fontSize: _fontSize_Title,
                color:
                    colorPrimary) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
            )
      ],
    );
  }

  void _onSearchInquiryListCallSuccess(
      FollowupHistoryListResponse followupHistoryListResponse) {
    _searchCustomerListResponse = followupHistoryListResponse;
  }
}
