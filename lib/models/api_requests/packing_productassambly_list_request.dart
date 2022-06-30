class PackingProductAssamblyListRequest {
  String ProductID;
  String CompanyId;

  PackingProductAssamblyListRequest({this.ProductID,this.CompanyId});

  PackingProductAssamblyListRequest.fromJson(Map<String, dynamic> json) {
    ProductID = json['ProductID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductID'] = this.ProductID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}