part of 'production_bloc.dart';

class ProductionStates extends BaseStates {
  ProductionStates();
}

class ProductionInitialStates extends ProductionStates {}

class MaterialInwardListCallResponseState extends ProductionStates {
  final MaterialInwardListResponse response;
  final int newPage;
  MaterialInwardListCallResponseState(this.response, this.newPage);
}

class MaterialOutwardListCallResponseState extends ProductionStates {
  final MaterialOutwardListResponse response;
  final int newPage;
  MaterialOutwardListCallResponseState(this.response, this.newPage);
}
