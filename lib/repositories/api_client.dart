import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:soleoserp/models/common/globals.dart';
import 'package:soleoserp/utils/date_time_extensions.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'custom_exception.dart';
import 'error_response_exception.dart';

class ApiClient {
  ///set apis' base url here

  static const BASE_URL = 'http://122.169.111.101:108/';

  /// General Flutter Test SerialKey = TEST-0000-SI0F-0208 / ID : admin / Pwd : Sharvaya / SiteURL : 122.169.11.101:3346

  ///Testing Project Credential
  /*

SharvayaNativeTEST  : [BaseURL(API)]:	http://122.169.111.101:107/ [WebURL]:http://122.169.111.101:207/  CompanyID:4131	SerailsKey:TEST-0000-SI0N-0207
SharvayaFlutterTEST : [BaseURL(API)]:	http://122.169.111.101:108/ [WebURL]:http://122.169.111.101:208/  CompanyID:4132	SerailsKey:TEST-0000-SI0F-0208
SoleosFlutterTEST   : [BaseURL(API)]:	http://122.169.111.101:112/ [WebURL]:http://122.169.111.101:212/  CompanyID:4133	SerailsKey:TEST-0000-SOLF-0212
DolphinFlutterTEST  : [BaseURL(API)]:	http://122.169.111.101:105/ [WebURL]:http://122.169.111.101:205/  CompanyID:4134	SerailsKey:TEST-0000-DOLF-0205
CartFlutterAPITEST  : [BaseURL(API)]:	http://122.169.111.101:106/ [WebURL]:http://122.169.111.101:206/  CompanyID:4135	SerailsKey:TEST-0000-CARF-0206

 */

  /// Live Project Credential
  /*

SharvayaNativeLive  : [BaseURL(API)]:	http://208.109.14.134:82/ [WebURL]:http://122.169.111.101:207/  CompanyID:4131	SerailsKey:TEST-0000-SI0N-0207
SharvayaFlutterLive : [BaseURL(API)]:	http://208.109.14.134:83/ [WebURL]:http://122.169.111.101:208/  CompanyID:1007	SerailsKey:6CTR-6KWG-3TQV-3WU0
SoleosFlutterLive   : [BaseURL(API)]:	http://208.109.14.134:84/ [WebURL]:http://122.169.111.101:212/  CompanyID:4133	SerailsKey:TEST-0000-SOLF-0212
DolphinFlutterLive  : [BaseURL(API)]:	http://208.109.14.134:85/ [WebURL]:http://122.169.111.101:205/  CompanyID:4134	SerailsKey:TEST-0000-DOLF-0205
CartFlutterLive     : [BaseURL(API)]:	http://208.109.14.134:86/ [WebURL]:http://122.169.111.101:206/  CompanyID:4135	SerailsKey:TEST-0000-CARF-0206

 */

  ///add end point of your apis as below
  static const END_POINT_LOGIN = 'Login/SerialKey';

  /// end point of login User Details
  static const END_POINT_LOGIN_USER_DETAILS = 'Login';
  static const END_POINT_LIST = 'users';
  static const END_POINT_CUSTOMER_CATEGORY = 'Customer/CategoryList';
  static const END_POINT_CUSTOMER_SOURCE = 'Customer/Source';
  static const END_POINT_COUNTRYLIST = 'Country/List';
  static const END_POINT_STATELIST = 'Customer/States/Search';
  static const END_POINT_CUSTOMER_PAGINATION = 'Customer';
  static const END_POINT_CUSTOMER_SEARCH = 'Customer/Search';
  static const END_POINT_CUSTOMER_SEARCH_BY_ID = 'Customer/';
  static const END_POINT_MENU_RIGHTS = "Dashboard/MenuList";
  static const End_POINT_DISTRICT_LIST = "Customer/District/Search";
  static const END_POINT_TALUKA_LIST = "Customer/Taluka/Search";
  static const END_POINT_CITY_LIST = "Customer/Cities/Search";
  static const END_POINT_INQUIRY = 'Inquiry';
  static const END_POINT_QUOTATION = 'Quatation';
  static const END_POINT_SALESBILL = 'SalesBill';

