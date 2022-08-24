import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart'
    as geolocator; // or whatever name you want
import 'package:location/location.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soleoserp/firebase_options.dart';
import 'package:soleoserp/ui/res/localizations/app_localizations.dart';
import 'package:soleoserp/ui/res/style_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Attend_Visit/Attend_Visit_Add_Edit/attend_visit_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Attend_Visit/Attend_Visit_List/attend_visit_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Attend_Visit/Attend_Visit_List/attend_visit_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/digital_signature.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/search_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/country_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/customer_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/distict_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_city_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_country_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_state_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerAdd_Edit/search_taluka_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/customer_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Customer/CustomerList/search_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_city_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_country_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_search_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/installation_state_search.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Installation/search_installation.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/CashVoucher/CashVoucherAddEdit/cash_voucher_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/CreditNote/credit_note_add_edit/credit_note_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/DebitNote/debit_note_add_edit/debit_note_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/ExpenseVoucher/expense_voucher_add_edit/expense_voucher_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/JournalVoucher/journal_voucher_add_edit_screen/journal_voucher_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageAccounts/PettyCashVoucher/petty_cash_voucher_add_edit/petty_cash_voucher_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/InspectionCheckList/inspection_check_list_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/JobCardInward/job_card_inward_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/JobCardOutward/job_card_outward_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialConsumption/material_consumption_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialIndent/material_indent_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialInward/material_inward_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialInward/material_inward_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialOutward/material_outward_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/MaterialOutward/material_outward_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/SiteSurvey/site_survey_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/StoreInward/store_inward_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ManageProduction/StoreOutward/store_outward_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/OfficeTODO/office_to_do.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/OfficeTODO/office_to_do_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_serach_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/ToDo/to_do_work_log_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/attendance/employee_attandance_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/attendance/employee_attendance_list.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_add_edit/bank_voucher_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_list/bank_voucher_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/bank_voucher/bank_voucher_list/search_bank_voucher_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/daily_activity/daily_activity_add_edit/daily_activity_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/daily_activity/daily_activity_list/daily_activity_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/daily_activity/daily_activity_list/search_daily_activity_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/dolphin_complaint_visit/dolphin_complaint_list/dolphin_complaint_visit_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/employee/employee_list/employee_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/employee/employee_list/employee_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/expense/expense_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/expense/expense_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/external_lead/external_lead_add_edit/external_lead_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/external_lead/external_lead_list/external_lead_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/external_lead/external_lead_list/search_external_lead_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_item_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/final_checking_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/final_checking/search_finalchecking.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_history_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/followup_pagination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/followup/search_followup_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/map_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/search_destination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/search_source_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/Followup_dialog/followup_inquiry_detail_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/add_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/customer_search/customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_add_edit.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_fillter/FollowupFromInquiry.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_fillter/inquiry_filter_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_product_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_product_shortcut_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/inquiry_share_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_product_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/inquiry/search_inquiry_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request/leave_request_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request/leave_request_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/leave_request_approval/leave_approval_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/loan/loan_list/loan_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/loan/loan_list/loan_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/loan_approval/loan_approval_list/loan_approval_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/maintenance/maintenance_list/maintenance_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/maintenance/maintenance_list/maintenance_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/missed_punch/missed_punch_list/missed_punch_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/missed_punch/missed_punch_list/missed_punch_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/missed_punch_approval/missed_punch_approval_list/missed_punch_approval_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_asambly_crud/packing_assambly_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_asambly_crud/packing_assambly_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_checklist_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/packing_checklist_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/region/country_list_for_packing.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/packing_checklist/search_packingchecklist_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/production_activity/production_activity_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/production_activity/production_activity_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_followup/quick_followup_add_edit/quick_followup_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_followup/quick_followup_list/quick_followup_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_inquiry/quick_inquiry_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quick_inquiry/search_quick_inquiry_customer_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotation_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotation_general_customer_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_product_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_add_edit/quotationdb/quotation_product_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/quotation_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/quotation/search_quotation_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salary_upad/salary_upad_list/salary_upad_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salary_upad/salary_upad_list/salary_upad_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sale_bill_list/sales_bill_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sale_bill_list/search_sales_bill_sceen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/module_no_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/sale_bill_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/sale_bill_db/sale_bill_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/sale_bill_db/sale_bill_product_list.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salebill/sales_bill_add_edit/sale_bill_db/sales_bill_product_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/SaleOrder_manan_design/saleorderdb/saleorder_other_charges_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/SaleOrder_manan_design/saleorderdb/saleorder_product_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/SaleOrder_manan_design/saleorderdb/salesorder_product_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/SaleOrder_manan_design/sales_order_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/salesorder_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/salesorder/search_salesorder_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller/telecaller_add_edit/company_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller/telecaller_add_edit/telecaller_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller/telecaller_list/telecaller_list_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller/telecaller_list/telecaller_list_search_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller_new/telecaller_new_add.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/telecaller_new/telecaller_new_pagintion.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/authentication/first_screen.dart';
import 'package:soleoserp/ui/screens/authentication/serial_key_screen.dart';
import 'package:soleoserp/ui/screens/pagination/pagination_demo_screen.dart';
import 'package:soleoserp/ui/screens/splash_screen.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'ui/screens/contactscrud/add_contact_screen.dart';
import 'ui/screens/contactscrud/contacts_crud_demo.dart';
import 'ui/screens/contactscrud/contacts_list_screen.dart';
import 'utils/offline_db_helper.dart';

