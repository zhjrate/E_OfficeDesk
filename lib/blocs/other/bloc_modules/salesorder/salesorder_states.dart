part of 'salesorder_bloc.dart';


abstract class SalesOrderStates extends BaseStates {
  const SalesOrderStates();
}

///all states of AuthenticationStates
class SalesOrderInitialState extends SalesOrderStates {}

class SalesOrderListCallResponseState extends SalesOrderStates {
  final SalesOrderListResponse response;
  final int newPage;
  SalesOrderListCallResponseState(this.response,this.newPage);
}

class SearchSalesOrderListByNameCallResponseState extends SalesOrderStates {
  final SearchSalesOrderListResponse response;

  SearchSalesOrderListByNameCallResponseState(this.response);
}

class SearchSalesOrderListByNumberCallResponseState extends SalesOrderStates {
  final SalesOrderListResponse response;

  SearchSalesOrderListByNumberCallResponseState(this.response);
}

class SalesOrderPDFGenerateResponseState extends SalesOrderStates {
  final SalesOrderPDFGenerateResponse response;

  SalesOrderPDFGenerateResponseState(this.response);
}
