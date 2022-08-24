import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soleoserp/models/api_requests/AttendVisit/attend_visit_delete_request.dart';
import 'package:soleoserp/models/api_requests/InquiryShareModel.dart';
import 'package:soleoserp/models/api_requests/Loan/loan_approval_save_request.dart';
import 'package:soleoserp/models/api_requests/ManageProductionRequest/MaterialInwardRequest/material_inward_list_request.dart';
import 'package:soleoserp/models/api_requests/ManageProductionRequest/MaterialOutward/material_outward_list_request.dart';
import 'package:soleoserp/models/api_requests/MissedPunch/missed_punch_approval_add_edit_request.dart';
import 'package:soleoserp/models/api_requests/MissedPunch/missed_punch_approval_request.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sale_bill_email_content_request.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sales_bill_inq_QT_SO_NO_list_Request.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sales_bill_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/SalesOrder/bank_details_list_request.dart';
import 'package:soleoserp/models/api_requests/ToDo_request/to_do_delete_request.dart';
import 'package:soleoserp/models/api_requests/all_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/api_token/api_token_update_request.dart';
import 'package:soleoserp/models/api_requests/attend_visit_list_request.dart';
import 'package:soleoserp/models/api_requests/attend_visit_save_request.dart';
import 'package:soleoserp/models/api_requests/attendance_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/attendance_list_request.dart';
import 'package:soleoserp/models/api_requests/attendance_save_request.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_list_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_save_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/checking_no_to_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/closer_reason_list_request.dart';
import 'package:soleoserp/models/api_requests/company_details_request.dart';
import 'package:soleoserp/models/api_requests/complaint_delete_request.dart';
import 'package:soleoserp/models/api_requests/complaint_list_request.dart';
import 'package:soleoserp/models/api_requests/complaint_no_list_request.dart';
import 'package:soleoserp/models/api_requests/complaint_save_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_by_Id_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_request.dart';
import 'package:soleoserp/models/api_requests/country_list_request.dart';
import 'package:soleoserp/models/api_requests/cust_id_inq_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_add_edit_api_request.dart';
import 'package:soleoserp/models/api_requests/customer_category_request.dart';
import 'package:soleoserp/models/api_requests/customer_delete_request.dart';
import 'package:soleoserp/models/api_requests/customer_id_to_contact_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_id_to_delete_all_contacts_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/customer_paggination_request.dart';
import 'package:soleoserp/models/api_requests/customer_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/daily_activity_delete_request.dart';
import 'package:soleoserp/models/api_requests/daily_activity_list_request.dart';
import 'package:soleoserp/models/api_requests/daily_activity_save_request.dart';
import 'package:soleoserp/models/api_requests/delete_all_packing_assambly_request.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_requests/distance_matrix_api_request.dart';
import 'package:soleoserp/models/api_requests/district_list_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_search_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_delete_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_list_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_save_request.dart';
import 'package:soleoserp/models/api_requests/dolphin_complaint_visit_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/employee_list_request.dart';
import 'package:soleoserp/models/api_requests/employee_search_request.dart';
import 'package:soleoserp/models/api_requests/expense_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/expense_image_upload_server_request.dart';
import 'package:soleoserp/models/api_requests/expense_list_request.dart';
import 'package:soleoserp/models/api_requests/expense_save_request.dart';
import 'package:soleoserp/models/api_requests/expense_type_request.dart';
import 'package:soleoserp/models/api_requests/expense_upload_image_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_list_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_save_request.dart';
import 'package:soleoserp/models/api_requests/external_lead_search_request.dart';
import 'package:soleoserp/models/api_requests/fetc_image_list_by_expense_pk_id_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_delete_all_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_header_save_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_items_request.dart';
import 'package:soleoserp/models/api_requests/final_checking_list_request.dart';
import 'package:soleoserp/models/api_requests/follower_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/followup_filter_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_history_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_by_customer_id_request.dart';
import 'package:soleoserp/models/api_requests/followup_inquiry_no_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_save_request.dart';
import 'package:soleoserp/models/api_requests/followup_type_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_upload_image_request.dart';
import 'package:soleoserp/models/api_requests/general_telecaller_img_upload_request/telecaller_upload_img_request.dart';
import 'package:soleoserp/models/api_requests/google_place_api_request.dart';
import 'package:soleoserp/models/api_requests/inqiory_header_save_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_followup_details_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_delete_product.dart';
import 'package:soleoserp/models/api_requests/inquiry_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_product_search_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_search_by_pk_id_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_share_emp_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/city_search_installtion_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_country_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_customerid_to_outwardno_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_delete_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_list_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_save_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_search_customer_request.dart';
import 'package:soleoserp/models/api_requests/leave_approval_save_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_list_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_save_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_type_request.dart';
import 'package:soleoserp/models/api_requests/loan_approval_list_request.dart';
import 'package:soleoserp/models/api_requests/loan_list_request.dart';
import 'package:soleoserp/models/api_requests/loan_search_request.dart';
import 'package:soleoserp/models/api_requests/location_address_request.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_requests/maintenance_list_request.dart';
import 'package:soleoserp/models/api_requests/maintenance_search_request.dart';
import 'package:soleoserp/models/api_requests/menu_rights_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_list_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/out_word_no_list_request.dart';
import 'package:soleoserp/models/api_requests/packing_assambly_edit_mode_request.dart';
import 'package:soleoserp/models/api_requests/packing_check_list_delete_request.dart';
import 'package:soleoserp/models/api_requests/packing_checklist_list.dart';
import 'package:soleoserp/models/api_requests/packing_productassambly_list_request.dart';
import 'package:soleoserp/models/api_requests/packing_save_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/productionActivity_save_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_delete_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_list_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_packing_list_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/typeofwork_request.dart';
import 'package:soleoserp/models/api_requests/product_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/product_group_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/quick_followup_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_delete_request.dart';
import 'package:soleoserp/models/api_requests/quotation_header_save_request.dart';
import 'package:soleoserp/models/api_requests/quotation_kind_att_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_no_to_product_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_other_charge_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_pdf_generate_request.dart';
import 'package:soleoserp/models/api_requests/quotation_product_delete_request.dart';
import 'package:soleoserp/models/api_requests/quotation_project_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_terms_condition_request.dart';
import 'package:soleoserp/models/api_requests/salary_upad_list_request.dart';
import 'package:soleoserp/models/api_requests/sales_bill_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/sales_bill_list_request.dart';
import 'package:soleoserp/models/api_requests/sales_order_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/salesorder_list_request.dart';
import 'package:soleoserp/models/api_requests/search_finalchecking_request.dart';
import 'package:soleoserp/models/api_requests/search_followup_by_status_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_fillter_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_inquiry_list_by_number_request.dart';
import 'package:soleoserp/models/api_requests/search_installation_request.dart';
import 'package:soleoserp/models/api_requests/search_packingchecklist_request.dart';
import 'package:soleoserp/models/api_requests/search_quotation_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_quotation_list_by_number_request.dart';
import 'package:soleoserp/models/api_requests/search_sale_bill_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_number_request.dart';
import 'package:soleoserp/models/api_requests/specification_list_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_requests/swastick_telecaller_request/new_telecaller_save_request.dart';
import 'package:soleoserp/models/api_requests/swastick_telecaller_request/telecaller_new_pagination_request.dart';
import 'package:soleoserp/models/api_requests/taluka_api_request.dart';
import 'package:soleoserp/models/api_requests/task_category_list_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_delete_image/telecaller_delete_image_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_save_request.dart';
import 'package:soleoserp/models/api_requests/tele_caller_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/telecaller_list_request.dart';
import 'package:soleoserp/models/api_requests/to_do_header_save_request.dart';
import 'package:soleoserp/models/api_requests/to_do_save_sub_details_request.dart';
import 'package:soleoserp/models/api_requests/to_do_worklog_list_request.dart';
import 'package:soleoserp/models/api_requests/todo_list_request.dart';
import 'package:soleoserp/models/api_requests/transection_mode_list_request.dart';
import 'package:soleoserp/models/api_responses/AttendVisit/attend_visit_delete_response.dart';
import 'package:soleoserp/models/api_responses/Loan/loan_approval_save_response.dart';
import 'package:soleoserp/models/api_responses/ManageProductionResponse/Material%20Outward/material_outward_list_response.dart';
import 'package:soleoserp/models/api_responses/ManageProductionResponse/MaterialInward/material_inward_list_response.dart';
import 'package:soleoserp/models/api_responses/MissedPunch/missed_punch_add_edit_response.dart';
import 'package:soleoserp/models/api_responses/SaleBill/sale_bill_email_content_response.dart';
import 'package:soleoserp/models/api_responses/SaleBill/sales_bill_INQ_QT_SO_NO_list_response.dart';
import 'package:soleoserp/models/api_responses/SaleOrder/bank_details_list_response.dart';
import 'package:soleoserp/models/api_responses/ToDo_delete_response/to_do_delete_response.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/attend_visit_list_response.dart';
import 'package:soleoserp/models/api_responses/attend_visit_save_response.dart';
import 'package:soleoserp/models/api_responses/attendance_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/attendance_response_list.dart';
import 'package:soleoserp/models/api_responses/attendance_save_response.dart';
import 'package:soleoserp/models/api_responses/bank_drop_down_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_list_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_save_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/checking_no_to_checking_item_response.dart';
import 'package:soleoserp/models/api_responses/city_api_response.dart';
import 'package:soleoserp/models/api_responses/closer_reason_list_response.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/complaint_delete_response.dart';
import 'package:soleoserp/models/api_responses/complaint_list_response.dart';
import 'package:soleoserp/models/api_responses/complaint_no_list_response.dart';
import 'package:soleoserp/models/api_responses/complaint_save_response.dart';
import 'package:soleoserp/models/api_responses/complaint_search_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response.dart';
import 'package:soleoserp/models/api_responses/country_list_response_for_packing_checking.dart';
import 'package:soleoserp/models/api_responses/cust_id_to_inq_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_add_edit_response.dart';
import 'package:soleoserp/models/api_responses/customer_category_list.dart';
import 'package:soleoserp/models/api_responses/customer_contact_save_response.dart';
import 'package:soleoserp/models/api_responses/customer_delete_response.dart';
import 'package:soleoserp/models/api_responses/customer_details_api_response.dart';
import 'package:soleoserp/models/api_responses/customer_id_to_contact_list_response.dart';
import 'package:soleoserp/models/api_responses/customer_id_to_delete_all_contact_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/daily_activity_delete_response.dart';
import 'package:soleoserp/models/api_responses/daily_activity_list_response.dart';
import 'package:soleoserp/models/api_responses/daily_activity_save_response.dart';
import 'package:soleoserp/models/api_responses/delete_all_packing_assambly_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/distance_matrix_api_response.dart';
import 'package:soleoserp/models/api_responses/district_api_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_search_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_delete_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_list_response.dart';
import 'package:soleoserp/models/api_responses/dolphin_complaint_visit_save_response.dart';
import 'package:soleoserp/models/api_responses/employee_list_response.dart';
import 'package:soleoserp/models/api_responses/expense_delete_image_response.dart';
import 'package:soleoserp/models/api_responses/expense_delete_response.dart';
import 'package:soleoserp/models/api_responses/expense_image_upload_server_response.dart';
import 'package:soleoserp/models/api_responses/expense_list_response.dart';
import 'package:soleoserp/models/api_responses/expense_save_response.dart';
import 'package:soleoserp/models/api_responses/expense_type_response.dart';
import 'package:soleoserp/models/api_responses/expense_upload_image_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_list_response.dart';
import 'package:soleoserp/models/api_responses/external_lead_save_response.dart';
import 'package:soleoserp/models/api_responses/external_leadsearch_response_by_name.dart';
import 'package:soleoserp/models/api_responses/fetch_image_by_expense_pk_id_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_delete_all_item_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_items_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_list_response.dart';
import 'package:soleoserp/models/api_responses/final_checking_sub_details_response.dart';
import 'package:soleoserp/models/api_responses/final_cheking_header_save_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_Image_Upload_response.dart';
import 'package:soleoserp/models/api_responses/followup_delete_Image_response.dart';
import 'package:soleoserp/models/api_responses/followup_delete_response.dart';
import 'package:soleoserp/models/api_responses/followup_filter_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_history_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_inquiry_by_customer_id_response.dart';
import 'package:soleoserp/models/api_responses/followup_inquiry_no_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_list_response.dart';
import 'package:soleoserp/models/api_responses/followup_save_success_response.dart';
import 'package:soleoserp/models/api_responses/followup_type_list_response.dart';
import 'package:soleoserp/models/api_responses/general_telecaller_img_upload_response/telecaller_upload_img_response.dart';
import 'package:soleoserp/models/api_responses/google_place_search_response.dart';
import 'package:soleoserp/models/api_responses/inq_no_to_product_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_delete_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_header_save_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_list_reponse.dart';
import 'package:soleoserp/models/api_responses/inquiry_no_to_delete_product_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_no_to_product_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_save_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_product_search_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_emp_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_share_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/Installation_customerid_to_outwardno_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_city_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_country_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_delete_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_employee_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_list_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_search_customer_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/save_installation_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/search_installation_label_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/state_search_response.dart';
import 'package:soleoserp/models/api_responses/leave_approval_save_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_delete_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_save_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_type_response.dart';
import 'package:soleoserp/models/api_responses/loan_list_response.dart';
import 'package:soleoserp/models/api_responses/location_address_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/maintenance_list_response.dart';
import 'package:soleoserp/models/api_responses/menu_rights_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_approval_list_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_list_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/out_word_no_list_response.dart';
import 'package:soleoserp/models/api_responses/packing_assambly_edit_mode_response.dart';
import 'package:soleoserp/models/api_responses/packing_assambly_save_response.dart';
import 'package:soleoserp/models/api_responses/packing_check_list_delete_response.dart';
import 'package:soleoserp/models/api_responses/packing_checking_list.dart';
import 'package:soleoserp/models/api_responses/packing_no_list_response.dart';
import 'package:soleoserp/models/api_responses/packing_product_assambly_list_response.dart';
import 'package:soleoserp/models/api_responses/packing_save_response.dart';
import 'package:soleoserp/models/api_responses/pagination_demo_list_response.dart';
import 'package:soleoserp/models/api_responses/product_drop_down_response.dart';
import 'package:soleoserp/models/api_responses/product_group_dropdown_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/productactivity_typeofwork_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/productionActivity_save_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_delete_reponse.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_list_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_packingno_response.dart';
import 'package:soleoserp/models/api_responses/quick_followup_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_delete_response.dart';
import 'package:soleoserp/models/api_responses/quotation_header_save_response.dart';
import 'package:soleoserp/models/api_responses/quotation_kind_att_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_no_to_product_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_other_charges_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_pdf_generate_response.dart';
import 'package:soleoserp/models/api_responses/quotation_product_delete_response.dart';
import 'package:soleoserp/models/api_responses/quotation_product_save_response.dart';
import 'package:soleoserp/models/api_responses/quotation_project_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_terms_condition_response.dart';
import 'package:soleoserp/models/api_responses/sales_bill_generate_pdf_response.dart';
import 'package:soleoserp/models/api_responses/sales_bill_list_response.dart';
import 'package:soleoserp/models/api_responses/sales_order_pdf_generate_pdf_response.dart';
import 'package:soleoserp/models/api_responses/salesorder_list_response.dart';
import 'package:soleoserp/models/api_responses/search_finalchecking_label_response.dart';
import 'package:soleoserp/models/api_responses/search_inquiry_list_response.dart';
import 'package:soleoserp/models/api_responses/search_packingchecklist_label_response.dart';
import 'package:soleoserp/models/api_responses/search_quotation_list_response.dart';
import 'package:soleoserp/models/api_responses/search_sales_bill_search_response.dart';
import 'package:soleoserp/models/api_responses/search_salesorder_list_response.dart';
import 'package:soleoserp/models/api_responses/specification_list_response.dart';
import 'package:soleoserp/models/api_responses/state_list_response.dart';
import 'package:soleoserp/models/api_responses/swastik_telecaller_response/telecaller_new_pagination_response.dart';
import 'package:soleoserp/models/api_responses/taluka_api_response.dart';
import 'package:soleoserp/models/api_responses/task_category_list_response.dart';
import 'package:soleoserp/models/api_responses/tele_caller_image_delete/tele_caller_delete_image_response.dart';
import 'package:soleoserp/models/api_responses/tele_caller_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/telecaller_list_response.dart';
import 'package:soleoserp/models/api_responses/to_do_header_save_response.dart';
import 'package:soleoserp/models/api_responses/to_do_save_sub_details_response.dart';
import 'package:soleoserp/models/api_responses/to_do_worklog_list_response.dart';
import 'package:soleoserp/models/api_responses/todo_list_response.dart';
import 'package:soleoserp/models/api_responses/transection_mode_list_response.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/models/common/packingProductAssamblyTable.dart';
import 'package:soleoserp/models/common/quotationtable.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

