part of 'salesbill_bloc.dart';



abstract class SalesBillStates extends BaseStates {
  const SalesBillStates();
}

///all states of AuthenticationStates
class SalesBillInitialState extends SalesBillStates {}

class SalesBillListCallResponseState extends SalesBillStates {
  final SalesBillListResponse response;
  final int newPage;
  SalesBillListCallResponseState(this.response,this.newPage);
}

class SearchSalesBillListByNameCallResponseState extends SalesBillStates {
  final SearchSalesBillListResponse response;

  SearchSalesBillListByNameCallResponseState(this.response);
}
class SalesBillPDFGenerateResponseState extends SalesBillStates {
  final SalesBillPDFGenerateResponse response;

  SalesBillPDFGenerateResponseState(this.response);
}

/*

class SearchQuotationListByNameCallResponseState extends QuotationStates {
  final SearchQuotationListResponse response;

  SearchQuotationListByNameCallResponseState(this.response);
}

class SearchQuotationListByNumberCallResponseState extends QuotationStates {
  final QuotationListResponse response;

  SearchQuotationListByNumberCallResponseState(this.response);
}*/
