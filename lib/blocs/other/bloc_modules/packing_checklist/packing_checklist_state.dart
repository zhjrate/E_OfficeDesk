part of 'packing_checklist_bloc.dart';
abstract class PackingChecklistListState extends BaseStates {
  const PackingChecklistListState();
}

///all states of AuthenticationStates
class PackingChecklistListInitialState extends PackingChecklistListState {}


class PackingChecklistListCallResponseState extends PackingChecklistListState  // Maint State Class Declare Here
    {
  final int newPage;

  final PackingChecklistListResponse response;
  PackingChecklistListCallResponseState(this.newPage,this.response);
}
class SearchPackingChecklistLabelCallResponseState extends PackingChecklistListState // Maint State Class Declare Here
    {


  final SearchPackingchecklistLabelResponse response;
  SearchPackingChecklistLabelCallResponseState(this.response);
}

class SearchPackingChecklistCallResponseState extends PackingChecklistListState // Maint State Class Declare Here
    {


  final PackingChecklistListResponse response;
  SearchPackingChecklistCallResponseState(this.response);
}

class PackingDeleteCallResponseState extends PackingChecklistListState {
  BuildContext context;
  final PackingCheckListDeleteResponse quotationDeleteResponse;

  PackingDeleteCallResponseState(this.context,this.quotationDeleteResponse);
}

class CountryListEventResponseState extends PackingChecklistListState{
  final CountryListResponseForPacking countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends PackingChecklistListState{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}

class CityListEventResponseState extends PackingChecklistListState{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}
class OutWordResponseState extends PackingChecklistListState{
  final OutWordNoListResponse outWordNoListResponse;
  OutWordResponseState(this.outWordNoListResponse);
}

class PackingProductAssamblyListResponseState extends PackingChecklistListState{
  final PackingProductAssamblyListResponse packingProductAssamblyListResponse;
  PackingProductAssamblyListResponseState(this.packingProductAssamblyListResponse);
}
class ProductGroupDropDownResponseState extends PackingChecklistListState{
  final ProductGroupDropDownResponse productGroupDropDownResponse;
  ProductGroupDropDownResponseState(this.productGroupDropDownResponse);
}

class ProductDropDownResponseState extends PackingChecklistListState{
  final ProductDropDownResponse productDropDownResponse;
  ProductDropDownResponseState(this.productDropDownResponse);
}

class PackingSaveResponseState extends PackingChecklistListState{
  final PackingSaveResponse packingSaveResponse;
  PackingSaveResponseState(this.packingSaveResponse);
}

class PackingAssamblySaveResponseState extends PackingChecklistListState{
  final PackingAssamblySaveResponse packingAssamblySaveResponse;
  PackingAssamblySaveResponseState(this.packingAssamblySaveResponse);
}

class DeleteAllPackingAssamblyResponseState extends PackingChecklistListState{
  final Delete_ALL_Assambly_Response delete_all_assambly_response;
  DeleteAllPackingAssamblyResponseState(this.delete_all_assambly_response);
}


class PackingAssamblyEditModeResponseState extends PackingChecklistListState{
  final PackingAssamblyEditModeResponse packingAssamblyEditModeResponse;
  PackingAssamblyEditModeResponseState(this.packingAssamblyEditModeResponse);
}


