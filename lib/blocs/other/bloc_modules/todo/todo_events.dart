part of 'todo_bloc.dart';

@immutable
abstract class ToDoEvents {}

///all events of AuthenticationEvents
class ToDoListCallEvent extends ToDoEvents {
  final ToDoListApiRequest toDoListApiRequest;
  ToDoListCallEvent(this.toDoListApiRequest);
}

class ToDoTodayListCallEvent extends ToDoEvents {
  final ToDoListApiRequest toDoListApiRequest;
  ToDoTodayListCallEvent(this.toDoListApiRequest);
}

class ToDoOverDueListCallEvent extends ToDoEvents {
  final ToDoListApiRequest toDoListApiRequest;
  ToDoOverDueListCallEvent(this.toDoListApiRequest);
}

class ToDoTComplitedListCallEvent extends ToDoEvents {
  final ToDoListApiRequest toDoListApiRequest;
  ToDoTComplitedListCallEvent(this.toDoListApiRequest);
}

class TaskCategoryListCallEvent extends ToDoEvents {
  final TaskCategoryListRequest taskCategoryListRequest;

  TaskCategoryListCallEvent(this.taskCategoryListRequest);
}

class ToDoSaveHeaderEvent extends ToDoEvents {
  final ToDoHeaderSaveRequest toDoHeaderSaveRequest;
  final int pkID;

  ToDoSaveHeaderEvent(this.pkID, this.toDoHeaderSaveRequest);
}

class ToDoSaveSubDetailsEvent extends ToDoEvents {
  final ToDoSaveSubDetailsRequest toDoSaveSubDetailsRequest;
  final int pkID;

  ToDoSaveSubDetailsEvent(this.pkID, this.toDoSaveSubDetailsRequest);
}

class ToDoWorkLogListEvent extends ToDoEvents {
  final ToDoWorkLogListRequest toDoWorkLogListRequest;

  ToDoWorkLogListEvent(this.toDoWorkLogListRequest);
}

class ToDoDeleteEvent extends ToDoEvents {
  final ToDoDeleteRequest toDoDeleteRequest;
  final int pkID;

  ToDoDeleteEvent(this.pkID, this.toDoDeleteRequest);
}

class SearchFollowupCustomerListByNameCallEvent extends ToDoEvents {
  final CustomerLabelValueRequest request;

  SearchFollowupCustomerListByNameCallEvent(this.request);
}
