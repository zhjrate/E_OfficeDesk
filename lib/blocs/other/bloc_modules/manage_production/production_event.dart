part of 'production_bloc.dart';

abstract class ProductionEvents {}

class MaterialInwardListCallEvent extends ProductionEvents {
  final int pageNo;
  final MaterialInwardListRequest materialInwardListRequest;
  MaterialInwardListCallEvent(this.pageNo, this.materialInwardListRequest);
}

class MaterialOutwardListCallEvent extends ProductionEvents {
  final int pageNo;
  final MaterialOutwardListRequest materialOutwardListRequest;
  MaterialOutwardListCallEvent(this.pageNo, this.materialOutwardListRequest);
}
