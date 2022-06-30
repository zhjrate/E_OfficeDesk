class FinalCheckingHeaderSaveRequest {
  String CheckingNo;
  String CustomerID;
  String ProductID;
  String CheckingDate;
  String PCNo;
  String LoginUserID;
  String CompanyId;

  /*CheckingNo:
CustomerID:441859
ProductID:
CheckingDate:2022-03-19
PCNo:PC-MAR22-003
LoginUserID:admin
CompanyId:11051*/

  FinalCheckingHeaderSaveRequest({
    this.CheckingNo,
    this.CustomerID,
    this.ProductID,
    this.CheckingDate,
    this.PCNo,
    this.LoginUserID,
    this.CompanyId,
  });

  FinalCheckingHeaderSaveRequest.fromJson(Map<String, dynamic> json) {


      CheckingNo=json['CheckingNo'];
      CustomerID=json['CustomerID'];
      ProductID=json['ProductID'];
      CheckingDate=json['CheckingDate'];
      PCNo=json['PCNo'];
      LoginUserID=json['LoginUserID'];
      CompanyId=json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


     data['CheckingNo']=this.CheckingNo;
     data['CustomerID']=this.CustomerID;
     data['ProductID']=this.ProductID;
     data['CheckingDate']=this.CheckingDate;
     data['PCNo']=this.PCNo;
     data['LoginUserID']=this.LoginUserID;
     data['CompanyId']=this.CompanyId;

    return data;
  }
}
