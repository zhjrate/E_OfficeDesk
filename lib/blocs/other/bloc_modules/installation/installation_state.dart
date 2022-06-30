part of 'installation_bloc.dart';

abstract class InstallationListState extends BaseStates {
  const InstallationListState();
}

///all states of AuthenticationStates
class InstallationListInitialState extends InstallationListState {}


class InstallationListCallResponseState extends InstallationListState // Maint State Class Declare Here
    {
  final int newPage;

  final InstallationListResponse response;
  InstallationListCallResponseState(this.newPage,this.response);
}

class SearchInstallationLabelCallResponseState extends InstallationListState // Maint State Class Declare Here
    {


  final SearchInstallationLabelResponse response;
  SearchInstallationLabelCallResponseState(this.response);
}

class SearchInstallationCallResponseState extends InstallationListState // Maint State Class Declare Here
    {

  final InstallationListResponse response;
  SearchInstallationCallResponseState(this.response);
}

class SaveInstallationCallResponseState extends InstallationListState // Maint State Class Declare Here
    {

  final SaveInstallationResponse response;
  SaveInstallationCallResponseState(this.response);
}

class DeleteInstallationCallResponseState extends InstallationListState // Maint State Class Declare Here
    {

  final InstallationDeleteRespose response;
  DeleteInstallationCallResponseState(this.response);
}


class InstallationCustomerSearchCallResponseState extends InstallationListState {
  final InstallationSearchCustomerResponse response;

  InstallationCustomerSearchCallResponseState(this.response);
}


class InstallationCountryCallResponseState extends InstallationListState {
  final InstallationCountryResponse response;

  InstallationCountryCallResponseState(this.response);
}


class StateSearchCallResponseState extends InstallationListState {
  final StateResponse response;

  StateSearchCallResponseState(this.response);
}

class CitySearchCallResponseState extends InstallationListState {
  final InstallationCityResponse response;

  CitySearchCallResponseState(this.response);
}

class CustomerIdToOutwardCallResponseState extends InstallationListState {
  final CustomerIdToOutwardnoResponse response;

  CustomerIdToOutwardCallResponseState(this.response);
}
class InstallationEmployeeCallResponseState extends InstallationListState {
  final InstallationEmployeeResponse response;

  InstallationEmployeeCallResponseState(this.response);
}