import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/blocs/other/bloc_modules/followup/followup_bloc.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_by_customer_id_request.dart';
import 'package:soleoserp/models/api_requests/followup_save_request.dart';
import 'package:soleoserp/models/api_requests/followup_type_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_upload_image_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/search_followup_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/General_Constants.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/image_full_screen.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddUpdateFollowupScreenArguments {
  FilterDetails editModel;

  AddUpdateFollowupScreenArguments(this.editModel);
}

class FollowUpAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/FollowUpAddEditScreen';
  final AddUpdateFollowupScreenArguments arguments;

  FollowUpAddEditScreen(this.arguments);

  @override
  _FollowUpAddEditScreenScreenState createState() =>
      _FollowUpAddEditScreenScreenState();
}

class _FollowUpAddEditScreenScreenState extends BaseState<FollowUpAddEditScreen>
    with BasicScreen, WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // FollowupTypeListResponse _offlineFollowupTypeListResponseData;
  // InquiryStatusListResponse _offlineInquiryLeadStatusData;

  final TextEditingController edt_FollowupType = TextEditingController();
  final TextEditingController edt_FollowupTypepkID = TextEditingController();

  final TextEditingController edt_FollowUpDate = TextEditingController();
  final TextEditingController edt_ReverseFollowUpDate = TextEditingController();

  final TextEditingController edt_CustomerName = TextEditingController();
  final TextEditingController edt_CustomerpkID = TextEditingController();
  final TextEditingController edt_FollowupInquiryStatusType =
      TextEditingController();
  final TextEditingController edt_FollowupInquiryStatusTypepkID =
      TextEditingController();

  final TextEditingController edt_CloserReasonStatusType =
      TextEditingController();
  final TextEditingController edt_CloserReasonStatusTypepkID =
      TextEditingController();

  final TextEditingController edt_Priority = TextEditingController();
  final TextEditingController edt_InqNo = TextEditingController();
  final TextEditingController edt_FollowupNotes = TextEditingController();
  final TextEditingController edt_NextFollowupDate = TextEditingController();
  final TextEditingController edt_ReverseNextFollowupDate =
      TextEditingController();

  final TextEditingController edt_PreferedTime = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_FolowupType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Folowup_Status = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_FolowupInquiryStatusType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_CloserReasonStatusType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_InquiryNoListType = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_FolowupInquiryByCustomerID = [];

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  SearchDetails _searchDetails;
  FollowupBloc _FollowupBloc;
  int savepkID = 0;
  bool _isForUpdate;
  bool _isInqury_details_Exist;

  FilterDetails _editModel;
  double _rating;
  bool _isSwitched;
  File _selectedImageFile;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;

  //CloserReasonListResponse _offlilineFollowupCloserReasonListData;

  int CompanyID = 0;
  String LoginUserID = "";
  bool is_closer_reasonVisible;
  String fileName = "";
  String ImageURLFromListing = "";
  String SiteURL = "";
  String GetImageNamefromEditMode = "";
  FocusNode NotesFocusNode;

  String Latitude = "";
  String Longitude = "";
  Location location = new Location();

  bool _serviceEnabled;
  Position _currentPosition;
  final Geolocator geolocator123 = Geolocator()..forceAndroidLocationManager;

  bool is_LocationService_Permission;
  bool SaveSucess;
  bool is_Storage_Service_Permission;

  @override
  void initState() {
    super.initState();
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    _getCurrentLocation();

    // permission();
    // checkPhotoPermissionStatus();
    checkPermissionStatus();
    // _offlineFollowupTypeListResponseData = SharedPrefHelper.instance.getFollowupTypeListResponse();
    // _offlineInquiryLeadStatusData = SharedPrefHelper.instance.getInquiryLeadStatus();
    // _offlilineFollowupCloserReasonListData = SharedPrefHelper.instance.getFollowupCloserReason();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    SiteURL = _offlineCompanyData.details[0].siteURL;

    SaveSucess = false;
    _FollowupBloc = FollowupBloc(baseBloc);
    NotesFocusNode = FocusNode();

    // _onFollowupListTypeCallSuccess(_offlineFollowupTypeListResponseData);
    //_onFollowupInquiryStatusListTypeCallSuccess(_offlineInquiryLeadStatusData);
    //_onCloserReasonStatusListTypeCallSuccess(_offlilineFollowupCloserReasonListData);
    FetchFollowupPriorityDetails();
    FetchFollowupStatusDetails();
    edt_Priority.addListener(() {
      NotesFocusNode.requestFocus();
    });

    //picked_s.periodOffset.toString();

    /* _FollowupBloc
      ..add(FollowupInquiryStatusTypeListByNameCallEvent(
          FollowupInquiryStatusTypeListRequest(
              CompanyId: CompanyID.toString(), pkID: "", StatusCategory: "Inquiry",LoginUserID: LoginUserID,SearchKey: "")));*/

    _isForUpdate = widget.arguments != null;
    if (_isForUpdate) {
      _editModel = widget.arguments.editModel;
      fillData();
    } else {
      _rating = 4.0;
      selectedDate = DateTime.now();
      edt_FollowUpDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
      edt_NextFollowupDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseNextFollowupDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      edt_PreferedTime.text =
          beforZeroHour + ":" + beforZerominute + " " + AM_PM;

      setState(() {});
    }


    _isSwitched = false;
    _isInqury_details_Exist = false;
    is_closer_reasonVisible = false;

    edt_FollowupInquiryStatusType.addListener(() {
      if (edt_FollowupInquiryStatusType.text == "Close - Lost") {
        is_closer_reasonVisible = true;
      } else {
        is_closer_reasonVisible = false;
      }
      setState(() {});
    });
    isExistINQFromEDIT();
    if (SaveSucess == true) {
      _onOldState();
    }
  }

  _LocationServiceEnable() async {
    /* geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;

        //  CreateMarkers(_currentPosition);
      });
      //_getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });*/
    /*  _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }*/

    /* _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {

        return;
      }
    }

    if(_permissionGranted==PermissionStatus.granted)
      {
        _getCurrentLocation();
      }
*/
  }

  _getCurrentLocation() {
    geolocator123
        .getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        Longitude = position.longitude.toString();
        Latitude = position.latitude.toString();
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
    NotesFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _FollowupBloc,
      /* ..add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
            CompanyId: CompanyID.toString(), pkID: "", StatusCategory: "FollowUp"))),*/

      child: BlocConsumer<FollowupBloc, FollowupStates>(
        builder: (BuildContext context, FollowupStates state) {
          if (state is FollowupInquiryNoListCallResponseState) {
            _onInquiryNoListTypeCallSuccess(state);
          }
          if (state is FollowupCustomerListByNameCallResponseState) {
            _onInquiryListByNumberCallSuccess(state);
          }

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          if (currentState is FollowupCustomerListByNameCallResponseState ||
              currentState is FollowupInquiryStatusListCallResponseState ||
              currentState is FollowupInquiryNoListCallResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, FollowupStates state) {
          if (state is FollowupInquiryByCustomerIdCallResponseState) {
            _onFollowupInquiryByCustomerIDCallSuccess(state);
          }
          if (state is FollowupSaveCallResponseState) {
            _onFollowupSaveCallSuccess(state);
          }
          if (state is FollowupImageDeleteCallResponseState) {
            _OnDeleteFollowupImageResponseSucess(state);
          }
          if (state is FollowupUploadImageCallResponseState) {
            _OnFollowupImageUploadSucessResponse(state);
          }

          if (state is FollowupTypeListCallResponseState) {
            _onFollowupListTypeCallSuccess(state);
          }
          if (state is InquiryLeadStatusListCallResponseState) {
            _onLeadStatusListTypeCallSuccess(state);
          }
          if (state is CloserReasonListCallResponseState) {
            _onCloserReasonStatusListTypeCallSuccess(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is FollowupInquiryByCustomerIdCallResponseState ||
              currentState is FollowupSaveCallResponseState ||
              currentState is FollowupImageDeleteCallResponseState ||
              currentState is FollowupUploadImageCallResponseState ||
              currentState is FollowupTypeListCallResponseState ||
              currentState is InquiryLeadStatusListCallResponseState ||
              currentState is CloserReasonListCallResponseState) {
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
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Followup List'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
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
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(Constant.CONTAINERMARGIN),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildSearchView(),
                        Visibility(
                          visible: _isInqury_details_Exist,
                          child: showcustomdialogWithMultiID1("Inquiry #",
                              enable1: false,
                              title: "Inquiry #",
                              hintTextvalue: "Tap to Select Inquiry#",
                              icon: Icon(Icons.arrow_drop_down),
                              controllerForLeft: edt_InqNo,
                              controller1: edt_FollowupInquiryStatusType,
                              controllerpkID: edt_FollowupInquiryStatusTypepkID,
                              Custom_values1:
                                  arr_ALL_Name_ID_For_FolowupInquiryByCustomerID),
                        ),
                        showcustomdialogWithID1("Followup Type",
                            enable1: false,
                            title: "Followup Type *",
                            hintTextvalue: "Tap to Select Followup Type",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_FollowupType,
                            controllerpkID: edt_FollowupTypepkID,
                            Custom_values1: arr_ALL_Name_ID_For_FolowupType),
                        CustomDropDown1("Priority",
                            enable1: false,
                            title: "Priority *",
                            hintTextvalue: "Tap to Select Priority",
                            icon: Icon(Icons.arrow_drop_down),
                            controllerForLeft: edt_Priority,
                            Custom_values1:
                                arr_ALL_Name_ID_For_Folowup_Priority),

                        /* CustomDropDown1("Followup Status",
                              enable1: false,
                              title: "Followup Status",
                              hintTextvalue: "Tap to Followup Status",
                              icon: Icon(Icons.arrow_drop_down),
                              controllerForLeft: edt_FollowupStatus,
                              Custom_values1: arr_ALL_Name_ID_For_Folowup_Status),
*/

                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Text("Followup Notes *",
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
                            focusNode: NotesFocusNode,
                            controller: edt_FollowupNotes,
                            minLines: 2,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Enter Notes',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildNextFollowupDate(),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                        _buildPreferredTime(),
                        Visibility(
                          visible: _isInqury_details_Exist,
                          child: showcustomdialogWithID1("Inquiry Status",
                              enable1: false,
                              title: "Inquiry Status",
                              hintTextvalue: "Tap to Select Inquiry Status",
                              icon: Icon(Icons.arrow_drop_down),
                              controllerForLeft: edt_FollowupInquiryStatusType,
                              controllerpkID: edt_FollowupInquiryStatusTypepkID,
                              Custom_values1:
                                  arr_ALL_Name_ID_For_FolowupInquiryStatusType),
                        ),
                        Visibility(
                          visible: _isInqury_details_Exist,
                          child: is_closer_reasonVisible == true
                              ? showcustomdialogWithID1("Closer Reason",
                                  enable1: false,
                                  title: "Closer Reason",
                                  hintTextvalue: "Tap to Select Closer Reason",
                                  icon: Icon(Icons.arrow_drop_down),
                                  controllerForLeft: edt_CloserReasonStatusType,
                                  controllerpkID:
                                      edt_CloserReasonStatusTypepkID,
                                  Custom_values1:
                                      arr_ALL_Name_ID_For_CloserReasonStatusType)
                              : Container(),
                        ),
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        RatingStar(),
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        SwitchNoFollowup(),
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        uploadImage(context),
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        getCommonButton(baseTheme, () async {
                          print("RatingValue " +
                              "Rate : " +
                              _rating.toInt().toString());
                          int nofollowupvalue = 0;
                          if (_isSwitched == false) {
                            nofollowupvalue = 0;
                          } else {
                            nofollowupvalue = 1;
                          }

                          print("SwitchValue " +
                              "Switch : " +
                              nofollowupvalue.toString());

                          if (edt_CustomerName.text != "") {
                            if (edt_FollowupType.text != "") {
                              if (edt_Priority.text != "") {
                                if (edt_FollowupNotes.text != "") {
                                  if (edt_NextFollowupDate.text != "") {
                                    if (_selectedImageFile != null) {
                                      fileName = _selectedImageFile.path
                                          .split('/')
                                          .last;
                                    } else {
                                      fileName = GetImageNamefromEditMode;
                                    }
                                    print("ALLIDS" +
                                        "CustomerID : " +
                                        edt_CustomerpkID.text +
                                        " FollowupType_pkID : " +
                                        edt_FollowupTypepkID.text +
                                        " InquiryStatusID : " +
                                        edt_FollowupInquiryStatusTypepkID.text +
                                        " CloserReason_pkID : " +
                                        edt_CloserReasonStatusTypepkID.text);
                                    String FollowupStatusIDs = "";
                                    String FollowupPriorityDetails = "";

                                    if (_offlineLoggedInData
                                            .details[0].serialKey
                                            .toLowerCase() ==
                                        "dol2-6uh7-ph03-in5h") {
                                      if (edt_Priority.text == "Hot") {
                                        FollowupPriorityDetails = "1";
                                      } else if (edt_Priority.text == "Cold") {
                                        FollowupPriorityDetails = "2";
                                      } else if (edt_Priority.text == "Warm") {
                                        FollowupPriorityDetails = "3";
                                      }
                                    } else {
                                      if (edt_Priority.text == "High") {
                                        FollowupPriorityDetails = "1";
                                      } else if (edt_Priority.text ==
                                          "Medium") {
                                        FollowupPriorityDetails = "2";
                                      } else if (edt_Priority.text == "Low") {
                                        FollowupPriorityDetails = "3";
                                      }
                                    }

                                    /*baseBloc
                                        .emit(ShowProgressIndicatorState(true));
*/
                                    if (is_LocationService_Permission == true) {
                                      bool serviceLocation = await Permission
                                          .locationWhenInUse
                                          .serviceStatus
                                          .isDisabled;

                                      // if (serviceLocation == false) {
                                      // baseBloc.emit(ShowProgressIndicatorState(false));

                                      DateTime FbrazilianDate =
                                          new DateFormat("dd-MM-yyyy")
                                              .parse(edt_FollowUpDate.text);
                                      DateTime NbrazilianDate =
                                          new DateFormat("dd-MM-yyyy")
                                              .parse(edt_NextFollowupDate.text);

                                      if (FbrazilianDate.isBefore(
                                          NbrazilianDate)) {
                                        showCommonDialogWithTwoOptions(context,
                                            "Are you sure you want to Save this Follow-Up?",
                                            negativeButtonTitle: "No",
                                            positiveButtonTitle: "Yes",
                                            onTapOfPositiveButton: () {
                                          Navigator.of(context).pop();
                                          String Msg = _isForUpdate == true
                                              ? "Followup Information. Updated Successfully"
                                              : "Followup Information. Added Successfully";
                                          _FollowupBloc.add(FollowupSaveByNameCallEvent(
                                              Msg,
                                              context,
                                              savepkID,
                                              FollowupSaveApiRequest(
                                                  pkID: savepkID.toString(),
                                                  FollowupDate: edt_ReverseFollowUpDate
                                                      .text,
                                                  CustomerID:
                                                      edt_CustomerpkID.text,
                                                  InquiryNo:
                                                      edt_InqNo.text == "null"
                                                          ? ""
                                                          : edt_InqNo.text,
                                                  MeetingNotes:
                                                      edt_FollowupNotes.text,
                                                  NextFollowupDate:
                                                      edt_ReverseNextFollowupDate
                                                          .text,
                                                  Rating: _rating
                                                      .toInt()
                                                      .toString(),
                                                  FollowupTypeId:
                                                      edt_FollowupTypepkID.text == "null"
                                                          ? ""
                                                          : edt_FollowupTypepkID
                                                              .text,
                                                  LoginUserID: LoginUserID,
                                                  Address: "",
                                                  NoFollowup: nofollowupvalue
                                                      .toString(),
                                                  InquiryStatusId: edt_FollowupInquiryStatusTypepkID.text == "null"
                                                      ? ""
                                                      : edt_FollowupInquiryStatusTypepkID
                                                          .text,
                                                  Latitude: Latitude,
                                                  Longitude: Longitude,
                                                  PreferredTime:
                                                      edt_PreferedTime.text,
                                                  ClosureReasonId:
                                                      edt_CloserReasonStatusTypepkID.text == "null"
                                                          ? ""
                                                          : edt_CloserReasonStatusTypepkID.text,
                                                  CompanyId: CompanyID.toString(),
                                                  FollowupPriority: FollowupPriorityDetails,
                                                  FollowUpImage: fileName)));
                                        });
                                      } else {
                                        if (FbrazilianDate.isAtSameMomentAs(
                                            NbrazilianDate)) {
                                          showCommonDialogWithTwoOptions(
                                              context,
                                              "Are you sure you want to Save this Follow-Up?",
                                              negativeButtonTitle: "No",
                                              positiveButtonTitle: "Yes",
                                              onTapOfPositiveButton: () {
                                            Navigator.of(context).pop();
                                            String Msg = _isForUpdate == true
                                                ? "Followup Information. Updated Successfully"
                                                : "Followup Information. Added Successfully";
                                            _FollowupBloc.add(FollowupSaveByNameCallEvent(
                                                Msg,
                                                context,
                                                savepkID,
                                                FollowupSaveApiRequest(
                                                    pkID: savepkID.toString(),
                                                    FollowupDate:
                                                        edt_ReverseFollowUpDate
                                                            .text,
                                                    CustomerID:
                                                        edt_CustomerpkID.text,
                                                    InquiryNo:
                                                        edt_InqNo.text == "null"
                                                            ? ""
                                                            : edt_InqNo.text,
                                                    MeetingNotes:
                                                        edt_FollowupNotes.text,
                                                    NextFollowupDate:
                                                        edt_ReverseNextFollowupDate
                                                            .text,
                                                    Rating: _rating
                                                        .toInt()
                                                        .toString(),
                                                    FollowupTypeId:
                                                        edt_FollowupTypepkID.text == "null"
                                                            ? ""
                                                            : edt_FollowupTypepkID
                                                                .text,
                                                    LoginUserID: LoginUserID,
                                                    Address: "",
                                                    NoFollowup: nofollowupvalue
                                                        .toString(),
                                                    InquiryStatusId:
                                                        edt_FollowupInquiryStatusTypepkID.text == "null"
                                                            ? ""
                                                            : edt_FollowupInquiryStatusTypepkID
                                                                .text,
                                                    Latitude: Latitude,
                                                    Longitude: Longitude,
                                                    PreferredTime:
                                                        edt_PreferedTime.text,
                                                    ClosureReasonId:
                                                        edt_CloserReasonStatusTypepkID.text == "null"
                                                            ? ""
                                                            : edt_CloserReasonStatusTypepkID.text,
                                                    CompanyId: CompanyID.toString(),
                                                    FollowupPriority: FollowupPriorityDetails,
                                                    FollowUpImage: fileName)));
                                          });
                                        } else {
                                          showCommonDialogWithSingleOption(
                                              context,
                                              "Next Followup Date Should be greater than Followup Date !",
                                              positiveButtonTitle: "OK");
                                        }
                                      }
                                      /*}else {
                                        location.requestService();
                                        await Future.delayed(
                                            const Duration(seconds: 3), () {});
                                        baseBloc.emit(
                                            ShowProgressIndicatorState(false));
                                      }*/
                                    } else {
                                      checkPermissionStatus();
                                    }
                                  } else {
                                    showCommonDialogWithSingleOption(context,
                                        "Next FollowupDate is required!",
                                        positiveButtonTitle: "OK");
                                  }
                                } else {
                                  showCommonDialogWithSingleOption(
                                      context, "Followup Notes is required!",
                                      positiveButtonTitle: "OK");
                                }
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Please Select Priority!",
                                    positiveButtonTitle: "OK");
                              }
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Please Select Followup Type!",
                                  positiveButtonTitle: "OK");
                            }
                          } else {
                            showCommonDialogWithSingleOption(
                                context, "Select Proper Customer From List!",
                                positiveButtonTitle: "OK");
                          }
                        }, "Save"),
                        SizedBox(
                          width: 20,
                          height: 15,
                        ),
                      ]))),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
  }

  Future<bool> _onOldState() {
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_FollowUpDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectNextFollowupDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_NextFollowupDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
        edt_ReverseNextFollowupDate.text = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      });
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController F_datecontroller) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;

        String AM_PM =
            selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
        String beforZeroHour = selectedTime.hourOfPeriod <= 9
            ? "0" + selectedTime.hourOfPeriod.toString()
            : selectedTime.hourOfPeriod.toString();
        String beforZerominute = selectedTime.minute <= 9
            ? "0" + selectedTime.minute.toString()
            : selectedTime.minute.toString();

        edt_PreferedTime.text = beforZeroHour +
            ":" +
            beforZerominute +
            " " +
            AM_PM; //picked_s.periodOffset.toString();
      });
  }

  FetchFollowupPriorityDetails() {
    if (_offlineLoggedInData.details[0].serialKey.toLowerCase() ==
        "dol2-6uh7-ph03-in5h") {
      arr_ALL_Name_ID_For_Folowup_Priority.clear();
      for (var i = 0; i < 3; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();

        if (i == 0) {
          all_name_id.Name = "Hot";
        } else if (i == 1) {
          all_name_id.Name = "Cold";
        } else if (i == 2) {
          all_name_id.Name = "Warm";
        }
        arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
      }
    } else {
      arr_ALL_Name_ID_For_Folowup_Priority.clear();
      for (var i = 0; i < 3; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();

        if (i == 0) {
          all_name_id.Name = "High";
        } else if (i == 1) {
          all_name_id.Name = "Medium";
        } else if (i == 2) {
          all_name_id.Name = "Low";
        }
        arr_ALL_Name_ID_For_Folowup_Priority.add(all_name_id);
      }
    }
  }

  FetchFollowupStatusDetails() {
    arr_ALL_Name_ID_For_Folowup_Status.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name = "Initialized";
      } else if (i == 1) {
        all_name_id.Name = "Pending";
      } else if (i == 2) {
        all_name_id.Name = "Sucess";
      }
      arr_ALL_Name_ID_For_Folowup_Status.add(all_name_id);
    }
  }

  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Search Customer *",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: edt_CustomerName,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Search customer",
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
                    Icons.search,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFollowupDate() {
    return InkWell(
      onTap: () {
        _selectDate(context, edt_FollowUpDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("FollowUp Date *",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_FollowUpDate.text == null ||
                              edt_FollowUpDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_FollowUpDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_FollowUpDate.text == null ||
                                  edt_FollowUpDate.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNextFollowupDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_NextFollowupDate);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Next FollowUp Date *",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_NextFollowupDate.text == null ||
                              edt_NextFollowupDate.text == ""
                          ? "DD-MM-YYYY"
                          : edt_NextFollowupDate.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_NextFollowupDate.text == null ||
                                  edt_NextFollowupDate.text == ""
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPreferredTime() {
    return InkWell(
      onTap: () {
        _selectTime(context, edt_PreferedTime);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("Preferred Time",
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      edt_PreferedTime.text == null ||
                              edt_PreferedTime.text == ""
                          ? "HH:MM:SS"
                          : edt_PreferedTime.text,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: edt_PreferedTime.text == null ||
                                  edt_PreferedTime.text == ""
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
    );
  }

  Future<void> _onTapOfSearchView() async {
    if (_isForUpdate == false) {
      navigateTo(context, SearchFollowupCustomerScreen.routeName).then((value) {
        if (value != null) {
          _searchDetails = value;
          edt_CustomerpkID.text = _searchDetails.value.toString();
          edt_CustomerName.text = _searchDetails.label.toString();

          _FollowupBloc.add(SearchFollowupCustomerListByNameCallEvent(
              CustomerLabelValueRequest(
                  CompanyId: CompanyID.toString(),
                  LoginUserID: "admin",
                  word: _searchDetails.value.toString())));
          /* _FollowupBloc.add(FollowupInquiryNoListByNameCallEvent(
            FollowerInquiryNoListRequest(
                CompanyId: CompanyID.toString(),
                LoginUserID: "admin",
                CustomerID: edt_CustomerpkID.text,
                InquiryNo: "",
                PageNo: "",
                PageSize: "")));*/
          _FollowupBloc.add(FollowupInquiryByCustomerIDCallEvent(
              FollowerInquiryByCustomerIDRequest(
            CompanyId: CompanyID.toString(),
            CustomerID: edt_CustomerpkID.text,
          )));
        }
        print("CustomerInfo : " +
            edt_CustomerName.text.toString() +
            " CustomerID : " +
            edt_CustomerpkID.text.toString());
      });
    }
  }

  void _onInquiryListByNumberCallSuccess(
      FollowupCustomerListByNameCallResponseState state) {}

  void _onFollowupSaveCallSuccess(FollowupSaveCallResponseState state) async {
    // if( state.followupSaveResponse.details[0].column2==" state.followupSaveResponse.details[0].column2")
    print("FollowupSav123" +
        " Response : " +
        state.followupSaveResponse.details[0].column2);
    if (_selectedImageFile != null) {
      _FollowupBloc.add(FollowupUploadImageNameCallEvent(
          _selectedImageFile,
          FollowUpUploadImageAPIRequest(
              CompanyId: CompanyID.toString(),
              LoginUserId: LoginUserID,
              pkID: "0",
              fileName: _selectedImageFile.path.split('/').last,
              FollowupID:
                  state.followupSaveResponse.details[0].column3.toString(),
              InquiryNo: edt_InqNo.text.toString() != ""
                  ? edt_InqNo.text.toString()
                  : "",
              Type: "0",
              file: _selectedImageFile)));
    } else {
      String Msg = _isForUpdate == true
          ? "Followup Information. Updated Successfully"
          : "Followup Information. Added Successfully";

      /* showCommonDialogWithSingleOption(state.context, Msg,
            positiveButtonTitle: "OK", onTapOfPositiveButton: () async {
             // navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
          });*/

      await showCommonDialogWithSingleOption(Globals.context, Msg,
          positiveButtonTitle: "OK", onTapOfPositiveButton: () {
        navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
      });
      //Navigator.of(context).pop();

    }
  }

  void _onFollowupListTypeCallSuccess(FollowupTypeListCallResponseState state) {
    if (state.followupTypeListResponse.details.length != 0) {
      arr_ALL_Name_ID_For_FolowupType.clear();
      for (var i = 0; i < state.followupTypeListResponse.details.length; i++) {
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.followupTypeListResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.followupTypeListResponse.details[i].pkID;
        arr_ALL_Name_ID_For_FolowupType.add(all_name_id);
      }

      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_FolowupType,
          context1: context,
          controller: edt_FollowupType,
          controllerID: edt_FollowupTypepkID,
          lable: "Select Followup Type");
    }
  }

  void _onFollowupInquiryStatusListTypeCallSuccess(
      InquiryStatusListResponse state) {
    if (state.details != null) {
      arr_ALL_Name_ID_For_FolowupInquiryStatusType.clear();
      for (var i = 0; i < state.details.length; i++) {
        print("InquiryStatus : " + state.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.details[i].inquiryStatus;
        all_name_id.pkID = state.details[i].pkID;
        arr_ALL_Name_ID_For_FolowupInquiryStatusType.add(all_name_id);
      }
    }
  }

  void _onCloserReasonStatusListTypeCallSuccess(
      CloserReasonListCallResponseState state) {
    if (state.closerReasonListResponse.details.length != 0) {
      arr_ALL_Name_ID_For_CloserReasonStatusType.clear();
      for (var i = 0; i < state.closerReasonListResponse.details.length; i++) {
        print("CloserReasonStatus : " +
            state.closerReasonListResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.closerReasonListResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.closerReasonListResponse.details[i].pkID;
        arr_ALL_Name_ID_For_CloserReasonStatusType.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_CloserReasonStatusType,
          context1: context,
          controller: edt_CloserReasonStatusType,
          controllerID: edt_CloserReasonStatusTypepkID,
          lable: "Select DisQualified Reason");
    }
  }

  void _onInquiryNoListTypeCallSuccess(
      FollowupInquiryNoListCallResponseState state) {
    if (state.followupInquiryNoListResponse.details != null) {
      arr_ALL_Name_ID_For_InquiryNoListType.clear();
      for (var i = 0;
          i < state.followupInquiryNoListResponse.details.length;
          i++) {
        print("InquiryNoStatus : " +
            state.followupInquiryNoListResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.followupInquiryNoListResponse.details[i].inquiryNo;
        all_name_id.Name1 = state
            .followupInquiryNoListResponse.details[i].inquiryStatus
            .toString();
        all_name_id.pkID =
            state.followupInquiryNoListResponse.details[i].inquiryStatusID;
        arr_ALL_Name_ID_For_InquiryNoListType.add(all_name_id);
      }
    }
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithOnlyName(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                lable: "Select $Category"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(title,
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
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: hintTextvalue,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showcustomdialogWithID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          InkWell(
            onTap:
                () => /*showcustomdialogWithID(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                controllerID: controllerpkID,
                lable: "Select $Category")*/
                    CreateDialogDropdown(Category),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(title,
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
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: hintTextvalue,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showcustomdialogWithMultiID1(String Category,
      {bool enable1,
      Icon icon,
      String title,
      String hintTextvalue,
      TextEditingController controllerForLeft,
      TextEditingController controller1,
      TextEditingController controllerpkID,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          InkWell(
            onTap: () => showcustomdialogWithMultipleID(
                values: Custom_values1,
                context1: context,
                controller: controllerForLeft,
                controller2: controller1,
                controllerID: controllerpkID,
                lable: "Select $Category"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(title,
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
                          child: TextField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: hintTextvalue,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fillData() {
    if (_editModel.followupDate == "") {
      selectedDate = DateTime.now();
      edt_FollowUpDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseFollowUpDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
    } else {
      edt_FollowUpDate.text = _editModel.followupDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseFollowUpDate.text = _editModel.followupDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }
    if (_editModel.nextFollowupDate == "") {
      selectedDate = DateTime.now();

      edt_NextFollowupDate.text = selectedDate.day.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.year.toString();
      edt_ReverseNextFollowupDate.text = selectedDate.year.toString() +
          "-" +
          selectedDate.month.toString() +
          "-" +
          selectedDate.day.toString();
    } else {
      edt_NextFollowupDate.text = _editModel.nextFollowupDate.getFormattedDate(
          fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "dd-MM-yyyy");
      edt_ReverseNextFollowupDate.text = _editModel.nextFollowupDate
          .getFormattedDate(
              fromFormat: "yyyy-MM-ddTHH:mm:ss", toFormat: "yyyy-MM-dd");
    }

    if (_editModel.preferredTime == "") {
      TimeOfDay selectedTime = TimeOfDay.now();

      String AM_PM = selectedTime.periodOffset.toString() == "12" ? "PM" : "AM";
      String beforZeroHour = selectedTime.hourOfPeriod <= 9
          ? "0" + selectedTime.hourOfPeriod.toString()
          : selectedTime.hourOfPeriod.toString();
      String beforZerominute = selectedTime.minute <= 9
          ? "0" + selectedTime.minute.toString()
          : selectedTime.minute.toString();

      edt_PreferedTime.text =
          beforZeroHour + ":" + beforZerominute + " " + AM_PM;
    } else {
      edt_PreferedTime.text = _editModel.preferredTime;
    }

    if (_offlineLoggedInData.details[0].serialKey.toLowerCase() ==
        "dol2-6uh7-ph03-in5h") {
      if (_editModel.followupPriority == 1) {
        edt_Priority.text = "Hot";
      } else if (_editModel.followupPriority == 2) {
        edt_Priority.text = "Cold";
      } else {
        edt_Priority.text = "Warm";
      }
    } else {
      if (_editModel.followupPriority == 1) {
        edt_Priority.text = "High";
      } else if (_editModel.followupPriority == 2) {
        edt_Priority.text = "Medium";
      } else {
        edt_Priority.text = "Low";
      }
    }

    edt_CustomerName.text = _editModel.customerName;
    edt_CustomerpkID.text = _editModel.customerID.toString();

    savepkID = _editModel.pkID.toInt();
    edt_InqNo.text = _editModel.inquiryNo;
    edt_FollowupInquiryStatusType.text = _editModel.inquiryStatusDesc;
    edt_FollowupInquiryStatusTypepkID.text =
        _editModel.inquiryStatusDescID.toString();

    print("InqExistt" + "INQNO : " + _editModel.inquiryNo);

    edt_FollowupNotes.text = _editModel.meetingNotes;

    edt_CloserReasonStatusTypepkID.text = _editModel.noFollClosureID.toString();
    edt_FollowupType.text = _editModel.inquiryStatus.toString();
    edt_FollowupTypepkID.text = _editModel.inquiryStatusID.toString();
    print("RARINGG" + "Rate : " + _editModel.rating.toDouble().toString());

    _rating = _editModel.rating == null || _editModel.rating == 0 ? 0.00 : _editModel.rating.toDouble();


    if (_editModel.noFollowup == 0) {
      _isSwitched = false;
    } else {
      _isSwitched = true;
    }
    if (_editModel.FollowUpImage.isNotEmpty) {
      ImageURLFromListing =
          SiteURL + "followupimages/" + _editModel.FollowUpImage;
      print("ImageURLFromListing" +
          "ImageURLFromListing : " +
          ImageURLFromListing);
      GetImageNamefromEditMode = _editModel.FollowUpImage;
      print("ImageURLFromListing1235" +
          "ImageURLFromListing : " +
          GetImageNamefromEditMode);
    } else {
      ImageURLFromListing = "";
    }

    _FollowupBloc.add(
        FollowupInquiryByCustomerIDCallEvent(FollowerInquiryByCustomerIDRequest(
      CompanyId: CompanyID.toString(),
      CustomerID: edt_CustomerpkID.text,
    )));

    /*
    CompanyId: CompanyID.toString(),LoginUserID: "admin",pkID: savepkID.toString(),FollowupDate: edt_ReverseFollowUpDate.text ,
                                            CustomerID: edt_CustomerpkID.text,InquiryNo: edt_InqNo.text , MeetingNotes: edt_FollowupNotes.text,
                                        NextFollowupDate: edt_ReverseNextFollowupDate.text , PreferredTime: edt_PreferedTime.text,Rating: "5",
                                          InquiryStatusID:edt_FollowupInquiryStatusTypepkID.text,ReturnFollowupPKID: "",NoFollowup: "0",NoFollClosureID: edt_CloserReasonStatusTypepkID.text,
                                        FollowupPriority: FollowupPriorityDetails,FollowupStatus: FollowupStatusIDs

    */
  }

  Widget RatingStar() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Rating",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: RatingBar.builder(
            initialRating: _rating,
            itemCount: 5,
            itemSize: 40,
            itemPadding: EdgeInsets.only(left: 15, right: 15),
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                  );
                case 1:
                  return Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  );
                case 2:
                  return Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                  );
                case 3:
                  return Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                  );
                case 4:
                  return Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                  );
                default:
                  return Container();
              }
            },
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
              print("DefaultRating" + "Default : " + rating.toString());
            },
          ),
        ),
      ],
    ));
  }

  Widget SwitchNoFollowup() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text("No Followup",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Switch(
              value: _isSwitched,
              activeColor: Colors.green,
              inactiveTrackColor: Colors.red,
              onChanged: (value) {
                print("_isSwitchedVALUE : $value");
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImage(BuildContext context123) {
    /*return Column(
     children: [
       _selectedImageFile == null
           ? false //edit mode or not
           ? Container(
           margin: EdgeInsets.only(bottom: 20),
           child: getSquareImage(
               "https://i.picsum.photos/id/183/200/300.jpg?hmac=Z9yCtuuIPn5CuOhwIntNEQFIRotghuBn06nqOSL828c",
               200,
               200))
           : Container()
           : Container(
           margin: EdgeInsets.only(bottom: 20),
           child: Image.file(
             _selectedImageFile,
             height: 200,
           )),
       getCommonButton(baseTheme, () {
         pickImage(context, onImageSelection: (file) {
           _selectedImageFile = file;
           baseBloc.refreshScreen();
         });
       }, "Upload")
     ],
   );*/
    //return getSquareImage("",100,100);
    return Column(
      children: [
        _selectedImageFile == null
            ? _isForUpdate //edit mode or not
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ImageURLFromListing.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: colorGray,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ImageFullScreenWrapperWidget(
                                  child: Image.network(
                                    ImageURLFromListing,
                                    height: 125,
                                    width: 125,
                                  ),
                                  dark: true,
                                ),
                              ),
                              Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: colorGray,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
/*
                                    margin: EdgeInsets.only(left: 180),
*/
                                    child: GestureDetector(
                                      onTap: () {
                                        showCommonDialogWithTwoOptions(context,
                                            "Are you sure you want to delete this Image ?",
                                            negativeButtonTitle: "No",
                                            positiveButtonTitle: "Yes",
                                            onTapOfPositiveButton: () {
                                          Navigator.of(context).pop();
                                          _FollowupBloc.add(
                                              FollowupImageDeleteCallEvent(
                                                  savepkID,
                                                  FollowupImageDeleteRequest(
                                                      CompanyId:
                                                          CompanyID.toString(),
                                                      LoginUserID:
                                                          LoginUserID)));
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: 32,
                                        color: colorPrimary,
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        : Container())
                : Container()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageFullScreenWrapperWidget(
                    child: Image.file(
                      _selectedImageFile,
                      height: 125,
                      width: 125,
                    ),
                    dark: true,
                  ),
                ),
              ),
        getCommonButton(baseTheme, () async {
          if (await Permission.storage.isDenied) {
            //await Permission.storage.request();

            checkPhotoPermissionStatus();
          } else {
            pickImage(context, onImageSelection: (file) {
              _selectedImageFile = file;
              baseBloc.refreshScreen();
            });
          }
        }, "Upload Image", backGroundColor: Colors.indigoAccent)
      ],
    );
  }

  void _onFollowupInquiryByCustomerIDCallSuccess(
      FollowupInquiryByCustomerIdCallResponseState state) {
    _isForUpdate == true
        ? edt_FollowupInquiryStatusTypepkID.text
        : edt_FollowupInquiryStatusTypepkID.text = "";
    _isForUpdate == true
        ? edt_FollowupInquiryStatusType.text
        : edt_FollowupInquiryStatusType.text = "";

    _isInqury_details_Exist = false;

    if (state.followupInquiryByCustomerIDResponse.details != null) {
      arr_ALL_Name_ID_For_FolowupInquiryByCustomerID.clear();
      for (var i = 0;
          i < state.followupInquiryByCustomerIDResponse.details.length;
          i++) {
        print("InquiryStatus : " +
            state.followupInquiryByCustomerIDResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.followupInquiryByCustomerIDResponse.details[i].inquiryNo;
        all_name_id.Name1 =
            state.followupInquiryByCustomerIDResponse.details[i].inquiryStatus;
        all_name_id.pkID = state
            .followupInquiryByCustomerIDResponse.details[i].inquiryStatusID;
        arr_ALL_Name_ID_For_FolowupInquiryByCustomerID.add(all_name_id);
        _isInqury_details_Exist = true;
      }
    } else {
      arr_ALL_Name_ID_For_FolowupInquiryByCustomerID.clear();
      _isInqury_details_Exist = false;
    }

    setState(() {});
  }

  void isExistINQFromEDIT() {
    if (edt_InqNo.text != "") {
      _isInqury_details_Exist = true;
    } else {
      _isInqury_details_Exist = false;
    }
    setState(() {});
  }

  _OnDeleteFollowupImageResponseSucess(
      FollowupImageDeleteCallResponseState state) {
    print("ImageDeleteSucess" +
        state.followupDeleteImageResponse.details[0].column2.toString());
    _isForUpdate = false;
    setState(() {});
  }

  _OnFollowupImageUploadSucessResponse(
      FollowupUploadImageCallResponseState state) async {
    //print("ImageUploadSucess"+ state.followupImageUploadResponse.details[0].column1);
    /* showCommonDialogWithSingleOption(context, Msg,
         positiveButtonTitle: "OK", onTapOfPositiveButton: () {
           _selectedImageFile.delete(recursive: true);
           //navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
           Navigator.of(context).pop();

         });*/
    String Msg = _isForUpdate == true
        ? "Followup Information. Updated Successfully"
        : "Followup Information. Added Successfully";
    await showCommonDialogWithSingleOption(Globals.context, Msg,
        positiveButtonTitle: "OK", onTapOfPositiveButton: () {
      navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
    });
    // Navigator.of(context).pop();
  }

  CreateDialogDropdown(String category) {
    if (category == "Inquiry Status") {
      _FollowupBloc.add(InquiryLeadStatusTypeListByNameCallEvent(
          FollowupInquiryStatusTypeListRequest(
              CompanyId: CompanyID.toString(),
              pkID: "",
              StatusCategory: "Inquiry",
              LoginUserID: LoginUserID,
              SearchKey: "")));
    } else if (category == "Followup Type") {
      _FollowupBloc.add(FollowupTypeListByNameCallEvent(FollowupTypeListRequest(
          CompanyId: CompanyID.toString(),
          pkID: "",
          StatusCategory: "FollowUp",
          LoginUserID: LoginUserID,
          SearchKey: "")));
    } else {
      _FollowupBloc
        ..add(CloserReasonTypeListByNameCallEvent(CloserReasonTypeListRequest(
            CompanyId: CompanyID.toString(),
            pkID: "",
            StatusCategory: "DisQualifiedReason",
            LoginUserID: LoginUserID,
            SearchKey: "")));
    }
  }

  void _onLeadStatusListTypeCallSuccess(
      InquiryLeadStatusListCallResponseState state) {
    if (state.inquiryStatusListResponse.details.length != 0) {
      arr_ALL_Name_ID_For_FolowupInquiryStatusType.clear();
      for (var i = 0; i < state.inquiryStatusListResponse.details.length; i++) {
        print("InquiryStatus : " +
            state.inquiryStatusListResponse.details[i].inquiryStatus);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name =
            state.inquiryStatusListResponse.details[i].inquiryStatus;
        all_name_id.pkID = state.inquiryStatusListResponse.details[i].pkID;
        arr_ALL_Name_ID_For_FolowupInquiryStatusType.add(all_name_id);
      }
      showcustomdialogWithID(
          values: arr_ALL_Name_ID_For_FolowupInquiryStatusType,
          context1: context,
          controller: edt_FollowupInquiryStatusType,
          controllerID: edt_FollowupInquiryStatusTypepkID,
          lable: "Select Inquiry Status");
    }
  }

  void checkPermissionStatus() async {
    bool granted = await Permission.location.isGranted;
    bool Denied = await Permission.location.isDenied;
    bool PermanentlyDenied = await Permission.location.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();
      is_LocationService_Permission = false;

      await Permission.location.request();

      // await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (PermanentlyDenied == true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_LocationService_Permission = false;
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.
      is_LocationService_Permission = true;
    }
  }

  void checkPhotoPermissionStatus() async {
    bool granted = await Permission.storage.isGranted;
    bool Denied = await Permission.storage.isDenied;
    bool PermanentlyDenied = await Permission.storage.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();
      is_Storage_Service_Permission = false;

      await Permission.storage.request();

/*      showCommonDialogWithSingleOption(
          context, "Location permission is required , You have to click on OK button to Allow the location access !",
          positiveButtonTitle: "OK",
      onTapOfPositiveButton: () async {
         await openAppSettings();
         Navigator.of(context).pop();

      }

      );*/

      // await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (PermanentlyDenied == true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_Storage_Service_Permission = false;
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.
      is_Storage_Service_Permission = true;

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

  Future<void> permission() async {
    if (await Permission.storage.isDenied) {
      //await Permission.storage.request();

      checkPhotoPermissionStatus();
    }
  }
}
