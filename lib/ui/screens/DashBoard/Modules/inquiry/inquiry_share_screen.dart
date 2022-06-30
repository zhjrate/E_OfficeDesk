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

import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/inquiry/inquiry_bloc.dart';
import 'package:soleoserp/models/api_requests/InquiryShareModel.dart';
import 'package:soleoserp/models/api_requests/follower_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_emp_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddInquiryShareScreenArguments {
  List<InquirySharedEmpDetails> arr_inquiry_share_emp_list;
  AddInquiryShareScreenArguments(this.arr_inquiry_share_emp_list);
}

class InquiryShareScreen extends BaseStatefulWidget {
  static const routeName = '/InquiryShareScreen';
  final AddInquiryShareScreenArguments arguments;

  InquiryShareScreen(this.arguments);

  @override
  _InquiryShareScreenState createState() => _InquiryShareScreenState();
}

class _InquiryShareScreenState extends BaseState<InquiryShareScreen>
    with BasicScreen, WidgetsBindingObserver {
  InquiryBloc _inquiryBloc;
  InquiryShareModel inquiryShareModel;
  List<InquiryShareModel> arrinquiryShareModel = [];

  //CustomerSourceResponse _offlineCustomerSource;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  String _InQNo;
  List<InquirySharedEmpDetails> _arr_inquiry_share_emp_list=[];

  List<bool> _isChecked;
  bool isselected = false;
  GroupController controller = GroupController();

  List<String> OnlyEMPLIST=[];
  List<int> OnlyEMPLISTINT=[];
  ALL_EmployeeList_Response _offlineALLEmployeeListData;


  @override
  void initState() {
    super.initState();
    if (widget.arguments != null) {
      _arr_inquiry_share_emp_list.clear();
      _arr_inquiry_share_emp_list = widget.arguments.arr_inquiry_share_emp_list;
    }
    screenStatusBarColor = colorPrimaryLight;
    // _offlineCustomerSource= SharedPrefHelper.instance.getCustomerSourceData();
    _offlineALLEmployeeListData = SharedPrefHelper.instance.getALLEmployeeList();

    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _inquiryBloc = InquiryBloc(baseBloc);
   /* _inquiryBloc.add(FollowerEmployeeListCallEvent(FollowerEmployeeListRequest(
        CompanyId: CompanyID.toString(), LoginUserID: "admin")));*/
    _onFollowerEmployeeListByStatusCallSuccess(
        _offlineALLEmployeeListData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _inquiryBloc,
      child: BlocConsumer<InquiryBloc, InquiryStates>(
        builder: (BuildContext context, InquiryStates state) {
         /* if (state is FollowerEmployeeListByStatusCallResponseState) {
            _OnEmployeeFolllowerListSucessResponse(state);
          }*/

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {

          return false;
        },
        listener: (BuildContext context, InquiryStates state) {

           if (state is InquiryShareResponseState) {
            _OnInquiryShareSucessResponse(state);
          }
        },
        listenWhen: (oldState, currentState) {
          if(currentState is InquiryShareResponseState)
            {
              return true;

            }
          return false;
        },
      ),
    );
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
          child:Column(
            
    children: [
      Expanded(child: _buildProductList()),
      _buildSearchView(),

    ],
    )


        )),
      ],
    );
  }

  ///builds header and title view
  Widget _buildSearchView() {
    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Min. 3 chars to search Product",
            style: TextStyle(
                fontSize: 12,
                color: colorPrimary,
                fontWeight: FontWeight.bold)),
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
                    autofocus: true,
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
    );*/
    return getCommonButton(baseTheme,(){


      var value = arrinquiryShareModel.where((item) => item.ISCHECKED == false).length;

      if(value==arrinquiryShareModel.length)
        {
          showCommonDialogWithSingleOption(
              context, "Select Any One Employee to Share Inquiry!",
              positiveButtonTitle: "OK");
        }
      else{

        arrinquiryShareModel.removeWhere((item) => item.ISCHECKED == false);

        for(var i=0;i<arrinquiryShareModel.length;i++)
        {
          print("DDFDr"+ arrinquiryShareModel[i].EmployeeName + "Checked" + arrinquiryShareModel[i].ISCHECKED.toString());
        }
        _inquiryBloc.add(InquiryShareModelCallEvent(arrinquiryShareModel));
      }

     //

    },"Share Inquiry");

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
    InquiryShareModel model = arrinquiryShareModel[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(model);
        },
        child: CheckboxListTile(
          value: model.ISCHECKED == null ? false : model.ISCHECKED,
          onChanged: (value) {
            setState(
              () {
                model.ISCHECKED = value;
                arrinquiryShareModel[index] = model;
              },
            );
          },
          title: Text(model.EmployeeName),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),

        /*Card(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
            child: Row(
              children: <Widget>[
                 Expanded(child: new Text(model.EmployeeName)),
                 Checkbox(value: _isChecked, onChanged: (bool value) {
                  setState(() {
                    //_isChecked = value;
                    arrinquiryShareModel.indexWhere((element) => element.ISCHECKED == value);

                  });
                })
              ],
            )


          ),
          margin: EdgeInsets.only(top: 10),
        ),*/
      ),
    );
  }

  ///calls search list api
  void _onSearchChanged(String value) {
    if (value.trim().length > 2) {
      _inquiryBloc.add(InquiryProductSearchNameCallEvent(
          InquiryProductSearchRequest(
              pkID: "",
              CompanyId: CompanyID.toString(),
              ListMode: "L",
              SearchKey: value)));
    }
  }

  void _OnEmployeeFolllowerListSucessResponse(///API Response
      FollowerEmployeeListByStatusCallResponseState state) {
    arrinquiryShareModel.clear();
    OnlyEMPLIST.clear();
    OnlyEMPLISTINT.clear();
    for (var i = 0; i < state.response.details.length; i++) {
      inquiryShareModel = InquiryShareModel(
          LoginUserID,
          state.response.details[i].pkID.toString(),
          CompanyID.toString(),
          _InQNo,
          false,
          state.response.details[i].employeeName);

      arrinquiryShareModel.add(inquiryShareModel);
      OnlyEMPLIST.add(state.response.details[i].employeeName);
      OnlyEMPLISTINT.add(state.response.details[i].pkID);
    }

    _isChecked = List<bool>.filled(arrinquiryShareModel.length, false);
  }


  void _onFollowerEmployeeListByStatusCallSuccess(ALL_EmployeeList_Response offlineFollowerEmployeeListData) {
    arrinquiryShareModel.clear();

    String INQFFTNO = "";

    for(var i=0;i<_arr_inquiry_share_emp_list.length;i++)
      {
        INQFFTNO = _arr_inquiry_share_emp_list[i].inquiryNo;
      }

    for(var i=0;i<offlineFollowerEmployeeListData.details.length;i++)
      {

        int empID = offlineFollowerEmployeeListData.details[i].pkID;

        inquiryShareModel = InquiryShareModel(
            LoginUserID,
            empID.toString(),
            CompanyID.toString(),
            INQFFTNO,
            false,
            offlineFollowerEmployeeListData.details[i].employeeName);
        arrinquiryShareModel.add(inquiryShareModel);


        for(var i1=0;i1<_arr_inquiry_share_emp_list.length;i1++)
        {

          if(_arr_inquiry_share_emp_list[i1].employeeID == empID)
          {
            print("EMPIDDDD"+ " EmpListEMPID : " + "offlineFollowerEmployeeListData.details[i].pkID.toString()" + " InquiryShareEMPID : " + _arr_inquiry_share_emp_list[i1].employeeID.toString() );
            InquiryShareModel inquiryShareModel123 = InquiryShareModel(
                LoginUserID,
                empID.toString(),
                CompanyID.toString(),
                INQFFTNO,
                true,
                offlineFollowerEmployeeListData.details[i].employeeName);
            //arrinquiryShareModel.contains(inquiryShareModel.)
            arrinquiryShareModel.removeAt(i);
            arrinquiryShareModel.add(inquiryShareModel123);


          //  arrinquiryShareModel.contains(inquiryShareModel.ISCHECKED) ? arrinquiryShareModel[arrinquiryShareModel.indexWhere((v) => v.ISCHECKED == inquiryShareModel.ISCHECKED)] = inquiryShareModel123 : arrinquiryShareModel;

          }
         /* else {
            inquiryShareModel = InquiryShareModel(
                LoginUserID,
                empID.toString(),
                CompanyID.toString(),
                INQFFTNO,
                false,
                offlineFollowerEmployeeListData.details[i1].employeeName);
            break;
          }*/

          print("EMPIDDDD"+ " EmpListEMPID : " + "offlineFollowerEmployeeListData.details[i].pkID.toString()" + " InquiryShareEMPID : " + _arr_inquiry_share_emp_list[i1].employeeID.toString() );


        }






        //arrinquiryShareModel.add(inquiryShareModel);

      }




  }

  void _OnInquiryShareSucessResponse(InquiryShareResponseState state)  async {

    String msg = "";
    for(var i=0;i<state.inquiryShareResponse.details.length;i++)
      {
        msg = state.inquiryShareResponse.details[i].column2;
        print("ResultofAPIwww"+state.inquiryShareResponse.details[i].column2);

        if(msg=="")
          {
            msg = "Inquiry Shared SucessFully !";
          }
        await showCommonDialogWithSingleOption(Globals.context,msg,
            positiveButtonTitle: "OK");
        Navigator.of(context).pop();
        //Navigator.pop(context);
      }



  }
}
