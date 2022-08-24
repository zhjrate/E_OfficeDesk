import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/InquiryShareModel.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddModuleNoScreenArguments {
  List<ALL_Name_ID> arr_inquiry_share_emp_list;
  AddModuleNoScreenArguments(this.arr_inquiry_share_emp_list);
}

class ModuleNoListScreen extends BaseStatefulWidget {
  static const routeName = '/ModuleNoListScreen';
  final AddModuleNoScreenArguments arguments;

  ModuleNoListScreen(this.arguments);

  @override
  _ModuleNoListScreenState createState() => _ModuleNoListScreenState();
}

class _ModuleNoListScreenState extends BaseState<ModuleNoListScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  InquiryShareModel inquiryShareModel;
  List<ALL_Name_ID> arrinquiryShareModel = [];

  //CustomerSourceResponse _offlineCustomerSource;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  String _InQNo;
  List<ALL_Name_ID> _arr_inquiry_share_emp_list = [];

  List<bool> _isChecked;
  bool isselected = false;
  GroupController controller = GroupController();

  List<String> OnlyEMPLIST = [];
  List<int> OnlyEMPLISTINT = [];
  ALL_EmployeeList_Response _offlineALLEmployeeListData;

  @override
  void initState() {
    super.initState();
    if (widget.arguments != null) {
      _arr_inquiry_share_emp_list.clear();
      _arr_inquiry_share_emp_list = widget.arguments.arr_inquiry_share_emp_list;
      arrinquiryShareModel = _arr_inquiry_share_emp_list;
    }
    screenStatusBarColor = colorPrimaryLight;
    // _offlineCustomerSource= SharedPrefHelper.instance.getCustomerSourceData();
    _offlineALLEmployeeListData =
        SharedPrefHelper.instance.getALLEmployeeList();

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
    /* _inquiryBloc.add(FollowerEmployeeListCallEvent(FollowerEmployeeListRequest(
        CompanyId: CompanyID.toString(), LoginUserID: "admin")));*/
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        getCommonAppBar(context, baseTheme, "Inquiry Share"),
        Expanded(
            child: Container(
                padding: EdgeInsets.only(
                  left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                  right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                  top: 25,
                ),
                child: Column(
                  children: [
                    Expanded(child: _buildProductList()),
                    _buildSearchView(),
                  ],
                ))),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    return getCommonButton(baseTheme, () {
      var value =
          arrinquiryShareModel.where((item) => item.isChecked == false).length;

      if (value == arrinquiryShareModel.length) {
        showCommonDialogWithSingleOption(
            context, "Select Any One Employee to Share Inquiry!",
            positiveButtonTitle: "OK");
      } else {
        // arrinquiryShareModel.removeWhere((item) => item.isChecked == false);

        for (var i = 0; i < arrinquiryShareModel.length; i++) {
          print("DDFDr" +
              arrinquiryShareModel[i].Name +
              "Checked" +
              arrinquiryShareModel[i].isChecked.toString());
        }
        List<ALL_Name_ID> temparray = [];
        temparray.addAll(arrinquiryShareModel);
        temparray.removeWhere((item) => item.isChecked == false);

        Navigator.of(context).pop(temparray);
        // _inquiryBloc.add(InquiryShareModelCallEvent(arrinquiryShareModel));
      }

      //
    }, "Share Inquiry");
  }

  ///builds product list
  Widget _buildProductList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _buildSearchProductListItem(index);
      },
      shrinkWrap: true,
      itemCount: arrinquiryShareModel.length,
    );
  }

  ///builds row item view of inquiry list
  Widget _buildSearchProductListItem(int index) {
    ALL_Name_ID model = arrinquiryShareModel[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(model);
        },
        child: CheckboxListTile(
          value: model.isChecked == null ? false : model.isChecked,
          onChanged: (value) {
            setState(
              () {
                model.isChecked = value;
                arrinquiryShareModel[index] = model;
              },
            );
          },
          title: Text(model.Name),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
