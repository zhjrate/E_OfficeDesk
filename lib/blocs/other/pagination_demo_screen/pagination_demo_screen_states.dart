part of 'pagination_demo_screen_bloc.dart';

abstract class PaginationDemoScreenStates extends BaseStates {
  const PaginationDemoScreenStates();
}

///all states of AuthenticationStates

class PaginationDemoScreenInitialState extends PaginationDemoScreenStates {}

class GetListCallEventResponseState extends PaginationDemoScreenStates {
  final PaginationDemoListResponse response;
  int page;
  GetListCallEventResponseState(this.response,this.page);
}