  static const END_POINT_FOLLOWUP = 'FollowUp';
  static const END_POINT_TODO = 'Todo/Search';
  static const END_POINT_INQUIRY_SEARCH_BY_NAME = 'Inquiry/SearchByName';
  static const END_POINT_INQUIRY_SEARCH_BY_PKID = 'Inquiry/';
  static const END_POINT_QUOTATION_SEARCH_BY_NAME = 'Quatation/Search';
  static const END_POINT_SALESORDER_PAGINATION = 'SalesOrder';
  static const END_POINT_INQUIRY_SEARCH_BY_INQUIRY_NO =
      'Inquiry/SearchByInquiryNo';
  static const END_POINT_QUOTATION_SEARCH_BY_QUOTATION_NO = 'Quatation/';
  static const END_POINT_SALESORDER_SEARCH_BY_NAME = 'SalesOrder/Search';
  static const END_POINT_QUOTATION_SEARCH_BY_SALESORDER_NO = 'SalesOrder/';
  static const END_POINT_FOLLOWUP_FILTER_PAGINATION = 'FollowUp/';
  static const END_POINT_FOLLOWUP_SEARCH_BY_STATUS = 'InquiryFollowUp/Status';
  static const END_POINT_FOLLOWER_EMPLOYEE_LIST =
      'Inquiry/EmployeeFollowerList';
  static const END_POINT_DESIGNATION_LIST = "Designation/List";
  static const END_POINT_CUSTOMER_ADD_EDIT = "Customer/";
  static const END_POINT_FOLLOWUP_TYPE_LIST =
      "Customer/Source"; //"Inquiry/Category";
  static const END_POINT_FOLLOWUP_INQUIRY_NO_LIST =
      "FollowUp/InquiryNoToFollowUp";
  static const END_POINT_FOLLOWUP_SAVE = "FollowUp/";
  static const END_POINT_FOLLOWUP_DELETE = "FollowUp/";
  static const END_POINT_EXPENSE_DELETE = "Expense/";
  static const END_POINT_INQUIRY_DELETE = "Inquiry/";
  static const END_POINT_LEAVE_REQUEST_DELETE = "LeaveRequest/";
  static const END_POINT_CUSTOMER_DELETE = "Customer/";
  static const END_POINT_ATTENDANCE_LIST = "DailyAttendance/List";
  static const END_POINT_ATTENDANCE_SAVE = "DailyAttendance/0/Save";
  static const END_POINT_ATTENDANCE_DELETE = "Attendance/";
  static const END_POINT_LEAVE_REQUEST_PAGINATION = "LeaveRequest";
  static const END_POINT_LEAVE_REQUEST_TYPE = "LeaveRequest/Type";
  static const END_POINT_LEAVE_REQUEST_SAVE = "LeaveRequest/";
  static const END_POINT_EXPENSE_PAGINATION_FILTER = "Expense/Search";
  static const END_POINT_EXPENSE_TYPE = "/Expense/ExpenseType";
  static const END_POINT_EXPENSE_SAVE = "Expense/";
  static const END_POINT_EXPENSE_UPLOAD = "Expense/UploadImage";
  static const END_POINT_FOLLOWUP_UPLOAD = "FollowUp/UploadImage";

  static const END_POINT_EXPENSE_UPLOAD_SERVER = "Expense/";
  static const END_POINT_EXPENSE_DELETE_IMAGE = "Expense/";
  static const END_POINT_FOLLOWUP_INQUIRY_BY_CUSTOMER_ID =
      "Inquiry/FetchByCustomerID";
  static const END_POINT_PRODUCT_SEARCH = "Inquiry/Product/List";
  static const END_POINT_CUSTOMER_CONTACT_SAVE = "Customer/Contacts/INS_UPD";
  static const END_POINT_INQUIRY_HEADER_SAVE = "Inquiry/";
  static const END_POINT_INQUIRY_NO_TO_PRODUCT_LIST = "Inquiry/Products/1-1000";
  static const END_POINT_INQUIRY_NO_TO_DELETE_PRODUCT_LIST = "Inquiry/";
  static const END_POINT_CUSTOMER_ID_TO_CONTACT_DETAILS =
      "Customer/Contacts/Search";
  static const END_POINT_CUSTOMER_ID_TO_CONTACT_ALL_DELETE =
      "Customer/Contacts/";
  static const END_POINT_FOLLOWUP_IMAGE_DELETE_BY_PK_ID = "FollowUp/";

