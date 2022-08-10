part of 'todo_bloc.dart';

abstract class ToDoStates extends BaseStates {
  const ToDoStates();
}

///all states of AuthenticationStates
class ToDoInitialState extends ToDoStates {}

class ToDoListCallResponseState extends ToDoStates {
  final ToDoListResponse response;
  final int newPage;
  ToDoListCallResponseState(this.response, this.newPage);
}

class ToDoTodayListCallResponseState extends ToDoStates {
  final ToDoListResponse response;
  final int newPage;
  ToDoTodayListCallResponseState(this.response, this.newPage);
}

class ToDoOverDueListCallResponseState extends ToDoStates {
  final ToDoListResponse response;
  final int newPage;
  ToDoOverDueListCallResponseState(this.response, this.newPage);
}

class ToDoCompletedListCallResponseState extends ToDoStates {
  final ToDoListResponse response;
  final int newPage;
  ToDoCompletedListCallResponseState(this.response, this.newPage);
}

class TaskCategoryCallResponseState extends ToDoStates {
  final TaskCategoryResponse taskCategoryResponse;

  TaskCategoryCallResponseState(this.taskCategoryResponse);
}

class ToDoSaveHeaderState extends ToDoStates {
  final ToDoSaveHeaderResponse toDoSaveHeaderResponse;

  ToDoSaveHeaderState(this.toDoSaveHeaderResponse);
}

class ToDoSaveSubDetailsState extends ToDoStates {
  final ToDoSaveSubDetailsResponse toDoSaveSubDetailsResponse;

  ToDoSaveSubDetailsState(this.toDoSaveSubDetailsResponse);
}

class ToDoWorkLogListState extends ToDoStates {
  final ToDoWorkLogListResponse toDoWorkLogListResponse;

  ToDoWorkLogListState(this.toDoWorkLogListResponse);
}

class ToDoDeleteResponseState extends ToDoStates {
  final ToDoDeleteResponse toDoDeleteResponse;

  ToDoDeleteResponseState(this.toDoDeleteResponse);
}

class FollowupCustomerListByNameCallResponseState extends ToDoStates {
  final CustomerLabelvalueRsponse response;

  FollowupCustomerListByNameCallResponseState(this.response);
}