Directory _appDocsDir;
String TitleNotificationSharvaya = "";

String Latitude;
String Longitude;
bool is_LocationService_Permission;
final Geolocator geolocator123 = Geolocator()..forceAndroidLocationManager;
Location location = new Location();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefHelper.createInstance();
  await OfflineDbHelper.createInstance();

  _appDocsDir = await getApplicationDocumentsDirectory();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
  checkPermissionStatus();
  runApp(MyApp());
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
    /*  showCommonDialogWithSingleOption(Globals.context,
        "Location permission is required , You have to click on OK button to Allow the location access !",
        positiveButtonTitle: "OK", onTapOfPositiveButton: () async {
      await openAppSettings();
      Navigator.of(Globals.context).pop();
    });*/

    await Permission.location.request();
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
    _getCurrentLocation();

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

_getCurrentLocation() {
  geolocator123
      .getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.best)
      .then((Position position) async {
    Longitude = position.longitude.toString();
    Latitude = position.latitude.toString();
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
    SharedPrefHelper.instance.setLatitude(Latitude);
    SharedPrefHelper.instance.setLongitude(Longitude);

    //  Address = "${first.featureName} : ${first.addressLine}";
  });

  // _FollowupBloc.add(LocationAddressCallEvent(LocationAddressRequest(key:"",latlng:Latitude+","+Longitude)));
}

//RouteSettings settings123;

