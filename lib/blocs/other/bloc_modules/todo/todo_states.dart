part of 'todo_bloc.dart';


abstract class ToDoStates extends BaseStates {
  const ToDoStates();
}

///all states of AuthenticationStates
class ToDoInitialState extends ToDoStates {}

class ToDoListCallResponseState extends ToDoStates {
  final ToDoListResponse response;
  final int newPage;
  ToDoListCallResponseState(this.response,this.newPage);
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