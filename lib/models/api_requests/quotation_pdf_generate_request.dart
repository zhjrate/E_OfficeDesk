class QuotationPDFGenerateRequest {
  String CompanyId;
  String QuotationNo;

  QuotationPDFGenerateRequest({this.CompanyId,this.QuotationNo});

  QuotationPDFGenerateRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    QuotationNo = json['QuotationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['QuotationNo'] = this.QuotationNo;

    return data;
  }
}