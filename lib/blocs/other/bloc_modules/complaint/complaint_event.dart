part of 'complaint_bloc.dart';


@immutable
abstract class ComplaintScreenEvents {}

///all events of AuthenticationEvents

class ComplaintListCallEvent extends ComplaintScreenEvents {

  final int pageNo;
  final ComplaintListRequest complaintListRequest;

  ComplaintListCallEvent(this.pageNo,this.complaintListRequest);
}

class ComplaintSearchByNameCallEvent extends ComplaintScreenEvents {

  final ComplaintSearchRequest complaintSearchRequest;

  ComplaintSearchByNameCallEvent(this.complaintSearchRequest);
}
class ComplaintSearchByIDCallEvent extends ComplaintScreenEvents {
  final int pkID;

  final ComplaintSearchByIDRequest complaintSearchByIDRequest;

  ComplaintSearchByIDCallEvent(this.pkID,this.complaintSearchByIDRequest);
}
class ComplaintDeleteCallEvent extends ComplaintScreenEvents {

  final int pkID;
  final ComplaintDeleteRequest complaintDeleteRequest;

  ComplaintDeleteCallEvent(this.pkID,this.complaintDeleteRequest);
}

class SearchFollowupCustomerListByNameCallEvent extends ComplaintScreenEvents {
  final CustomerLabelValueRequest request;

  SearchFollowupCustomerListByNameCallEvent(this.request);
}

class CustomerSourceCallEvent extends ComplaintScreenEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class ComplaintSaveCallEvent extends ComplaintScreenEvents {

  final int pkID;
  final ComplaintSaveRequest complaintSaveRequest;

  ComplaintSaveCallEvent(this.pkID,this.complaintSaveRequest);
}

class TransectionModeCallEvent extends ComplaintScreenEvents {
  final TransectionModeListRequest request;

  TransectionModeCallEvent(this.request);
}