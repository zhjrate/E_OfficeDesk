part of 'missed_punch_bloc.dart';




abstract class MissedPunchScreenStates extends BaseStates {
  const MissedPunchScreenStates();
}

///all states of AuthenticationStates

class MissedPunchScreenInitialState extends MissedPunchScreenStates {}

class MissedPunchListResponseState extends MissedPunchScreenStates {

  final MissedPunchListResponse loanListResponse;
  final int newPage;

  MissedPunchListResponseState(this.newPage,this.loanListResponse);
}

class MissedPunchSearchByNameResponseState extends MissedPunchScreenStates {

  final MissedPunchSearchByNameResponse missedPunchSearchByNameResponse;

  MissedPunchSearchByNameResponseState(this.missedPunchSearchByNameResponse);
}

class MissedPunchSearchByIDResponseState extends MissedPunchScreenStates {

  final MissedPunchListResponse missedPunchListResponse;

  MissedPunchSearchByIDResponseState(this.missedPunchListResponse);
}

class MissedPunchDeleteResponseState extends MissedPunchScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  MissedPunchDeleteResponseState(this.bankVoucherDeleteResponse);
}

class MissedPunchApprovalListResponseState extends MissedPunchScreenStates {
  final MissedPunchApprovalListResponse missedPunchApprovalListResponse;

  MissedPunchApprovalListResponseState(this.missedPunchApprovalListResponse);
}