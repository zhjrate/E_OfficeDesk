part of 'quotation_bloc.dart';


abstract class QuotationStates extends BaseStates {
  const QuotationStates();
}

///all states of AuthenticationStates
class QuotationInitialState extends QuotationStates {}

class QuotationListCallResponseState extends QuotationStates {
  final QuotationListResponse response;
  final int newPage;
  QuotationListCallResponseState(this.response,this.newPage);
}

class SearchQuotationListByNameCallResponseState extends QuotationStates {
  final SearchQuotationListResponse response;

  SearchQuotationListByNameCallResponseState(this.response);
}

class SearchQuotationListByNumberCallResponseState extends QuotationStates {
  final QuotationListResponse response;

  SearchQuotationListByNumberCallResponseState(this.response);
}

class QuotationPDFGenerateResponseState extends QuotationStates {
  final QuotationPDFGenerateResponse response;

  QuotationPDFGenerateResponseState(this.response);
}

class QuotationCustomerListByNameCallResponseState extends QuotationStates {
  final CustomerLabelvalueRsponse response;

  QuotationCustomerListByNameCallResponseState(this.response);
}

class QuotationNoToProductListCallResponseState extends QuotationStates {
  final QuotationNoToProductResponse response;
  int StateCode;
  QuotationNoToProductListCallResponseState(this.StateCode,this.response);
}

class SpecificationListResponseState extends QuotationStates {
  final SpecificationListResponse response;

  SpecificationListResponseState(this.response);
}


class QuotationKindAttListResponseState extends QuotationStates {
  final QuotationKindAttListResponse response;

  QuotationKindAttListResponseState(this.response);
}


class QuotationProjectListResponseState extends QuotationStates {
  final QuotationProjectListResponse response;

  QuotationProjectListResponseState(this.response);
}

class QuotationTermsCondtionResponseState extends QuotationStates {
  final QuotationTermsCondtionResponse response;

  QuotationTermsCondtionResponseState(this.response);
}

class CustIdToInqListResponseState extends QuotationStates {
  final CustIdToInqListResponse response;

  CustIdToInqListResponseState(this.response);
}

class InqNoToProductListResponseState extends QuotationStates {

  final InqNoToProductListResponse response;

  InqNoToProductListResponseState(this.response);
}

class InquiryProductSearchByStateCodeResponseState extends QuotationStates{
  int ProductID;
  String ProductName;
  double Quantity;
  double UnitRate;
  final InquiryProductSearchResponse inquiryProductSearchResponse;
  InquiryProductSearchByStateCodeResponseState(this.ProductID,this.ProductName,this.Quantity,this.UnitRate,this.inquiryProductSearchResponse);
}

class QuotationHeaderSaveResponseState extends QuotationStates {

  int pkID;
  final QuotationSaveHeaderResponse response;
  BuildContext context;
  QuotationHeaderSaveResponseState(this.context,this.pkID,this.response);
}

class QuotationProductSaveResponseState extends QuotationStates{
  final QuotationProductSaveResponse quotationProductSaveResponse;
  BuildContext context;
  QuotationProductSaveResponseState(this.context,this.quotationProductSaveResponse);
}

class QuotationProductDeleteResponseState extends QuotationStates {

  final QuotationProductDeleteResponse response;

  QuotationProductDeleteResponseState(this.response);
}

class QuotationDeleteCallResponseState extends QuotationStates {
  BuildContext context;
  final QuotationDeleteResponse quotationDeleteResponse;

  QuotationDeleteCallResponseState(this.context,this.quotationDeleteResponse);
}


class QuotationOtherChargeListResponseState extends QuotationStates {
  final QuotationOtherChargesListResponse quotationOtherChargesListResponse;

  QuotationOtherChargeListResponseState(this.quotationOtherChargesListResponse);
}


class QuotationBankDropDownResponseState extends QuotationStates {
  final BankDorpDownResponse response;

  QuotationBankDropDownResponseState(this.response);
}