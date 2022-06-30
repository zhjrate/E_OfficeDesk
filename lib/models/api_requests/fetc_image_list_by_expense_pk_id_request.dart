class FetchImageListByExpensePKID_Request {
  String CompanyId;
  String ExpenseID;


  FetchImageListByExpensePKID_Request({this.CompanyId,this.ExpenseID});

  FetchImageListByExpensePKID_Request.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    ExpenseID = json['ExpenseID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['ExpenseID'] = this.ExpenseID;


    return data;
  }
}