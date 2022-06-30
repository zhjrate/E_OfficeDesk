part of 'bank_voucher_bloc.dart';


abstract class BankVoucherScreenStates extends BaseStates {
  const BankVoucherScreenStates();
}

///all states of AuthenticationStates

class BankVoucherScreenInitialState extends BankVoucherScreenStates {}

class BankvoucherListResponseState extends BankVoucherScreenStates {
  final BankVoucherListResponse bankVoucherListResponse;
  final int newPage;

  BankvoucherListResponseState(this.newPage,this.bankVoucherListResponse);
}
class BankVoucherSearchByNameCallResponseState extends BankVoucherScreenStates {
  final BankVoucherSearchByNameResponse response;

  BankVoucherSearchByNameCallResponseState(this.response);
}

class BankVoucherSearchByIDCallResponseState extends BankVoucherScreenStates {
  final BankVoucherListResponse bankVoucherListResponse;

  BankVoucherSearchByIDCallResponseState(this.bankVoucherListResponse);
}

class BankVoucherDeleteResponseState extends BankVoucherScreenStates {
  final BankVoucherDeleteResponse bankVoucherDeleteResponse;

  BankVoucherDeleteResponseState(this.bankVoucherDeleteResponse);
}


class TransectionModeResponseState extends BankVoucherScreenStates {
  final TransectionModeListResponse transectionModeListResponse;

  TransectionModeResponseState(this.transectionModeListResponse);
}


class BankVoucherCustomerListByNameCallResponseState extends BankVoucherScreenStates {
  final CustomerLabelvalueRsponse response;

  BankVoucherCustomerListByNameCallResponseState(this.response);
}
class BankDropDownResponseState extends BankVoucherScreenStates {
  final BankDorpDownResponse response;

  BankDropDownResponseState(this.response);
}

class BankVoucherSaveResponseState extends BankVoucherScreenStates {
  final BankVoucherSaveResponse bankVoucherSaveResponse;
  final BuildContext context;

  BankVoucherSaveResponseState(this.context,this.bankVoucherSaveResponse);
}

/*
class DailyActivityCallResponseState extends DailyActivityScreenStates {
  final DailyActivityListResponse dailyActivityListResponse;
  final int newPage;

  DailyActivityCallResponseState(this.newPage,this.dailyActivityListResponse);
}

class DailyActivityDeleteCallResponseState extends DailyActivityScreenStates {
  final DailyActivityDeleteResponse dailyActivityDeleteResponse;

  DailyActivityDeleteCallResponseState(this.dailyActivityDeleteResponse);
}


class TaskCategoryCallResponseState extends DailyActivityScreenStates {
  final TaskCategoryResponse taskCategoryResponse;

  TaskCategoryCallResponseState(this.taskCategoryResponse);
}

class DailyActivitySaveCallResponseState extends DailyActivityScreenStates {
  final DailyActivitySaveResponse dailyActivitySaveResponse;

  DailyActivitySaveCallResponseState(this.dailyActivitySaveResponse);
}*/
