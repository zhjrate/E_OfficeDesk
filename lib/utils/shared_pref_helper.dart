import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/closer_reason_list_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_category_list.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/expense_type_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_type_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_type_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';


class SharedPrefHelper {
  final SharedPreferences prefs;
  static SharedPrefHelper instance;

  ///key names for preference data storage
  static const String IS_LOGGED_IN_DATA = "logged_in_data";
  static const String IS_COMPANY_LOGGED_IN_DATA = "company_logged_in_data";
  static const String IS_SALES_LIST_IN_DATA = "sale_list_in_data";

  static const String IS_CUSTOMER_CATEGORY_IN_DATA = "customer_category_in_data";
  static const String IS_CUSTOMER_SOURCE_IN_DATA = "customer_source_in_data";
  static const String IS_CUSTOMER_DESIGNATION_IN_DATA = "customer_designation_in_data";
  static const String IS_INQUIRY_LEAD_STATUS_IN_DATA = "inquiry_lead_status_in_data";
  static const String IS_FOLLOWER_EMPLOYEE_LIST_IN_DATA = "follower_employee_in_data";
  static const String IS_ALL_EMPLOYEE_LIST_IN_DATA = "all_employee_in_data";

  static const String IS_FollowupTypeListResponse_IN_DATA = "followup_type_list_in_data";

  static const String IS_CloserReasonListResponse_IN_DATA = "CloserReasonListResponse_in_data";
  static const String IS_LeaveRequestTypeResponse_IN_DATA = "LeaveRequestTypeResponse_in_data1";
  static const String IS_EXPENSE_TYPE_IN_DATA = "expenseType_in_data";


  static const String IS_REGISTERED = "is_registered";
  static const String AUTH_TOKEN_STRING = "auth_token";
  static const String IS_LOGGED_IN_USER_DATA = "logged_User_in_data";
  static const String GEN_LATITUDE = "Latitude";
  static const String GEN_LONGITUDE = "Longitude";



  SharedPrefHelper(this.prefs);

  static Future<void> createInstance() async {
    instance = SharedPrefHelper(await SharedPreferences.getInstance());
  }