  static const END_POINT_INQUIRY_PRODUCT_SAVE = "Inquiry/Product/INS_UPD";
  static const END_POINT_FETCH_IMAGE_LIST_BY_EXPENSE_PKID =
      'Expense/0/ImageList';
  static const END_POINT_GOOGLE_PLACE_SEARCH =
      'https://maps.googleapis.com/maps/api/place/textsearch/json';

  static const END_POINT_DISTANCE_MATRIX =
      'https://maps.googleapis.com/maps/api/distancematrix/json';
  static const END_POINT_LOCATION_ADDRESS =
      'https://maps.google.com/maps/api/geocode/json';
  static const END_POINT_FOLLOWUP_HISTORY_LIST =
      "InquiryNo/FollowUpDetail"; //"Inquiry/Category";
  static const END_POINT_INQUIRY_NO_FOLLLOWUP_DETAILS =
      "InquiryNo/FollowUpDetail";
  static const END_POINT_DAILY_ACTIVITY_LIST_DETAILS = "DailyActivity";
  static const END_POINT_DAILY_ACTIVITY_DELETE = "DailyActivity/";
  static const END_POINT_TASK_CATEGORY = "DailyActivity/TaskCategoryList";
  static const END_POINT_DAILY_ACTIVITY_SAVE_DETAILS = "DailyActivity";
  static const END_POINT_TO_DO_SAVE = "Todo/";
  static const END_POINT_TO_DO_WORK_LOG = "TodoLog/List";
  static const END_POINT_SALES_BILL_SEARCH_BY_NAME = 'SalesBill/Search';
  static const END_POINT_QUOTATION_GENERATE_PDF = 'Quatation/GenerateQuotation';
  static const END_POINT_SALES_ORDER_GENERATE_PDF =
      'SalesOrder/GenerateSalesOrder';
  static const END_POINT_SALES_BILL_GENERATE_PDF =
      'SalesBill/GenerateSalesBill';

  static const END_POINT_INQUIRY_SHARE = "InquiryOwner/Share";
  static const END_POINT_ALL_EMPLOYEE_LIST = 'Inquiry/OrgEmployeeList';
  static const END_POINT_INQUIRY_SHARED_EMP_LIST = 'Inquiry/Share';
  static const END_POINT_BANK_VOUCHER_LIST_DETAILS = "FinancialTransaction";
  static const END_POINT_BANK_VOUCHER_SEARCH = 'FinancialTransaction/Search';
  static const END_POINT_TRANSECTION_MODE_LIST_DETAILS =
      "FinancialTransaction/Wallet";

  static const END_POINT_BANK_DROP_DOWN = 'SalesOrder/BankDetails';
  static const END_POINT_COMPLAINT_LIST_DETAILS = "Complaint";
  static const END_POINT_COMPLAINT_SEARCH_BY_NAME_DETAILS = "Complaint/Search";
  static const END_POINT_COMPLAINT_SEARCH_BY_ID_DETAILS = "Complaint";

  static const END_POINT_COMPLAINT_SAVE_DETAILS = "Complaint";
  static const END_POINT_ATTEND_VISIT_DETAILS = "ComplaintVisit";
  static const END_POINT_COMPLAINT_NO_LIST_DETAILS =
      "ComplaintVisit/CustomerID";
  static const END_POINT_ATTEND_VISIT_SAVE_DETAILS = "ComplaintVisit";
  static const END_POINT_ATTEND_VISIT_SEARCH_DETAILS = "ComplaintVisit/Search";

  static const END_POINT_QTNO_TO_PRODUCT_LIST = 'Quatation/Products';
  static const END_POINT_QUOTATION_SPEC_LIST = 'Quatation/0/Specifications';
  static const END_POINT_QUOTATION_KIND_ATT_LIST = 'Quatation/KindlyAttention';
  static const END_POINT_QUOTATION_PROJECT_LIST = 'Quatation/ProjectList';
  static const END_POINT_QUOTATION_TERMS_CONDITION_LIST = 'Quatation/TNC';
  static const END_POINT_CUST_ID_TO_INQ_LIST =
      'Quatation/CustomerIdToInquiryNo';
  static const END_POINT_INQ_NO_PRODUCT_LIST =
      'Quatation/CustomerIdToInquiryDetail';
  static const END_POINT_QUOTATION_HEADER_REQUEST = "Quatation";
  static const END_POINT_QUOTATION_PRODUCT_SAVE = "Quatation";
  static const END_POINT_QT_NO_TO_DELETE_PRODUCT_LIST = "Quatation/";
  static const END_POINT_DELETE_QUOTATION = "Quatation/";

