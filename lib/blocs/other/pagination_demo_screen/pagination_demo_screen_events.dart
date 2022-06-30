part of 'pagination_demo_screen_bloc.dart';

@immutable
abstract class PaginationDemoScreenEvents {}

///all events of AuthenticationEvents

class GetListCallEvent extends PaginationDemoScreenEvents {
  final int pageNo;

  GetListCallEvent(this.pageNo);
}
