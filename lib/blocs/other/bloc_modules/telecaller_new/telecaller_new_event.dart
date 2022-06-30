part of 'telecaller_new_bloc.dart';


@immutable
abstract class TeleCallerNewEvents {}

///all events of AuthenticationEvents
/*
class ExternalLeadListCallEvent extends ExternalLeadEvents {
  final int pageNo;
  final ExpenseListAPIRequest expenseListAPIRequest;
  ExpenseEventsListCallEvent(this.pageNo,this.expenseListAPIRequest);
}*/

class TeleCallerNewListCallEvent extends TeleCallerNewEvents {
  final int pageNo;
  final TeleCallerNewListRequest request1;
  TeleCallerNewListCallEvent(this.pageNo,this.request1);
}

class CountryCallEvent extends TeleCallerNewEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends TeleCallerNewEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}


class DistrictCallEvent extends TeleCallerNewEvents {
  final DistrictApiRequest districtApiRequest;
  DistrictCallEvent(this.districtApiRequest);
}

class TalukaCallEvent extends TeleCallerNewEvents {
  final TalukaApiRequest talukaApiRequest;
  TalukaCallEvent(this.talukaApiRequest);
}

class CityCallEvent extends TeleCallerNewEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}

class CustomerSourceCallEvent extends TeleCallerNewEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class TeleCallerDeleteCallEvent extends TeleCallerNewEvents {
  final int pkID;

  final CustomerDeleteRequest customerDeleteRequest;

  TeleCallerDeleteCallEvent(this.pkID,this.customerDeleteRequest);
}

class TeleCallerSearchByNameCallEvent extends TeleCallerNewEvents {
  final TeleCallerSearchRequest request1;
  TeleCallerSearchByNameCallEvent(this.request1);
}

class TeleCallerSearchByIDCallEvent extends TeleCallerNewEvents {
  final TeleCallerSearchRequest request1;
  TeleCallerSearchByIDCallEvent(this.request1);
}

class NewTeleCallerSaveCallEvent extends TeleCallerNewEvents {
  final int pkID;
  final NewTeleCallerSaveRequest request1;
  NewTeleCallerSaveCallEvent(this.pkID,this.request1);
}

class SearchCustomerListByNameCallEvent extends TeleCallerNewEvents {
  final CustomerLabelValueRequest request;

  SearchCustomerListByNameCallEvent(this.request);
}
