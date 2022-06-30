class OutWordNoListRequest {
  String CustomerID;
  String CompanyId;

  OutWordNoListRequest({this.CustomerID,this.CompanyId});

  OutWordNoListRequest.fromJson(Map<String, dynamic> json) {
    CustomerID = json['CustomerID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.CustomerID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}