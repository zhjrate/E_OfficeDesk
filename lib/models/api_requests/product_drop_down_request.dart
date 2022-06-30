class ProductDropDownRequest {
  String pkID;
  String CompanyId;

  ProductDropDownRequest({this.pkID,this.CompanyId});

  ProductDropDownRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}