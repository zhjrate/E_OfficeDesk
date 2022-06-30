class BankVoucherDeleteRequest {
  String CompanyID;

  BankVoucherDeleteRequest({this.CompanyID});

  BankVoucherDeleteRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}