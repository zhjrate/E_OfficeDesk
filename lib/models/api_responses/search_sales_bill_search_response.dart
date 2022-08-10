class SearchSalesBillListResponse {
  List<SearchSalesBillListResponseSearchDetails> details;
  int totalCount;

  SearchSalesBillListResponse({this.details, this.totalCount});

  SearchSalesBillListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchSalesBillListResponseSearchDetails.fromJson(v));
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

class SearchSalesBillListResponseSearchDetails {
  String custoemerName;
  String invoiceNo;
  String quotationNo;
  int value;

  SearchSalesBillListResponseSearchDetails(
      {this.custoemerName, this.invoiceNo, this.quotationNo, this.value});

  SearchSalesBillListResponseSearchDetails.fromJson(Map<String, dynamic> json) {
    custoemerName = json['CustomerName'];
    invoiceNo = json['InvoiceNo'];
    quotationNo = json['QuotationNo'] == null ? "" : json['QuotationNo'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerName'] = this.custoemerName;
    data['InvoiceNo'] = this.invoiceNo;
    data['QuotationNo'] = this.quotationNo;
    data['value'] = this.value;
    return data;
  }
}
