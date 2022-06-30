part of 'expense_bloc.dart';


@immutable
abstract class ExpenseEvents {}

///all events of AuthenticationEvents
class ExpenseEventsListCallEvent extends ExpenseEvents {
  final int pageNo;
  final ExpenseListAPIRequest expenseListAPIRequest;
  ExpenseEventsListCallEvent(this.pageNo,this.expenseListAPIRequest);
}

class ExpenseDeleteByNameCallEvent extends ExpenseEvents {
  final int pkID;

  final FollowupDeleteRequest followupDeleteRequest;

  ExpenseDeleteByNameCallEvent(this.pkID,this.followupDeleteRequest);
}



class ExpenseSaveByNameCallEvent extends ExpenseEvents {
  final int pkID;
  final ExpenseSaveAPIRequest expenseSaveAPIRequest;

  ExpenseSaveByNameCallEvent(this.pkID,this.expenseSaveAPIRequest);
}

class ExpenseUploadImageNameCallEvent extends ExpenseEvents {

  final List<File> expenseImageFile;
  final ExpenseUploadImageAPIRequest expenseUploadImageAPIRequest;

  ExpenseUploadImageNameCallEvent(this.expenseImageFile,this.expenseUploadImageAPIRequest);
}

class ExpenseImageUploadServerNameCallEvent extends ExpenseEvents {
  final ExpenseImageUploadServerAPIRequest expenseImageUploadServerAPIRequest;

  ExpenseImageUploadServerNameCallEvent(this.expenseImageUploadServerAPIRequest);
}

class ExpenseDeleteImageNameCallEvent extends ExpenseEvents {
  final int pkID;
  final ExpenseDeleteImageRequest expenseDeleteImageRequest;

  ExpenseDeleteImageNameCallEvent(this.pkID,this.expenseDeleteImageRequest);
}


class ExpenseEmployeeListCallEvent extends ExpenseEvents {

  final AttendanceEmployeeListRequest attendanceEmployeeListRequest;
  ExpenseEmployeeListCallEvent(this.attendanceEmployeeListRequest);
}
class FetchImageListByExpensePKID_RequestCallEvent extends ExpenseEvents {

  final FetchImageListByExpensePKID_Request fetchImageListByExpensePKID_Request;
  FetchImageListByExpensePKID_RequestCallEvent(this.fetchImageListByExpensePKID_Request);
}
class ExpenseTypeByNameCallEvent extends ExpenseEvents {

  final ExpenseTypeAPIRequest expenseTypeAPIRequest;

  ExpenseTypeByNameCallEvent(this.expenseTypeAPIRequest);
}


