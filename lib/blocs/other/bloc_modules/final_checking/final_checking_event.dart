part of 'final_checking_bloc.dart';

@immutable
abstract class FinalCheckingListEvent {}

///all events of AuthenticationEvents
class FinalCheckingListCallEvent extends FinalCheckingListEvent  //Main Event Class
    {
  final int pageNo;
  final FinalCheckingListRequest finalCheckingListRequest;
  FinalCheckingListCallEvent(this.pageNo,this.finalCheckingListRequest);
}

class SearchFinalCheckingLabelCallEvent extends FinalCheckingListEvent  //Main Event Class
    {
  final SearchFinalCheckingRequest searchFinalCheckingRequest;
  SearchFinalCheckingLabelCallEvent(this.searchFinalCheckingRequest);
}

class SearchFinalCheckingCallEvent extends FinalCheckingListEvent  //Main Event Class
    {
  final SearchFinalCheckingRequest searchFinalCheckingRequest;
  SearchFinalCheckingCallEvent(this.searchFinalCheckingRequest);
}

class OutWordCallEvent extends FinalCheckingListEvent {
  final OutWordNoListRequest outWordNoListRequest;
  OutWordCallEvent(this.outWordNoListRequest);
}

class FinalCheckingItemsRequestCallEvent extends FinalCheckingListEvent {
  final FinalCheckingItemsRequest finalCheckingItemsRequest;
  FinalCheckingItemsRequestCallEvent(this.finalCheckingItemsRequest);
}

class CheckingNoToCheckingItemsRequestCallEvent extends FinalCheckingListEvent {
  final CheckingNoToCheckingItemsRequest checkingNoToCheckingItemsRequest;
  CheckingNoToCheckingItemsRequestCallEvent(this.checkingNoToCheckingItemsRequest);
}

class FinalCheckingHeaderSaveRequestCallEvent extends FinalCheckingListEvent {
  final int pkID;
  final FinalCheckingHeaderSaveRequest finalCheckingHeaderSaveRequest;
  FinalCheckingHeaderSaveRequestCallEvent(this.pkID,this.finalCheckingHeaderSaveRequest);
}

class FinalCheckingSubDetailsSaveCallEvent extends FinalCheckingListEvent {

  final List<FinalCheckingItems> finalCheckingItems;
  FinalCheckingSubDetailsSaveCallEvent(this.finalCheckingItems);
}

class FinalCheckingDeleteAllItemRequestCallEvent extends FinalCheckingListEvent {
  final String FinalcheckingNo;
  final FinalCheckingDeleteAllItemsRequest finalCheckingDeleteAllItemsRequest;
  FinalCheckingDeleteAllItemRequestCallEvent(this.FinalcheckingNo,this.finalCheckingDeleteAllItemsRequest);
}

class FinalCheckingDeleteCallEvent extends FinalCheckingListEvent {
  final int pkID;
  final FinalCheckingDeleteAllItemsRequest finalCheckingDeleteAllItemsRequest;
  FinalCheckingDeleteCallEvent(this.pkID,this.finalCheckingDeleteAllItemsRequest);
}