import 'api_client.dart';
import 'error_response_exception.dart';

// will be user for user related api calling and data processing
class Repository {
  SharedPrefHelper prefs = SharedPrefHelper.instance;
  final ApiClient apiClient;

  Repository({@required this.apiClient});

  static Repository getInstance() {
    return Repository(apiClient: ApiClient(httpClient: http.Client()));
  }

  ///add your functions of api calls as below

  Future<CompanyDetailsResponse> CompanyDetailsCallApi(
      CompanyDetailsApiRequest companyDetailsApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LOGIN, companyDetailsApiRequest.toJson());

      // print("JSONARRAYRESPOVN" + json.toString());
      CompanyDetailsResponse companyDetailsResponse =
          CompanyDetailsResponse.fromJson(json);
      return companyDetailsResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerCategoryResponse> customer_Category_List_call(
      CustomerCategoryRequest categoryResponse) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_CATEGORY, categoryResponse.toJson());
      CustomerCategoryResponse companyDetailsResponse =
          CustomerCategoryResponse.fromJson(json);
      return companyDetailsResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerSourceResponse> customer_Source_List_call(
      CustomerSourceRequest sourceRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SOURCE, sourceRequest.toJson());
      CustomerSourceResponse customerSourceResponse =
          CustomerSourceResponse.fromJson(json);
      return customerSourceResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupHistoryListResponse> inquiry_no_to_followup_details(
      InquiryNoToFollowupDetailsRequest sourceRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_NO_FOLLLOWUP_DETAILS,
          sourceRequest.toJson());
      FollowupHistoryListResponse customerSourceResponse =
          FollowupHistoryListResponse.fromJson(json);
      return customerSourceResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  ///Login USer APi Details as below
  Future<LoginUserDetialsResponse> loginUserDetailsCall(
      LoginUserDetialsAPIRequest loginUserDetialsAPIRequest) async {
    try {
      /*  String jsonString = await apiClient.apiCallLoginUSerPost(
          */ /*ApiClient.END_POINT_LOGIN_USER_DETAILS*/ /*
          "Login/" + loginUserDetialsAPIRequest.companyId.toString(),
          loginUserDetialsAPIRequest.toJson());
      print("json - $jsonString");
      List<dynamic> list = json.decode(jsonString);*/
      //return LoginUserDetials.fromJson(list[0]);

      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LOGIN_USER_DETAILS +
              "/" +
              loginUserDetialsAPIRequest.companyId.toString(),
          loginUserDetialsAPIRequest.toJson());
      LoginUserDetialsResponse loginUserDetialsResponse =
          LoginUserDetialsResponse.fromJson(json);
      return loginUserDetialsResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDetailsResponse> CustomerDetailsCall(
      CustomerPaginationRequest customerPaginationRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_PAGINATION + "/1-10",
          customerPaginationRequest.toJson());
      CustomerDetailsResponse customerDetailsResponse =
          CustomerDetailsResponse.fromJson(json);
      return customerDetailsResponse;

      /*String jsonString = await apiClient.apiCallCustomerPaginationPost(
          ApiClient.END_POINT_LOGIN_USER_DETAILS
          "Customer/1-10/",
          customerPaginationRequest.toJson());
      print("json - $jsonString");
      List<dynamic> list = json.decode(jsonString);
      //return CustomerDetailsFromJson(jsonString);*/ /*
      return CustomerDetailsResponse.fromJson(list[0]);*/
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PaginationDemoListResponse> getList(int pageNo) async {
    try {
      Map<String, dynamic> response = await apiClient
          .apiCallGet(ApiClient.END_POINT_LIST, query: "page=$pageNo");
      print("response - ${response}");
      return PaginationDemoListResponse.fromJson(response);
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CountryListResponse> country_list_call(
      CountryListRequest countryListRequest) async {
    try {
      /*  String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_COUNTRYLIST, categoryRequest.toJson());
      print("json - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      */ /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/

      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_COUNTRYLIST, countryListRequest.toJson());
      CountryListResponse countryListResponse =
          CountryListResponse.fromJson(json);
      return countryListResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CountryListResponseForPacking> country_list_call_For_Packing(
      CountryListRequest countryListRequest) async {
    try {
      /*  String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_COUNTRYLIST, categoryRequest.toJson());
      print("json - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      */ /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/

      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_COUNTRYLIST, countryListRequest.toJson());
      CountryListResponseForPacking countryListResponse =
          CountryListResponseForPacking.fromJson(json);
      return countryListResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<StateListResponse> state_list_call(
      StateListRequest stateListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_STATELIST, stateListRequest.toJson());
      StateListResponse stateListResponse = StateListResponse.fromJson(json);
      return stateListResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

/*  Future<String> customer_list_pagination(CustomerPaginationRequest customerPaginationRequest,int query) async {
    try {
      String jsonString = await apiClient.apiCallPostPagination(
          ApiClient.END_POINT_CUSTOMER_PAGINATION,'$query',customerPaginationRequest.toJson());
      print("json123456 - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      */ /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/ /*
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/

  Future<CustomerDetailsResponse> customer_list_pagination(
      CustomerPaginationRequest customerPaginationRequest, int query) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPostPagination(
          ApiClient.END_POINT_CUSTOMER_PAGINATION,
          '$query',
          customerPaginationRequest.toJson());
      CustomerDetailsResponse customerDetailsResponse =
          CustomerDetailsResponse.fromJson(json);
      return customerDetailsResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<String> customer_search_label_value(
      CustomerLabelValueRequest customerLabelValueRequest) async {
    try {
      String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH,
          customerLabelValueRequest.toJson());
      print("CustomerLabeljson - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<String> customer_search_by_id(
      CustomerSearchByIdRequest customerSearchByIdRequest) async {
    try {
      String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH_BY_ID +
              customerSearchByIdRequest.CustomerID.toString(),
          customerSearchByIdRequest.toJson());
      print("CustomerLabeljson - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DistrictApiResponse> district_list_details(
      DistrictApiRequest districtApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.End_POINT_DISTRICT_LIST, districtApiRequest.toJson());
      DistrictApiResponse districtApiResponse =
          DistrictApiResponse.fromJson(json);
      return districtApiResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TalukaApiRespose> taluka_list_details(
      TalukaApiRequest talukaApiRequest) async {
    try {
      /*   String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_TALUKA_LIST, talukaApiRequest.toJson());
      print("End_POINT_DISTRICT_LIST - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      */ /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TALUKA_LIST, talukaApiRequest.toJson());
      TalukaApiRespose talukaApiRespose = TalukaApiRespose.fromJson(json);
      return talukaApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CityApiRespose> city_list_details(
      CityApiRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CITY_LIST, talukaApiRequest.toJson());
      CityApiRespose cityApiRespose = CityApiRespose.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<OutWordNoListResponse> OutWordAPI(
      OutWordNoListRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PackingOutWord_List,
          outWordNoListRequest.toJson());
      OutWordNoListResponse cityApiRespose =
          OutWordNoListResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingNoListResponse> PackingNoListAPI(
      OutWordNoListRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PACKING_NO_LIST, outWordNoListRequest.toJson());
      PackingNoListResponse cityApiRespose =
          PackingNoListResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingItemsResponse> FinalCheckingItemsAPI(
      FinalCheckingItemsRequest finalCheckingItemsRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FINAL_CHECKING_ITEMS,
          finalCheckingItemsRequest.toJson());
      FinalCheckingItemsResponse cityApiRespose =
          FinalCheckingItemsResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CheckingNoToCheckingItemsResponse> CheckingNoToCheckingItemsAPI(
      CheckingNoToCheckingItemsRequest finalCheckingItemsRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CHECKING_TO_CHECKING_ITEMS,
          finalCheckingItemsRequest.toJson());
      CheckingNoToCheckingItemsResponse cityApiRespose =
          CheckingNoToCheckingItemsResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingHeaderSaveResponse> finalCheckingHeaderSaveApi(int pkID,
      FinalCheckingHeaderSaveRequest finalCheckingItemsRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FINAL_CHEKING_SAVE + pkID.toString() + "/Save",
          finalCheckingItemsRequest.toJson());
      FinalCheckingHeaderSaveResponse cityApiRespose =
          FinalCheckingHeaderSaveResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingDeleteAllItemResponse> finalCheckingDeleteAllItemApi(
      String fcNo,
      FinalCheckingDeleteAllItemsRequest finalCheckingItemsRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FINAL_CHEKING_DELETE_ALL_ITEM +
              fcNo.toString() +
              "/Del",
          finalCheckingItemsRequest.toJson());
      FinalCheckingDeleteAllItemResponse cityApiRespose =
          FinalCheckingDeleteAllItemResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingDeleteAllItemResponse> finalCheckingDeleteApi(int pkID,
      FinalCheckingDeleteAllItemsRequest finalCheckingItemsRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FINAL_CHEKING_DELETE_FROM_LIST_SCREEN +
              pkID.toString() +
              "/Del",
          finalCheckingItemsRequest.toJson());
      FinalCheckingDeleteAllItemResponse cityApiRespose =
          FinalCheckingDeleteAllItemResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingProductAssamblyListResponse> PackingProductAssamblyListAPI(
      PackingProductAssamblyListRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PackingProductAssamblyList,
          outWordNoListRequest.toJson());
      PackingProductAssamblyListResponse cityApiRespose =
          PackingProductAssamblyListResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ProductGroupDropDownResponse> ProductGroupDropDownAPi(
      ProductGroupDropDownRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Product_GroupDropDown,
          outWordNoListRequest.toJson());
      ProductGroupDropDownResponse cityApiRespose =
          ProductGroupDropDownResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ProductDropDownResponse> ProductDropDownAPi(
      ProductDropDownRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Product_DropDown, outWordNoListRequest.toJson());
      ProductDropDownResponse cityApiRespose =
          ProductDropDownResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingSaveResponse> PackingSaveAPi(
      int pkID, PackingSaveRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PACKING_SAVE + pkID.toString() + "/Save",
          outWordNoListRequest.toJson());
      PackingSaveResponse cityApiRespose = PackingSaveResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<Delete_ALL_Assambly_Response> DeleteAllPackingAssamblyAPI(
      String PcNo, DeleteAllPakingAssamblyRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PACKING_ASSAMBLY_ALL_DELETE +
              PcNo.toString() +
              "/Del",
          outWordNoListRequest.toJson());
      Delete_ALL_Assambly_Response cityApiRespose =
          Delete_ALL_Assambly_Response.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingAssamblyEditModeResponse> PackingAssamblyEditModeAPI(
      PackingAssamblyEditModeRequest outWordNoListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PACKING_ASSAMBLY_EDIT_MODE,
          outWordNoListRequest.toJson());
      PackingAssamblyEditModeResponse cityApiRespose =
          PackingAssamblyEditModeResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryListResponse> getInquiryList(
      int pageNo, InquiryListApiRequest inquiryListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_INQUIRY}/$pageNo-10",
          inquiryListApiRequest.toJson());
      InquiryListResponse response = InquiryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryProductSearchResponse> getInquiryProductSearchList(
      InquiryProductSearchRequest inquiryProductSearchRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PRODUCT_SEARCH,
          inquiryProductSearchRequest.toJson());
      InquiryProductSearchResponse response =
          InquiryProductSearchResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationSaveHeaderResponse> getQuotationHeaderSaveResponse(
      int pkID, QuotationHeaderSaveRequest inquiryProductSearchRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_QUOTATION_HEADER_REQUEST}/$pkID/Save",
          inquiryProductSearchRequest.toJson());
      QuotationSaveHeaderResponse response =
          QuotationSaveHeaderResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryHeaderSaveResponse> getInquiryHeaderSave(
      int pkID, InquiryHeaderSaveRequest inquiryHeaderSaveRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_HEADER_SAVE + pkID.toString() + "/Save",
          inquiryHeaderSaveRequest.toJson());
      InquiryHeaderSaveResponse response =
          InquiryHeaderSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryNoToProductResponse> getInquiryNoToProductList(
      InquiryNoToProductListRequest inquiryNoToProductListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_NO_TO_PRODUCT_LIST,
          inquiryNoToProductListRequest.toJson());
      InquiryNoToProductResponse response =
          InquiryNoToProductResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryNoToDeleteProductResponse> getInquiryNoToDeleteProductList(
      String InqNo,
      InquiryNoToDeleteProductRequest inquiryNoToDeleteProductRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_NO_TO_DELETE_PRODUCT_LIST +
              InqNo +
              "/MultiProductDelete",
          inquiryNoToDeleteProductRequest.toJson());
      InquiryNoToDeleteProductResponse response =
          InquiryNoToDeleteProductResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationProductDeleteResponse> getQtNoToDeleteProductList(
      String QT_No,
      QuotationProductDeleteRequest quotationProductDeleteRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QT_NO_TO_DELETE_PRODUCT_LIST +
              QT_No +
              "/ProductDel",
          quotationProductDeleteRequest.toJson());
      QuotationProductDeleteResponse response =
          QuotationProductDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryListResponse> getInquiryByPkID(String pkID,
      InquirySearchByPkIdRequest inquirySearchByPkIdRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_SEARCH_BY_PKID + pkID,
          inquirySearchByPkIdRequest.toJson());
      InquiryListResponse response = InquiryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupListResponse> getFollowupList(
      int pageNo, FollowupListApiRequest followupListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_FOLLOWUP}/$pageNo-10",
          followupListApiRequest.toJson());
      FollowupListResponse response = FollowupListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryListResponse> getInquiryListSearchByNumber(
      SearchInquiryListByNumberRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_SEARCH_BY_INQUIRY_NO, request.toJson());
      InquiryListResponse response = InquiryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchInquiryListResponse> getInquiryListSearchByName(
      SearchInquiryListByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_SEARCH_BY_NAME, request.toJson());
      SearchInquiryListResponse response =
          SearchInquiryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryListResponse> getInquiryListSearchByNameFillter(
      SearchInquiryListFillterByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_SEARCH_BY_FILLTER, request.toJson());
      InquiryListResponse response = InquiryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDetailsResponse> getCustomerList(
      int pageNo, CustomerPaginationRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_PAGINATION}/$pageNo-10",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      CustomerDetailsResponse response = CustomerDetailsResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DailyActivityListResponse> getDailyActivityList(
      int pageNo, DailyActivityListRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DAILY_ACTIVITY_LIST_DETAILS}/$pageNo-10",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      DailyActivityListResponse response =
          DailyActivityListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherListResponse> getBankVoucherList(
      int pageNo, BankVoucherListRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_BANK_VOUCHER_LIST_DETAILS}/$pageNo-10",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      BankVoucherListResponse response = BankVoucherListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<EmployeeListResponse> getEmployeeList(
      int pageNo, EmployeeListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EMPLOYEE_LIST_DETAILS}/$pageNo-10",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      EmployeeListResponse response = EmployeeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<EmployeeListResponse> getEmployeeListWithOneImage(
      int pageNo, EmployeeListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EMPLOYEE_LIST_DETAILS}/$pageNo-10000",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      EmployeeListResponse response = EmployeeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LoanListResponse> getLoanList(
      int pageNo, LoanListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_LOAN_LIST_DETAILS}/$pageNo-10",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      LoanListResponse response = LoanListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MaintenanceListResponse> getMaintenanceList(
      int pageNo, MaintenanceListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MAINTENANCE_LIST_DETAILS}/$pageNo-10",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      MaintenanceListResponse response = MaintenanceListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MaintenanceListResponse> getMaintenanceSearch(
      MaintenanceSearchRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MAINTENANCE_SEARCH_DETAILS}",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      MaintenanceListResponse response = MaintenanceListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MissedPunchListResponse> getMissedPunchList(
      int pageNo, MissedPunchListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MISSED_PUNCH_LIST_DETAILS}/$pageNo-10",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      MissedPunchListResponse response = MissedPunchListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LoanListResponse> getSalaryUpadList(
      int pageNo, SalaryUpadListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_SALARY_UPAD_LIST_DETAILS}/$pageNo-10",
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      LoanListResponse response = LoanListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<EmployeeListResponse> getEmployeeSearchResult(
      EmployeeSearchRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EMPLOYEE_SEARCH_DETAILS,
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      EmployeeListResponse response = EmployeeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LoanListResponse> getLoanSearchResult(
      LoanSearchRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LOAN_SEARCH_DETAILS,
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      LoanListResponse response = LoanListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MissedPunchListResponse> getMissedPunchSearchByID(int pkID,
      MissedPunchSearchByIDRequest missedPunchSearchByNameRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MISSED_PUNCH_SEARCH_BY_ID_DETAILS}$pkID",
          missedPunchSearchByNameRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " +
          missedPunchSearchByNameRequest.toJson().toString());
      MissedPunchListResponse response = MissedPunchListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getMissedDeleteByID(
      int pkID, BankVoucherDeleteRequest missedPunchSearchByNameRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MISSED_PUNCH_DELETE_BY_ID_DETAILS}/$pkID/Delete",
          missedPunchSearchByNameRequest.toJson(),
          showSuccessDialog: true);
      print("ToJSONRESPONSFG : " +
          missedPunchSearchByNameRequest.toJson().toString());
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getsalaryUpadDelete(
      int pkID, BankVoucherDeleteRequest missedPunchSearchByNameRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MISSED_SALARY_UPAD_DELETE_BY_ID_DETAILS}/$pkID/Del",
          missedPunchSearchByNameRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " +
          missedPunchSearchByNameRequest.toJson().toString());
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MissedPunchSearchByNameResponse> getMissedPunchSearchByName(
      MissedPunchSearchByNameRequest missedPunchSearchByNameRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MISSED_PUNCH_SEARCH_DETAILS,
          missedPunchSearchByNameRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " +
          missedPunchSearchByNameRequest.toJson().toString());
      MissedPunchSearchByNameResponse response =
          MissedPunchSearchByNameResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LoanListResponse> getLoanApprovalList(
      LoanApprovalListRequest employeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LOAN_APPROVAL_LIST_DETAILS,
          employeeListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + employeeListRequest.toJson().toString());
      LoanListResponse response = LoanListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LoanApprovalSaveResponse> getLoanApprovalSAve(
      int pkID, LoanApprovalSaveRequest loanApprovalSaveRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LOAN_APPROVAL_SAVE_DETAILS +
              pkID.toString() +
              "/LoanUpd",
          loanApprovalSaveRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + loanApprovalSaveRequest.toJson().toString());
      LoanApprovalSaveResponse response =
          LoanApprovalSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MissedPunchApprovalListResponse> getMissedPunchApprovalList(
      MissedPunchApprovalListRequest missedPunchApprovalListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MISSED_PUNCH_APPROVAL_LIST_DETAILS,
          missedPunchApprovalListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " +
          missedPunchApprovalListRequest.toJson().toString());
      MissedPunchApprovalListResponse response =
          MissedPunchApprovalListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MissedPunchApprovalSaveResponse> getMissedPunchApprovalSave(int pkID,
      MissedPunchApprovalSaveRequest missedPunchApprovalListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MISSED_PUNCH_APPROVAL_SAVE +
              pkID.toString() +
              "/ChangeApproval",
          missedPunchApprovalListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " +
          missedPunchApprovalListRequest.toJson().toString());
      MissedPunchApprovalSaveResponse response =
          MissedPunchApprovalSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintListResponse> getComplaintList(
      int pageNo, ComplaintListRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_COMPLAINT_LIST_DETAILS}/$pageNo-10",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      ComplaintListResponse response = ComplaintListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintSearchResponse> getComplaintSearchByName(
      ComplaintSearchRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_COMPLAINT_SEARCH_BY_NAME_DETAILS}",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      ComplaintSearchResponse response = ComplaintSearchResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintSearchResponse> getVisitSearchByName(
      ComplaintSearchRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_ATTEND_VISIT_SEARCH_DETAILS}",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      ComplaintSearchResponse response = ComplaintSearchResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DolphinComplaintSearchResponse> getDolphinComplaintSearchByName(
      DolphinComplaintSearchRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DOLPHIN_COMPLAINT_VISIT_SEARCH_DETAILS}",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      DolphinComplaintSearchResponse response =
          DolphinComplaintSearchResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintListResponse> getComplaintSearchByID(
      int pkID, ComplaintSearchByIDRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_COMPLAINT_SEARCH_BY_ID_DETAILS}/$pkID",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      ComplaintListResponse response = ComplaintListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendVisitListResponse> getVisitSearchByID(
      int pkID, ComplaintSearchByIDRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_ATTEND_VISIT_SAVE_DETAILS}/$pkID",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      AttendVisitListResponse response = AttendVisitListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendVisitDeleteResponse> getAttendVisitDeleteAPI(
      AttendVisitDeleteRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_ATTEND_VISIT_DELETE}",
          complaintListRequest.toJson(),
          showSuccessDialog:
              true /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      AttendVisitDeleteResponse response =
          AttendVisitDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DolphinComplaintVisitListResponse> getDolphinComplaintVisitSearchByID(
      int pkID, DolphinComplaintSearchByIDRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DOLPHIN_COMPLAINT_VISIT_SEARCH_ID_DETAILS}/$pkID",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      DolphinComplaintVisitListResponse response =
          DolphinComplaintVisitListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DolphinComplaintVisitSaveResponse> getDolphinComplaintVisitSave(
      int pkID, DolphinComplaintVisitSaveRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DOLPHIN_COMPLAINT_VISIT_SAVE_DETAILS}/$pkID/Save",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      DolphinComplaintVisitSaveResponse response =
          DolphinComplaintVisitSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DolphinComplaintVisitDeleteResponse> getDolphinComplaintVisitDelete(
      DolphinComplaintVisitDeleteRequest complaintListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DOLPHIN_COMPLAINT_VISIT_DELETE_DETAILS}",
          complaintListRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintListRequest.toJson().toString());
      DolphinComplaintVisitDeleteResponse response =
          DolphinComplaintVisitDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintSaveResponse> getComplaintSave(
      int pkID, ComplaintSaveRequest complaintSaveRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_COMPLAINT_SAVE_DETAILS}/$pkID/Save",
          complaintSaveRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintSaveRequest.toJson().toString());
      ComplaintSaveResponse response = ComplaintSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintDeleteResponse> DeleteComplaintBypkID(
      int pkID, ComplaintDeleteRequest complaintDeleteRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_COMPLAINT_SEARCH_BY_ID_DETAILS}/$pkID/Delete",
          complaintDeleteRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print("ToJSONRESPONSFG : " + complaintDeleteRequest.toJson().toString());
      ComplaintDeleteResponse response = ComplaintDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherListResponse> getBankVoucherSearchByIDResponse(
      int id, BankVoucherSearchByIDRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_BANK_VOUCHER_LIST_DETAILS}/$id/Fetch",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      BankVoucherListResponse response = BankVoucherListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDetailsResponse> getCustomerListSearchByNumber(
      CustomerSearchByIdRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH_BY_ID + request.CustomerID,
          request.toJson());
      CustomerDetailsResponse response = CustomerDetailsResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerLabelvalueRsponse> getCustomerListSearchByName(
      CustomerLabelValueRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH, request.toJson());
      CustomerLabelvalueRsponse response =
          CustomerLabelvalueRsponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerLabelvalueRsponse> getTeleCallerCustomerListSearchByName(
      CustomerLabelValueRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH, request.toJson());
      CustomerLabelvalueRsponse response =
          CustomerLabelvalueRsponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationNoToProductResponse> getQTNotoProductList(
      QuotationNoToProductListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QTNO_TO_PRODUCT_LIST, request.toJson());
      QuotationNoToProductResponse response =
          QuotationNoToProductResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SpecificationListResponse> getProductSpecificationList(
      SpecificationListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_SPEC_LIST, request.toJson());
      SpecificationListResponse response =
          SpecificationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationKindAttListResponse> getQuotationKindAttList(
      QuotationKindAttListApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_KIND_ATT_LIST, request.toJson());
      QuotationKindAttListResponse response =
          QuotationKindAttListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationProjectListResponse> getQuotationProjectList(
      QuotationProjectListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_PROJECT_LIST, request.toJson());
      QuotationProjectListResponse response =
          QuotationProjectListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationTermsCondtionResponse> getQuotationTermConditionList(
      QuotationTermsConditionRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_TERMS_CONDITION_LIST, request.toJson());
      QuotationTermsCondtionResponse response =
          QuotationTermsCondtionResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustIdToInqListResponse> getCustIdToInqList(
      CustIdToInqListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUST_ID_TO_INQ_LIST, request.toJson());
      CustIdToInqListResponse response = CustIdToInqListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InqNoToProductListResponse> getInqNoProductList(
      InquiryNoToProductListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQ_NO_PRODUCT_LIST, request.toJson());
      InqNoToProductListResponse response =
          InqNoToProductListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankDorpDownResponse> getBankDropDown(
      BankDropDownRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_BANK_DROP_DOWN, request.toJson());
      BankDorpDownResponse response = BankDorpDownResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherSearchByNameResponse> getBankVoucherSearchByName(
      BankVoucherSearchByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_BANK_VOUCHER_SEARCH, request.toJson());
      BankVoucherSearchByNameResponse response =
          BankVoucherSearchByNameResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationListResponse> getQuotationList(
      int pageNo, QuotationListApiRequest quotationListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_QUOTATION}/$pageNo-10",
          quotationListApiRequest.toJson());
      QuotationListResponse response = QuotationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesBillListResponse> getSalesBillList(
      int pageNo, SalesBillListRequest quotationListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_SALESBILL}/$pageNo-10",
          quotationListApiRequest.toJson());
      SalesBillListResponse response = SalesBillListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationListResponse> getQuotationListSearchByNumber(
      int pkID, SearchQuotationListByNumberRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_SEARCH_BY_QUOTATION_NO +
              pkID.toString() +
              "/Fetch",
          request.toJson());
      QuotationListResponse response = QuotationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchQuotationListResponse> getQuotationListSearchByName(
      SearchQuotationListByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_SEARCH_BY_NAME, request.toJson());
      SearchQuotationListResponse response =
          SearchQuotationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationPDFGenerateResponse> getQuotationPDFGenerate(
      QuotationPDFGenerateRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_GENERATE_PDF, request.toJson());
      QuotationPDFGenerateResponse response =
          QuotationPDFGenerateResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesOrderPDFGenerateResponse> getSalesOrderPDFGenerate(
      SalesOrderPDFGenerateRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_ORDER_GENERATE_PDF, request.toJson());
      SalesOrderPDFGenerateResponse response =
          SalesOrderPDFGenerateResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesBillPDFGenerateResponse> getSalesBillPDFGenerate(
      SalesBillPDFGenerateRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_BILL_GENERATE_PDF, request.toJson());
      SalesBillPDFGenerateResponse response =
          SalesBillPDFGenerateResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchSalesBillListResponse> getSalesBillListSearchByName(
      SearchSalesBillListByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_BILL_SEARCH_BY_NAME, request.toJson());
      SearchSalesBillListResponse response =
          SearchSalesBillListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesBillListResponse> getSalesBillSearchDetailsAPI(
      int CustID, SalesBillSearchByIdRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_BILL_BY_ID + CustID.toString() + "/Fetch",
          request.toJson());
      SalesBillListResponse response = SalesBillListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

