class SearchSalesOrderListByNumberRequest {
  String CompanyId;
  String OrderNo;
  String pkID;
  String LoginUserID;


  SearchSalesOrderListByNumberRequest({this.CompanyId,this.OrderNo,this.pkID,this.LoginUserID});

  SearchSalesOrderListByNumberRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    OrderNo = json['OrderNo'];
    pkID = json['pkID'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    //data['OrderNo'] = this.OrderNo;
    //data['pkID'] = this.pkID;
    data['LoginUserID'] = this.LoginUserID;


    return data;
  }
}