import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/production_activity/production_activity_bloc.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/productionActivity_save_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_packing_list_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/typeofwork_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/productionActivity_save_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_list_response.dart';

import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/production_activity/production_activity_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
class ProductionActivityEditArguments{
  ProductionActivityDetails editDetails;
  ProductionActivityEditArguments(this.editDetails);
}

class ProductionActivityAdd extends BaseStatefulWidget {
  static const routeName = '/ProductionActivityAdd';
  final ProductionActivityEditArguments arguments;
  ProductionActivityAdd(this.arguments);


   @override
  _ProductionActivityAddState createState() => _ProductionActivityAddState();
}
class _ProductionActivityAddState extends BaseState<ProductionActivityAdd> with WidgetsBindingObserver,BasicScreen {
  ProductionActivityBloc productionActivityBloc;
  double height = 50;
  double circular = 8;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";
  DateTime selectdate = DateTime.now();
  TimeOfDay selecttime = TimeOfDay.now();
  List<ALL_Name_ID>status = [];
  List<ALL_Name_ID>typeofwork = [];
  List<ALL_Name_ID>employee = [];
  List<ALL_Name_ID>packinglist = [];
  bool _isTapped;
  ProductionActivityDetails _editmodel;
  int savePkid=0;


  TextEditingController employeename = TextEditingController();
  TextEditingController packingno = TextEditingController();
  TextEditingController employeeid = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController productionstatus = TextEditingController();
  TextEditingController work = TextEditingController();
  TextEditingController hour = TextEditingController();
  TextEditingController workid = TextEditingController();
  TextEditingController reversedate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    date.text = selectdate.day.toString() + "-" + selectdate.month.toString() + "-" + selectdate.year.toString();
    reversedate.text = selectdate.year.toString() + "-" + selectdate.month.toString() + "-" + selectdate.day.toString();
    productionActivityBloc = ProductionActivityBloc(baseBloc);
    _isTapped = widget.arguments!=null;
    if(_isTapped){
      _editmodel = widget.arguments.editDetails;
      fillData();
    }else{}

  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => productionActivityBloc,
      child: BlocConsumer<ProductionActivityBloc, ProductionActivityListState>(
        builder: (BuildContext context, ProductionActivityListState state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, ProductionActivityListState state) {

          if(state is ProductionActivityTypeofWorkCallResponseState){
            _ontapoftypeofwork(state);
          }
          if(state is EmployeeCallResponseState){
            _ontapofselectemployee(state);
          }
          if(state is PackingListCallResponseState){
            _ontapofselectpackinglist(state);
          }
          if(state is ProductionActivitySaveCallResponseState){
            _ontapofsaveactivity(state);
          }

          return super.build(context);

        },
        listenWhen: (oldState, currentState) {
          if(
          currentState is ProductionActivityTypeofWorkCallResponseState ||
              currentState is EmployeeCallResponseState  ||
              currentState is PackingListCallResponseState ||
              currentState is ProductionActivitySaveCallResponseState
          ){
            return true;
          }

          return false;
        },
      ),
    );
  }


  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.purple, Colors.blue],
        ),
        title: Text(
          "Production Activity",
          style: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Select Employee*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  productionActivityBloc.add(EmployeeCallEvent(
                      InstallationEmployeeRequest(CompanyId: this.CompanyID.toString())));
                },
                child:Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
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
                              decoration: InputDecoration(
                                hintText: "Select Employee",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ), //Inward
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Packing List",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  productionActivityBloc.add(PackingListCallEvent(
                      ProductionPackingListRequest(CompanyId: this.CompanyID.toString())));
                },
                child:Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: packingno,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Select Packing List",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),  //inwarddate
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Select Date*",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            InkWell(
              onTap: () {
                _selectDate(context, date);
              },
              child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      _selectDate(context, date);
                    },
                    child: Card(
                      elevation: 5,
                      color: colorLightGray,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: height,
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
                                  decoration: InputDecoration(
                                    hintText: "DD-MM-YYYY",
                                    labelStyle: TextStyle(
                                      color: Color(0xFF000000),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF000000),
                                  ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                              ),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: colorGrayDark,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ), //sn
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Work Notes *",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 100,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                elevation: 5,
                color: colorLightGray,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 20, right: 20,top: 10),

                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: TextField(
                              controller: notes,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Tap to Work Notes",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF000000),
                            ) // baseTheme.textTheme.headline2.
                              ),
                          ),
                        ),

                    ],
                  ),
                ),
              ),
            ), //customername
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(left: 23),
                child: Text("Type of Work",
                    style: TextStyle(
                        fontSize: 12,
                        color: colorPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  productionActivityBloc.add(ProductionActivityTypeofWorkCallEvent(
                      TypeOfWorkRequest(pkID: "",CompanyId: this.CompanyID.toString())));
                },
                child:Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              controller: work,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Select Work",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),//basicammount
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 20,right: 10),
              child: Row(children: [
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      //margin: EdgeInsets.only(left: 23),
                      child: Text("Hours",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(

                    child: Container(

                      child: Text("Production Status",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorPrimary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ]),
            ), //heading
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: InkWell(
                        onTap: (){
                        },
                        child: Card(
                          elevation: 5,
                          color: colorLightGray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            height: height,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: hour,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        //hintText: "DD-MM-YYYY",
                                        labelStyle: TextStyle(
                                          color: Color(0xFF000000),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF000000),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: (){
                        status.clear();
                        for (int i = 0; i < 2; i++) {
                          ALL_Name_ID st = ALL_Name_ID();
                          if (i == 0) {
                            st.Name = "In Process";
                          }
                          if (i == 1) {
                            st.Name = "Completed";
                          }
                          status.add(st);
                        }
                        showcustomdialogWithOnlyName(
                            values: status,
                            context1: context,
                            controller: productionstatus,
                            lable: "Types of Status");
                      },
                      child: Card(
                        elevation: 5,
                        color: colorLightGray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          height: height,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: productionstatus,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: "Select Status",
                                      labelStyle: TextStyle(
                                        color: Color(0xFF000000),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF000000),
                                    ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: colorGrayDark,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(colorPrimary),
                ),
                onPressed: (){
                  _ontapofsave();
                },
                child:Text("Save",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 18,
                    color: colorWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
  void _ontapofsave() {
   if(employeename.text==""){
     showCommonDialogWithSingleOption(context,"Select Employee");
   }
   else if(packingno.text==""){
     showCommonDialogWithSingleOption(context,"Select Packing No");
   }
   else if(reversedate.text==""){
     showCommonDialogWithSingleOption(context,"Select Date");
   }
   else if(notes.text==""){
     showCommonDialogWithSingleOption(context,"Fill Work Notes");
   }
   else if(work.text==""){
     showCommonDialogWithSingleOption(context,"Select Type of Work");
   }
   else if(hour.text==""){
     showCommonDialogWithSingleOption(context,"Fill Hours");
   }
   else if(productionstatus.text==""){
     showCommonDialogWithSingleOption(context,"Select Production Status");
   }
   else{productionActivityBloc.add(ProductionActivitySaveCallEvent(savePkid,
       SaveProductionActivityRequest(
         ActivityDate: reversedate.text,
         TaskCategoryID: workid.text,
         TaskDescription: notes.text,
         TaskDuration: hour.text,
         Status: productionstatus.text,
         LoginUserID: this.LoginUserID,
         CompanyId: this.CompanyID.toString(),
         PCNo: packingno.text,
       )));}


  }

  void _ontapoftypeofwork(ProductionActivityTypeofWorkCallResponseState state) {
      typeofwork.clear();
      print("Second Time");
      for(int i=0;i<state.response.details.length;i++){
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.response.details[i].taskCategoryName;
        all_name_id.pkID = state.response.details[i].pkID;
        typeofwork.add(all_name_id);
      }
   showcustomdialog(
     values: typeofwork,
     context1: context,
     controller:work,
     controller2:workid,
     lable: "Select Type of Work"
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
  void _ontapofselectemployee(EmployeeCallResponseState state) {
    employee.clear();
    print("Second Time");
    for(int i=0;i<state.response.details.length;i++){
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.response.details[i].employeeName;
      all_name_id.pkID = state.response.details[i].pkID;
      employee.add(all_name_id);
    }
    showcustomdialog(
        values: employee,
        context1: context,
        controller: employeename,
        controller2: employeeid,
        lable: "Select Employee");
  }

  void _ontapofselectpackinglist(PackingListCallResponseState state) {
    packinglist.clear();
    for(int i=0;i<state.response.details.length;i++){
      ALL_Name_ID all_name_id = ALL_Name_ID();
      all_name_id.Name = state.response.details[i].pCNo;
      packinglist.add(all_name_id);
    }
    showcustomdialogWithOnlyName(
      values: packinglist,
      context1: context,
      controller: packingno,
      lable: "Select Packing List",
    );
  }

  void _ontapofsaveactivity(ProductionActivitySaveCallResponseState state) {
    ProductionActivitySaveDetails saveresponse = state.response.details[0];
    showCommonDialogWithSingleOption(context,saveresponse.column2,
    onTapOfPositiveButton: (){
      ontapofok(date,employeeid,employeename);
    }
    );
  }


  void fillData() async {
    employeename.text=_editmodel.createdEmployeeName.toString();
    employeeid.text = _editmodel.createdEmployeeID.toString();
    packingno.text=_editmodel.pCno.toString();
    date.text=_editmodel.activityDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "dd-MM-yyyy");
    reversedate.text=_editmodel.activityDate.getFormattedDate(
        fromFormat: "yyyy-MM-ddTHH:mm:ss",
        toFormat: "yyyy-MM-dd");
    notes.text=_editmodel.taskDescription.toString();
    work.text=_editmodel.taskCategoryName.toString();
    workid.text=_editmodel.taskCategoryID.toString();
    hour.text=_editmodel.taskDuration.toString();
    productionstatus.text=_editmodel.status.toString();
    savePkid = _editmodel.pkID;

  }

  void ontapofok(TextEditingController IN_Date,TextEditingController IN_Id,TextEditingController IN_Name) {
    navigateTo(context, ProductionActivityListScreen.routeName,
    arguments: ProductionDate(IN_Date,IN_Id,IN_Name)
    );
  }
}
