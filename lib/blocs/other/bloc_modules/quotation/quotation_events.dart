part of 'quotation_bloc.dart';



@immutable
abstract class QuotationEvents {}

///all events of AuthenticationEvents
class QuotationListCallEvent extends QuotationEvents {
  final int pageNo;
  final QuotationListApiRequest quotationListApiRequest;
  QuotationListCallEvent(this.pageNo,this.quotationListApiRequest);
}

class SearchQuotationListByNameCallEvent extends QuotationEvents {
  final SearchQuotationListByNameRequest request;

  SearchQuotationListByNameCallEvent(this.request);
}

class SearchQuotationListByNumberCallEvent extends QuotationEvents {
  final int pkID;
  final SearchQuotationListByNumberRequest request;

  SearchQuotationListByNumberCallEvent(this.pkID,this.request);
}

class QuotationPDFGenerateCallEvent extends QuotationEvents {
  final QuotationPDFGenerateRequest request;

  QuotationPDFGenerateCallEvent(this.request);
}
class SearchQuotationCustomerListByNameCallEvent extends QuotationEvents {
  final CustomerLabelValueRequest request;

  SearchQuotationCustomerListByNameCallEvent(this.request);
}

class QuotationNoToProductListCallEvent extends QuotationEvents {
  final QuotationNoToProductListRequest request;
 int StateCode;
  QuotationNoToProductListCallEvent(this.StateCode,this.request);
}

class QuotationSpecificationCallEvent extends QuotationEvents {
  final SpecificationListRequest request;

  QuotationSpecificationCallEvent(this.request);
}

class QuotationKindAttListCallEvent extends QuotationEvents {
  final QuotationKindAttListApiRequest request;

  QuotationKindAttListCallEvent(this.request);
}


class QuotationProjectListCallEvent extends QuotationEvents {
  final QuotationProjectListRequest request;

  QuotationProjectListCallEvent(this.request);
}

class QuotationTermsConditionCallEvent extends QuotationEvents {
  final QuotationTermsConditionRequest request;

  QuotationTermsConditionCallEvent(this.request);
}

class CustIdToInqListCallEvent extends QuotationEvents {
  final CustIdToInqListRequest request;

  CustIdToInqListCallEvent(this.request);
}


class InqNoToProductListCallEvent extends QuotationEvents {
  final InquiryNoToProductListRequest request;

  InqNoToProductListCallEvent(this.request);
}

class InquiryProductSearchNameWithStateCodeCallEvent extends QuotationEvents {

  int ProductID;
  String ProductName;
  double Quantity;
  double UnitRate;
  final InquiryProductSearchRequest inquiryProductSearchRequest;

  InquiryProductSearchNameWithStateCodeCallEvent(this.ProductID,this.ProductName,this.Quantity,this.UnitRate,this.inquiryProductSearchRequest);
}



class QuotationHeaderSaveCallEvent extends QuotationEvents {
  int pkID;
  BuildContext context;
  final QuotationHeaderSaveRequest request;

  QuotationHeaderSaveCallEvent(this.context,this.pkID,this.request);
}

class QuotationProductSaveCallEvent extends QuotationEvents {
  String QT_No;
  BuildContext context;
  final List<QuotationTable> quotationProductModel;
  QuotationProductSaveCallEvent(this.context,this.QT_No,this.quotationProductModel);
}

class QuotationDeleteProductCallEvent extends QuotationEvents {
  String qt_No;
  final QuotationProductDeleteRequest request;

  QuotationDeleteProductCallEvent(this.qt_No,this.request);
}


class QuotationDeleteRequestCallEvent extends QuotationEvents {
  BuildContext context;
  final int pkID;

  final QuotationDeleteRequest quotationDeleteRequest;

  QuotationDeleteRequestCallEvent(this.context,this.pkID,this.quotationDeleteRequest);
}

class QuotationOtherChargeCallEvent extends QuotationEvents {
  String CompanyID;
  final QuotationOtherChargesListRequest request;

  QuotationOtherChargeCallEvent(this.CompanyID,this.request);
}

class QuotationBankDropDownCallEvent extends QuotationEvents {
  final BankDropDownRequest request;

  QuotationBankDropDownCallEvent(this.request);
}


