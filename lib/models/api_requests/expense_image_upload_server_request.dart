/*ExpenseID:10046
Name:logo.png
Type:4
LoginUserID:admin
CompanyId:10032*/


class ExpenseImageUploadServerAPIRequest {
  String CompanyId;
  String LoginUserID;
   String ExpenseID;
  String Name;
  String Type;



  ExpenseImageUploadServerAPIRequest({this.CompanyId,this.LoginUserID,this.ExpenseID,this.Name,this.Type});

  ExpenseImageUploadServerAPIRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    ExpenseID = json['ExpenseID'];
    Name = json['Name'];
    Type=json['Type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['ExpenseID'] = this.ExpenseID;
    data['Name'] = this.Name;
    data['Type'] = this.Type;

    return data;
  }
}