/*CompanyId:4132
CustomerID:91694
ModuleType:SalesOrder
//LoginUserID:admin*/
class SaleBill_INQ_QT_SO_NO_ListRequest {
  String CompanyId;

  String CustomerID;
  String ModuleType;

  SaleBill_INQ_QT_SO_NO_ListRequest(
      {this.CompanyId, this.CustomerID, this.ModuleType});

  SaleBill_INQ_QT_SO_NO_ListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];
    ModuleType = json['ModuleType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;
    data['ModuleType'] = this.ModuleType;

    return data;
  }
}