File fileFromDocsDir(String filename) {
  String pathName = p.join(_appDocsDir.path, filename);
  return File(pathName);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  ///handles screen transaction based on route name
  static MaterialPageRoute globalGenerateRoute(RouteSettings settings) {
    //if screen have no argument to pass data in next screen while transiting
    // final GlobalKey<ScaffoldState> key = settings.arguments;

    switch (settings.name) {
      case SplashScreen.routeName:
        return getMaterialPageRoute(SplashScreen());
      case SerialKeyScreen.routeName:
        return getMaterialPageRoute(SerialKeyScreen());
      case FirstScreen.routeName:
        return getMaterialPageRoute(FirstScreen());
      case HomeScreen.routeName:
        return getMaterialPageRoute(HomeScreen());
      case CountryListScreen.routeName:
        return getMaterialPageRoute(CountryListScreen());
      case Customer_ADD_EDIT.routeName:
        return getMaterialPageRoute(Customer_ADD_EDIT(settings.arguments));
      case ContactsCrudDemo.routeName:
        return getMaterialPageRoute(ContactsCrudDemo());
      case PaginationDemoScreen.routeName:
        return getMaterialPageRoute(PaginationDemoScreen());
      case ContactsListScreen.routeName:
        return getMaterialPageRoute(ContactsListScreen());
      case AddContactScreen.routeName:
        return getMaterialPageRoute(AddContactScreen(settings.arguments));
      case FollowupListScreen.routeName:
        return getMaterialPageRoute(FollowupListScreen());
      case FollowUpAddEditScreen.routeName:
        return getMaterialPageRoute(FollowUpAddEditScreen(settings.arguments));
      case ToDoPaginationListScreen.routeName:
        return getMaterialPageRoute(ToDoPaginationListScreen());
      case ToDoAddEditScreen.routeName:
        return getMaterialPageRoute(ToDoAddEditScreen(settings.arguments));
      case ComplaintPaginationListScreen.routeName:
        return getMaterialPageRoute(ComplaintPaginationListScreen());
      case ComplaintAddEditScreen.routeName:
        return getMaterialPageRoute(ComplaintAddEditScreen(settings.arguments));
      case InquiryListScreen.routeName:
        return getMaterialPageRoute(InquiryListScreen(settings.arguments));
      case SearchInquiryScreen.routeName:
        return getMaterialPageRoute(SearchInquiryScreen());
      case CustomerListScreen.routeName:
        return getMaterialPageRoute(CustomerListScreen());
      case SearchCustomerScreen.routeName:
        return getMaterialPageRoute(SearchCustomerScreen());
      case QuotationListScreen.routeName:
        return getMaterialPageRoute(QuotationListScreen());
      case SearchQuotationScreen.routeName:
        return getMaterialPageRoute(SearchQuotationScreen());
      case SalesOrderListScreen.routeName:
        return getMaterialPageRoute(SalesOrderListScreen());
      case SearchSalesOrderScreen.routeName:
        return getMaterialPageRoute(SearchSalesOrderScreen());
      case ToDoListScreen.routeName:
        return getMaterialPageRoute(ToDoListScreen());
      case SearchCountryScreen.routeName:
        return getMaterialPageRoute(SearchCountryScreen(settings.arguments));
      case SearchStateScreen.routeName:
        return getMaterialPageRoute(SearchStateScreen(settings.arguments));
      case SearchDistrictScreen.routeName:
        return getMaterialPageRoute(SearchDistrictScreen(settings.arguments));
      case SearchTalukaScreen.routeName:
        return getMaterialPageRoute(SearchTalukaScreen(settings.arguments));
      case SearchCityScreen.routeName:
        return getMaterialPageRoute(SearchCityScreen(settings.arguments));
      case SearchFollowupCustomerScreen.routeName:
        return getMaterialPageRoute(SearchFollowupCustomerScreen());
      case AttendanceListScreen.routeName:
        return getMaterialPageRoute(AttendanceListScreen());
      case AttendanceAdd_EditScreen.routeName:
        return getMaterialPageRoute(
            AttendanceAdd_EditScreen(settings.arguments));
      case LeaveRequestListScreen.routeName:
        return getMaterialPageRoute(LeaveRequestListScreen());
      case LeaveRequestAddEditScreen.routeName:
        return getMaterialPageRoute(
            LeaveRequestAddEditScreen(settings.arguments));
      case LeaveRequestApprovalListScreen.routeName:
        return getMaterialPageRoute(LeaveRequestApprovalListScreen());
      case InquiryAddEditScreen.routeName:
        return getMaterialPageRoute(InquiryAddEditScreen(settings.arguments));
      case ExpenseListScreen.routeName:
        return getMaterialPageRoute(ExpenseListScreen());
      case ExpenseAddEditScreen.routeName:
        return getMaterialPageRoute(ExpenseAddEditScreen(settings.arguments));
      case SearchInquiryProductScreen.routeName:
        return getMaterialPageRoute(SearchInquiryProductScreen());
      //AddInquiryProductScreen
      case AddInquiryProductScreen.routeName:
        return getMaterialPageRoute(
            AddInquiryProductScreen(settings.arguments));
      case InquiryProductListScreen.routeName:
        return getMaterialPageRoute(
            InquiryProductListScreen(settings.arguments));
      case SearchInquiryCustomerScreen.routeName:
        return getMaterialPageRoute(SearchInquiryCustomerScreen());
      case MapScreen.routeName:
        return getMaterialPageRoute(MapScreen());
      case SearchSourceScreen.routeName:
        return getMaterialPageRoute(SearchSourceScreen());
      case SearchDestinationScreen.routeName:
        return getMaterialPageRoute(SearchDestinationScreen());
      case FollowupHistoryScreen.routeName:
        return getMaterialPageRoute(FollowupHistoryScreen(settings.arguments));
      case MapScreen.routeName:
        return getMaterialPageRoute(MapScreen());
      case DailyActivityListScreen.routeName:
        return getMaterialPageRoute(
            DailyActivityListScreen(settings.arguments));
      case SearchDailyActivityScreen.routeName:
        return getMaterialPageRoute(SearchDailyActivityScreen());
      //InquiryProductListScreen
      case DailyActivityAddEditScreen.routeName:
        return getMaterialPageRoute(
            DailyActivityAddEditScreen(settings.arguments));
      case SalesBillListScreen.routeName:
        return getMaterialPageRoute(SalesBillListScreen());
      case ToDoWorkLogScreen.routeName:
        return getMaterialPageRoute(ToDoWorkLogScreen(settings.arguments));
      case InquiryShareScreen.routeName:
        return getMaterialPageRoute(InquiryShareScreen(settings.arguments));
      case BankVoucherListScreen.routeName:
        return getMaterialPageRoute(BankVoucherListScreen());
      case SearchBankVoucherScreen.routeName:
        return getMaterialPageRoute(SearchBankVoucherScreen());
      case BankVoucherAddEditScreen.routeName:
        return getMaterialPageRoute(
            BankVoucherAddEditScreen(settings.arguments));
      case SearchComplaintScreen.routeName:
        return getMaterialPageRoute(SearchComplaintScreen());
      case SearchComplaintCustomerScreen.routeName:
        return getMaterialPageRoute(SearchComplaintCustomerScreen());
      case AttendVisitListScreen.routeName:
        return getMaterialPageRoute(AttendVisitListScreen());
      case AttendVisitAddEditScreen.routeName:
        return getMaterialPageRoute(
            AttendVisitAddEditScreen(settings.arguments));
      case SearchAttendVisitScreen.routeName:
        return getMaterialPageRoute(SearchAttendVisitScreen());
      case QuickInquiryScreen.routeName:
        return getMaterialPageRoute(QuickInquiryScreen());
      case QuotationAddEditScreen.routeName:
        return getMaterialPageRoute(QuotationAddEditScreen(settings.arguments));
      case SearchQuotationCustomerScreen.routeName:
        return getMaterialPageRoute(SearchQuotationCustomerScreen());
      case QuotationProductListScreen.routeName:
        return getMaterialPageRoute(
            QuotationProductListScreen(settings.arguments));

      case AddQuotationProductScreen.routeName:
        return getMaterialPageRoute(
            AddQuotationProductScreen(settings.arguments));
      case QuotationOtherChargeScreen.routeName:
        return getMaterialPageRoute(
            QuotationOtherChargeScreen(settings.arguments));
      case EmployeeListScreen.routeName:
        return getMaterialPageRoute(EmployeeListScreen());
      case SearchEmployeeScreen.routeName:
        return getMaterialPageRoute(SearchEmployeeScreen());
      case LoanListScreen.routeName:
        return getMaterialPageRoute(LoanListScreen());
      case SearchLoanScreen.routeName:
        return getMaterialPageRoute(SearchLoanScreen());
      case LoanApprovalListScreen.routeName:
        return getMaterialPageRoute(LoanApprovalListScreen());
      case MissedPunchListScreen.routeName:
        return getMaterialPageRoute(MissedPunchListScreen());
      case SearchMissedPunchScreen.routeName:
        return getMaterialPageRoute(SearchMissedPunchScreen());
      case SalaryUpadListScreen.routeName:
        return getMaterialPageRoute(SalaryUpadListScreen());
      case SearchSalaryUpadScreen.routeName:
        return getMaterialPageRoute(SearchSalaryUpadScreen());

      case MaintenanceListScreen.routeName:
        return getMaterialPageRoute(MaintenanceListScreen());
      case SearchMaintenanceScreen.routeName:
        return getMaterialPageRoute(SearchMaintenanceScreen());
      case ExternalLeadListScreen.routeName:
        return getMaterialPageRoute(ExternalLeadListScreen());
      case ExternalLeadAddEditScreen.routeName:
        return getMaterialPageRoute(
            ExternalLeadAddEditScreen(settings.arguments));
      case SearchExternalLeadScreen.routeName:
        return getMaterialPageRoute(
            SearchExternalLeadScreen(settings.arguments));
      case TeleCallerListScreen.routeName:
        return getMaterialPageRoute(TeleCallerListScreen());
      case SearchTeleCallerScreen.routeName:
        return getMaterialPageRoute(SearchTeleCallerScreen(settings.arguments));
      case TeleCallerAddEditScreen.routeName:
        return getMaterialPageRoute(
            TeleCallerAddEditScreen(settings.arguments));
      case SearchCompanyScreen.routeName:
        return getMaterialPageRoute(SearchCompanyScreen(settings.arguments));
      case DolphinComplaintVisitListScreen.routeName:
        return getMaterialPageRoute(DolphinComplaintVisitListScreen());

      case SearchCustomerQuickInquiryScreen.routeName:
        return getMaterialPageRoute(
            SearchCustomerQuickInquiryScreen(settings.arguments));

      case PackingChecklistScreen.routeName:
        return getMaterialPageRoute(PackingChecklistScreen());
      case SearchPackingChecklistScreen.routeName:
        return getMaterialPageRoute(SearchPackingChecklistScreen());
      case PackingChecklistAddScreen.routeName:
        return getMaterialPageRoute(
            PackingChecklistAddScreen(settings.arguments));
      case SearchCountryPackingScreen.routeName:
        return getMaterialPageRoute(
            SearchCountryPackingScreen(settings.arguments));
      case PackingAssamblyListScreen.routeName:
        return getMaterialPageRoute(
            PackingAssamblyListScreen(settings.arguments));
      case PackingAssamblyAddEditScreen.routeName:
        return getMaterialPageRoute(
            PackingAssamblyAddEditScreen(settings.arguments));
      case FinalCheckingListScreen.routeName:
        return getMaterialPageRoute(FinalCheckingListScreen());
      case FinalCheckingAddScreen.routeName:
        return getMaterialPageRoute(FinalCheckingAddScreen(settings.arguments));
      case SearchFinalCheckingScreen.routeName:
        return getMaterialPageRoute(SearchFinalCheckingScreen());
      case FinalCheckingItemScreen.routeName:
        return getMaterialPageRoute(FinalCheckingItemScreen());

      case InstallationListScreen.routeName:
        return getMaterialPageRoute(InstallationListScreen());
      case SearchInstallationScreen.routeName:
        return getMaterialPageRoute(SearchInstallationScreen());

      case InstallationAddScreen.routeName:
        return getMaterialPageRoute(InstallationAddScreen(settings.arguments));
      case InstallationSearchCustomerScreen.routeName:
        return getMaterialPageRoute(InstallationSearchCustomerScreen());
      case InstallationSearchCountryScreen.routeName:
        return getMaterialPageRoute(InstallationSearchCountryScreen());
      case InstallationStateSearchScreen.routeName:
        return getMaterialPageRoute(
            InstallationStateSearchScreen(settings.arguments));
      case InstallationCitySearch.routeName:
        return getMaterialPageRoute(InstallationCitySearch(settings.arguments));
      case ProductionActivityListScreen.routeName:
        return getMaterialPageRoute(
            ProductionActivityListScreen(settings.arguments));
      case ProductionActivityAdd.routeName:
        return getMaterialPageRoute(ProductionActivityAdd(settings.arguments));
      case QuickFollowupListScreen.routeName:
        return getMaterialPageRoute(QuickFollowupListScreen());

      case QuickFollowUpAddEditScreen.routeName:
        return getMaterialPageRoute(
            QuickFollowUpAddEditScreen(settings.arguments));

      case TeleCallerNewListScreen.routeName:
        return getMaterialPageRoute(TeleCallerNewListScreen());

      case TeleCallerAddEditNewScreen.routeName:
        return getMaterialPageRoute(
            TeleCallerAddEditNewScreen(settings.arguments));

      case SearchInquiryScreenFilter.routeName:
        return getMaterialPageRoute(SearchInquiryScreenFilter());

      case FollowUpInquiryAddEditScreen.routeName:
        return getMaterialPageRoute(
            FollowUpInquiryAddEditScreen(settings.arguments));

      case FollowUpFromInquiryAddEditScreen.routeName:
        return getMaterialPageRoute(
            FollowUpFromInquiryAddEditScreen(settings.arguments));

      case ProductHistoryScreen.routeName:
        return getMaterialPageRoute(ProductHistoryScreen(settings.arguments));

      case SearchSalesBillScreen.routeName:
        return getMaterialPageRoute(SearchSalesBillScreen());

      case MyDigitalSignature.routeName:
        return getMaterialPageRoute(MyDigitalSignature());

      case MissedPunchApprovalListScreen.routeName:
        return getMaterialPageRoute(MissedPunchApprovalListScreen());

      case SearchTODOCustomerScreen.routeName:
        return getMaterialPageRoute(SearchTODOCustomerScreen());

      case OfficeToDoScreen.routeName:
        return getMaterialPageRoute(OfficeToDoScreen());

      case OfficeToDoAddEditScreen.routeName:
        return getMaterialPageRoute(
            OfficeToDoAddEditScreen(settings.arguments));

      case SalesBillAddEditScreen.routeName:
        return getMaterialPageRoute(SalesBillAddEditScreen(settings.arguments));
      case SaleBillProductListScreen.routeName:
        return getMaterialPageRoute(
            SaleBillProductListScreen(settings.arguments));

      case AddSaleBillProductScreen.routeName:
        return getMaterialPageRoute(
            AddSaleBillProductScreen(settings.arguments));

      case SaleBillOtherChargeScreen.routeName:
        return getMaterialPageRoute(
            SaleBillOtherChargeScreen(settings.arguments));
      //

      case SaleOrderNewAddEditScreen.routeName:
        return getMaterialPageRoute(
            SaleOrderNewAddEditScreen(settings.arguments));

      case SalesOrderProductListScreen.routeName:
        return getMaterialPageRoute(
            SalesOrderProductListScreen(settings.arguments));

      case AddSalesOrderProductScreen.routeName:
        return getMaterialPageRoute(
            AddSalesOrderProductScreen(settings.arguments));
      case SalesOrderOtherChargeScreen.routeName:
        return getMaterialPageRoute(
            SalesOrderOtherChargeScreen(settings.arguments));
      case ModuleNoListScreen.routeName:
        return getMaterialPageRoute(ModuleNoListScreen(settings.arguments));
      case CreditNoteAddEditScreen.routeName:
        return getMaterialPageRoute(CreditNoteAddEditScreen());

      case CashVoucherAddEditScreen.routeName:
        return getMaterialPageRoute(CashVoucherAddEditScreen());

      case DebitNoteAddEditScreen.routeName:
        return getMaterialPageRoute(DebitNoteAddEditScreen());
      case PettyCashVoucherAddEditScreen.routeName:
        return getMaterialPageRoute(PettyCashVoucherAddEditScreen());
      case ExpenseVoucherAddEditScreen.routeName:
        return getMaterialPageRoute(ExpenseVoucherAddEditScreen());
      case JournalVoucherAddEditScreen.routeName:
        return getMaterialPageRoute(JournalVoucherAddEditScreen());
      case MaterialInwardListScreen.routeName:
        return getMaterialPageRoute(MaterialInwardListScreen());
      case MaterialInwardAddEdit.routeName:
        return getMaterialPageRoute(MaterialInwardAddEdit());
      case MaterialOutwardListScreen.routeName:
        return getMaterialPageRoute(MaterialOutwardListScreen());
      case MaterialOutwardAddEdit.routeName:
        return getMaterialPageRoute(MaterialOutwardAddEdit());
      case StoreInwardAddEditScreen.routeName:
        return getMaterialPageRoute(StoreInwardAddEditScreen());
      case StoreOutwardAddEditScreen.routeName:
        return getMaterialPageRoute(StoreOutwardAddEditScreen());
      case MaterialConsumptionAddEditScreen.routeName:
        return getMaterialPageRoute(MaterialConsumptionAddEditScreen());
      case InspectionCheckListAddEditScreen.routeName:
        return getMaterialPageRoute(InspectionCheckListAddEditScreen());
      case JobCardInwardAddEditScreen.routeName:
        return getMaterialPageRoute(JobCardInwardAddEditScreen());
      case JobCardOutwardAddEditScreen.routeName:
        return getMaterialPageRoute(JobCardOutwardAddEditScreen());
      case MaterialIndentAddEditScreen.routeName:
        return getMaterialPageRoute(MaterialIndentAddEditScreen());
      case SiteSurveyAddEditScreen.routeName:
        return getMaterialPageRoute(SiteSurveyAddEditScreen());

      //
      default:
        return null;
    }
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
          onGenerateRoute: MyApp.globalGenerateRoute,
          debugShowCheckedModeBanner: false,
          supportedLocales: [
            Locale('en', 'US'),
          ],
          localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
          ],
          // Returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },
          title: "Flutter base app",
          theme: buildAppTheme(),
          initialRoute: getInitialRoute(TitleNotificationSharvaya)),
    );
  }

  ///returns initial route based on condition of logged in/out
  getInitialRoute(String titleNotificationSharvaya) {
    if (SharedPrefHelper.instance.isLogIn()) {
      return HomeScreen.routeName;
    } else if (SharedPrefHelper.instance.isRegisteredIn()) {
      return FirstScreen.routeName;
    }

    return SerialKeyScreen.routeName;
  }
}
