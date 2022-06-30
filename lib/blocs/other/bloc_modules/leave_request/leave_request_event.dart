part of 'leave_request_bloc.dart';





@immutable
abstract class LeaveRequestEvents {}

///all events of AuthenticationEvents

class LeaveRequestCallEvent extends LeaveRequestEvents {
  final int pageNo;

  final LeaveRequestListAPIRequest leaveRequestListAPIRequest;
  LeaveRequestCallEvent(this.pageNo,this.leaveRequestListAPIRequest);
}

class LeaveRequestEmployeeListCallEvent extends LeaveRequestEvents
{
  final AttendanceEmployeeListRequest attendanceEmployeeListRequest;
  LeaveRequestEmployeeListCallEvent(this.attendanceEmployeeListRequest);
}
class LeaveRequestDeleteByNameCallEvent extends LeaveRequestEvents {
  final int pkID;

  final FollowupDeleteRequest leaverequestdelete;

  LeaveRequestDeleteByNameCallEvent(this.pkID,this.leaverequestdelete);
}



class LeaveRequestSaveCallEvent extends LeaveRequestEvents
{
  int pkID;
  final LeaveRequestSaveAPIRequest leaveRequestSaveAPIRequest;
  LeaveRequestSaveCallEvent(this.pkID,this.leaveRequestSaveAPIRequest);
}

class LeaveRequestApprovalSaveCallEvent extends LeaveRequestEvents
{
  int pkID;
  final LeaveApprovalSaveAPIRequest leaveApprovalSaveAPIRequest;
  LeaveRequestApprovalSaveCallEvent(this.pkID,this.leaveApprovalSaveAPIRequest);
}

class LeaveRequestTypeCallEvent extends LeaveRequestEvents
{
  final LeaveRequestTypeAPIRequest leaveRequestTypeAPIRequest;
  LeaveRequestTypeCallEvent(this.leaveRequestTypeAPIRequest);
}