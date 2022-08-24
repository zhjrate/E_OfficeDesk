part of 'salesbill_bloc.dart';

abstract class SalesBillStates extends BaseStates {
  const SalesBillStates();
}

///all states of AuthenticationStates
class SalesBillInitialState extends SalesBillStates {}

class SalesBillListCallResponseState extends SalesBillStates {
  final SalesBillListResponse response;
  final int newPage;
  SalesBillListCallResponseState(this.response, this.newPage);
}

class SearchSalesBillListByNameCallResponseState extends SalesBillStates {
  final SearchSalesBillListResponse response;

  SearchSalesBillListByNameCallResponseState(this.response);
}

class SalesBillPDFGenerateResponseState extends SalesBillStates {
  final SalesBillPDFGenerateResponse response;

  SalesBillPDFGenerateResponseState(this.response);
}

class SalesBillSearchByNameResponseState extends SalesBillStates {
  final SalesBillSearchByNameResponse response;

  SalesBillSearchByNameResponseState(this.response);
}

class SalesBillSearchByIDResponseState extends SalesBillStates {
  final SalesBillListResponse response;

  SalesBillSearchByIDResponseState(this.response);
}

class QuotationBankDropDownResponseState extends SalesBillStates {
  final BankDorpDownResponse response;

  QuotationBankDropDownResponseState(this.response);
}

class QuotationTermsCondtionResponseState extends SalesBillStates {
  final QuotationTermsCondtionResponse response;

  QuotationTermsCondtionResponseState(this.response);
}

class SaleBillEmailContentResponseState extends SalesBillStates {
  final SaleBillEmailContentResponse response;

  SaleBillEmailContentResponseState(this.response);
}

class SalesBill_INQ_QT_SO_NO_ListResponseState extends SalesBillStates {
  final SalesBill_INQ_QT_SO_NO_ListResponse response;
  SalesBill_INQ_QT_SO_NO_ListResponseState(this.response);
}

class SalesBill_QT_ResponseState extends SalesBillStates {
  final SalesBill_INQ_QT_SO_NO_ListResponse response;
  SalesBill_QT_ResponseState(this.response);
}

class SalesBill_SO_ListResponseState extends SalesBillStates {
  final SalesBill_INQ_QT_SO_NO_ListResponse response;
  SalesBill_SO_ListResponseState(this.response);
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