  static const END_POINT_EMPLOYEE_LIST_DETAILS = "Employee";
  static const END_POINT_EMPLOYEE_SEARCH_DETAILS = "Employee/SearchByName";
  static const END_POINT_EMPLOYEE_DELETE_DETAILS = "Employee";

  static const END_POINT_LOAN_LIST_DETAILS = "Loan";
  static const END_POINT_LOAN_SEARCH_DETAILS = "Loan/Search";
  static const END_POINT_LOAN_DELETE_DETAILS = "Loan";
  static const END_POINT_LOAN_APPROVAL_LIST_DETAILS = "Loan/ByApprovalStatus";
  static const END_POINT_LOAN_APPROVAL_SAVE_DETAILS = "Loan/";

  static const END_POINT_MISSED_PUNCH_LIST_DETAILS = "MissedPunch";
  static const END_POINT_MISSED_PUNCH_SEARCH_DETAILS = "MissedPunch/Search";
  static const END_POINT_MISSED_PUNCH_SEARCH_BY_ID_DETAILS = "MissedPunch/";
  static const END_POINT_MISSED_PUNCH_DELETE_BY_ID_DETAILS = "MissedPunch/";

  static const END_POINT_SALARY_UPAD_LIST_DETAILS = "Salary";
  static const END_POINT_MISSED_SALARY_UPAD_DELETE_BY_ID_DETAILS = "Salary";

  static const END_POINT_MAINTENANCE_LIST_DETAILS = "Maintanance";

  static const END_POINT_MAINTENANCE_SEARCH_DETAILS = "Maintanance/Search";
  static const END_POINT_MISSED_PUNCH_APPROVAL_LIST_DETAILS =
      "MissedPunch/ListByStatus";
  static const END_POINT_EXTERNAL_LEAD_SEARCH_DETAILS = "ExternalLead/Search";
  static const END_POINT_EXTERNAL_LEAD_SAVE_DETAILS = "ExternalLead";

  static const TAG = "ApiClient";

  static const END_POINT_EXTERNAL_LEAD_PAGINATION = 'ExternalLead';

  static const END_POINT_TELE_CALLER_PAGINATION = 'TeleCaller';
  static const END_POINT_TELE_CALLER_SEARCH_DETAILS = "TeleCaller/Search";
  static const END_POINT_TELE_CALLER_PAGINATION1 = 'TeleCaller123';

  static const END_POINT_DOLPHIN_ATTEND_VISIT_DETAILS = "DolComplaintVisit";
  static const END_POINT_DOLPHIN_COMPLAINT_VISIT_SEARCH_DETAILS =
      "DolComplaintVisit/Search";
  static const END_POINT_DOLPHIN_COMPLAINT_VISIT_SEARCH_ID_DETAILS =
      "DolComplaintVisit";
  static const END_POINT_DOLPHIN_COMPLAINT_VISIT_DELETE_DETAILS =
      "DolComplaintVisit/CompaintDel";
  static const END_POINT_DOLPHIN_COMPLAINT_VISIT_SAVE_DETAILS =
      "DolComplaintVisit";

