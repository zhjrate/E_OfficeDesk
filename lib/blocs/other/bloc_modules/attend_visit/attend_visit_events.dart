part of 'attend_visit_bloc.dart';



@immutable
abstract class AttendVisitEvents {}

///all events of AuthenticationEvents
class AttendVisitListCallEvent extends AttendVisitEvents
{
  final int pageNo;
  final AttendVisitListRequest attendVisitListRequest;
  AttendVisitListCallEvent(this.pageNo,this.attendVisitListRequest);
}
class ComplaintNoListCallEvent extends AttendVisitEvents
{
  final ComplaintNoListRequest complaintNoListRequest;
  ComplaintNoListCallEvent(this.complaintNoListRequest);
}
class CustomerSourceCallEvent extends AttendVisitEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class TransectionModeCallEvent extends AttendVisitEvents {
  final TransectionModeListRequest request;

  TransectionModeCallEvent(this.request);
}

class AttendVisitSaveCallEvent extends AttendVisitEvents {

  int pkID;
  BuildContext context;
  final AttendVisitSaveRequest request;

  AttendVisitSaveCallEvent(this.context,this.pkID,this.request);
}

class ComplaintSearchByNameCallEvent extends AttendVisitEvents {

  final ComplaintSearchRequest complaintSearchRequest;

  ComplaintSearchByNameCallEvent(this.complaintSearchRequest);
}

class AttendVisitSearchByIDCallEvent extends AttendVisitEvents {
  final int pkID;

  final ComplaintSearchByIDRequest complaintSearchByIDRequest;

  AttendVisitSearchByIDCallEvent(this.pkID,this.complaintSearchByIDRequest);
}