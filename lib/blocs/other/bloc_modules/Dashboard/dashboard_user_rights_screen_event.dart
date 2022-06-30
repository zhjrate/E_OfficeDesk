part of 'dashboard_user_rights_screen_bloc.dart';

@immutable
abstract class DashBoardScreenEvents {}

///all events of AuthenticationEvents

class MenuRightsCallEvent extends DashBoardScreenEvents {
  final MenuRightsRequest menuRightsRequest;
  MenuRightsCallEvent(this.menuRightsRequest);
}

/*class CustomerCategoryCallEvent extends DashBoardScreenEvents {
  final CustomerCategoryRequest request1;
  CustomerCategoryCallEvent(this.request1);
}*/
/*class CustomerSourceCallEvent extends DashBoardScreenEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}*/
/*class DesignationCallEvent extends DashBoardScreenEvents {
  final DesignationApiRequest designationApiRequest;
  DesignationCallEvent(this.designationApiRequest);
}*/
/*class InquiryLeadStatusTypeListByNameCallEvent extends DashBoardScreenEvents {
  final FollowupInquiryStatusTypeListRequest followupInquiryStatusTypeListRequest;

  InquiryLeadStatusTypeListByNameCallEvent(this.followupInquiryStatusTypeListRequest);
}*/
class FollowerEmployeeListCallEvent extends DashBoardScreenEvents {
  final FollowerEmployeeListRequest followerEmployeeListRequest;
  FollowerEmployeeListCallEvent(this.followerEmployeeListRequest);
}
/*class FollowupTypeListByNameCallEvent extends DashBoardScreenEvents {
  final FollowupTypeListRequest followupTypeListRequest;

  FollowupTypeListByNameCallEvent(this.followupTypeListRequest);
}*/
class FollowupInquiryStatusTypeListByNameCallEvent extends DashBoardScreenEvents {
  final FollowupInquiryStatusTypeListRequest followupInquiryStatusTypeListRequest;

  FollowupInquiryStatusTypeListByNameCallEvent(this.followupInquiryStatusTypeListRequest);
}

class NavigateToView extends DashBoardScreenEvents {
  final String path;

  NavigateToView(this.path);
}


class ALLEmployeeNameCallEvent extends DashBoardScreenEvents {
  final ALLEmployeeNameRequest allEmployeeNameRequest;

  ALLEmployeeNameCallEvent(this.allEmployeeNameRequest);
}


/*
class CloserReasonTypeListByNameCallEvent extends DashBoardScreenEvents {
  final CloserReasonTypeListRequest closerReasonTypeListRequest;

  CloserReasonTypeListByNameCallEvent(this.closerReasonTypeListRequest);
}
*/

/*class LeaveRequestTypeCallEvent extends DashBoardScreenEvents
{
  final LeaveRequestTypeAPIRequest leaveRequestTypeAPIRequest;
  LeaveRequestTypeCallEvent(this.leaveRequestTypeAPIRequest);
}*/

/*
class ExpenseTypeByNameCallEvent extends DashBoardScreenEvents {

  final ExpenseTypeAPIRequest expenseTypeAPIRequest;

  ExpenseTypeByNameCallEvent(this.expenseTypeAPIRequest);
}*/
class AttendanceCallEvent extends DashBoardScreenEvents
{
  final AttendanceApiRequest attendanceApiRequest;
  AttendanceCallEvent(this.attendanceApiRequest);
}

class AttendanceSaveCallEvent extends DashBoardScreenEvents
{
  final AttendanceSaveApiRequest attendanceSaveApiRequest;
  AttendanceSaveCallEvent(this.attendanceSaveApiRequest);
}


class EmployeeListCallEvent extends DashBoardScreenEvents {

  final int pageNo;
  final EmployeeListRequest employeeListRequest;

  EmployeeListCallEvent(this.pageNo,this.employeeListRequest);
}