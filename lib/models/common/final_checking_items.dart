/* "CheckingNo":"FC-MAR22-002",
        "CustomerID":441859,
        "Item":"Name Plate Check",
        "Checked":1,
        "Remarks":"Test From API From PostMan",
        "SerialNo":"Test Serail No",
        "SRno":1,
        "LoginUserID":"admin",
        "CompanyId":11051*/
class FinalCheckingItems {
  int id;
  String CheckingNo;
  String CustomerID;
  String Item;
  String Checked;
  String Remarks;
  String SerialNo;
  String SRno;
  String LoginUserID;
  String CompanyId;


  FinalCheckingItems(
      this.CheckingNo,
      this.CustomerID,
      this.Item,
      this.Checked,
      this.Remarks,
      this.SerialNo,
      this.SRno,
      this.LoginUserID,
      this.CompanyId,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CheckingNo'] = this.CheckingNo;
    data['CustomerID'] = this.CustomerID;
    data['Item'] = this.Item;
    data['Checked'] = this.Checked;
    data['Remarks']=this.Remarks;
    data['SerialNo'] = this.SerialNo;
    data['SRno'] = this.SRno;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    return data;
  }


  @override
  String toString() {
    return 'FinalCheckingItems{CheckingNo: $CheckingNo, CustomerID: $CustomerID, Item: $Item, Checked: $Checked, Remarks: $Remarks, SerialNo: $SerialNo, SRno: $SRno, LoginUserID: $LoginUserID, CompanyId: $CompanyId}';
  }


}