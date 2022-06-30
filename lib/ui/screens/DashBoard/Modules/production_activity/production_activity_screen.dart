
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/production_activity/production_activity_bloc.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_delete_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';

import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_list_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/production_activity/production_activity_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';


class ProductionDate {
  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  ProductionDate(this.controller1,this.controller2,this.controller3);
}

class ProductionActivityListScreen extends BaseStatefulWidget {
  static const routeName = '/ProductionActivityListScreen';
  ProductionDate arguments;
  ProductionActivityListScreen(this.arguments);

  @override
  _ProductionActivityListScreenState createState() => _ProductionActivityListScreenState();
}
class _ProductionActivityListScreenState extends BaseState<ProductionActivityListScreen>
    with BasicScreen,WidgetsBindingObserver {

  ProductionActivityBloc productionActivityBloc;
  int pageno = 0;
  int selected= 0;
  ProductionActivityResponse Response;
  double _fontSize_Title = 11;
  double _fontSize_Label = 9;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  DateTime selectdate = DateTime.now();
  TimeOfDay selecttime = TimeOfDay.now();
  TextEditingController date = TextEditingController();
  TextEditingController reversedate = TextEditingController();
  TextEditingController initialdate = TextEditingController();
  TextEditingController employeename = TextEditingController();
  TextEditingController employeeid = TextEditingController();
  TextEditingController requiredate = TextEditingController();
  List<ALL_Name_ID>employee = [];
  double count=0 ;
  String EmployeeName;
  String EmployeeID;
  int Count;
  double Total=0;
  bool MainDate = false;


  bool _isExist;


  @override
  void initState() {
    super.initState();
   if(widget.arguments==null){
     MainDate = false;
   }else if(widget.arguments!=null){
     MainDate = true;
   }else{}

    productionActivityBloc = ProductionActivityBloc(baseBloc);
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    employeename.text = _offlineLoggedInData.details[0].employeeName;
    employeeid.text = _offlineLoggedInData.details[0].employeeID.toString();
    employeename.text = EmployeeName;
    date.text = selectdate.day.toString() + "-" + selectdate.month.toString() + "-" + selectdate.year.toString();
    reversedate.text = selectdate.year.toString() + "-" + selectdate.month.toString() + "-" + selectdate.day.toString();
    initialdate.text = selectdate.year.toString() + "-" + selectdate.month.toString() + "-" + selectdate.day.toString();
    if(MainDate){
      requiredate = widget.arguments.controller1;
      employeeid = widget.arguments.controller2;
      employeename = widget.arguments.controller3;
      date.text = requiredate.text;
      reversedate.text = requiredate.text.getFormattedDate(fromFormat: "dd-MM-yyyy", toFormat: "yyyy-MM-dd");

    }
    employeeid.addListener(ProductionActivityListener);
    reversedate.addListener(ProductionActivityListener);
    _isExist = false;

  }
  ProductionActivityListener() {
    Total = 0;
    if (employeeid != null || reversedate != null) {
      productionActivityBloc.add(ProductionActivityListCallEvent(1,
          ProductionActivityRequest(CompanyId: this.CompanyID.toString(),
              LoginUserID: this.LoginUserID,
              ActivityDate: reversedate.text,
              EmployeeID: employeeid.text)));
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      productionActivityBloc..add(ProductionActivityListCallEvent(pageno+1,ProductionActivityRequest(CompanyId: this.CompanyID.toString(),LoginUserID: this.LoginUserID,ActivityDate: reversedate.text,EmployeeID:employeeid.text))),
      child: BlocConsumer<ProductionActivityBloc, ProductionActivityListState>(
        builder: (BuildContext context, ProductionActivityListState state) {
          if (state is ProductionActivityListCallResponseState) {

            packingchecklistsuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is ProductionActivityListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, ProductionActivityListState state) {
          if (state is ProductionActivityListCallResponseState) {

            _datesuccess(state);
          }
          if(state is EmployeeCallResponseState){
            _ontapofselectemployee(state);
          }
          if(state is ProductionActivityDeleteCallResponseState){
            _ontapofdelete(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is ProductionActivityListCallResponseState||
              currentState is EmployeeCallResponseState||
              currentState is ProductionActivityDeleteCallResponseState
          ) {
            return true;
          }
          return false;
        },
      ),    );
  }

  @override
  Widget buildBody(BuildContext context) {
   return WillPopScope(

      onWillPop: () {
        navigateTo(context, HomeScreen.routeName, clearAllStack: true);
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: NewGradientAppBar(
          gradient: LinearGradient(
            colors: [Colors.red,Colors.purple,Colors.blue],
          ),
          title: Text("Production Activity"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                })
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                child:RefreshIndicator(
                  onRefresh: ()async{
                    reversedate.clear();
                    employeename.text =  _offlineLoggedInData.details[0].employeeName.toString();
                    employeeid.text = _offlineLoggedInData.details[0].employeeID.toString();
                    reversedate.text = initialdate.text;
                    date.text = initialdate.text.getFormattedDate(fromFormat: "yyyy-MM-dd", toFormat: "dd-MM-yyyy");
                    setState(() {
                      _ondatesuccess();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: Column(
                      children: [
                        
                        _buildname(),
                        _buildSearchView(),
                        SizedBox(height: 10,),
                        Expanded(child:_buildInquiryList()),



                      ],
                    ),

                  ),),
              ),
              /*Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(bottom: 10),
                child: FloatingActionButton(
                  onPressed: ()  {
                    // Add your onPressed code here!
                    navigateTo(context, ProductionActivityAdd.routeName);
                  },
                  child: const Icon(Icons.add),
                  backgroundColor: colorPrimary,
                ),
              ),*/
              _buildCount(),
            ],
          ),
        ),

        floatingActionButton:FloatingActionButton(
          onPressed: ()  {
            // Add your onPressed code here!
            print(date);

            navigateTo(context, ProductionActivityAdd.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
        bottomSheet: Padding(padding: EdgeInsets.only(bottom: 80)),

        drawer: build_Drawer(
            context: context,
            UserName: "",
            RolCode: ""),
      ),
    );
  }


  void packingchecklistsuccess(ProductionActivityListCallResponseState state) {

        Response = state.response;

           count = 0;
           Total = 0;
          for(int i=0;i<state.response.details.length;i++){
            count=state.response.details[i].taskDuration;
            Total = Total +count;
          }
        if(Response.details.length!=0){
          _isExist = true;
        }else if(Response.details.length==0){
          _isExist = false;
        }



  }
  Widget _buildInquiryList() {

    if(_isExist){return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (shouldPaginate(
          scrollInfo,
        )
        ){
          _onPackingCheckListPagination();
          return true;
        } else {
          return false;
        }
      },
      child: ListView.builder(
        key: Key('selected $selected'),

        itemBuilder: (context, index) {
          return _buildCustomerList(index);
        },
        shrinkWrap: true,
        itemCount: Response.details.length,
      ),
    );}
    else if(!_isExist){
      return Container(
        alignment: Alignment.center,
          child:   Lottie.asset(
             NO_SEARCH_RESULT_FOUND,
              height: 150,
              width: 150,
          ),
      );
    }
  }

  ///builds row item view of inquiry list
  Widget _buildCustomerList(int index) {
    return ExpantionCustomer(context,index);

  }
  void _onPackingCheckListPagination() {
    productionActivityBloc.add(ProductionActivityListCallEvent(pageno + 1,ProductionActivityRequest(CompanyId: this.CompanyID.toString(),LoginUserID: this.LoginUserID,ActivityDate: reversedate.text,EmployeeID:employeeid.text)));
  }

  Widget ExpantionCustomer(BuildContext context, int index) {
    ProductionActivityDetails p = Response.details[index];


      return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: ExpansionTileCard(
            initialElevation: 5.0,
            elevation: 5.0,
            elevationCurve: Curves.easeInOut,
            shadowColor: Color(0xFF504F4F),
            baseColor: Color(0xFFFCFCFC),
            expandedColor: Color(0xFFC1E0FA),
            //Colors.deepOrange[50],ADD8E6
            leading: CircleAvatar(
                backgroundColor: Color(0xFF504F4F),
                child: /*Image.asset(IC_USERNAME,height: 25,width: 25,)*/ Image
                    .network(
                  "http://demo.sharvayainfotech.in/images/profile.png",
                  height: 35,
                  fit: BoxFit.fill,
                  width: 35,
                )),
            title: Text(
              p.createdEmployeeName.toString(),
              style: TextStyle(color: Colors.black), //8A2CE2)),
            ),
            subtitle:Text(
              "TaskDuration : "+p.taskDuration.toString(),
              style: TextStyle(color: Colors.black), //8A2CE2)),
            ) ,

            children: [
              Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[


                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(

                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Name",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),

                                          Text(
                                              p.createdEmployeeName == ""
                                                  ? "N/A"
                                                  :  p.createdEmployeeName ,
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),
                                  SizedBox(width: 10,),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Work Hours",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              p.taskDuration.toString() == null
                                                  ? "N/A"
                                                  : p.taskDuration.toString(),
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),
                                ]),
                            SizedBox(
                              height: sizeboxsize,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Work Category",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              p.taskCategoryName == ""
                                                  ? "N/A"
                                                  : p.taskCategoryName,
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Work Status",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              p.status == null
                                                  ? "N/A"
                                                  :  p.status,
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),

                                ]),
                            SizedBox(
                              height: sizeboxsize,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Work Notes",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              p.taskDescription == ""
                                                  ? "N/A"
                                                  :  p.taskDescription,
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text("PackingList No",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(label_color),
                                                  fontSize: _fontSize_Label,
                                                  letterSpacing: .3)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              p.pCno== null
                                                  ? "N/A"
                                                  :  p.pCno,
                                              style: TextStyle(
                                                  color: Color(title_color),
                                                  fontSize: _fontSize_Title,
                                                  letterSpacing: .3)),
                                        ],
                                      )),

                                ]),




                          ],
                        ),
                      ),
                    ],
                  )),

              SizedBox(
                height: 20,
              ),
              ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        _onTapOfEditProduction(p);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                            color: colorPrimary,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Edit',
                            style: TextStyle(color: colorPrimary),
                          ),
                        ],
                      ),
                    ),

                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        _onTapOfDeleteActivitymain(p.pkID);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: colorPrimary,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: colorPrimary),
                          ),
                        ],
                      ),
                    )


                  ]),
              SizedBox(height: 10,),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );


  }
  Widget _buildSearchView() {
    return Container(
      child: Row(

        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                productionActivityBloc.add(EmployeeCallEvent(
                    InstallationEmployeeRequest(CompanyId: this.CompanyID.toString())));
              },
              child: Container(
                child: Card(
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
                          child: TextField(
                            controller: employeename,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            enabled: false,

                            //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                            decoration: InputDecoration(
                              //hintText: "Tap to Enter Area",
                              labelStyle: TextStyle(
                                color: Color(0xFF000000),
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF000000),
                            ), // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: colorGrayDark,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _selectDate(context, date);
              },
              child: Container(
                child: Card(
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
                          child: TextField(
                            controller: date,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            enabled: false,

                            //onSubmitted: (_) => FocusScope.of(context).requestFocus(myFocusNode),
                            decoration: InputDecoration(
                              //hintText: "Tap to Enter Area",
                              labelStyle: TextStyle(
                                color: Color(0xFF000000),
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF000000),
                            ), // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.calendar_today,
                            color: colorGrayDark,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildname() {
    return Container(
       child:Row(
         children: [
                    Expanded(
                      child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: Text("Select Employee",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
             child: Container(
               alignment: Alignment.topLeft,
               margin: EdgeInsets.only(left: 10),
               child: Text("Select Date",
                   style: TextStyle(
                       fontSize: 12,
                       color: colorPrimary,
                       fontWeight: FontWeight.bold)),
             ),
           ),
                  ],
       ),
    );
 }
  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: DateTime(2001, 2),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectdate)
      setState(() {
        selectdate = picked;
        date.text = selectdate.day.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.year.toString();
        reversedate.text = selectdate.year.toString() +
            "-" +
            selectdate.month.toString() +
            "-" +
            selectdate.day.toString();
      });
  }
  void _ondatesuccess(){
     Total = 0;
    productionActivityBloc.add(ProductionActivityListCallEvent(1,ProductionActivityRequest(CompanyId:this.CompanyID.toString(),LoginUserID: this.LoginUserID,ActivityDate: reversedate.text,EmployeeID:employeeid.text)));
  }

  void _datesuccess(ProductionActivityListCallResponseState state) {
    Response = state.response;
  }

  void _onTapOfEditProduction(ProductionActivityDetails model) {


    navigateTo(context, ProductionActivityAdd.routeName,
        arguments: ProductionActivityEditArguments(model))
        .then((value) {
      ProductionActivityDetails DT = value;
      date.text = DT.activityDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss",
          toFormat: "dd-MM-yyyy");

      productionActivityBloc..add(ProductionActivityListCallEvent(1,ProductionActivityRequest(CompanyId:this.CompanyID.toString(),LoginUserID: this.LoginUserID,ActivityDate:reversedate.text,EmployeeID:employeeid.text )));

    });
  }
  void _ontapofselectemployee(EmployeeCallResponseState state) {

    employee.clear();
    for(int i=0;i<state.response.details.length;i++){
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.response.details[i].employeeName;
      all_name_id.pkID = state.response.details[i].pkID;
      employee.add(all_name_id);
    }
    showcustomdialogWithID(
        values: employee,
        context1: context,
        controller: employeename,
        controllerID: employeeid,
        lable: "Select Employee");
  }
  void _onTapOfDeleteActivitymain(int id) {
    print("CUSTID" + id.toString());
    showCommonDialogWithTwoOptions(
        context, "Are you sure you want to delete this Customer?",
        negativeButtonTitle: "No",
        positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
      Navigator.of(context).pop();
      productionActivityBloc.add(ProductionActivityDeleteCallEvent(id,ProductionActivityDeleteRequest(CompanyId: this.CompanyID.toString())));
    });
  }

  void _ontapofdelete(ProductionActivityDeleteCallResponseState state) {
    showCommonDialogWithSingleOption(context,state.response.details[0].column1);
    productionActivityBloc.add(ProductionActivityListCallEvent(1,ProductionActivityRequest(CompanyId:this.CompanyID.toString(),LoginUserID: this.LoginUserID,ActivityDate: reversedate.text,EmployeeID:employeeid.text)));
  }
Widget _buildCount(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 40,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: colorPrimary,
          ),
          child: Row(

            children: [
              Container(
                margin: EdgeInsets.only(left: 15,top: 3),
                child: Icon(Icons.timer_outlined,
                color: Colors.white,
                size: 17,),
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text("Total Task Duration\t:",
                style: TextStyle(
                  fontFamily: "Poppins_Regular",
                  fontSize: 17,
                  color: Colors.white,
                ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  Total.toStringAsFixed(2),
                  style: TextStyle(
                      fontFamily: "Poppins_Regular",
                      fontSize: 17,
                      color: Colors.white,

                    ),
                  ),
              ),


            ],
          ),
        ),
      ],
    );

}


}

