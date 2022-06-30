
part of 'production_activity_bloc.dart';


@immutable
abstract class ProductionActivityListEvent {}

///all events of AuthenticationEvents
class ProductionActivityListCallEvent extends ProductionActivityListEvent  //Main Event Class
    {
  final int pageNo;
  final ProductionActivityRequest productionActivityRequest;
  ProductionActivityListCallEvent(this.pageNo,this.productionActivityRequest);
}

class ProductionActivityTypeofWorkCallEvent extends ProductionActivityListEvent  //Main Event Class
    {

  final TypeOfWorkRequest typeOfWorkRequest;
  ProductionActivityTypeofWorkCallEvent(this.typeOfWorkRequest);
}

class EmployeeCallEvent extends ProductionActivityListEvent {
  final InstallationEmployeeRequest installationEmployeeRequest;

  EmployeeCallEvent(this.installationEmployeeRequest);
}

class PackingListCallEvent extends ProductionActivityListEvent {
  final ProductionPackingListRequest  productionPackingListRequest;

  PackingListCallEvent(this.productionPackingListRequest);
}

class ProductionActivitySaveCallEvent extends ProductionActivityListEvent {
  final int id;
  final SaveProductionActivityRequest  saveProductionActivityRequest;

  ProductionActivitySaveCallEvent(this.id,this.saveProductionActivityRequest);
}

class ProductionActivityDeleteCallEvent extends ProductionActivityListEvent {
  final int id;
  final ProductionActivityDeleteRequest  productionActivityDeleteRequest;

  ProductionActivityDeleteCallEvent(this.id,this.productionActivityDeleteRequest);
}
