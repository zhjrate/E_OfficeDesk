part of 'dashboard_user_rights_screen_bloc.dart';

abstract class DashBoardScreenStates extends BaseStates {
  const DashBoardScreenStates();
}

///all states of AuthenticationStates

class MenuRightsScreenInitialState extends DashBoardScreenStates {}

class MenuRightsEventResponseState extends DashBoardScreenStates {
  MenuRightsResponse menuRightsResponse;
  MenuRightsEventResponseState(this.menuRightsResponse);
}
/*class CustomerCategoryCallEventResponseState extends DashBoardScreenStates{
  final CustomerCategoryResponse categoryResponse;
  CustomerCategoryCallEventResponseState(this.categoryResponse);
}*/
/*class CustomerSourceCallEventResponseState extends DashBoardScreenStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}*/
/*class DesignationListEventResponseState extends DashBoardScreenStates{
  final DesignationApiResponse designationApiResponse;
  DesignationListEventResponseState(this.designationApiResponse);
}*/
/*class InquiryLeadStatusListCallResponseState extends DashBoardScreenStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  InquiryLeadStatusListCallResponseState(this.inquiryStatusListResponse);
}*/

class FollowerEmployeeListByStatusCallResponseState
    extends DashBoardScreenStates {
  final FollowerEmployeeListResponse response;

  FollowerEmployeeListByStatusCallResponseState(this.response);
}

/*class FollowupTypeListCallResponseState extends DashBoardScreenStates {
  final FollowupTypeListResponse followupTypeListResponse;

  FollowupTypeListCallResponseState(this.followupTypeListResponse);
}*/
class FollowupInquiryStatusListCallResponseState extends DashBoardScreenStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  FollowupInquiryStatusListCallResponseState(this.inquiryStatusListResponse);
}

class NavigateToSecond extends DashBoardScreenStates {
  final String ref;

  NavigateToSecond(this.ref);
}
/*class CloserReasonListCallResponseState extends DashBoardScreenStates {
  final CloserReasonListResponse closerReasonListResponse;

  CloserReasonListCallResponseState(this.closerReasonListResponse);
}*/
/*class LeaveRequestTypeResponseState extends DashBoardScreenStates {
  final LeaveRequestTypeResponse response;
  LeaveRequestTypeResponseState(this.response);
}*/

/*
class ExpenseTypeCallResponseState extends DashBoardScreenStates {
  final ExpenseTypeResponse expenseTypeResponse;

  ExpenseTypeCallResponseState(this.expenseTypeResponse);
}*/
class ALL_EmployeeNameListResponseState extends DashBoardScreenStates {
  final ALL_EmployeeList_Response all_employeeList_Response;

  ALL_EmployeeNameListResponseState(this.all_employeeList_Response);
}

class AttendanceListCallResponseState extends DashBoardScreenStates {
  final Attendance_List_Response response;
  AttendanceListCallResponseState(this.response);
}

class AttendanceSaveCallResponseState extends DashBoardScreenStates {
  final AttendanceSaveResponse response;
  AttendanceSaveCallResponseState(this.response);
}

class EmployeeListResponseState extends DashBoardScreenStates {
  final EmployeeListResponse employeeListResponse;
  final int newPage;

  EmployeeListResponseState(this.newPage, this.employeeListResponse);
}

class APITokenUpdateState extends DashBoardScreenStates {
  final String apiresponse;

  APITokenUpdateState(this.apiresponse);
}
