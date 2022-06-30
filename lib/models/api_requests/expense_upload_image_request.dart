/*CompanyId:10032
LoginUserId:admin
pkID:10046
fileName:logo.png*/




import 'dart:io';

class ExpenseUploadImageAPIRequest {
  String CompanyId;
  String pkID;
  String LoginUserId;
  String fileName;
  String ExpenseID;
  String Type;
  File file;
 /*CompanyId
LoginUserId
pkID
fileName
ExpenseID
Type*/

  ExpenseUploadImageAPIRequest(
      {this.CompanyId,
        this.pkID,
        this.LoginUserId,
        this.fileName,this.ExpenseID,this.Type,this.file});

  ExpenseUploadImageAPIRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
    LoginUserId = json['LoginUserId'];
    fileName = json['fileName'];
    ExpenseID = json['ExpenseID'];
    Type = json['Type'];
    file = json[''];

  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    data['LoginUserId'] = this.LoginUserId;
    data['ExpenseID'] = this.ExpenseID;
    data['Type'] = this.Type;
    data['fileName'] = this.fileName;

    // data['']=this.file;
    return data;
  }
}