/*  Future<String> menu_rights_api(MenuRightsRequest menuRightsRequest) async {
    try {
      String jsonString = await apiClient.apiCallPost(
          ApiClient.END_POINT_MENU_RIGHTS, menuRightsRequest.toJson());
      print("MenuRightsResponse - $jsonString");
      // var list = json.decode(jsonString);
      return jsonString; //CustomerCategoryResponseFromJson(list);
      //  return LoginApiResponse.fromJson(list[0]);
      */ /* Future<CustomerCategoryResponse> itemsList = (await Future<CustomerCategoryResponse>.from(list.map((i) => LoginApiResponse.fromJson(i)))) as Future<CustomerCategoryResponse>;
      return itemsList;*/ /*
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/

  Future<MenuRightsResponse> menu_rights_api(MenuRightsRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MENU_RIGHTS, request.toJson());
      MenuRightsResponse response = MenuRightsResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesOrderListResponse> getSalesOrderList(
      int pageNo, SalesOrderListApiRequest salesOrderListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_SALESORDER_PAGINATION}/$pageNo-10",
          salesOrderListApiRequest.toJson());
      SalesOrderListResponse response = SalesOrderListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchSalesOrderListResponse> getSalesOrderListSearchByName(
      SearchSalesOrderListByNameRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALESORDER_SEARCH_BY_NAME, request.toJson());
      SearchSalesOrderListResponse response =
          SearchSalesOrderListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesOrderListResponse> getSalesOrderListSearchByNumber(
      int pkID, SearchSalesOrderListByNumberRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUOTATION_SEARCH_BY_SALESORDER_NO +
              pkID.toString() +
              "/Fetch",
          request.toJson());
      SalesOrderListResponse response = SalesOrderListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ToDoListResponse> getToDoList(
      ToDoListApiRequest toDoListApiRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TODO, toDoListApiRequest.toJson());
      ToDoListResponse response = ToDoListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupListResponse> getFollowupListbyStatus(
      SearchFollowupListByNameRequest searchFollowupListByNameRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_SEARCH_BY_STATUS,
          searchFollowupListByNameRequest.toJson());
      FollowupListResponse response = FollowupListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowerEmployeeListResponse> getFollowerEmployeeList(
      FollowerEmployeeListRequest followerEmployeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWER_EMPLOYEE_LIST,
          followerEmployeeListRequest.toJson());
      FollowerEmployeeListResponse response =
          FollowerEmployeeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryShareEmpListResponse> getInquiryShareEmpList(
      InquiryShareEmpListRequest inquiryShareEmpListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_INQUIRY_SHARED_EMP_LIST,
          inquiryShareEmpListRequest.toJson());
      InquiryShareEmpListResponse response =
          InquiryShareEmpListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ALL_EmployeeList_Response> getALLEmployeeList(
      ALLEmployeeNameRequest followerEmployeeListRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_ALL_EMPLOYEE_LIST,
          followerEmployeeListRequest.toJson());
      ALL_EmployeeList_Response response =
          ALL_EmployeeList_Response.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DesignationApiResponse> designation_list_details(
      DesignationApiRequest designationApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_DESIGNATION_LIST, designationApiRequest.toJson());
      DesignationApiResponse designationApiResponse =
          DesignationApiResponse.fromJson(json);
      return designationApiResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  /* Future<CustomerAddEditApiResponse>customer_add_edit_details(CustomerAddEditApiRequest customerAddEditApiRequest) async {
    try {

      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_ADD_EDIT+"0/Save", customerAddEditApiRequest.toJson(),showSuccessDialog: true);
      CustomerAddEditApiResponse customerAddEditApiResponse =
      CustomerAddEditApiResponse.fromJson(json);
      return customerAddEditApiResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/
  Future<CustomerAddEditApiResponse> customer_add_edit_details(
      CustomerAddEditApiRequest customerAddEditApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_ADD_EDIT +
              customerAddEditApiRequest.customerID +
              "/Save",
          customerAddEditApiRequest.toJson());
      CustomerAddEditApiResponse customerAddEditApiResponse =
          CustomerAddEditApiResponse.fromJson(json);
      return customerAddEditApiResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerContactSaveResponse> customerContactSave_details(
      List<ContactModel> _contactsList) async {
    try {
      Map<String, dynamic> json =
          await apiClient.apiCallPostforMultipleJSONArray(
              ApiClient.END_POINT_CUSTOMER_CONTACT_SAVE, _contactsList,
              showSuccessDialog: true);
      CustomerContactSaveResponse customerAddEditApiResponse123 =
          CustomerContactSaveResponse.fromJson(json);
      return customerAddEditApiResponse123;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerIdToContactListResponse> getCustomerListFromCustomerID(
      CustomerIdToCustomerListRequest customerIdToCustomerListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_ID_TO_CONTACT_DETAILS,
          customerIdToCustomerListRequest.toJson());
      CustomerIdToContactListResponse customerIdToContactListResponse =
          CustomerIdToContactListResponse.fromJson(json);
      return customerIdToContactListResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerIdToDeleteAllContactResponse> getCustomerIdToDeleteAllContact(
      int pkID,
      CustomerIdToDeleteAllContactRequest
          customerIdToCustomerListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_ID_TO_CONTACT_ALL_DELETE +
              pkID.toString() +
              "/DeleteByCustomer",
          customerIdToCustomerListRequest.toJson());
      CustomerIdToDeleteAllContactResponse customerIdToContactListResponse =
          CustomerIdToDeleteAllContactResponse.fromJson(json);
      return customerIdToContactListResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryProductSaveResponse> inquiryProductSaveDetails(
      List<InquiryProductModel> inquiryProductModel) async {
    try {
      Map<String, dynamic> json =
          await apiClient.apiCallPostforMultipleJSONArray(
              ApiClient.END_POINT_INQUIRY_PRODUCT_SAVE, inquiryProductModel);
      InquiryProductSaveResponse inquiryProductSaveResponse =
          InquiryProductSaveResponse.fromJson(json);
      return inquiryProductSaveResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingAssamblySaveResponse> packingAssamblySaveAPI(
      List<PackingProductAssamblyTable> inquiryProductModel) async {
    try {
      Map<String, dynamic> json =
          await apiClient.apiCallPostforMultipleJSONArray(
              ApiClient.END_POINT_PACKING_ASSAMBLY_SAVE, inquiryProductModel);
      PackingAssamblySaveResponse inquiryProductSaveResponse =
          PackingAssamblySaveResponse.fromJson(json);
      return inquiryProductSaveResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingSubDetailsSaveResponse> finalCheckingSubDetailsSaveAPI(
      List<FinalCheckingItems> inquiryProductModel) async {
    try {
      Map<String, dynamic> json =
          await apiClient.apiCallPostforMultipleJSONArray(
              ApiClient.END_POINT_FINAL_CHECKING_SUB_DETAILS_SAVE,
              inquiryProductModel);
      FinalCheckingSubDetailsSaveResponse inquiryProductSaveResponse =
          FinalCheckingSubDetailsSaveResponse.fromJson(json);
      return inquiryProductSaveResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationProductSaveResponse> quotationProductSaveDetails(
      String QT_No, List<QuotationTable> quotationProductModel) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPostforMultipleJSONArray(
          "${ApiClient.END_POINT_QUOTATION_PRODUCT_SAVE}/$QT_No/ProductSaveByProdId",
          quotationProductModel);
      QuotationProductSaveResponse inquiryProductSaveResponse =
          QuotationProductSaveResponse.fromJson(json);
      return inquiryProductSaveResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryShareResponse> inquiryShareSaveDetails(
      List<InquiryShareModel> inquiryShareModel) async {
    try {
      Map<String, dynamic> json =
          await apiClient.apiCallPostforMultipleJSONArray(
              ApiClient.END_POINT_INQUIRY_SHARE, inquiryShareModel);
      InquiryShareResponse inquiryShareResponse =
          InquiryShareResponse.fromJson(json);
      return inquiryShareResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

/*
  Future<CustomerDeleteResponse> deleteCustomer(String pkID,CustomerDeleteRequest customerDeleteRequest) async {
    try {

      Map<String, dynamic> json = await apiClient.apiCallLoginUSerPost(
          ApiClient.END_POINT_CUSTOMER_ADD_EDIT+ pkID +"/Delete", customerDeleteRequest.toJson());
      CustomerDeleteResponse customerDeleteResponse =
      CustomerDeleteResponse.fromJson(json);
      return customerDeleteResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/
/*  Future<void> deleteCustomer(int id,CustomerDeleteRequest customerDeleteRequest) async {
    try {
      await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_ADD_EDIT}/${id}/Delete", customerDeleteRequest.toJson());
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/

  Future<FollowupTypeListResponse> getFollowupTypeList(
      FollowupTypeListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_TYPE_LIST, request.toJson());
      FollowupTypeListResponse response =
          FollowupTypeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryStatusListResponse> getFollowupInquiryStatusList(
      FollowupInquiryStatusTypeListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_TYPE_LIST, request.toJson());
      InquiryStatusListResponse response =
          InquiryStatusListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CloserReasonListResponse> getCloserReasonStatusList(
      CloserReasonTypeListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_TYPE_LIST, request.toJson());
      CloserReasonListResponse response =
          CloserReasonListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupHistoryListResponse> getFollowupHistoryList(
      FollowupHistoryListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_HISTORY_LIST, request.toJson());
      FollowupHistoryListResponse response =
          FollowupHistoryListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuickFollowupListResponse> getQuickFollowupListAPi(
      QuickFollowupListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUICK_FOLLOWUP_LIST, request.toJson());
      QuickFollowupListResponse response =
          QuickFollowupListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupInquiryNoListResponse> getInquiryNoStatusList(
      FollowerInquiryNoListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_INQUIRY_NO_LIST, request.toJson());
      FollowupInquiryNoListResponse response =
          FollowupInquiryNoListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupSaveSuccessResponse> getFollowupSaveStatus(
      int pkID, FollowupSaveApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_SAVE + pkID.toString() + "/Save",
          request.toJson());
      FollowupSaveSuccessResponse response =
          FollowupSaveSuccessResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupSaveSuccessResponse> getQuickFollowupSaveStatus(
      int pkID, FollowupSaveApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_QUICK_FOLLOWUP_SAVE + pkID.toString() + "/Save",
          request.toJson());
      FollowupSaveSuccessResponse response =
          FollowupSaveSuccessResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpsenseSaveResponse> getExpenseSave(
      int pkID, ExpenseSaveAPIRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXPENSE_SAVE + pkID.toString() + "/Save",
          request.toJson());
      ExpsenseSaveResponse response = ExpsenseSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpenseDeleteImageResponse> getDeleteExpenseImage(
      int pkID, ExpenseDeleteImageRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXPENSE_DELETE_IMAGE +
              pkID.toString() +
              "/DeleteImageByExpenseID",
          request.toJson(),
          showSuccessDialog: true);
      ExpenseDeleteImageResponse response =
          ExpenseDeleteImageResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpenseImageUploadServerAPIResponse> getExpenseImageUploadserer(
      ExpenseImageUploadServerAPIRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXPENSE_UPLOAD_SERVER +
              request.ExpenseID +
              "/ImageSave",
          request.toJson());
      ExpenseImageUploadServerAPIResponse response =
          ExpenseImageUploadServerAPIResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InquiryDeleteResponse> deleteInquiry(
      int id, FollowupDeleteRequest followupDeleteRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_INQUIRY_DELETE}/${id}/Delete",
          followupDeleteRequest.toJson(),
          showSuccessDialog: true);
      InquiryDeleteResponse response = InquiryDeleteResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationDeleteResponse> deleteQuotation(
      int id, QuotationDeleteRequest quotationDeleteRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DELETE_QUOTATION}/${id}/Delete",
          quotationDeleteRequest.toJson(),
          showSuccessDialog: true);
      QuotationDeleteResponse response = QuotationDeleteResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingCheckListDeleteResponse> deletePackingCheckList(
      int id, PackingCheckListDeleteRequest quotationDeleteRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_PackingChecklist_DELETE}/${id}/Del",
          quotationDeleteRequest.toJson(),
          showSuccessDialog: true);
      PackingCheckListDeleteResponse response =
          PackingCheckListDeleteResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<QuotationOtherChargesListResponse> getQuotationOtherChargeList(
      String id,
      QuotationOtherChargesListRequest quotationOtherChargesListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DELETE_QUOTATION}/${id}/Charges",
          quotationOtherChargesListRequest.toJson());
      QuotationOtherChargesListResponse response =
          QuotationOtherChargesListResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupDeleteResponse> deleteFollowup(
      int id, FollowupDeleteRequest followupDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_FOLLOWUP_DELETE}/${id}/Delete", followupDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_FOLLOWUP_DELETE}/${id}/Delete",
          followupDeleteRequest.toJson(),
          showSuccessDialog: true);
      FollowupDeleteResponse response = FollowupDeleteResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupDeleteResponse> deleteQuickFollowup(
      int id, FollowupDeleteRequest followupDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_FOLLOWUP_DELETE}/${id}/Delete", followupDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_FOLLOWUP_DELETE}/${id}/Delete",
          followupDeleteRequest.toJson(),
          showSuccessDialog: false);
      FollowupDeleteResponse response = FollowupDeleteResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDeleteResponse> deleteCustomer(
      int id, CustomerDeleteRequest customerDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete",
          customerDeleteRequest.toJson(),
          showSuccessDialog: true);
      CustomerDeleteResponse response = CustomerDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDeleteResponse> deleteExternalLead(
      int id, CustomerDeleteRequest customerDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EXTERNAL_LEAD_SAVE_DETAILS}/${id}/Delete",
          customerDeleteRequest.toJson(),
          showSuccessDialog: true);
      CustomerDeleteResponse response = CustomerDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerDeleteResponse> deleteTeleCaller(
      int id, CustomerDeleteRequest customerDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TELE_CALLER_PAGINATION}/${id}/Delete",
          customerDeleteRequest.toJson(),
          showSuccessDialog: true);
      CustomerDeleteResponse response = CustomerDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LeaveRequestDeleteResponse> deleteLeaveRequest(
      int id, FollowupDeleteRequest followupDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_LEAVE_REQUEST_DELETE}/${id}/Delete", followupDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_LEAVE_REQUEST_DELETE}/${id}/Delete",
          followupDeleteRequest.toJson(),
          showSuccessDialog: true);
      LeaveRequestDeleteResponse response =
          LeaveRequestDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DailyActivityDeleteResponse> deleteDailyActivity(
      int id, DailyActivityDeleteRequest customerDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DAILY_ACTIVITY_DELETE}/${id}/Delete",
          customerDeleteRequest.toJson(),
          showSuccessDialog: true);
      DailyActivityDeleteResponse response =
          DailyActivityDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DailyActivitySaveResponse> saveDailyActivity(
      int id, DailyActivitySaveRequest dailyActivitySaveRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DAILY_ACTIVITY_SAVE_DETAILS}/${id}/Save",
          dailyActivitySaveRequest.toJson());
      DailyActivitySaveResponse response =
          DailyActivitySaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TaskCategoryResponse> taskCategoryDetails(
      TaskCategoryListRequest taskCategoryListRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TASK_CATEGORY, taskCategoryListRequest.toJson());
      TaskCategoryResponse response = TaskCategoryResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getbankvoucherDelete(
      int id, BankVoucherDeleteRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_BANK_VOUCHER_LIST_DETAILS}/${id}/Delete",
          bankVoucherDeleteRequest.toJson());
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getEmployeeDelete(
      int id, BankVoucherDeleteRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EMPLOYEE_DELETE_DETAILS}/${id}/Del",
          bankVoucherDeleteRequest.toJson(),
          showSuccessDialog: true);
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getLoanDelete(
      int id, BankVoucherDeleteRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_LOAN_LIST_DETAILS}/${id}/Del",
          bankVoucherDeleteRequest.toJson());
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherDeleteResponse> getMaintenanceDelete(
      int id, BankVoucherDeleteRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_MAINTENANCE_LIST_DETAILS}/${id}/Delete",
          bankVoucherDeleteRequest.toJson());
      BankVoucherDeleteResponse response =
          BankVoucherDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankVoucherSaveResponse> getbankvoucherSave(
      int id, BankVoucherSaveRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_BANK_VOUCHER_LIST_DETAILS}/${id}/Save",
          bankVoucherDeleteRequest.toJson());
      BankVoucherSaveResponse response = BankVoucherSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TransectionModeListResponse> getTransectionModeList(
      TransectionModeListRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TRANSECTION_MODE_LIST_DETAILS}",
          bankVoucherDeleteRequest.toJson());
      TransectionModeListResponse response =
          TransectionModeListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendVisitSaveResponse> getAttendVisitSave(
      int pkId, AttendVisitSaveRequest bankVoucherDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_ATTEND_VISIT_SAVE_DETAILS}/$pkId/Save",
          bankVoucherDeleteRequest.toJson());
      AttendVisitSaveResponse response = AttendVisitSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ToDoWorkLogListResponse> toDoWorkLogListMethod(
      ToDoWorkLogListRequest toDoWorkLogListRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TO_DO_WORK_LOG, toDoWorkLogListRequest.toJson());
      ToDoWorkLogListResponse response = ToDoWorkLogListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ToDoDeleteResponse> todoDeleteAPI(
      int pkId, ToDoDeleteRequest toDoDeleteRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TO_DO_DELETE}/$pkId/Delete",
          toDoDeleteRequest.toJson());
      ToDoDeleteResponse response = ToDoDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ToDoSaveHeaderResponse> todo_save_method(
      int pkID, ToDoHeaderSaveRequest toDoHeaderSaveRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TO_DO_SAVE + pkID.toString() + "/Save",
          toDoHeaderSaveRequest.toJson());
      ToDoSaveHeaderResponse response = ToDoSaveHeaderResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ToDoSaveSubDetailsResponse> todo_save_sub_method(
      int pkID, ToDoSaveSubDetailsRequest toDoHeaderSaveRequest) async {
    try {
      /* await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete", customerDeleteRequest.toJson());*/
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TO_DO_SAVE + pkID.toString() + "/Log",
          toDoHeaderSaveRequest.toJson());
      ToDoSaveSubDetailsResponse response =
          ToDoSaveSubDetailsResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpenseDeleteResponse> deleteExpense(
      int id, FollowupDeleteRequest followupDeleteRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EXPENSE_DELETE}/${id}/Delete",
          followupDeleteRequest.toJson(),
          showSuccessDialog: true);
      ExpenseDeleteResponse response = ExpenseDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<Attendance_List_Response> getAttendanceList(
      AttendanceApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_ATTENDANCE_LIST, request.toJson());
      Attendance_List_Response response =
          Attendance_List_Response.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendVisitListResponse> getAttenVisitList(
      int pageNo, AttendVisitListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_ATTEND_VISIT_DETAILS}/$pageNo-10",
          request.toJson());
      AttendVisitListResponse response = AttendVisitListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DolphinComplaintVisitListResponse> getDolphinComplaintVisitList(
      int pageNo, DolphinComplaintVisitListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_DOLPHIN_ATTEND_VISIT_DETAILS}/$pageNo-10",
          request.toJson());
      DolphinComplaintVisitListResponse response =
          DolphinComplaintVisitListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ComplaintNoListResponse> getComplaintNoList(
      ComplaintNoListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_COMPLAINT_NO_LIST_DETAILS, request.toJson());
      ComplaintNoListResponse response = ComplaintNoListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendanceEmployeeListResponse> attendanceEmployeeList(
      AttendanceEmployeeListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWER_EMPLOYEE_LIST, request.toJson());
      AttendanceEmployeeListResponse response =
          AttendanceEmployeeListResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FetchImageListByExpensePKID_Response> fetchImageListbyExpensePKID(
      FetchImageListByExpensePKID_Request request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FETCH_IMAGE_LIST_BY_EXPENSE_PKID,
          request.toJson());
      FetchImageListByExpensePKID_Response response =
          FetchImageListByExpensePKID_Response.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendanceSaveResponse> attendanceSave(
      AttendanceSaveApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_ATTENDANCE_SAVE, request.toJson(),
          showSuccessDialog: true);
      AttendanceSaveResponse response = AttendanceSaveResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<AttendanceSaveResponse> DashBoardattendanceSave(
      AttendanceSaveApiRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_ATTENDANCE_SAVE, request.toJson(),
          showSuccessDialog: false);
      AttendanceSaveResponse response = AttendanceSaveResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LeaveRequestListResponse> getLeaveRequestList(
      int pageNo, LeaveRequestListAPIRequest leaveRequestListAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_LEAVE_REQUEST_PAGINATION}/$pageNo-10",
          leaveRequestListAPIRequest.toJson());
      LeaveRequestListResponse response =
          LeaveRequestListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupFilterListResponse> getFollowupFilterList(
    String filtername,
    FollowupFilterListRequest request,
  ) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_FILTER_PAGINATION +
              filtername +
              "/Filter",
          request.toJson());
      FollowupFilterListResponse response =
          FollowupFilterListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LeaveRequestTypeResponse> getLeaveRequestType(
      LeaveRequestTypeAPIRequest leaveRequestListAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LEAVE_REQUEST_TYPE,
          leaveRequestListAPIRequest.toJson());
      LeaveRequestTypeResponse response =
          LeaveRequestTypeResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LeaveRequestSaveResponse> getLeaveRequestSave(
      int pkID, LeaveRequestSaveAPIRequest leaveRequestSaveAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LEAVE_REQUEST_SAVE + pkID.toString() + "/Save",
          leaveRequestSaveAPIRequest.toJson(),
          showSuccessDialog: true);
      LeaveRequestSaveResponse response =
          LeaveRequestSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LeaveApprovalSaveResponse> getLeaveApprovalSave(
      int pkID, LeaveApprovalSaveAPIRequest leaveApprovalSaveAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_LEAVE_REQUEST_SAVE +
              pkID.toString() +
              "/ChangeApproval",
          leaveApprovalSaveAPIRequest.toJson(),
          showSuccessDialog: true);
      LeaveApprovalSaveResponse response =
          LeaveApprovalSaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpenseListResponse> getExpenseList(
      int pageNo, ExpenseListAPIRequest expenseListAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EXPENSE_PAGINATION_FILTER}/$pageNo-10",
          expenseListAPIRequest.toJson());
      ExpenseListResponse response = ExpenseListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExpenseTypeResponse> getExpenseType(
      ExpenseTypeAPIRequest expenseTypeAPIRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXPENSE_TYPE, expenseTypeAPIRequest.toJson());
      ExpenseTypeResponse response = ExpenseTypeResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

