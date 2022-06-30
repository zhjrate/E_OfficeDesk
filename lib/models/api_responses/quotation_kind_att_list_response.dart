class QuotationKindAttListResponse {
  List<QuotationKindAttDetails> details;
  int totalCount;

  QuotationKindAttListResponse({this.details, this.totalCount});

  QuotationKindAttListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new QuotationKindAttDetails.fromJson(v));
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

class QuotationKindAttDetails {
  int customerID;
  String customerName;
  String contactPerson1;

  QuotationKindAttDetails({this.customerID, this.customerName, this.contactPerson1});

  QuotationKindAttDetails.fromJson(Map<String, dynamic> json) {
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    contactPerson1 = json['ContactPerson1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ContactPerson1'] = this.contactPerson1;
    return data;
  }
}