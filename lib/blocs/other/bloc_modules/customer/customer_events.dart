part of 'customer_bloc.dart';

@immutable
abstract class CustomerEvents {}

///all events of AuthenticationEvents
class CustomerListCallEvent extends CustomerEvents {
  final int pageNo;
  final CustomerPaginationRequest customerPaginationRequest;

  CustomerListCallEvent(this.pageNo,this.customerPaginationRequest);
}




class SearchCustomerListByNameCallEvent extends CustomerEvents {
  final CustomerLabelValueRequest request;

  SearchCustomerListByNameCallEvent(this.request);
}

class SearchCustomerListByNumberCallEvent extends CustomerEvents {
  final CustomerSearchByIdRequest request;

  SearchCustomerListByNumberCallEvent(this.request);
}


class CountryCallEvent extends CustomerEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends CustomerEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}


class DistrictCallEvent extends CustomerEvents {
  final DistrictApiRequest districtApiRequest;
  DistrictCallEvent(this.districtApiRequest);
}

class TalukaCallEvent extends CustomerEvents {
  final TalukaApiRequest talukaApiRequest;
  TalukaCallEvent(this.talukaApiRequest);
}

class CityCallEvent extends CustomerEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}


class CustomerAddEditCallEvent extends CustomerEvents {
  final CustomerAddEditApiRequest customerAddEditApiRequest;
  CustomerAddEditCallEvent(this.customerAddEditApiRequest);
}

class CustomerDeleteByNameCallEvent extends CustomerEvents {
  final int pkID;

  final CustomerDeleteRequest customerDeleteRequest;

  CustomerDeleteByNameCallEvent(this.pkID,this.customerDeleteRequest);
}

class CustomerContactSaveCallEvent extends CustomerEvents {

  final List<ContactModel> _contactsList;
  CustomerContactSaveCallEvent(this._contactsList);
}

class CustomerIdToCustomerListCallEvent extends CustomerEvents {
  final CustomerIdToCustomerListRequest customerIdToCustomerListRequest;
  CustomerIdToCustomerListCallEvent(this.customerIdToCustomerListRequest);
}

class CustomerIdToDeleteAllContactCallEvent extends CustomerEvents {
  final int pkID;

  final CustomerIdToDeleteAllContactRequest customerIdToDeleteAllContactRequest;

  CustomerIdToDeleteAllContactCallEvent(this.pkID,this.customerIdToDeleteAllContactRequest);
}
class CustomerCategoryCallEvent extends CustomerEvents {
  final CustomerCategoryRequest request1;
  CustomerCategoryCallEvent(this.request1);
}

class CustomerSourceCallEvent extends CustomerEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class DesignationCallEvent extends CustomerEvents {
  final DesignationApiRequest designationApiRequest;
  DesignationCallEvent(this.designationApiRequest);
}