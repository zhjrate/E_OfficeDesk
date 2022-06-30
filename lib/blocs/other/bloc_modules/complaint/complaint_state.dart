part of 'complaint_bloc.dart';


abstract class ComplaintScreenStates extends BaseStates {
  const ComplaintScreenStates();
}

///all states of AuthenticationStates

class ComplaintScreenInitialState extends ComplaintScreenStates {}

class ComplaintListResponseState extends ComplaintScreenStates {
  final ComplaintListResponse complaintListResponse;
  final int newPage;

  ComplaintListResponseState(this.newPage,this.complaintListResponse);
}

class ComplaintSearchByNameResponseState extends ComplaintScreenStates {
  final ComplaintSearchResponse complaintSearchResponse;

  ComplaintSearchByNameResponseState(this.complaintSearchResponse);
}

class ComplaintSearchByIDResponseState extends ComplaintScreenStates {
  final ComplaintListResponse complaintSearchByIDResponse;

  ComplaintSearchByIDResponseState(this.complaintSearchByIDResponse);
}

class ComplaintDeleteResponseState extends ComplaintScreenStates {
  final ComplaintDeleteResponse complaintDeleteResponse;

  ComplaintDeleteResponseState(this.complaintDeleteResponse);
}

class FollowupCustomerListByNameCallResponseState extends ComplaintScreenStates {
  final CustomerLabelvalueRsponse response;

  FollowupCustomerListByNameCallResponseState(this.response);
}

class CustomerSourceCallEventResponseState extends ComplaintScreenStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class ComplaintSaveResponseState extends ComplaintScreenStates {
  final ComplaintSaveResponse complaintSaveResponse;

  ComplaintSaveResponseState(this.complaintSaveResponse);
}