  Future<void> putBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    if (prefs.containsKey(key)) {
      return prefs.getBool(key);
    }
    return defaultValue;
  }

  Future<void> putDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    if (prefs.containsKey(key)) {
      return prefs.getDouble(key);
    }
    return defaultValue;
  }

  Future<void> putString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String getString(String key, {String defaultValue = ""}) {
    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    }
    return defaultValue;
  }

  Future<void> putInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    if (prefs.containsKey(key)) {
      return prefs.getInt(key);
    }
    return defaultValue;
  }


  setLatitude(String latitude) async {
    await putString(GEN_LATITUDE,latitude);
  }
  getLatitude(){
    return getString(GEN_LATITUDE);
  }

  setLongitude(String longitude) async {
    await putString(GEN_LONGITUDE,longitude);
  }
  getLongitude(){
    return getString(GEN_LONGITUDE);
  }

  setCompanyData(CompanyDetailsResponse data) async {
    await putString(IS_COMPANY_LOGGED_IN_DATA, json.encode(data));
  }
  setCustomerCategoryData(CustomerCategoryResponse data) async {
    await putString(IS_CUSTOMER_CATEGORY_IN_DATA, json.encode(data));
  }
  setCustomerSourceData(CustomerSourceResponse data) async {
    await putString(IS_CUSTOMER_SOURCE_IN_DATA, json.encode(data));
  }
  setCustomerDesignationData(DesignationApiResponse data) async {
    await putString(IS_CUSTOMER_DESIGNATION_IN_DATA, json.encode(data));
  }
  setInquiryLeadStatusData(InquiryStatusListResponse data) async {
    await putString(IS_INQUIRY_LEAD_STATUS_IN_DATA, json.encode(data));
  }
  setFollowerEmployeeListData(FollowerEmployeeListResponse data) async {
    await putString(IS_FOLLOWER_EMPLOYEE_LIST_IN_DATA, json.encode(data));
  }

  setALLEmployeeListData(ALL_EmployeeList_Response data) async {
    await putString(IS_ALL_EMPLOYEE_LIST_IN_DATA, json.encode(data));
  }
  //FollowupTypeListResponse
  setFollowupTypeListResponse(FollowupTypeListResponse data) async {
    await putString(IS_FollowupTypeListResponse_IN_DATA, json.encode(data));
  }
  setLoginUserData(LoginUserDetialsResponse data) async {
    await putString(IS_LOGGED_IN_USER_DATA, json.encode(data));
  }

  setFollowupCloserReason(CloserReasonListResponse data) async {
    await putString(IS_CloserReasonListResponse_IN_DATA, json.encode(data));
  }
  setLeaveRequestType(LeaveRequestTypeResponse data) async {
    await putString(IS_LeaveRequestTypeResponse_IN_DATA, json.encode(data));
  }
  setExpenseType(ExpenseTypeResponse data) async {
    await putString(IS_EXPENSE_TYPE_IN_DATA, json.encode(data));
  }
  CompanyDetailsResponse getCompanyData()  {
    return CompanyDetailsResponse.fromJson(json.decode(getString(IS_COMPANY_LOGGED_IN_DATA)));
  }
  LoginUserDetialsResponse getLoginUserData()  {
    return LoginUserDetialsResponse.fromJson(json.decode(getString(IS_LOGGED_IN_USER_DATA)));
  }
  CustomerCategoryResponse getCustomerCategoryData()  {
    return CustomerCategoryResponse.fromJson(json.decode(getString(IS_CUSTOMER_CATEGORY_IN_DATA)));
  }
  CustomerSourceResponse getCustomerSourceData()  {
    return CustomerSourceResponse.fromJson(json.decode(getString(IS_CUSTOMER_SOURCE_IN_DATA)));
  }
  DesignationApiResponse getCustomerDesignationData()  {
    return DesignationApiResponse.fromJson(json.decode(getString(IS_CUSTOMER_DESIGNATION_IN_DATA)));
  }
  InquiryStatusListResponse getInquiryLeadStatus()  {
    return InquiryStatusListResponse.fromJson(json.decode(getString(IS_INQUIRY_LEAD_STATUS_IN_DATA)));
  }
  FollowerEmployeeListResponse getFollowerEmployeeList()  {
    return FollowerEmployeeListResponse.fromJson(json.decode(getString(IS_FOLLOWER_EMPLOYEE_LIST_IN_DATA)));
  }
  ALL_EmployeeList_Response getALLEmployeeList()  {
    return ALL_EmployeeList_Response.fromJson(json.decode(getString(IS_ALL_EMPLOYEE_LIST_IN_DATA)));
  }

  FollowupTypeListResponse getFollowupTypeListResponse()  {
    return FollowupTypeListResponse.fromJson(json.decode(getString(IS_FollowupTypeListResponse_IN_DATA)));
  }

  CloserReasonListResponse getFollowupCloserReason()  {
    return CloserReasonListResponse.fromJson(json.decode(getString(IS_CloserReasonListResponse_IN_DATA)));
  }

  LeaveRequestTypeResponse getLeaveRequestType()  {
    return LeaveRequestTypeResponse.fromJson(json.decode(getString(IS_LeaveRequestTypeResponse_IN_DATA)));
  }

  ExpenseTypeResponse getExpenseType()  {
    return ExpenseTypeResponse.fromJson(json.decode(getString(IS_EXPENSE_TYPE_IN_DATA)));
  }



  Future<bool> clear() async {
    return await prefs.clear();
  }

  bool isRegisteredIn() {
    return getBool(IS_REGISTERED) ?? false;
  }
  bool isLogIn() {
    return getBool(IS_LOGGED_IN_DATA) ?? false;
  }




 /* setSalesListData(String key, List<ALL_Name_ID> value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, json.encode(value));
  }

  Future<List<String>> getSalesListData(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getStringList(key);
  }*/

}