/*  Future<ExpenseUploadImageResponse> getuploadImage(List<File> imagesfiles,
      ExpenseUploadImageAPIRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPostMultipart(
          ApiClient.END_POINT_EXPENSE_UPLOAD,request.toJson(),imageFilesToUpload: imagesfiles);

     // print("response - ${json}");

      ExpenseUploadImageResponse response =
      ExpenseUploadImageResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }*/

  Future<ExpenseUploadImageResponse> getuploadImage(
      File imagesfiles,
      ExpenseUploadImageAPIRequest
          expenseUploadImageAPIRequest /*String expenseID, String companyId, String loginUserId, String fileName, String type, String pkID,*/) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPostMultipart(
          ApiClient.END_POINT_EXPENSE_UPLOAD,
          /*{
        "ExpenseID": "$expenseID",
        "CompanyId":"$companyId",
        "LoginUserId":"$loginUserId",
        "fileName":"$fileName",
        "pkID":"$pkID",
        "Type":'$type',

      }*/
          expenseUploadImageAPIRequest.toJson(),
          imageFilesToUpload: [imagesfiles]);
      ExpenseUploadImageResponse response =
          ExpenseUploadImageResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<Telecaller_image_upload_response> getuploadImageTeleCaller(
      File imagesfiles,
      TeleCallerUploadImgApiRequest expenseUploadImageAPIRequest) async {
    try {
      Map<String, dynamic> jsons = await apiClient.apiCallPostMultipart(
          ApiClient.END_POINT_TELECALLER_IMG_UPLOAD,
          expenseUploadImageAPIRequest.toJson(),
          imageFilesToUpload: [imagesfiles]);
      print(jsons);
      Telecaller_image_upload_response response =
          Telecaller_image_upload_response.fromJson(jsons);

      return response;
    } on ErrorResponseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<FollowupImageUploadResponse> getFollowupuploadImage(
      File imagesfiles, FollowUpUploadImageAPIRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPostMultipart(
          ApiClient.END_POINT_FOLLOWUP_UPLOAD, request.toJson(),
          imageFilesToUpload: [imagesfiles]);

      // print("response - ${json}");

      FollowupImageUploadResponse response =
          FollowupImageUploadResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupInquiryByCustomerIDResponse> getFollowupInquiryByCustomerID(
      FollowerInquiryByCustomerIDRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_INQUIRY_BY_CUSTOMER_ID,
          request.toJson());

      // print("response - ${json}");

      FollowupInquiryByCustomerIDResponse response =
          FollowupInquiryByCustomerIDResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FollowupDeleteImageResponse> getFollowupImageDeleteByPkID(
      int pkID, FollowupImageDeleteRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FOLLOWUP_IMAGE_DELETE_BY_PK_ID +
              pkID.toString() +
              "/DeleteImage",
          request.toJson(),
          showSuccessDialog: true);

      // print("response - ${json}");

      FollowupDeleteImageResponse response =
          FollowupDeleteImageResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TeleCallerImageDeleteResponse> getTeleCallerImageDeleteByPkID(
      int pkID, TeleCallerImageDeleteRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TELECALLER_IMAGE_DELETE_BY_PK_ID +
              pkID.toString() +
              "/DeleteImage",
          request.toJson(),
          showSuccessDialog: true);

      // print("response - ${json}");

      TeleCallerImageDeleteResponse response =
          TeleCallerImageDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PlacesSearchResponse> googelePlaceSearch(
      String MapAPIKey, PlaceSearchRequest placeSearchRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallGoogleGet(
          ApiClient.END_POINT_GOOGLE_PLACE_SEARCH,
          query: placeSearchRequest.query,
          key: MapAPIKey);

      // print("JSONARRAYRESPOVN" + json.toString());
      PlacesSearchResponse placesSearchResponse =
          PlacesSearchResponse.fromJson(json);
      return placesSearchResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<DistanceMatrixResponse> distanceMatrixDetails(
      String MapAPIKey, DistanceMatrix_Request distanceMatrix_Request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallGoogleGetDistance(
          ApiClient.END_POINT_DISTANCE_MATRIX,
          origins: distanceMatrix_Request.origins,
          destinations: distanceMatrix_Request.destinations,
          key: MapAPIKey);

      // print("JSONARRAYRESPOVN" + json.toString());
      DistanceMatrixResponse distanceMatrixResponse =
          DistanceMatrixResponse.fromJson(json);
      return distanceMatrixResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<LocationAddressResponse> location_address(
      LocationAddressRequest locationAddressRequest) async {
    try {
      Map<String, dynamic> json = await apiClient
          .apiCallGoogleGetLocationAddress(ApiClient.END_POINT_LOCATION_ADDRESS,
              latlng: locationAddressRequest.latlng,
              key: locationAddressRequest.key);

      // print("JSONARRAYRESPOVN" + json.toString());
      LocationAddressResponse locationAddressResponse =
          LocationAddressResponse.fromJson(json);
      return locationAddressResponse;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadListResponse> getExternalLeadList(
      int pageNo, ExternalLeadListRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EXTERNAL_LEAD_PAGINATION}/$pageNo-10",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      ExternalLeadListResponse response =
          ExternalLeadListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TeleCallerListResponse> getTeleCallerList(
      int pageNo, TeleCallerListRequest customerPaginationRequest) async {
    //todo due to one api bug temporary adding following key
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TELE_CALLER_PAGINATION1}/$pageNo-10",
          customerPaginationRequest
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);
      print(
          "ToJSONRESPONSFG : " + customerPaginationRequest.toJson().toString());
      TeleCallerListResponse response = TeleCallerListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadSearchResponseByName> externalLeadSearchByNamedetails(
      ExternalLeadSearchRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXTERNAL_LEAD_SEARCH_DETAILS,
          talukaApiRequest.toJson());
      ExternalLeadSearchResponseByName cityApiRespose =
          ExternalLeadSearchResponseByName.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TeleCallerSearchResponseByName> getTeleCallerSearchByNamedetails(
      TeleCallerSearchRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TELE_CALLER_SEARCH_DETAILS,
          talukaApiRequest.toJson());
      TeleCallerSearchResponseByName cityApiRespose =
          TeleCallerSearchResponseByName.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadListResponse> externalLeadSearchByIDDetails(
      ExternalLeadSearchRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_EXTERNAL_LEAD_SEARCH_DETAILS,
          talukaApiRequest.toJson());
      ExternalLeadListResponse cityApiRespose =
          ExternalLeadListResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TeleCallerListResponse> getTeleCallerLeadSearchByIDDetails(
      TeleCallerSearchRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_TELE_CALLER_SEARCH_DETAILS,
          talukaApiRequest.toJson());
      TeleCallerListResponse cityApiRespose =
          TeleCallerListResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadSaveResponse> externalLeadSaveDetails(
      int pkID, ExternalLeadSaveRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_EXTERNAL_LEAD_PAGINATION}/$pkID/Save",
          talukaApiRequest.toJson());
      ExternalLeadSaveResponse cityApiRespose =
          ExternalLeadSaveResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadSaveResponse> teleCallerSaveDetails(
      int pkID, TeleCallerSaveRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TELE_CALLER_PAGINATION}/$pkID/Save",
          talukaApiRequest.toJson());
      ExternalLeadSaveResponse cityApiRespose =
          ExternalLeadSaveResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ExternalLeadSaveResponse> new_teleCallerSaveDetails(
      int pkID, NewTeleCallerSaveRequest talukaApiRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_NEW_TELE_CALLER_SAVE}/$pkID/Save",
          talukaApiRequest.toJson());
      ExternalLeadSaveResponse cityApiRespose =
          ExternalLeadSaveResponse.fromJson(json);
      return cityApiRespose;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingChecklistListResponse> PackingChecklistCall(
      int pageNo, PackingChecklistListRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Packing_checklist_list}/$pageNo-10",
          request.toJson());
      PackingChecklistListResponse response =
          PackingChecklistListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingListResponse> FinalCheckingListCall(
      int pageNo, FinalCheckingListRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Final_Checking_List}/$pageNo-10",
          request.toJson());
      FinalCheckingListResponse response =
          FinalCheckingListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchFinalCheckingLabelResponse> searchfinalcheckinglabel(
      SearchFinalCheckingRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FinalChecking_Search, request.toJson());
      SearchFinalCheckingLabelResponse response =
          SearchFinalCheckingLabelResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<FinalCheckingListResponse> searchfinalchecking(
      SearchFinalCheckingRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_FinalChecking_Search, request.toJson());
      FinalCheckingListResponse response =
          FinalCheckingListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingChecklistListResponse> searchpackingchecklist(
      SearchPackingChecklistRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PackingChecklist_Search, request.toJson());
      PackingChecklistListResponse response =
          PackingChecklistListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchPackingchecklistLabelResponse> searchpackingchecklistlabel(
      SearchPackingChecklistRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_PackingChecklist_Search, request.toJson());
      SearchPackingchecklistLabelResponse response =
          SearchPackingchecklistLabelResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationListResponse> InstallationListCall(
      int pageNo, InstallationListRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Installation_List}/$pageNo-10",
          request.toJson());
      InstallationListResponse response =
          InstallationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationListResponse> searchinstallation(
      SearchInstallationRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Installation_Search, request.toJson());
      InstallationListResponse response =
          InstallationListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SearchInstallationLabelResponse> searchinstallationlabel(
      SearchInstallationRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Installation_Search, request.toJson());
      SearchInstallationLabelResponse response =
          SearchInstallationLabelResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationDeleteRespose> deleteinstallation(
      int id, InstallationDeleteRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_CUSTOMER_DELETE}/${id}/Delete",
          request.toJson(),
          showSuccessDialog: true);

      InstallationDeleteRespose response =
          InstallationDeleteRespose.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationSearchCustomerResponse> installationcustomersearch(
      InstallationCustomerSearchRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CUSTOMER_SEARCH, request.toJson());
      InstallationSearchCustomerResponse response =
          InstallationSearchCustomerResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationCountryResponse> installationcontry(
      InstallationCountryRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Installation_country, request.toJson());
      InstallationCountryResponse response =
          InstallationCountryResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<StateResponse> installationstate(StateListRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_STATELIST, request.toJson());
      StateResponse response = StateResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationCityResponse> installationcity(
      CitySearchInstallationApiRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_CITY_LIST, request.toJson());
      InstallationCityResponse response =
          InstallationCityResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<CustomerIdToOutwardnoResponse> idtooutwardno(
      InstallationCustomerIdToOutwardnoRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Id_To_Outward, request.toJson());
      CustomerIdToOutwardnoResponse response =
          CustomerIdToOutwardnoResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<InstallationEmployeeResponse> installationemployee(
      InstallationEmployeeRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Installation_employee, request.toJson());
      InstallationEmployeeResponse response =
          InstallationEmployeeResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SaveInstallationResponse> saveinstallation(
      int id, SaveInstallationRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Save_Installation_List}/$id/Save",
          request.toJson());
      SaveInstallationResponse response =
          SaveInstallationResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TypeOfWorkResponse> ProductionTypeofwork(
      TypeOfWorkRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Production_Typeofwork, request.toJson());
      TypeOfWorkResponse response = TypeOfWorkResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ProductionActivityResponse> ProductionActivityListCall(
      ProductionActivityRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Production_Activity_List, request.toJson());
      ProductionActivityResponse response =
          ProductionActivityResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<PackingListResponse> packinglist(
      ProductionPackingListRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_Production_packinglist, request.toJson());
      PackingListResponse response = PackingListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ProductionActivitySaveResponse> productionactivitysave(
      int id, SaveProductionActivityRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Production_Save}/$id/Save", request.toJson());
      ProductionActivitySaveResponse response =
          ProductionActivitySaveResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<ProductionActivityDeleteResponse> productionactivitydelete(
      int id, ProductionActivityDeleteRequest request) async {
    try {
      /// API Client Class Here Declare Value
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_Production_Save}/$id/Delete",
          request.toJson());
      ProductionActivityDeleteResponse response =
          ProductionActivityDeleteResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<TelecallerNewpaginationResponse> telecallernewlist(
      int pageNo, TeleCallerNewListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          "${ApiClient.END_POINT_TELE_CALLER_New_pagination}/$pageNo-10",
          request
              .toJson() /*jsontemparray: customerPaginationRequest.lstcontact*/);

      TelecallerNewpaginationResponse response =
          TelecallerNewpaginationResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<BankDetailsListResponse> getBankDetailsAPI(
      SaleOrderBankDetailsListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_ORDER_BANK_DETIALS, request.toJson());
      BankDetailsListResponse response = BankDetailsListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SaleBillEmailContentResponse> getEmailContentAPI(
      SalesBillEmailContentRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_BILL_EMAIL_CONTENT, request.toJson());
      SaleBillEmailContentResponse response =
          SaleBillEmailContentResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<SalesBill_INQ_QT_SO_NO_ListResponse> getINQ_QT_SO_NO_API(
      SaleBill_INQ_QT_SO_NO_ListRequest request) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_SALES_BILL_INQ_QT_SO_NO_LIST_API,
          request.toJson());
      SalesBill_INQ_QT_SO_NO_ListResponse response =
          SalesBill_INQ_QT_SO_NO_ListResponse.fromJson(json);

      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  /****************************************Manage Accounts*****************************************/
  Future<MaterialInwardListResponse> materialInwardListAPI(
      int pageNo, MaterialInwardListRequest materialInwardListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MATERIAL_INWARD_LIST +
              "/" +
              pageNo.toString() +
              "-10",
          materialInwardListRequest.toJson());
      MaterialInwardListResponse response =
          MaterialInwardListResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<MaterialOutwardListResponse> materialOutwardListAPI(
      int pageNo, MaterialOutwardListRequest materialOutwardListRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.END_POINT_MATERIAL_OUTWARD_LIST +
              "/" +
              pageNo.toString() +
              "-10",
          materialOutwardListRequest.toJson());
      MaterialOutwardListResponse response =
          MaterialOutwardListResponse.fromJson(json);
      return response;
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }

  Future<String> getAPIUpdateTokenAPI(
      APITokenUpdateRequest apiTokenUpdateRequest) async {
    try {
      Map<String, dynamic> json = await apiClient.apiCallPost(
          ApiClient.API_TOKEN_UPDATE, apiTokenUpdateRequest.toJson());

      return json.toString();
    } on ErrorResponseException catch (e) {
      rethrow;
    }
  }
}
