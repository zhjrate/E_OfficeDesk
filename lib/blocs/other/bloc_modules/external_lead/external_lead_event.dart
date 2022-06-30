part of 'external_lead_bloc.dart';


@immutable
abstract class ExternalLeadEvents {}

///all events of AuthenticationEvents
/*
class ExternalLeadListCallEvent extends ExternalLeadEvents {
  final int pageNo;
  final ExpenseListAPIRequest expenseListAPIRequest;
  ExpenseEventsListCallEvent(this.pageNo,this.expenseListAPIRequest);
}*/

class ExternalLeadListCallEvent extends ExternalLeadEvents {
  final int pageNo;
  final ExternalLeadListRequest request1;
  ExternalLeadListCallEvent(this.pageNo,this.request1);
}

class CountryCallEvent extends ExternalLeadEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends ExternalLeadEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}


class DistrictCallEvent extends ExternalLeadEvents {
  final DistrictApiRequest districtApiRequest;
  DistrictCallEvent(this.districtApiRequest);
}

class TalukaCallEvent extends ExternalLeadEvents {
  final TalukaApiRequest talukaApiRequest;
  TalukaCallEvent(this.talukaApiRequest);
}

class CityCallEvent extends ExternalLeadEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}

class CustomerSourceCallEvent extends ExternalLeadEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class ExternalLeadDeleteCallEvent extends ExternalLeadEvents {
  final int pkID;

  final CustomerDeleteRequest customerDeleteRequest;

  ExternalLeadDeleteCallEvent(this.pkID,this.customerDeleteRequest);
}

class ExternalLeadSearchByNameCallEvent extends ExternalLeadEvents {
  final ExternalLeadSearchRequest request1;
  ExternalLeadSearchByNameCallEvent(this.request1);
}

class ExternalLeadSearchByIDCallEvent extends ExternalLeadEvents {
  final ExternalLeadSearchRequest request1;
  ExternalLeadSearchByIDCallEvent(this.request1);
}

class ExternalLeadSaveCallEvent extends ExternalLeadEvents {
  final int pkID;
  final ExternalLeadSaveRequest request1;
  ExternalLeadSaveCallEvent(this.pkID,this.request1);
}