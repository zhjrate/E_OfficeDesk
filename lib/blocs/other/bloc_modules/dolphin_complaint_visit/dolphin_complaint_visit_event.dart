part of 'dolphin_complaint_visit_bloc.dart';





@immutable
abstract class DolphinComplaintVisitEvents {}

///all events of AuthenticationEvents
class DolphinComplaintVisitListCallEvent extends DolphinComplaintVisitEvents
{
  final int pageNo;
  final DolphinComplaintVisitListRequest dolphinComplaintVisitListRequest;
  DolphinComplaintVisitListCallEvent(this.pageNo,this.dolphinComplaintVisitListRequest);
}

class DolphinComplaintSearchByNameCallEvent extends DolphinComplaintVisitEvents {

  final DolphinComplaintSearchRequest dolphinComplaintSearchRequest;

  DolphinComplaintSearchByNameCallEvent(this.dolphinComplaintSearchRequest);
}


class DolphinComplaintVisitSearchByIDCallEvent extends DolphinComplaintVisitEvents {
  final int pkID;

  final DolphinComplaintSearchByIDRequest dolphinComplaintSearchByIDRequest;

  DolphinComplaintVisitSearchByIDCallEvent(this.pkID,this.dolphinComplaintSearchByIDRequest);
}

class DolphinComplaintVisitDeleteCallEvent extends DolphinComplaintVisitEvents {

  final DolphinComplaintVisitDeleteRequest dolphinComplaintVisitDeleteRequest;

  DolphinComplaintVisitDeleteCallEvent(this.dolphinComplaintVisitDeleteRequest);
}

class DolphinComplaintVisitSaveCallEvent extends DolphinComplaintVisitEvents {
  final int pkID;

  final DolphinComplaintVisitSaveRequest dolphinComplaintVisitSaveRequest;

  DolphinComplaintVisitSaveCallEvent(this.pkID,this.dolphinComplaintVisitSaveRequest);
}