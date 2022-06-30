part of 'leave_request_bloc.dart';


abstract class LeaveRequestStates extends BaseStates {
  const LeaveRequestStates();
}

///all states of AuthenticationStates

class LeaveRequestStatesInitialState extends LeaveRequestStates {}


class LeaveRequestStatesResponseState extends LeaveRequestStates{
  LeaveRequestListResponse leaveRequestListResponse;
  final int newPage;


  LeaveRequestStatesResponseState(this.newPage,this.leaveRequestListResponse);
}
class LeaveRequestEmployeeListResponseState extends LeaveRequestStates {
  final AttendanceEmployeeListResponse response;
  LeaveRequestEmployeeListResponseState(this.response);
}
class LeaveRequestDeleteCallResponseState extends LeaveRequestStates {
  final LeaveRequestDeleteResponse leaveRequestDeleteResponse;

  LeaveRequestDeleteCallResponseState(this.leaveRequestDeleteResponse);
}



class LeaveRequestSaveResponseState extends LeaveRequestStates {
  final LeaveRequestSaveResponse response;
  LeaveRequestSaveResponseState(this.response);
}

class LeaveApprovalSaveResponseState extends LeaveRequestStates {
  final LeaveApprovalSaveResponse response;
  LeaveApprovalSaveResponseState(this.response);
}

class LeaveRequestTypeResponseState extends LeaveRequestStates {
  final LeaveRequestTypeResponse response;
  LeaveRequestTypeResponseState(this.response);
}