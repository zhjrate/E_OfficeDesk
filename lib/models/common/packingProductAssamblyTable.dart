class PackingProductAssamblyTable {

  /* "PCNo": "PC-MAR22-003",
        "FinishProductID": 40046,
        "ProductGroupID": 2,
        "ProductID": 30017,
        "Quantity": 7,
        "Unit": "Nos",
        "ProductSpecification": "Test From API Side test 1",
        "Remarks": "Test Remarks From Sharvaya Infotech From API",
        "LoginUserID": "admin",
        "CompanyId": 11051*/


  int id;
  String PCNo;
  int FinishProductID;
  String FinishProductName;
  int ProductGroupID;
  String ProductGroupName;
  int ProductID;
  String ProductName;
  String Unit;
  double Quantity;
  String ProductSpecification;
  String Remarks;
  String LoginUserID;
  String CompanyId;






  PackingProductAssamblyTable(
      this.PCNo,
      this.FinishProductID,
      this.FinishProductName,
      this.ProductGroupID,
      this.ProductGroupName,
      this.ProductID,
      this.ProductName,
      this.Unit,
      this.Quantity,
      this.ProductSpecification,
      this.Remarks,
      this.LoginUserID,
      this.CompanyId,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
      data['PCNo'] = this.PCNo;
    data['FinishProductID'] = this.FinishProductID;
    data['FinishProductName'] = this.FinishProductName;
    data['ProductGroupID'] = this.ProductGroupID;
    data['ProductGroupName'] = this.ProductGroupName;
    data['ProductID'] = this.ProductID;
    data['ProductName'] = this.ProductName;
    data['Unit'] = this.Unit;
    data['Quantity'] = this.Quantity;
    data['ProductSpecification']=this.ProductSpecification;
    data['Remarks']=this.Remarks;
    data['LoginUserID']=this.LoginUserID;
    data['CompanyId']= this.CompanyId;


    return data;
  }
  @override
  String toString() {
    return 'PackingProductAssamblyTable{id: $id, PCNo: $PCNo, FinishProductID: $FinishProductID, FinishProductName: $FinishProductName, ProductGroupID: $ProductGroupID, ProductGroupName: $ProductGroupName, ProductID: $ProductID, ProductName: $ProductName, Unit: $Unit, Quantity: $Quantity, ProductSpecification: $ProductSpecification, Remarks: $Remarks, LoginUserID: $LoginUserID, CompanyId: $CompanyId}';
  }

}
