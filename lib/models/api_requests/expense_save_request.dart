/*pkID:0
ExpenseDate:2021-11-22
ExpenseTypeId:1
Amount:1000
ExpenseNotes:Test today for understand
FromLocation:TATA Company LTD
ToLocation:New Vadaj
LoginUserID:admin
CompanyId:1007
ExpenseImage:*/

class ExpenseSaveAPIRequest {
  String CompanyId;
  String pkID;
  String ExpenseDate;
  String ExpenseTypeId;
  String Amount;
  String ExpenseNotes;
  String FromLocation;
  String ToLocation;
  String LoginUserID;
  String ExpenseImage;

  ExpenseSaveAPIRequest(
      {this.CompanyId,
      this.pkID,
      this.ExpenseDate,
      this.ExpenseTypeId,
      this.Amount,
      this.ExpenseNotes,
      this.FromLocation,
      this.ToLocation,
      this.LoginUserID,
      this.ExpenseImage});

  ExpenseSaveAPIRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
    ExpenseDate = json['ExpenseDate'];
    ExpenseTypeId = json['ExpenseTypeId'];
    Amount = json['Amount'];
    ExpenseNotes = json['ExpenseNotes'];
    FromLocation = json['FromLocation'];
    ToLocation = json['ToLocation'];
    LoginUserID = json['LoginUserID'];
    ExpenseImage = json['ExpenseImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    data['ExpenseDate'] = this.ExpenseDate;
    data['ExpenseTypeId'] = this.ExpenseTypeId;
    data['Amount'] = this.Amount;
    data['ExpenseNotes'] = this.ExpenseNotes;
    data['FromLocation'] = this.FromLocation;
    data['ToLocation'] = this.ToLocation;
    data['LoginUserID'] = this.LoginUserID;
    data['ExpenseImage'] = this.ExpenseImage;

    return data;
  }
}
