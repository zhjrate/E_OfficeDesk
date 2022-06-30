part of 'maintenance_bloc.dart';



@immutable
abstract class MaintenanceScreenEvents {}

///all events of AuthenticationEvents

class MaintenanceListCallEvent extends MaintenanceScreenEvents {

  final int pageNo;
  final MaintenanceListRequest maintenanceListRequest;

  MaintenanceListCallEvent(this.pageNo,this.maintenanceListRequest);
}


class MaintenanceSearchCallEvent extends MaintenanceScreenEvents {

  final MaintenanceSearchRequest maintenanceSearchRequest;

  MaintenanceSearchCallEvent(this.maintenanceSearchRequest);
}

class MaintenanceDeleteCallEvent extends MaintenanceScreenEvents {
  final int pkID;

  final BankVoucherDeleteRequest bankVoucherDeleteRequest;

  MaintenanceDeleteCallEvent(this.pkID,this.bankVoucherDeleteRequest);
}