part of 'expense_bloc.dart';


abstract class ExpenseStates extends BaseStates {
  const ExpenseStates();
}

///all states of AuthenticationStates
class ExpenseInitialState extends ExpenseStates {}

class ExpenseListCallResponseState extends ExpenseStates {
  final ExpenseListResponse response;
  final int newPage;
  ExpenseListCallResponseState(this.response,this.newPage);
}
class ExpenseDeleteCallResponseState extends ExpenseStates {
  final ExpenseDeleteResponse expenseDeleteResponse;

  ExpenseDeleteCallResponseState(this.expenseDeleteResponse);
}


class ExpenseSaveCallResponseState extends ExpenseStates {
  final ExpsenseSaveResponse expsenseSaveResponse;

  ExpenseSaveCallResponseState(this.expsenseSaveResponse);
}

class ExpenseUploadImageCallResponseState extends ExpenseStates {
  final ExpenseUploadImageResponse expenseUploadImageResponse;

  ExpenseUploadImageCallResponseState(this.expenseUploadImageResponse);
}

class ExpenseImageUploadServerCallResponseState extends ExpenseStates {
  final ExpenseImageUploadServerAPIResponse expenseImageUploadServerAPIResponse;

  ExpenseImageUploadServerCallResponseState(this.expenseImageUploadServerAPIResponse);
}

class ExpenseDeleteImageCallResponseState extends ExpenseStates {
  final ExpenseDeleteImageResponse expenseDeleteImageResponse;

  ExpenseDeleteImageCallResponseState(this.expenseDeleteImageResponse);
}

class ExpenseEmployeeListResponseState extends ExpenseStates {
  final AttendanceEmployeeListResponse response;
  ExpenseEmployeeListResponseState(this.response);
}

class FetchImageListByExpensePKID_ResponseState extends ExpenseStates {
  final FetchImageListByExpensePKID_Response fetchImageListByExpensePKID_Response;
  FetchImageListByExpensePKID_ResponseState(this.fetchImageListByExpensePKID_Response);
}

class ExpenseTypeCallResponseState extends ExpenseStates {
  final ExpenseTypeResponse expenseTypeResponse;

  ExpenseTypeCallResponseState(this.expenseTypeResponse);
}