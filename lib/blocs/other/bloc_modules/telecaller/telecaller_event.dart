part of 'telecaller_bloc.dart';


@immutable
abstract class TeleCallerEvents {}

///all events of AuthenticationEvents
/*
class ExternalLeadListCallEvent extends ExternalLeadEvents {
  final int pageNo;
  final ExpenseListAPIRequest expenseListAPIRequest;
  ExpenseEventsListCallEvent(this.pageNo,this.expenseListAPIRequest);
}*/

class TeleCallerListCallEvent extends TeleCallerEvents {
  final int pageNo;
  final TeleCallerListRequest request1;
  TeleCallerListCallEvent(this.pageNo,this.request1);
}

class CountryCallEvent extends TeleCallerEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends TeleCallerEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}


class DistrictCallEvent extends TeleCallerEvents {
  final DistrictApiRequest districtApiRequest;
  DistrictCallEvent(this.districtApiRequest);
}

class TalukaCallEvent extends TeleCallerEvents {
  final TalukaApiRequest talukaApiRequest;
  TalukaCallEvent(this.talukaApiRequest);
}

class CityCallEvent extends TeleCallerEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}

class CustomerSourceCallEvent extends TeleCallerEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class TeleCallerDeleteCallEvent extends TeleCallerEvents {
  final int pkID;

  final CustomerDeleteRequest customerDeleteRequest;

  TeleCallerDeleteCallEvent(this.pkID,this.customerDeleteRequest);
}

class TeleCallerSearchByNameCallEvent extends TeleCallerEvents {
  final TeleCallerSearchRequest request1;
  TeleCallerSearchByNameCallEvent(this.request1);
}

class TeleCallerSearchByIDCallEvent extends TeleCallerEvents {
  final TeleCallerSearchRequest request1;
  TeleCallerSearchByIDCallEvent(this.request1);
}

class TeleCallerSaveCallEvent extends TeleCallerEvents {
  final int pkID;
  final TeleCallerSaveRequest request1;
  TeleCallerSaveCallEvent(this.pkID,this.request1);
}

class SearchCustomerListByNameCallEvent extends TeleCallerEvents {
  final CustomerLabelValueRequest request;

  SearchCustomerListByNameCallEvent(this.request);
}

class TeleCallerUploadImageNameCallEvent extends TeleCallerEvents {

  final File telecallerImageFile;
  final TeleCallerUploadImgApiRequest teleCallerUploadImgApiRequest;

  TeleCallerUploadImageNameCallEvent(this.telecallerImageFile,this.teleCallerUploadImgApiRequest);
}

class TeleCallerImageDeleteRequestCallEvent extends TeleCallerEvents {
  final int pkID;
  final TeleCallerImageDeleteRequest request1;
  TeleCallerImageDeleteRequestCallEvent(this.pkID,this.request1);
}
