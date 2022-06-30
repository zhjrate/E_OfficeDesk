

part of 'installation_bloc.dart';

@immutable
abstract class InstalltionListEvent {}

///all events of AuthenticationEvents
class InstalltionListCallEvent extends InstalltionListEvent  //Main Event Class
    {
  final int pageNo;
  final InstallationListRequest installationListRequest;
  InstalltionListCallEvent(this.pageNo,this.installationListRequest);
}
class SearchInstallationLabelCallEvent extends InstalltionListEvent  //Main Event Class
    {
  final SearchInstallationRequest searchInstallationRequest;
  SearchInstallationLabelCallEvent(this.searchInstallationRequest);
}

class SearchInstallationCallEvent extends InstalltionListEvent  //Main Event Class
    {
  final SearchInstallationRequest searchInstallationRequest;
  SearchInstallationCallEvent(this.searchInstallationRequest);
}


class SaveInstallationCallEvent extends InstalltionListEvent  //Main Event Class
    {
      final int id;
  final SaveInstallationRequest saveInstallationRequest;
  SaveInstallationCallEvent(this.id,this.saveInstallationRequest);
}

class DeleteInstallationCallEvent extends InstalltionListEvent {
  final int pkID;

  final InstallationDeleteRequest installationDeleteRequest;

  DeleteInstallationCallEvent(this.pkID,this.installationDeleteRequest);
}

class InstallationSearchCustomerCallEvent extends InstalltionListEvent {
  final InstallationCustomerSearchRequest installationCustomerSearchRequest;

  InstallationSearchCustomerCallEvent(this.installationCustomerSearchRequest);
}


class InstallationCountryCallEvent extends InstalltionListEvent {
  final InstallationCountryRequest installationCountryRequest;

  InstallationCountryCallEvent(this.installationCountryRequest);
}


class StateSearchCallEvent extends InstalltionListEvent {
  final StateListRequest stateListRequest;

  StateSearchCallEvent(this.stateListRequest);
}

class CitySearchCallEvent extends InstalltionListEvent {
  final CitySearchInstallationApiRequest cityApiRequest;

  CitySearchCallEvent(this.cityApiRequest);
}

class CustomerIdToOutwardCallEvent extends InstalltionListEvent {
  final InstallationCustomerIdToOutwardnoRequest installationCustomerIdToOutwardnoRequest;

  CustomerIdToOutwardCallEvent(this.installationCustomerIdToOutwardnoRequest);
}
class InstallationEmployeeCallEvent extends InstalltionListEvent {
  final InstallationEmployeeRequest installationEmployeeRequest;

  InstallationEmployeeCallEvent(this.installationEmployeeRequest);
}