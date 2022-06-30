
part of 'production_activity_bloc.dart';

abstract class ProductionActivityListState extends BaseStates {
  const ProductionActivityListState();
}

///all states of AuthenticationStates
class ProductionActivityListInitialState extends ProductionActivityListState {}


class ProductionActivityListCallResponseState extends ProductionActivityListState // Maint State Class Declare Here
    {


  final ProductionActivityResponse response;
  ProductionActivityListCallResponseState(this.response);
}

class ProductionActivityTypeofWorkCallResponseState extends ProductionActivityListState // Maint State Class Declare Here
    {


  final TypeOfWorkResponse response;
  ProductionActivityTypeofWorkCallResponseState(this.response);
}

class EmployeeCallResponseState extends ProductionActivityListState {
  final InstallationEmployeeResponse response;

  EmployeeCallResponseState(this.response);
}

class PackingListCallResponseState extends ProductionActivityListState {
  final PackingListResponse response;

  PackingListCallResponseState(this.response);
}


class ProductionActivitySaveCallResponseState extends ProductionActivityListState {
  final ProductionActivitySaveResponse response;

  ProductionActivitySaveCallResponseState(this.response);
}

class ProductionActivityDeleteCallResponseState extends ProductionActivityListState {
  final ProductionActivityDeleteResponse response;

  ProductionActivityDeleteCallResponseState(this.response);
}