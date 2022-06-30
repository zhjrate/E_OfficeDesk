part of 'dailyactivity_bloc.dart';

abstract class DailyActivityScreenStates extends BaseStates {
  const DailyActivityScreenStates();
}

///all states of AuthenticationStates

class DailyActivityScreenInitialState extends DailyActivityScreenStates {}

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
}