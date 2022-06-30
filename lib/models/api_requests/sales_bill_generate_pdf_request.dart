class SalesBillPDFGenerateRequest {
  String CompanyId;
  String InvoiceNo;

  SalesBillPDFGenerateRequest({this.CompanyId,this.InvoiceNo});

  SalesBillPDFGenerateRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    InvoiceNo = json['InvoiceNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['InvoiceNo'] = this.InvoiceNo;

    return data;
  }
}