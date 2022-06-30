class QuotationKindAttListApiRequest {
  String CompanyId;
  String CustomerID;

  QuotationKindAttListApiRequest({this.CompanyId,this.CustomerID});

  QuotationKindAttListApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;
    // data['pkID'] = this.pkId;

    return data;
  }
}