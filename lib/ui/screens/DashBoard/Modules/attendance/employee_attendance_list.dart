import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soleoserp/blocs/other/bloc_modules/attendance_employee/attendance_bloc.dart';
import 'package:soleoserp/models/api_requests/attendance_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/attendance/employee_attandance_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceListScreen extends BaseStatefulWidget {
  static const routeName = '/attendancelistscreen';

  @override
  _AttendanceListScreenState createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends BaseState<AttendanceListScreen>
    with BasicScreen, WidgetsBindingObserver {
  AttendanceBloc _attendanceBloc;
  LoginUserDetialsResponse _offlineLoggedInData;
  CompanyDetailsResponse _offlineCompanyData;
  FollowerEmployeeListResponse _offlineFollowerEmployeeListData;

  List<ALL_Name_ID> _listFilteredDistrict = [];
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  DateTime selectedDate;
  bool isShowCardDetails = false;

  /*TextEditingController _eventControllerIn_Time;
  TextEditingController _eventControllerOut_Time;*/
  TextEditingController _eventControllerNotes;

  SharedPreferences prefs;

  //TimeOfDay selectedTime = TimeOfDay.now();
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Attendance_EmplyeeList = [];
  final TextEditingController edt_AttendanceEmployeeList =
      TextEditingController();
  final TextEditingController edt_AttendanceUSERID = TextEditingController();
  final TextEditingController edt_AttendanceEmployeeID =
      TextEditingController();
  final TextEditingController edt_DateFilter = TextEditingController();
  bool isvisible_Out_time = false;
  bool isEnableAddEdit = false;
  int CompanyID = 0;
  String LoginUserID = "";

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    edt_DateFilter.text = DateTime.parse(DateTime.now().toString()).toString();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _offlineFollowerEmployeeListData =
        SharedPrefHelper.instance.getFollowerEmployeeList();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _onAttendanceEmployeeListCallSuccess(_offlineFollowerEmployeeListData);

    screenStatusBarColor = colorPrimary;
    _attendanceBloc = AttendanceBloc(baseBloc);
    _controller = CalendarController();

    _events = {};
    _selectedEvents = [];
    prefsData();

    edt_AttendanceUSERID.text = LoginUserID;
    edt_AttendanceEmployeeList.text =
        _offlineLoggedInData.details[0].employeeName.toString();
    edt_AttendanceEmployeeID.text =
        _offlineLoggedInData.details[0].employeeID.toString();

    //edt_AttendanceEmployeeList.addListener(followerEmployeeList);
    edt_AttendanceUSERID.addListener(followerEmployeeList);

    getcurrentTimeInfo();
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _attendanceBloc
        ..add(AttendanceCallEvent(AttendanceApiRequest(
            pkID: "",
            EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
            Month: "",
            Year: "",
            CompanyId: CompanyID.toString(),
            LoginUserID: LoginUserID))),
      child: BlocConsumer<AttendanceBloc, AttendanceStates>(
        builder: (BuildContext context, AttendanceStates state) {
          if (state is AttendanceListCallResponseState) {
            _onInquiryListCallSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is AttendanceListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, AttendanceStates state) {},
        listenWhen: (oldState, currentState) {
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Attendance'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: colorWhite,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                  // showMonthYearePicker(context);
                })
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _attendanceBloc.add(AttendanceCallEvent(
                        AttendanceApiRequest(
                            pkID: "",
                            EmployeeID: _offlineLoggedInData
                                .details[0].employeeID
                                .toString(),
                            Month: "",
                            Year: "",
                            CompanyId:
                                _offlineCompanyData.details[0].pkId.toString(),
                            LoginUserID: LoginUserID)));
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        _buildEmplyeeListView(),
                        SizedBox(
                          height: 10,
                        ),

                        TableCalendar(
                          initialSelectedDay: DateTime.now(),
                          events: _events,
                          endDay: DateTime.now(),
                          weekendDays: [DateTime.sunday],
                          initialCalendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                              canEventMarkersOverflow: true,
                              todayColor: colorPrimary,
                              selectedColor: Theme.of(context).primaryColor,
                              todayStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white)),
                          headerStyle: HeaderStyle(
                            centerHeaderTitle: true,
                            formatButtonDecoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            formatButtonTextStyle:
                                TextStyle(color: Colors.white),
                            formatButtonShowsNext: false,
                          ),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (date, events, holidays) {
                            setState(() {
                              isEnableAddEdit = true;
                              _selectedEvents = events;

                              if (_selectedEvents.isNotEmpty) {
                                isvisible_Out_time = true;
                              } else {
                                isvisible_Out_time = false;
                              }

                              if (_offlineLoggedInData.details[0].roleCode ==
                                      'admin' ||
                                  _offlineLoggedInData.details[0].roleCode ==
                                      'hradmin') {
                                isEnableAddEdit = true;
                              } else {
                                String PresentDate = _controller
                                        .selectedDay.year
                                        .toString() +
                                    "-" +
                                    _controller.selectedDay.month.toString() +
                                    "-" +
                                    _controller.selectedDay.day.toString();
                                var now = new DateTime.now();
                                var formatter = new DateFormat('yyyy-MM-dd');
                                String currentday = formatter.format(now);
                                String PresentDate1 =
                                    formatter.format(_controller.selectedDay);

                                if (DateTime.parse(PresentDate1) ==
                                    (DateTime.parse(currentday))) {
                                  if (events.isNotEmpty) {
                                    if (events[1].toString().isNotEmpty) {
                                      isEnableAddEdit = false;
                                    } else {
                                      isEnableAddEdit = true;
                                    }
                                  }
                                } else {
                                  isEnableAddEdit = false;
                                }
                              }

                              // print("Hleodfpkk" + "dfdf : "+events[0].toString()+events[1].toString());
                            });
                          },
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: colorfullDay,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                            todayDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        /*color: colorfullDay,*/
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(
                                          color: colorfullDay,
                                          fontWeight: FontWeight.bold),
                                    )),
                            singleMarkerBuilder: (context, date, event) {
                              isvisible_Out_time = false;

                              for (var i = 0; i < event.length; i++) {
                                if (event[i].isNotEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorPrimary), //Change color
                                    width: 5.0,
                                    height: 5.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1.5),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                              return Container();
                            },
                          ),
                          calendarController: _controller,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: isvisible_Out_time,
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                    color: colorPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                        ),

                        Visibility(
                          visible: isvisible_Out_time,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 60),
                            child: Card(
                              elevation: 5,
                              color: colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "In-Time",
                                                    style: TextStyle(
                                                        color: colorPrimary,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      _selectedEvents.isNotEmpty
                                                          ? _selectedEvents[0]
                                                              .toString()
                                                          : "00:00",
                                                      style: TextStyle(
                                                          color: colorBlack,
                                                          fontSize: 12)),
                                                ]),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Out-Time",
                                                    style: TextStyle(
                                                        color: colorPrimary,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      _selectedEvents.isNotEmpty
                                                          ? _selectedEvents[1]
                                                              .toString()
                                                          : "00:00",
                                                      style: TextStyle(
                                                          color: colorBlack,
                                                          fontSize: 12)),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Notes ",
                                                style: TextStyle(
                                                    color: colorPrimary,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  _selectedEvents.isNotEmpty
                                                      ? _selectedEvents[2]
                                                          .toString()
                                                      : "N/A",
                                                  style: TextStyle(
                                                      color: colorBlack,
                                                      fontSize: 12)),
                                            ]),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),

                        // ..._selectedEvents.map((event) =>
                        //
                        //     Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Container(
                        //         height: MediaQuery.of(context).size.height / 20,
                        //         width: MediaQuery.of(context).size.width / 2,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(30),
                        //             color: Colors.white,
                        //             border: Border.all(color: Colors.grey)),
                        //         child: Center(
                        //             child: Text(
                        //           event.toString(),
                        //           style: TextStyle(
                        //               color: Colors.blue,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 16),
                        //         )),
                        //       ),
                        //     )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) =>
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            FloatingActionButton(
              backgroundColor: colorPrimary,
              onPressed: () {
                showMonthPicker(
                  context: context,
                  //firstDate: DateTime(DateTime.now().year - 1, 5),
                  lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now()
                          .month), //DateTime(DateTime.now().year + 1, 9),
                  initialDate: DateTime.now(),
                  locale: Locale("en"),
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      print("DatefromMonthPicker" +
                          DateTime.parse(date.toString()).toString());
                      selectedDate = date;
                      edt_DateFilter.text =
                          DateTime.parse(date.toString()).toString();
                      DateTime currentday = DateTime.now();
                      _controller.setSelectedDay(
                          DateTime(date.year, date.month, currentday.day),
                          runCallback: true);
                    });
                  }
                });
              },
              child: Icon(Icons.calendar_today),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isEnableAddEdit,
              child: FloatingActionButton(
                onPressed: _showAddDialog,
                child: const Icon(Icons.add),
                backgroundColor: colorPrimary,
              ),
            ),
          ]),
        ),
        drawer: build_Drawer(
            context: context, UserName: "KISHAN", RolCode: "Admin"),
      ),
    );
  }

  ///builds header and title view

  ///builds inquiry list

  ///updates data of inquiry list
  void _onInquiryListCallSuccess(AttendanceListCallResponseState state) async {
    // await Future.delayed(const Duration(seconds: 2), (){});
    _listFilteredDistrict.clear();

    //prefs.setString("events","");
    String DatePresent = "";
    _events.clear();
    for (var i = 0; i < state.response.details.length; i++) {
      print("AttendanceResponse" +
          "Response Attendance :" +
          state.response.details[i].presenceDate +
          " ParseDate : " +
          state.response.details[i].presenceDate.getFormattedDate(
              fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd") +
          " Notes : " +
          state.response.details[i].notes);
      if (state.response.details[i].timeIn.toString().isNotEmpty) {
        print("OnlyTimeIN" +
            " TimeIn : " +
            state.response.details[i].timeIn.toString());
      }
      if (state.response.details[i].timeOut.toString().isNotEmpty) {
        print("OnlyTimeout" +
            " Timeout : " +
            state.response.details[i].timeOut.toString());
      }
      _events[DateTime.parse(state.response.details[i].presenceDate)] = [
        state.response.details[i].timeIn.toString(),
        state.response.details[i].timeOut.toString(),
        state.response.details[i].notes.toString()
      ];

      prefs.setString("events", json.encode(encodeMap(_events)));
    }

    /*

      _controller.setSelectedDay(
          DateTime.now(),
          runCallback: true);

    */

    for (var i = 0; i < _events.length; i++) {
      print("Dayseventfromapi" + " :- DaysEvents :" + _events.toString());
    }
  }

  FillDatafromAPI() {
    if (_listFilteredDistrict != null) {
      for (var i = 0; i < _listFilteredDistrict.length; i++) {
        print("KSJKDJD" +
            "Response Attendance :" +
            _listFilteredDistrict[i].PresentDate);

        // prefs.setString("events", json.encode(encodeMap(_events)));
      }
    }
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  void _showAddDialog() {
    String PresentDate = _controller.selectedDay.year.toString() +
        "-" +
        _controller.selectedDay.month.toString() +
        "-" +
        _controller.selectedDay.day.toString();
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String currentday = formatter.format(now);
    String PresentDate1 = formatter.format(_controller.selectedDay);

    print("_SelectedDaysEvent34" +
        " Events : " +
        _selectedEvents.toString() +
        " SelectedEventDaysss  : " +
        PresentDate);

    if (_offlineLoggedInData.details[0].roleCode == 'admin' ||
        _offlineLoggedInData.details[0].roleCode == 'hradmin') {
      navigateTo(context, AttendanceAdd_EditScreen.routeName,
              arguments: AddUpdateAttendanceArguments(
                  _selectedEvents, edt_AttendanceEmployeeID.text, PresentDate))
          .then((value) {
        _attendanceBloc
          ..add(AttendanceCallEvent(AttendanceApiRequest(
              pkID: "",
              EmployeeID: _offlineLoggedInData.details[0].employeeID.toString(),
              Month: "",
              Year: "",
              CompanyId: CompanyID.toString(),
              LoginUserID: LoginUserID)));

        if (value != null) {
          _selectedEvents = value;
        }
        _events[_controller.selectedDay] = [_selectedEvents];
        prefs.setString("events", json.encode(encodeMap(_events)));

        print("CustomerInfoEventss : " + _selectedEvents.toString());
      });
    } else {
      print("CustomerInfoEventss123 : " +
          DateTime.parse(PresentDate1).toString() +
          " OtherDate : " +
          DateTime.parse(currentday)
              .toString()); //.compareTo(DateTime.now()).toString());

      // print("CustomerInfoujil : " + " 1 : "+_selectedEvents[0] +" 2 : " +_selectedEvents[1]);//.compareTo(DateTime.now()).toString());

      if (DateTime.parse(PresentDate1) == (DateTime.parse(currentday))) {
        navigateTo(context, AttendanceAdd_EditScreen.routeName,
                arguments: AddUpdateAttendanceArguments(_selectedEvents,
                    edt_AttendanceEmployeeID.text, PresentDate))
            .then((value) {
          _attendanceBloc
            ..add(AttendanceCallEvent(AttendanceApiRequest(
                pkID: "",
                EmployeeID:
                    _offlineLoggedInData.details[0].employeeID.toString(),
                Month: "",
                Year: "",
                CompanyId: CompanyID.toString(),
                LoginUserID: LoginUserID)));

          if (value != null) {
            _selectedEvents = value;
          }
          _events[_controller.selectedDay] = [_selectedEvents];
          prefs.setString("events", json.encode(encodeMap(_events)));

          print("CustomerInfoEventss : " + _selectedEvents.toString());
        });
      }
    }
  }

  void _onAttendanceEmployeeListCallSuccess(
      FollowerEmployeeListResponse state) {
    arr_ALL_Name_ID_For_Attendance_EmplyeeList.clear();
    if (state.details != null) {
      for (var i = 0; i < state.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].employeeName;
        all_name_id.Name1 = state.details[i].userID;
        all_name_id.pkID = state.details[i].pkID;

        arr_ALL_Name_ID_For_Attendance_EmplyeeList.add(all_name_id);
      }
    }
  }

  Widget _buildEmplyeeListView() {
    return InkWell(
      onTap: () {
        // _onTapOfSearchView(context);
        showcustomdialogWithMultipleID(
            values: arr_ALL_Name_ID_For_Attendance_EmplyeeList,
            context1: context,
            controller: edt_AttendanceEmployeeList,
            controllerID: edt_AttendanceEmployeeID,
            controller2: edt_AttendanceUSERID,
            lable: "Select Employee");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Select Employee",
                  style: TextStyle(
                      fontSize: 12,
                      color: colorPrimary,
                      fontWeight: FontWeight
                          .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                  ),
              Icon(
                Icons.filter_list_alt,
                color: colorPrimary,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            Card(
              elevation: 5,
              color: colorLightGray,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                // padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
                width: double.maxFinite,
                child: Row(
                  children: [
                    Expanded(
                      child: /* Text(
                          SelectedStatus =="" ?
                          "Tap to select Status" : SelectedStatus.Name,
                          style:TextStyle(fontSize: 12,color: Color(0xFF000000),fontWeight: FontWeight.bold)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),*/

                          TextField(
                        controller: edt_AttendanceEmployeeList,
                        onChanged: (value) {
                          _attendanceBloc.add(AttendanceCallEvent(
                              AttendanceApiRequest(
                                  pkID: "",
                                  EmployeeID: value,
                                  Month: "",
                                  Year: "",
                                  CompanyId: CompanyID.toString(),
                                  LoginUserID: LoginUserID)));
                        },
                        enabled: false,
                        style: TextStyle(fontSize: 15),
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Select",
                        ),
                      ),
                      // dropdown()
                    ),
                    /*  Icon(
                      Icons.arrow_drop_down,
                      color: colorGrayDark,
                    )*/
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  followerEmployeeList() {
    print(
        "CurrentEMP Text is ${edt_AttendanceEmployeeList.text + " USERID : " + edt_AttendanceUSERID.text + " EmployeeID : " + edt_AttendanceEmployeeID.text}");
    _attendanceBloc.add(AttendanceCallEvent(AttendanceApiRequest(
        pkID: "",
        EmployeeID: edt_AttendanceEmployeeID.text,
        Month: "",
        Year: "",
        CompanyId: CompanyID.toString(),
        LoginUserID: LoginUserID)));
    setState(() {});
  }

  void showMonthYearePicker() {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: DateTime.now(),
      locale: Locale("en"),
    ).then((date) {
      if (date != null) {
        setState(() {
          //selectedDate = date;
        });
      }
    });
  }

  isSameDay(DateTime day, DateTime parse) {
    if (day == parse) {
      return true;
    } else {
      return true;
    }
  }

  Widget showticker(List<String> strArr) {
    if (strArr.length != null) {
      for (var i = 0; i < strArr.length; i++) {
        print("markerevent" + strArr[i].isNotEmpty.toString());

        if (strArr[i].isNotEmpty) {
          return Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: colorPrimary), //Change color
            width: 5.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
          );
        } else {
          return Container();
        }
      }
    } else {
      return Container();
    }
  }

  void getcurrentTimeInfo() async {
    DateTime startDate = await NTP.now();
    print('NTP DateTime: ${startDate} ${DateTime.now()}');
  }
}
