part of 'dailyactivity_bloc.dart';

@immutable
abstract class DailyActivityScreenEvents {}

///all events of AuthenticationEvents

class DailyActivityListCallEvent extends DailyActivityScreenEvents {

  final int pageNo;
  final DailyActivityListRequest dailyActivityListRequest;

  DailyActivityListCallEvent(this.pageNo,this.dailyActivityListRequest);
}

class DailyActivityDeleteByNameCallEvent extends DailyActivityScreenEvents {
  final int pkID;

  final DailyActivityDeleteRequest dailyActivityDeleteRequest;

  DailyActivityDeleteByNameCallEvent(this.pkID,this.dailyActivityDeleteRequest);
}


class TaskCategoryListCallEvent extends DailyActivityScreenEvents {

  final TaskCategoryListRequest taskCategoryListRequest;

  TaskCategoryListCallEvent(this.taskCategoryListRequest);
}

class DailyActivitySaveByNameCallEvent extends DailyActivityScreenEvents {
  final int pkID;

  final DailyActivitySaveRequest dailyActivitySaveRequest;

  DailyActivitySaveByNameCallEvent(this.pkID,this.dailyActivitySaveRequest);
}