part of 'salesbill_bloc.dart';

@immutable
abstract class SalesBillEvents {}

///all events of AuthenticationEvents
class SalesBillListCallEvent extends SalesBillEvents {
  final int pageNo;
  final SalesBillListRequest salesBillListRequest;
  SalesBillListCallEvent(this.pageNo, this.salesBillListRequest);
}

class SearchSaleBillListByNameCallEvent extends SalesBillEvents {
  final SearchSalesBillListByNameRequest request;

  SearchSaleBillListByNameCallEvent(this.request);
}

/*
class SearchQuotationListByNameCallEvent extends QuotationEvents {
  final SearchQuotationListByNameRequest request;

  SearchQuotationListByNameCallEvent(this.request);
}

class SearchQuotationListByNumberCallEvent extends QuotationEvents {
  final int pkID;
  final SearchQuotationListByNumberRequest request;

  SearchQuotationListByNumberCallEvent(this.pkID,this.request);
}*/
class SalesBillPDFGenerateCallEvent extends SalesBillEvents {
  final SalesBillPDFGenerateRequest request;

  SalesBillPDFGenerateCallEvent(this.request);
}

class SalesBillSearchByNameRequestCallEvent extends SalesBillEvents {
  final SalesBillSearchByNameRequest request;

  SalesBillSearchByNameRequestCallEvent(this.request);
}

class SalesBillSearchByIdRequestCallEvent extends SalesBillEvents {
  int custID;
  final SalesBillSearchByIdRequest request;

  SalesBillSearchByIdRequestCallEvent(this.custID, this.request);
}

class QuotationBankDropDownCallEvent extends SalesBillEvents {
  final BankDropDownRequest request;

  QuotationBankDropDownCallEvent(this.request);
}

class QuotationTermsConditionCallEvent extends SalesBillEvents {
  final QuotationTermsConditionRequest request;
  QuotationTermsConditionCallEvent(this.request);
}

class SalesBillEmailContentRequestEvent extends SalesBillEvents {
  final SalesBillEmailContentRequest request;
  SalesBillEmailContentRequestEvent(this.request);
}

class SaleBill_INQ_QT_SO_NO_ListRequestEvent extends SalesBillEvents {
  final SaleBill_INQ_QT_SO_NO_ListRequest request;
  SaleBill_INQ_QT_SO_NO_ListRequestEvent(this.request);
}
