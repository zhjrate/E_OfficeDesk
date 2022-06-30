part of 'maintenance_bloc.dart';



abstract class MaintenanceScreenStates extends BaseStates {
  const MaintenanceScreenStates();
}

///all states of AuthenticationStates

class MaintenanceScreenInitialState extends MaintenanceScreenStates {}

class MaintenanceListResponseState extends MaintenanceScreenStates {

  final MaintenanceListResponse maintenanceListResponse;
  final int newPage;

  MaintenanceListResponseState(this.newPage,this.maintenanceListResponse);
}

class MaintenanceSearchResponseState extends MaintenanceScreenStates {

  final MaintenanceListResponse maintenanceListResponse;

  MaintenanceSearchResponseState(this.maintenanceListResponse);
}

class MaintenanceDeleteResponseState extends MaintenanceScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  MaintenanceDeleteResponseState(this.bankVoucherDeleteResponse);
}