  static const END_POINT_Packing_checklist_list = 'PackingCheckList';
  static const END_POINT_Final_Checking_List = 'FinalChecking';
  static const END_POINT_Production_Activity_List = 'Production/Filter';
  static const END_POINT_Installation_Search = 'Installation/Search';
  static const END_POINT_FinalChecking_Search = 'FinalChecking/Search';
  static const END_POINT_PackingChecklist_Search = 'PackingCheckList/Search';
  static const END_POINT_PackingChecklist_DELETE = 'PackingChecking';
  static const END_POINT_PackingOutWord_List = 'CustomerID/OrderNo';
  static const END_POINT_PackingProductAssamblyList =
      'PackingChecking/SalesOrderAssemblyList';
  static const END_POINT_Product_GroupDropDown =
      'PackingCheckList/ProductGroup';
  static const END_POINT_Product_DropDown = 'PackingCheckList/ProductNameList';
  static const END_POINT_PACKING_SAVE = 'PackingCheckList/';
  static const END_POINT_PACKING_ASSAMBLY_SAVE = 'PackinAssembly/0/DetailSave';
  static const END_POINT_PACKING_NO_LIST = 'CustomerID/PackingNoList';
  static const END_POINT_PACKING_ASSAMBLY_EDIT_MODE = 'PackingDetail/List';
  static const END_POINT_PACKING_ASSAMBLY_ALL_DELETE = 'PackingAssembly/';
  static const END_POINT_FINAL_CHECKING_ITEMS = 'CustomerID/CatDescSSRList';
  static const END_POINT_CHECKING_TO_CHECKING_ITEMS =
      'FinalCheckingDetail/List';
  static const END_POINT_FINAL_CHEKING_SAVE = 'FinalChecking/';
  static const END_POINT_FINAL_CHECKING_SUB_DETAILS_SAVE =
      'FinalCheckingDetail/0/DetailSave';
  static const END_POINT_FINAL_CHEKING_DELETE_ALL_ITEM = 'FinalCheckingDetail/';
  static const END_POINT_FINAL_CHEKING_DELETE_FROM_LIST_SCREEN =
      'FinalChecking/';

  static const END_POINT_Installation_List = 'Installation';
  static const END_POINT_Save_Installation_List = 'Installation';
  static const END_POINT_Delete_Installation = 'Installation';
  static const END_POINT_Installation_country = 'Customer/Country';
  static const END_POINT_Id_To_Outward = 'CustomerID/OutwardNoList';
  static const END_POINT_Installation_employee = 'Inquiry/OrgEmployeeList';
  static const END_POINT_Production_Typeofwork =
      'DailyActivity/TaskCategoryList';
  static const END_POINT_Production_packinglist = 'Production/PackingNoList';
  static const END_POINT_Production_Save = 'Production';
  static const END_POINT_QUICK_FOLLOWUP_LIST = 'FollowUp/ActiveStatus';
  static const END_POINT_QUICK_FOLLOWUP_SAVE = "QuickFollowUp/";
  static const END_POINT_TELE_CALLER_New_pagination = 'TeleCaller123';
  static const END_POINT_NEW_TELE_CALLER_SAVE = 'SwastikTeleCaller';
  static const END_POINT_INQUIRY_SEARCH_BY_FILLTER = 'Inquiry/SearchList';
  static const END_POINT_TELECALLER_IMG_UPLOAD = "TeleCaller/UploadImage";
  static const END_POINT_TELECALLER_IMAGE_DELETE_BY_PK_ID = "TeleCaller/";
  static const END_POINT_TO_DO_DELETE = "Todo";
  static const END_POINT_ATTEND_VISIT_DELETE = "ComplaintVisit/CompaintDel";
  static const END_POINT_SALES_BILL_BY_ID = "SalesBill/";
  static const END_POINT_MISSED_PUNCH_APPROVAL_SAVE = "MissedPunch/";
  static const END_POINT_SALES_ORDER_BANK_DETIALS = "SalesOrder/BankDetails";
  static const END_POINT_SALES_BILL_EMAIL_CONTENT =
      "Quatation/0/GeneralEmailList";
  static const END_POINT_SALES_BILL_INQ_QT_SO_NO_LIST_API =
      "SalesBill/CustomerIDToModuleDetails";

  /******************************Material Inward******************************/
  static const END_POINT_MATERIAL_INWARD_LIST = 'Inward';
  static const END_POINT_MATERIAL_OUTWARD_LIST = 'Outward';
  static const API_TOKEN_UPDATE = 'Common/UserWiseTokenUpdate';

  final http.Client httpClient;

  ApiClient({this.httpClient});

