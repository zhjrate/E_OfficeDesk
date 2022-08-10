part of 'missed_punch_bloc.dart';



@immutable
abstract class MissedPunchScreenEvents {}

///all events of AuthenticationEvents

class MissedPunchListCallEvent extends MissedPunchScreenEvents {

  final int pageNo;
  final MissedPunchListRequest listRequest;

  MissedPunchListCallEvent(this.pageNo,this.listRequest);
}

class MissedPunchSearchByNameCallEvent extends MissedPunchScreenEvents {

  final MissedPunchSearchByNameRequest missedPunchSearchByNameRequest;

  MissedPunchSearchByNameCallEvent(this.missedPunchSearchByNameRequest);
}
class MissedPunchSearchByIDCallEvent extends MissedPunchScreenEvents {

  int pkID;
  final MissedPunchSearchByIDRequest missedPunchSearchByIDRequest;

  MissedPunchSearchByIDCallEvent(this.pkID,this.missedPunchSearchByIDRequest);
}

class MissedPunchDeleteCallEvent extends MissedPunchScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  MissedPunchDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}
class MissedPunchApprovalListCallEvent extends MissedPunchScreenEvents {

  final MissedPunchApprovalListRequest missedPunchApprovalListRequest;

  MissedPunchApprovalListCallEvent(this.missedPunchApprovalListRequest);
}

class MissedPunchApprovalSaveRequestCallEvent extends MissedPunchScreenEvents {

  int pkID;
  final MissedPunchApprovalSaveRequest missedPunchApprovalSaveRequest;

  MissedPunchApprovalSaveRequestCallEvent(this.pkID,this.missedPunchApprovalSaveRequest);
}