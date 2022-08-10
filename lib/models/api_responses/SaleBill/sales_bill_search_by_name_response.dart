class SalesBillSearchByNameResponse {
  List<SalesBillSearchByNameResponseDetails> details;
  int totalCount;

  SalesBillSearchByNameResponse({this.details, this.totalCount});

  SalesBillSearchByNameResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <SalesBillSearchByNameResponseDetails>[];
      json['details'].forEach((v) {
        details.add(new SalesBillSearchByNameResponseDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class SalesBillSearchByNameResponseDetails {
  String customerName;
  String invoiceNo;
  String quotationNo;
  int value;

  SalesBillSearchByNameResponseDetails(
      {this.customerName, this.invoiceNo, this.quotationNo, this.value});

  SalesBillSearchByNameResponseDetails.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    invoiceNo = json['InvoiceNo'];
    quotationNo = json['QuotationNo'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.customerName;
    data['InvoiceNo'] = this.invoiceNo;
    data['QuotationNo'] = this.quotationNo;
    data['value'] = this.value;
    return data;
  }
}
