import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/attendance_employee/attendance_bloc.dart';
import 'package:soleoserp/models/api_requests/attendance_save_request.dart';
import 'package:soleoserp/models/api_requests/location_address_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';
import 'package:geolocator/geolocator.dart' as geolocator; // or whatever name you want
import 'package:http/http.dart' as http;

import 'employee_attendance_list.dart';

class AddUpdateAttendanceArguments {
  // SearchDetails editModel;

  List<dynamic> selectedEvents = [];
  String EmployeeID = "";
  String PresentDate = "";

  AddUpdateAttendanceArguments(
      this.selectedEvents, this.EmployeeID, this.PresentDate);
}

class AttendanceAdd_EditScreen extends BaseStatefulWidget {
  static const routeName = '/AttendanceAdd_EditScreen';
  final AddUpdateAttendanceArguments arguments;

  AttendanceAdd_EditScreen(this.arguments);

  @override
  _AttendanceAdd_EditScreenState createState() =>
      _AttendanceAdd_EditScreenState();
}

class _AttendanceAdd_EditScreenState extends BaseState<AttendanceAdd_EditScreen>
    with BasicScreen, WidgetsBindingObserver {
  AttendanceBloc _FollowupBloc;
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _eventControllerIn_Time;
  TextEditingController _eventControllerOut_Time;
  TextEditingController _eventControllerNotes;

  bool _isForUpdate;
  List<dynamic> _selectedEvents = [];
  String _EmployeeID = "";
  String _PresentDate = "";
  bool isvisible_Out_time = false;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  void showToast() {
    setState(() {
      isvisible_Out_time = !isvisible_Out_time;
    });
  }

  String Address;
  String Latitude;
  String Longitude;

  DateTime selectedDate = DateTime.now();
  Location location = new Location();
  bool _serviceEnabled;
  LocationData _locationData;
  bool is_LocationService_Permission;
  Position _currentPosition;
  final Geolocator geolocator123 = Geolocator()..forceAndroidLocationManager;



  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    checkPermissionStatus();

    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _FollowupBloc = AttendanceBloc(baseBloc);
    _eventControllerIn_Time = TextEditingController();
    _eventControllerNotes = TextEditingController();

    _eventControllerOut_Time = TextEditingController();
    /*
  if (_isForUpdate !=null)
  {
      _selectedEvents = widget.arguments.selectedEvents;
      fillData();
  }
  */
    _selectedEvents = widget.arguments.selectedEvents;
    _EmployeeID = widget.arguments.EmployeeID;
   // _PresentDate =

    _PresentDate = selectedDate.year.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.day.toString();

    _PresentDate = widget.arguments.PresentDate;

    fillData();
    //saveDetails();

  }

  void checkPermissionStatus() async {


    bool granted = await Permission.location.isGranted;
    bool Denied = await  Permission.location.isDenied;
    bool PermanentlyDenied = await Permission.location.isPermanentlyDenied;

    print("PermissionStatus" + "Granted : "+   granted.toString()  + " Denied : " + Denied.toString() + " PermanentlyDenied : " + PermanentlyDenied.toString() );

    if (Denied==true) {
      // openAppSettings();
      is_LocationService_Permission=false;
      showCommonDialogWithSingleOption(
          context, "Location permission is required , You have to click on OK button to Allow the location access !",
          positiveButtonTitle: "OK",
          onTapOfPositiveButton: () async {
            await openAppSettings();
            Navigator.of(context).pop();

          }

      );

      // await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();

    }
    if (PermanentlyDenied==true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_LocationService_Permission=false;
      openAppSettings();



    }

    if (granted==true) {
      // The OS restricts access, for example because of parental controls.
      is_LocationService_Permission=true;

      /*if (serviceLocation == true) {
        // Use location.
        _serviceEnabled=false;

         location.requestService();


      }
      else{
        _serviceEnabled=true;
        _getCurrentLocation();



      }*/
    }
  }
  _getCurrentLocation()  {
    geolocator123.getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best)
        .then((Position position) async {
      _currentPosition = position;
      Longitude = position.longitude.toString();
      Latitude = position.latitude.toString();

      Address = await getAddressFromLatLng(Latitude,Longitude,"AIzaSyCVs8h5lia6ktiHnj2yzLYJOGtn0CQG48k");


    }).catchError((e) {
      print(e);
    });

    location.onLocationChanged.listen((LocationData currentLocation) async {
      // Use current location
      print("OnLocationChange" +
          " Location : " +
          currentLocation.latitude.toString());
      //  placemarks = await placemarkFromCoordinates(currentLocation.latitude,currentLocation.longitude);
      // final coordinates = new Coordinates(currentLocation.latitude,currentLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;
      //  print("${first.featureName} : ${first.addressLine}");
      Latitude = currentLocation.latitude.toString();
      Longitude = currentLocation.longitude.toString();
      Address = await getAddressFromLatLng(Latitude,Longitude,"AIzaSyCVs8h5lia6ktiHnj2yzLYJOGtn0CQG48k");

      //  Address = "${first.featureName} : ${first.addressLine}";
    });


   // _FollowupBloc.add(LocationAddressCallEvent(LocationAddressRequest(key:"AIzaSyCVs8h5lia6ktiHnj2yzLYJOGtn0CQG48k",latlng:Latitude+","+Longitude)));

  }

  Future<String> getAddressFromLatLng(String lat, String lng, String skey) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$skey&latlng=$lat,$lng';
    if(lat != "" && lng != "null"){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        //Address = _formattedAddress;
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return null;
    } else return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc,
      child: BlocConsumer<AttendanceBloc, AttendanceStates>(
        builder: (BuildContext context, AttendanceStates state) {
          if (state is AttendanceListCallResponseState) {
            //_onSearchInquiryListCallSuccess(state);
          }
          /*  if (state is AttendanceSaveCallResponseState) {
            _onSaveAttendanceResponseSuccess(state.response);
          }*/
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState
              is AttendanceListCallResponseState /*|| currentState is AttendanceSaveCallResponseState*/) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context123, AttendanceStates state) {
          if (state is AttendanceSaveCallResponseState) {
            _onSaveAttendanceResponseSuccess(state);
          }
          if(state is LocationAddressResponseState)
            {
              _onLocationAddressSucessResponse(state);

            }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is AttendanceSaveCallResponseState || currentState is LocationAddressResponseState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,

      child: Column(
        children: [
          NewGradientAppBar(
            title: Text('ADD Attendance'),
            gradient:
                LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
            actions: <Widget>[
              IconButton(
                onPressed: (){
                  navigateTo(context, AttendanceListScreen.routeName, clearAllStack: true);

                },
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2,
                top: 25,
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (_offlineLoggedInData.details[0].roleCode ==
                                    'admin' ||
                                _offlineLoggedInData.details[0].roleCode ==
                                    'hradmin') {
                              _selectFromTime(context, _eventControllerIn_Time);
                            } else {
                              if (_eventControllerIn_Time.text == "") {
                                _selectFromTime(context, _eventControllerIn_Time);
                              }
                            }
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Text("In-Time",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: colorPrimary,
                                          fontWeight: FontWeight
                                              .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                      ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  elevation: 5,
                                  color: colorLightGray,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _eventControllerIn_Time.text ==
                                                        null ||
                                                    _eventControllerIn_Time
                                                            .text ==
                                                        ""
                                                ? "HH:MM:SS"
                                                : _eventControllerIn_Time.text,
                                            style: baseTheme.textTheme.headline3
                                                .copyWith(
                                                    color: _eventControllerIn_Time
                                                                    .text ==
                                                                null ||
                                                            _eventControllerIn_Time
                                                                    .text ==
                                                                ""
                                                        ? colorGrayDark
                                                        : colorBlack),
                                          ),
                                        ),
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: colorGrayDark,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: isvisible_Out_time,
                          child: InkWell(
                            onTap: () {
                              _selectToTime(context, _eventControllerOut_Time);
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10, right: 10),
                                    child: Text("Out-Time",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: colorPrimary,
                                            fontWeight: FontWeight
                                                .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                                        ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Card(
                                    elevation: 5,
                                    color: colorLightGray,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Container(
                                      height: 60,
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _eventControllerOut_Time.text ==
                                                          null ||
                                                      _eventControllerOut_Time
                                                              .text ==
                                                          ""
                                                  ? "HH:MM:SS"
                                                  : _eventControllerOut_Time.text,
                                              style: baseTheme.textTheme.headline3
                                                  .copyWith(
                                                      color: _eventControllerOut_Time
                                                                      .text ==
                                                                  null ||
                                                              _eventControllerOut_Time
                                                                      .text ==
                                                                  ""
                                                          ? colorGrayDark
                                                          : colorBlack),
                                            ),
                                          ),
                                          Icon(
                                            Icons.watch_later_outlined,
                                            color: colorGrayDark,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Notes",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: colorPrimary,
                                  fontWeight: FontWeight
                                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7, right: 7, top: 10),
                          child: TextFormField(
                            controller: _eventControllerNotes,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Tap to Enter Notes',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {

                            bool IsValidDateTime123 = false;

                           if(_eventControllerIn_Time.text !="" && _eventControllerOut_Time.text !="")
                           {
                             print("bothDate Inserted");

                              print("TimeFormatedddd" + "FromTime : " + stringToTimeOfDay(_eventControllerOut_Time.text).toString().replaceAll(":", ""));

                           var fromDate=  stringToTimeOfDay(_eventControllerIn_Time.text).toString().replaceAll(":", "") ;
                           var toDate = stringToTimeOfDay(_eventControllerOut_Time.text).toString().replaceAll(":", "") ;
                           String removeTiem =  fromDate.toString().replaceAll("TimeOfDay(", "");
                           String removeTiem1 =  toDate.toString().replaceAll("TimeOfDay(", "");
                           String FromTime7up = removeTiem.replaceAll(")", "");
                           String ToTime7up = removeTiem1.replaceAll(")", "");

                           print("DoublValueTime" + "FromTime : "+ FromTime7up  + "ToTime : " + ToTime7up );

                           if(double.parse(FromTime7up) <=  double.parse(ToTime7up))
                            {
                              print("Valid");
                              baseBloc.emit(ShowProgressIndicatorState(true));

                              if(is_LocationService_Permission==true)
                              {

                                bool serviceLocation = await Permission.locationWhenInUse.serviceStatus.isDisabled;

                                if(serviceLocation==false)
                                {

                                  _getCurrentLocation();

                                  baseBloc.emit(ShowProgressIndicatorState(false));

                                  showCommonDialogWithTwoOptions(
                                      context, "Are you sure you want to Save this Attendance ?",
                                      negativeButtonTitle: "No",
                                      positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
                                    Navigator.of(context).pop();

                                    _FollowupBloc.add(AttendanceSaveCallEvent(
                                        AttendanceSaveApiRequest(
                                            EmployeeID: _EmployeeID,
                                            PresenceDate: _PresentDate,
                                            TimeIn: _eventControllerIn_Time.text,
                                            TimeOut: _eventControllerOut_Time.text,
                                            Latitude: Latitude,
                                            LocationAddress: Address,
                                            Longitude: Longitude,
                                            Notes: _eventControllerNotes.text,
                                            LoginUserID: LoginUserID,
                                            CompanyId: CompanyID.toString())));
                                  });
                                }
                                else
                                {

                                  location.requestService();
                                  await Future.delayed(const Duration(seconds:3), (){});
                                  baseBloc.emit(ShowProgressIndicatorState(false));
                                }

                              }
                              else{

                                checkPermissionStatus();

                              }
                            }
                          else{
                            print("Invalid");
                            showCommonDialogWithSingleOption(context, "Invalid Time ! Time-OUT is must be greater then Time-IN",
                                positiveButtonTitle: "OK");
                          }

                           }
                           else {
                             print("bothDate Not Inserted");
                             baseBloc.emit(ShowProgressIndicatorState(true));


                             if(is_LocationService_Permission==true)
                             {
                               bool serviceLocation = await Permission.locationWhenInUse.serviceStatus.isDisabled;

                               if(serviceLocation==false)
                               {

                                 _getCurrentLocation();
                                 baseBloc.emit(ShowProgressIndicatorState(false));


                                 showCommonDialogWithTwoOptions(
                                     context, "Are you sure you want to Save this Attendance ?",
                                     negativeButtonTitle: "No",
                                     positiveButtonTitle: "Yes", onTapOfPositiveButton: () {
                                   Navigator.of(context).pop();

                                   _FollowupBloc.add(AttendanceSaveCallEvent(
                                       AttendanceSaveApiRequest(
                                           EmployeeID: _EmployeeID,
                                           PresenceDate: _PresentDate,
                                           TimeIn: _eventControllerIn_Time.text,
                                           TimeOut: _eventControllerOut_Time.text,
                                           Latitude: Latitude,
                                           LocationAddress: Address,
                                           Longitude: Longitude,
                                           Notes: _eventControllerNotes.text,
                                           LoginUserID: LoginUserID,
                                           CompanyId: CompanyID.toString())));
                                 });
                               }
                               else
                               {

                                  location.requestService();
                                 await Future.delayed(const Duration(seconds:3), (){});
                                  baseBloc.emit(ShowProgressIndicatorState(false));

                               }

                             }
                             else{

                               checkPermissionStatus();

                             }


                           }

                            // DateTime ToDate = DateTime.parse(_eventControllerOut_Time.text);




                            // _selectedEvents=[_eventControllerIn_Time.text,_eventControllerOut_Time.text];
                            //Navigator.of(context).pop(_selectedEvents);
                           /* await navigateTo(
                                context, AttendanceListScreen.routeName,
                                clearAllStack: true);*/
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 5,
                                  color: colorPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Save",
                                              style: baseTheme.textTheme.headline3
                                                  .copyWith(
                                                      color: colorWhite,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, AttendanceListScreen.routeName, clearAllStack: true);
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  Future<void> _selectFromTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    print("LoginDetails" +
        "ROLECODE : " +
        _offlineLoggedInData.details[0].roleCode);

    if (_offlineLoggedInData.details[0].roleCode == 'admin' ||
        _offlineLoggedInData.details[0].roleCode == 'hradmin') {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      //final TimeOfDay picked_s = TimeOfDay.now();

      if (picked_s != null) //&& picked_s != selectedTime)
        {
          //selectedTime = picked_s;

          String AM_PM =
          picked_s.periodOffset.toString() == "12" ? "PM" : "AM";
          String beforZeroHour = picked_s.hourOfPeriod <= 9
              ? "0" + picked_s.hourOfPeriod.toString()
              : picked_s.hourOfPeriod.toString();
          String beforZerominute = picked_s.minute <= 9
              ? "0" + picked_s.minute.toString()
              : picked_s.minute.toString();

          _eventControllerIn_Time.text = beforZeroHour +
              ":" +
              beforZerominute +
              " " +
              AM_PM; //picked_s.periodOffset.toString();
          setState(() {

          });
        }

    } else {
      selectedTime = TimeOfDay.now();

      String AM_PM =
      selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      F_datecontroller.text = beforZeroHour +
          ":" +
          beforZerominute +
          " " +
          AM_PM; //picked_s.periodOffset.toString();
      setState(() {

      });
    }
  }
  Future<void> _selectToTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    print("LoginDetails" +
        "ROLECODE : " +
        _offlineLoggedInData.details[0].roleCode);

    if (_offlineLoggedInData.details[0].roleCode == 'admin' ||
        _offlineLoggedInData.details[0].roleCode == 'hradmin') {
      final TimeOfDay picked_s = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            );
          });
      //final TimeOfDay picked_s = TimeOfDay.now();

      if (picked_s != null)// && picked_s != selectedTime)
      {
       // selectedTime = picked_s;

        String AM_PM =
        picked_s.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = picked_s.hourOfPeriod <= 9
            ? "0" + picked_s.hourOfPeriod.toString()
            : picked_s.hourOfPeriod.toString();
        String beforZerominute = picked_s.minute <= 9
            ? "0" + picked_s.minute.toString()
            : picked_s.minute.toString();

        _eventControllerOut_Time.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
        setState(() {

        });
      }

    } else {
      selectedTime = TimeOfDay.now();

      String AM_PM =
      selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      F_datecontroller.text = beforZeroHour +
          ":" +
          beforZerominute +
          " " +
          AM_PM; //picked_s.periodOffset.toString();
      setState(() {

      });
    }
  }

  void fillData() {
    // print("FilldataResult"+ _selectedEvents.toString());
    if (_selectedEvents.isNotEmpty) {
      print("FilldataResult" + _selectedEvents.toString());

      _eventControllerIn_Time.text = _selectedEvents[0];
      _eventControllerOut_Time.text = _selectedEvents[1];
      _eventControllerNotes.text = _selectedEvents[2];

      if (_offlineLoggedInData.details[0].roleCode == 'admin' ||
          _offlineLoggedInData.details[0].roleCode == 'hradmin') {

        setState(() {
          isvisible_Out_time = true;
        });
      } else {
        if (_selectedEvents[0].toString().isNotEmpty) {
          setState(() {
            isvisible_Out_time = true;
          });
        } else {
          setState(() {
            isvisible_Out_time = false;
          });
        }
      }
    } else {
      if (_offlineLoggedInData.details[0].roleCode == 'admin' ||
          _offlineLoggedInData.details[0].roleCode == 'hradmin') {
        setState(() {
          isvisible_Out_time = true;
          String AM_PM =
          selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
          String beforZeroHour = selectedTime.hourOfPeriod <= 9
              ? "0" + selectedTime.hourOfPeriod.toString()
              : selectedTime.hourOfPeriod.toString();
          String beforZerominute = selectedTime.minute <= 9
              ? "0" + selectedTime.minute.toString()
              : selectedTime.minute.toString();

          _eventControllerIn_Time.text = beforZeroHour +
              ":" +
              beforZerominute +
              " " +
              AM_PM;
          /*_eventControllerOut_Time.text = beforZeroHour +
              ":" +
              beforZerominute +
              " " +
              AM_PM;*/
        });
      } else {
        setState(() {
          isvisible_Out_time = false;
        });
      }
    }
  }

  /*void saveDetails() async {

    location.onLocationChanged.listen((LocationData currentLocation) async {
      print("OnLocationChange" + " Location : " + currentLocation.latitude.toString());
      final coordinates = new Coordinates(currentLocation.latitude,currentLocation.longitude);
     var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
     var first = addresses.first;
      print("${first.featureName} : ${first.addressLine}");
      Latitude = currentLocation.latitude.toString();
      Longitude = currentLocation.longitude.toString();
      Address = "${first.featureName} : ${first.addressLine}";
    });

  }*/
  /*getSetAddress(Coordinates coordinates) async {
    final addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
    });
  }
*/
 /* Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }*/

  void _onSaveAttendanceResponseSuccess(AttendanceSaveCallResponseState state) {
    print("AttendanceSave23" + " Message : " + state.response.details[0].column2);
    navigateTo(context, AttendanceListScreen.routeName, clearAllStack: true);
    /* _FollowupBloc
      ..add(AttendanceCallEvent(AttendanceApiRequest(
          pkID: "",
          EmployeeID:
         "47",
          Month: "",
          Year: "",
          CompanyId:CompanyID.toString())));
    navigateTo(context, AttendanceListScreen.routeName,
        clearAllStack: true);*/
  }

  void _onLocationAddressSucessResponse(LocationAddressResponseState state) {
    if(state.locationAddressResponse.results.length!=0)
      {
        for(var i=0;i<state.locationAddressResponse.results.length;i++)
          {
            Address = state.locationAddressResponse.results[i].formattedAddress;
            Latitude = state.locationAddressResponse.results[i].geometry.location.lat.toString();
            Longitude = state.locationAddressResponse.results[i].geometry.location.lng.toString();

          }
      }

    setState(() {

    });
  }



}