  ///GET api call
  Future<dynamic> apiCallGet(String url, {String query = ""}) async {
    var responseJson;
    var getUrl;

    if (query.isNotEmpty) {
      getUrl = '$BASE_URL$url?$query';
    } else {
      getUrl = '$BASE_URL$url';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Api request url : $getUrl");
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print("Api request url : $getUrl\nHeaders - $headers");

    try {
      final response = await httpClient
          .get(Uri.parse(getUrl), headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = await _response(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  ///POST api call
  Future<dynamic> apiCallPost(
    String url,
    Map<String, dynamic> requestJsonMap, {
    String baseUrl = BASE_URL,
    bool showSuccessDialog = false,
    //dynamic jsontemparray,
  }) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Headers - $headers");
    //String asd = json.encode(jsontemparray);
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap" /*+ "JSON Array $asd"*/);
    try {
      final response = await httpClient
          .post(Uri.parse("$baseUrl$url"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));

      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  Future<dynamic> apiCallPostforMultipleJSONArray(
    String url,
    dynamic jsontemparray, {
    String baseUrl = BASE_URL,
    bool showSuccessDialog = false,
    //dynamic jsontemparray,
  }) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Headers - $headers");
    String asd = json.encode(jsontemparray);
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $asd" /*+ "JSON Array $asd"*/);
    try {
      final response = await httpClient
          .post(Uri.parse("$baseUrl$url"),
              headers: headers,
              body: (jsontemparray == null) ? null : json.encode(jsontemparray))
          .timeout(const Duration(seconds: 60));

      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  ///POST api call with multipart and multiple image

  Future<dynamic> apiCallPostMultipart(
      String url, Map<String, dynamic> requestJsonMap,
      {List<File> imageFilesToUpload,
      String baseUrl = BASE_URL,
      String imageFieldKey = "image",
      bool showSuccessDialog: false}) async {
    var responseJson;
    print("$baseUrl$url\n$requestJsonMap");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (!imageFilesToUpload[0].existsSync()) {
      print("file not exist");
    }

    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");

    final request = http.MultipartRequest("POST", Uri.parse("$baseUrl$url"));
    if (requestJsonMap != null) {
      request.fields.addAll(requestJsonMap);
    }
    request.headers.addAll(headers);

    if (imageFilesToUpload != null) {
      imageFilesToUpload.forEach((element) async {
        if (element != null) {
          var pic =
              await http.MultipartFile.fromPath(imageFieldKey, element.path);
          request.files.add(pic);
        }
      });
    }
    //upload kro?

    try {
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson =
          await _responseLogin(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  /*Future<dynamic> apiCallPostMultipart(
      String url, Map<String, dynamic> requestJsonMap,
      {List<File> imageFilesToUpload,
        String baseUrl = BASE_URL,
        String imageFieldKey = "image",
        bool showSuccessDialog: false}) async {
    var responseJson;
    print("$baseUrl$url\n$requestJsonMap");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

    };

    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");

    final request = http.MultipartRequest("POST", Uri.parse("$baseUrl$url"));
    if (requestJsonMap != null) {
      request.fields.addAll(requestJsonMap);
    }
    request.headers.addAll(headers);

    if (imageFilesToUpload != null) {
      imageFilesToUpload.forEach((element) async {
        if (element != null) {
          var pic =
          await http.MultipartFile.fromPath(imageFieldKey, element.path);
          request.files.add(pic);
        }
      });

    }

    try {
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson =
      await _responseLogin(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }*/

  ///POST api call pagination
  Future<dynamic> apiCallPostPagination(
    String url,
    String query,
    Map<String, dynamic> requestJsonMap, {
    String baseUrl = BASE_URL,
    bool showSuccessDialog = false,
  }) async {
    var responseJson;
    var geturl;

    if (query.isNotEmpty) {
      geturl = '$BASE_URL$url/$query-10';
    } else {
      geturl = '$BASE_URL$url/0-10';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Headers - $headers");
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");
    try {
      final response = await httpClient
          .post(Uri.parse("$geturl"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));

      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  /// Post api for Login_USer Details
  Future<dynamic> apiCallLoginUSerPost(
    String url,
    Map<String, dynamic> requestJsonMap, {
    String baseUrl = BASE_URL,
    bool showSuccessDialog = false,
  }) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Headers - $headers");
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");
    try {
      final response = await httpClient
          .post(Uri.parse("$baseUrl$url"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));

      responseJson =
          await _responseLogin(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  /// Post api for Login_USer Details
  Future<dynamic> apiCallCustomerPaginationPost(
    String url,
    Map<String, dynamic> requestJsonMap, {
    String baseUrl = BASE_URL,
    bool showSuccessDialog = false,
  }) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Headers - $headers");
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");
    try {
      final response = await httpClient
          .post(Uri.parse("$baseUrl$url"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));

      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  ///PUT api call with multipart and single image
  Future<dynamic> apiCallPutMultipart(
      String url, Map<String, String> requestJsonMap,
      {File imageFileToUpload, String baseUrl = BASE_URL}) async {
    var responseJson;
    print("$baseUrl$url\n$requestJsonMap");
    Map<String, String> headers = {};
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");

    final request = http.MultipartRequest("PUT", Uri.parse("$baseUrl$url"));
    request.fields.addAll(requestJsonMap);
    request.headers.addAll(headers);

    if (imageFileToUpload != null) {
      var pic =
          await http.MultipartFile.fromPath("image", imageFileToUpload.path);
      request.files.add(pic);
    }

    try {
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson = await _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  ///PUT api call with multipart and single image
  ///AWS api call
  Future<void> awsApiCallPut(
    String url,
    Map<String, String> requestJsonMap, {
    @required File imageFileToUpload,
  }) async {
    print("$url\n$requestJsonMap");
    print("Api request url : $url\nApi request params : $requestJsonMap");
    try {
      Uint8List bytes = imageFileToUpload.readAsBytesSync();

      var responseJson = await http.put(Uri.parse(url), body: bytes, headers: {
        "Content-Type":
            "image/${path.extension(imageFileToUpload.path).substring(1)}"
      });
      if (responseJson.statusCode == 200) {
        //uploaded successfully
        print("Response - ${responseJson.body}");
      } else {
        //uploading failed
        throw BadRequestException(
            "Uploading file operation failed, please try again later");
      }
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    } catch (e) {
      print("exception e - $e");
      throw e;
    }
  }

  /*  Future<dynamic> apiCallPostMultipart(
      String url, Map<String, String> requestJsonMap,
      {List<File> imageFilesToUpload,
        String baseUrl = BASE_URL,
        String imageFieldKey = "image",
        bool showSuccessDialog: false}) async {
    var responseJson;
    print("$baseUrl$url\n$requestJsonMap");
    Map<String, String> headers = {};
    String authToken =
    SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");

    final request = http.MultipartRequest("POST", Uri.parse("$baseUrl$url"));
    if (requestJsonMap != null) {
      request.fields.addAll(requestJsonMap);
    }
    request.headers.addAll(headers);

    if (imageFilesToUpload != null) {
      imageFilesToUpload.forEach((element) async {
        if (element != null) {
          var pic =
          await http.MultipartFile.fromPath(imageFieldKey, element.path);
          request.files.add(pic);
        }
      });
    }

    try {
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      responseJson =
      await _responseLogin(response, showSuccessDialog: showSuccessDialog);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }*/

  ///PUT api call
  Future<dynamic> apiCallPut(String url, Map<String, dynamic> requestJsonMap,
      {String baseUrl = BASE_URL, bool showSuccessDialog = false}) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}

    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");
    try {
      final response = await httpClient
          .put(Uri.parse("$baseUrl$url"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));
      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  ///DELETE api call
  Future<dynamic> apiCallDelete(String url, Map<String, dynamic> requestJsonMap,
      {String baseUrl = BASE_URL, bool showSuccessDialog = false}) async {
    var responseJson;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }
    print("$baseUrl$url");

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print(
        "Api request url : $baseUrl$url\nHeaders - $headers\nApi request params : $requestJsonMap");

    try {
      final response = await httpClient
          .delete(Uri.parse("$baseUrl$url"),
              headers: headers,
              body:
                  (requestJsonMap == null) ? null : json.encode(requestJsonMap))
          .timeout(const Duration(seconds: 60));
      responseJson =
          await _response(response, showSuccessDialog: showSuccessDialog);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request time out');
    }
    return responseJson;
  }

  ///handling whole response
  ///decrypts response and checks for all status code error
  ///returns "data" object response if status is success

  Future<dynamic> _response(http.Response response,
      {bool showSuccessDialog = false}) async {
    debugPrint("Api response\n${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        final data = responseJson["Data"];
        final message = responseJson["Message"];

        if (responseJson["Status"] == 1) {
          if (showSuccessDialog) {
            await showCommonDialogWithSingleOption(Globals.context, message,
                positiveButtonTitle: "OK");
          }

          return data;
        }
        if (responseJson["Status"] == 2) {
          if (showSuccessDialog) {
            await showCommonDialogWithSingleOption(Globals.context, message,
                positiveButtonTitle: "OK");
          }

          return data;
        }
        if (responseJson["Status"] == 3) {
          await showCommonDialogWithSingleOption(Globals.context, message,
              positiveButtonTitle: "OK");

          return data;
        }
        if (data is Map<String, dynamic>) {
          throw ErrorResponseException(data, message);
        }
        throw ErrorResponseException(null, message);
      case 400:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw ServerErrorException(message.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> _responseLogin(http.Response response,
      {bool showSuccessDialog = false}) async {
    debugPrint("Api response\n${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);

        return responseJson;

      case 400:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw UnauthorisedException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message = responseJson["message"];
        throw ServerErrorException(message.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> _responseImage(http.Response response,
      {bool showSuccessDialog = false}) async {
    debugPrint("Api response\n${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        //final data = responseJson["details"];
        // final message = responseJson["Message"];

        /* if (responseJson["Status"] == 1) {
          if (showSuccessDialog) {
            await showCommonDialogWithSingleOption(Globals.context, message,
                positiveButtonTitle: "OK");
          }

          return data;
        }
        if (responseJson["Status"] == 2) {
          if (showSuccessDialog) {
            await showCommonDialogWithSingleOption(Globals.context, message,
                positiveButtonTitle: "OK");
          }

          return data;
        }*/
        return responseJson;
      /* if (data is Map<String, dynamic>) {
          throw ErrorResponseException(data, message);
        }
        throw ErrorResponseException(null, message);*/
      case 400:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message = responseJson["Message"];
        throw ServerErrorException(message.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<dynamic> apiCallGoogleGetDistance(String url,
      {String origins = "", String destinations = "", String key = ""}) async {
    var responseJson;
    var getUrl;

    if (origins.isNotEmpty) {
      getUrl = '$url?origins=$origins&destinations=$destinations&key=$key';
    } else {
      getUrl = '$url';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Api request url : $getUrl");
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print("Api request url : $getUrl\nHeaders - $headers");

    try {
      final response = await httpClient
          .get(Uri.parse(getUrl), headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = await _responseGoogle(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> apiCallGoogleGetLocationAddress(String url,
      {String latlng = "", String key = ""}) async {
    var responseJson;
    var getUrl;

    if (latlng.isNotEmpty) {
      getUrl = '$url?key=$key&latlng=$latlng';
    } else {
      getUrl = '$url';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Api request url : $getUrl");
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print("Api request url : $getUrl\nHeaders - $headers");

    try {
      final response = await httpClient
          .get(Uri.parse(getUrl), headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = await _responseGoogle(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> apiCallGoogleGet(String url,
      {String query = "", String key = ""}) async {
    var responseJson;
    var getUrl;

    if (query.isNotEmpty) {
      getUrl = '$url?query=$query&key=$key';
    } else {
      getUrl = '$url';
    }

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print("Api request url : $getUrl");
    String authToken =
        SharedPrefHelper.instance.getString(SharedPrefHelper.AUTH_TOKEN_STRING);
    if (authToken != null && authToken.isNotEmpty) {
      headers['access-token'] = "$authToken";
    }

    try {
      String timeZone = await getCurrentTimeZone();
      if (timeZone != null && timeZone.isNotEmpty) {
        headers['timeZone'] = timeZone;
      }
    } catch (e) {}
    print("Api request url : $getUrl\nHeaders - $headers");

    try {
      final response = await httpClient
          .get(Uri.parse(getUrl), headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = await _responseGoogle(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> _responseGoogle(http.Response response,
      {bool showSuccessDialog = false}) async {
    debugPrint("Api response\n${response.body}");
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        final data = responseJson; //["results"];
        //final message = responseJson["Message"];

        return data;

        if (data is Map<String, dynamic>) {
          throw ErrorResponseException(data, "RetriveDataSucess");
        }
        throw ErrorResponseException(null, "RetriveDataFail");
      case 400:
        var responseJson = json.decode(response.body);
        final message =
            "RetriveDataFail With Status Code 400"; //responseJson["Message"];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body);
        final message =
            "RetriveDataFail With Status Code 401"; //responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body);
        final message =
            "RetriveDataFail With Status Code 403"; //responseJson["Message"];
        throw UnauthorisedException(message.toString());
      case 404:
        var responseJson = json.decode(response.body);
        final message =
            "RetriveDataFail With Status Code 404"; //responseJson["Message"];
        throw NotFoundException(message.toString());
      case 500:
        var responseJson = json.decode(response.body);
        final message =
            "RetriveDataFail With Status Code 500"; //responseJson["Message"];
        throw ServerErrorException(message.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
