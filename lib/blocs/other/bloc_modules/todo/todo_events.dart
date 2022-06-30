part of 'todo_bloc.dart';



@immutable
abstract class ToDoEvents {}

///all events of AuthenticationEvents
class ToDoListCallEvent extends ToDoEvents {
  final ToDoListApiRequest toDoListApiRequest;
  ToDoListCallEvent(this.toDoListApiRequest);
}
class TaskCategoryListCallEvent extends ToDoEvents {

  final TaskCategoryListRequest taskCategoryListRequest;

  TaskCategoryListCallEvent(this.taskCategoryListRequest);
}

class ToDoSaveHeaderEvent extends ToDoEvents {

  final ToDoHeaderSaveRequest toDoHeaderSaveRequest;
  final int pkID;

  ToDoSaveHeaderEvent(this.pkID,this.toDoHeaderSaveRequest);
}

class ToDoSaveSubDetailsEvent extends ToDoEvents {

  final ToDoSaveSubDetailsRequest toDoSaveSubDetailsRequest;
  final int pkID;

  ToDoSaveSubDetailsEvent(this.pkID,this.toDoSaveSubDetailsRequest);
}
class ToDoWorkLogListEvent extends ToDoEvents {

  final ToDoWorkLogListRequest toDoWorkLogListRequest;

  ToDoWorkLogListEvent(this.toDoWorkLogListRequest);
}