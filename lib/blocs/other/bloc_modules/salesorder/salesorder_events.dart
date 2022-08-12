part of 'salesorder_bloc.dart';

@immutable
abstract class SalesOrderEvents {}

///all events of AuthenticationEvents
class SalesOrderListCallEvent extends SalesOrderEvents {
  final int pageNo;
  final SalesOrderListApiRequest salesOrderListApiRequest;
  SalesOrderListCallEvent(this.pageNo, this.salesOrderListApiRequest);
}

class SearchSalesOrderListByNameCallEvent extends SalesOrderEvents {
  final SearchSalesOrderListByNameRequest request;

  SearchSalesOrderListByNameCallEvent(this.request);
}

class SearchSalesOrderListByNumberCallEvent extends SalesOrderEvents {
  final int pkID;
  final SearchSalesOrderListByNumberRequest request;

  SearchSalesOrderListByNumberCallEvent(this.pkID, this.request);
}

class SalesOrderPDFGenerateCallEvent extends SalesOrderEvents {
  final SalesOrderPDFGenerateRequest request;

  SalesOrderPDFGenerateCallEvent(this.request);
}

class SaleOrderBankDetailsListRequestEvent extends SalesOrderEvents {
  final SaleOrderBankDetailsListRequest request;

  SaleOrderBankDetailsListRequestEvent(this.request);
}

class QuotationProjectListCallEvent extends SalesOrderEvents {
  final QuotationProjectListRequest request;

  QuotationProjectListCallEvent(this.request);
}

class QuotationTermsConditionCallEvent extends SalesOrderEvents {
  final QuotationTermsConditionRequest request;

  QuotationTermsConditionCallEvent(this.request);
}
