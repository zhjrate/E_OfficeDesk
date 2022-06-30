part of 'dolphin_complaint_visit_bloc.dart';


abstract class DolphinComplaintVisitStates extends BaseStates {
  const DolphinComplaintVisitStates();
}

///all states of AuthenticationStates
class DolphinComplaintVisitInitialState extends DolphinComplaintVisitStates {}


class DolphinComplaintVisitListCallResponseState extends DolphinComplaintVisitStates {
  final int newPage;

  final DolphinComplaintVisitListResponse response;
  DolphinComplaintVisitListCallResponseState(this.newPage,this.response);
}
class DolphinComplaintSearchByNameResponseState extends DolphinComplaintVisitStates {
  final DolphinComplaintSearchResponse dolphinComplaintSearchResponse;

  DolphinComplaintSearchByNameResponseState(this.dolphinComplaintSearchResponse);
}

class  DolphinComplaintVisitSearchByIDResponseState extends DolphinComplaintVisitStates {
  final DolphinComplaintVisitListResponse response;

  DolphinComplaintVisitSearchByIDResponseState(this.response);
}

class  DolphinComplaintVisitDeleteResponseState extends DolphinComplaintVisitStates {
  final DolphinComplaintVisitDeleteResponse response;

  DolphinComplaintVisitDeleteResponseState(this.response);
}


class  DolphinComplaintVisitSaveResponseState extends DolphinComplaintVisitStates {
  final DolphinComplaintVisitSaveResponse response;

  DolphinComplaintVisitSaveResponseState(this.response);
}

