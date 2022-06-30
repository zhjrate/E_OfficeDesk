part of 'final_checking_bloc.dart';

abstract class FinalCheckingListState extends BaseStates {
  const FinalCheckingListState();
}

///all states of AuthenticationStates
class FinalCheckingListInitialState extends FinalCheckingListState {}


class FinalCheckingListCallResponseState extends FinalCheckingListState // Maint State Class Declare Here
    {
  final int newPage;

  final FinalCheckingListResponse response;
  FinalCheckingListCallResponseState(this.newPage,this.response);
}

class SearchFinalCheckingLabelCallResponseState extends FinalCheckingListState // Maint State Class Declare Here
    {


  final SearchFinalCheckingLabelResponse response;
  SearchFinalCheckingLabelCallResponseState(this.response);
}

class SearchFinalCheckingCallResponseState extends FinalCheckingListState // Maint State Class Declare Here
    {


  final FinalCheckingListResponse response;
  SearchFinalCheckingCallResponseState(this.response);
}

class PackingNoListResponseState extends FinalCheckingListState{
  final PackingNoListResponse packingNoListResponse;
  PackingNoListResponseState(this.packingNoListResponse);
}

class FinalCheckingItemsResponseState extends FinalCheckingListState{
  final FinalCheckingItemsResponse finalCheckingItemsResponse;
  FinalCheckingItemsResponseState(this.finalCheckingItemsResponse);
}

class CheckingNoToCheckingItemsResponseState extends FinalCheckingListState{
  final CheckingNoToCheckingItemsResponse checkingNoToCheckingItemsResponse;
  CheckingNoToCheckingItemsResponseState(this.checkingNoToCheckingItemsResponse);
}

class FinalCheckingHeaderSaveResponseState extends FinalCheckingListState{
  final FinalCheckingHeaderSaveResponse finalCheckingHeaderSaveResponse;
  FinalCheckingHeaderSaveResponseState(this.finalCheckingHeaderSaveResponse);
}

class FinalCheckingSubDetailsSaveResponseState extends FinalCheckingListState{
  final FinalCheckingSubDetailsSaveResponse finalCheckingSubDetailsSaveResponse;
  FinalCheckingSubDetailsSaveResponseState(this.finalCheckingSubDetailsSaveResponse);
}

class FinalCheckingDeleteAllItemResponseState extends FinalCheckingListState{
  final FinalCheckingDeleteAllItemResponse finalCheckingDeleteAllItemResponse;
  FinalCheckingDeleteAllItemResponseState(this.finalCheckingDeleteAllItemResponse);
}

class FinalCheckingDeleteResponseState extends FinalCheckingListState{
  final FinalCheckingDeleteAllItemResponse finalCheckingDeleteAllItemResponse;
  FinalCheckingDeleteResponseState(this.finalCheckingDeleteAllItemResponse);
}