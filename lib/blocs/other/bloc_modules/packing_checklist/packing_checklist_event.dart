
part of 'packing_checklist_bloc.dart';



@immutable
abstract class PackingChecklistListEvent {}

///all events of AuthenticationEvents
class PackingChecklistListCallEvent extends PackingChecklistListEvent  //Main Event Class
    {
  final int pageNo;
  final PackingChecklistListRequest packingChecklistListRequest;
  PackingChecklistListCallEvent(this.pageNo,this.packingChecklistListRequest);
}

class SearchPackingChecklistLabelCallEvent extends PackingChecklistListEvent  //Main Event Class
    {
  final SearchPackingChecklistRequest searchPackingChecklistRequest;
  SearchPackingChecklistLabelCallEvent(this.searchPackingChecklistRequest);
}

class SearchPackingChecklistCallEvent extends PackingChecklistListEvent  //Main Event Class
    {
  final SearchPackingChecklistRequest searchPackingChecklistRequest;
  SearchPackingChecklistCallEvent(this.searchPackingChecklistRequest);
}

class PackingDeleteRequestCallEvent extends PackingChecklistListEvent {
  BuildContext context;
  final int pkID;

  final PackingCheckListDeleteRequest packingCheckListDeleteRequest;

  PackingDeleteRequestCallEvent(this.context,this.pkID,this.packingCheckListDeleteRequest);
}

class CountryCallEvent extends PackingChecklistListEvent {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends PackingChecklistListEvent {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}

class CityCallEvent extends PackingChecklistListEvent {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}

class OutWordCallEvent extends PackingChecklistListEvent {
  final OutWordNoListRequest outWordNoListRequest;
  OutWordCallEvent(this.outWordNoListRequest);
}

class PackingProductAssamblyListRequestCallEvent extends PackingChecklistListEvent {
  final PackingProductAssamblyListRequest packingProductAssamblyListRequest;
  PackingProductAssamblyListRequestCallEvent(this.packingProductAssamblyListRequest);
}



class ProductGroupDropDownRequestCallEvent extends PackingChecklistListEvent {
  final ProductGroupDropDownRequest packingProductAssamblyListRequest;
  ProductGroupDropDownRequestCallEvent(this.packingProductAssamblyListRequest);
}


class ProductDropDownRequestCallEvent extends PackingChecklistListEvent {
  final ProductDropDownRequest productDropDownRequest;
  ProductDropDownRequestCallEvent(this.productDropDownRequest);
}

class PackingSaveCallEvent extends PackingChecklistListEvent {
  final int pkID;
  final PackingSaveRequest packingSaveRequest;
  PackingSaveCallEvent(this.pkID,this.packingSaveRequest);
}

class PackingAssamblySaveCallEvent extends PackingChecklistListEvent {

  final List<PackingProductAssamblyTable> packingAssamblyList;
  PackingAssamblySaveCallEvent(this.packingAssamblyList);
}

class DeleteALLPackingAssamblyCallEvent extends PackingChecklistListEvent {
  final String pcNo;

  final DeleteAllPakingAssamblyRequest deleteAllPakingAssamblyRequest;
  DeleteALLPackingAssamblyCallEvent(this.pcNo,this.deleteAllPakingAssamblyRequest);
}
class PackingAssamblyEditModeRequestCallEvent extends PackingChecklistListEvent {
  final PackingAssamblyEditModeRequest packingAssamblyEditModeRequest;
  PackingAssamblyEditModeRequestCallEvent(this.packingAssamblyEditModeRequest);
}