class CustomerCategoryRequest {
  String pkID;
  String CompanyID;

  CustomerCategoryRequest({this.pkID,this.CompanyID});

  CustomerCategoryRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}