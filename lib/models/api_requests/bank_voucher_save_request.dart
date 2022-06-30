/*VoucherType:Bank
RecPay:Receive
VoucherNo:
VoucherDate:2022-02-03
AccountID:51490
CustomerID:61509
EmployeeID:77
TransType:acc
TransModeID:2
TransID:456321789
TransDate:2022-01-31
VoucherAmount:1550
BankName:Bank Of India
Remark:Test For Payable Amount
BasicAmt:1500
NetAmt:1500
LoginUserID:admin
CompanyId:10032*/
class BankVoucherSaveRequest {
  String VoucherType;
  String RecPay;
  String VoucherNo;
  String VoucherDate;
  String AccountID;
  String CustomerID;
  String EmployeeID;
  String TransType;
  String TransModeID;
  String TransID;
  String TransDate;
  String VoucherAmount;
  String BankName;
  String Remark;
  String BasicAmt;
  String NetAmt;
  String CompanyID;
  String LoginUserID;

  //BankVoucherSaveRequest({this.CompanyID, this.LoginUserID});

  BankVoucherSaveRequest({
    this.VoucherType,
    this.RecPay,
    this.VoucherNo,
    this.VoucherDate,
    this.AccountID,
    this.CustomerID,
    this.EmployeeID,
    this.TransType,
    this.TransModeID,
    this.TransID,
    this.TransDate,
    this.VoucherAmount,
    this.BankName,
    this.Remark,
    this.BasicAmt,
    this.NetAmt,
    this.CompanyID,
    this.LoginUserID});


  BankVoucherSaveRequest.fromJson(Map<String, dynamic> json) {
      VoucherType=json["VoucherType"];
      RecPay=json["RecPay"];
      VoucherNo=json["VoucherNo"];
      VoucherDate=json["VoucherDate"];
      AccountID=json["AccountID"];
      CustomerID=json["CustomerID"];
      EmployeeID=json["EmployeeID"];
      TransType=json["TransType"];
      TransModeID=json["TransModeID"];
      TransID=json["TransID"];
      TransDate=json["TransDate"];
      VoucherAmount=json["VoucherAmount"];
      BankName=json["BankName"];
      Remark=json["Remark"];
      BasicAmt=json["BasicAmt"];
      NetAmt=json["NetAmt"];
      CompanyID=json["CompanyId"];
      LoginUserID=json["LoginUserID"];












  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VoucherType']=this.VoucherType;
    data['RecPay']=this.RecPay;
    data['VoucherNo']=this.VoucherNo;
    data['VoucherDate']=this.VoucherDate;
    data['AccountID']=this.AccountID;
    data['CustomerID']=this.CustomerID;
    data['EmployeeID']=this.EmployeeID;
    data['TransType']=this.TransType;
    data['TransModeID']=this.TransModeID;
    data['TransID']=this.TransID;
    data['TransDate']=this.TransDate;
    data['VoucherAmount']=this.VoucherAmount;
    data['BankName']=this.BankName;
    data['Remark']=this.Remark;
    data['BasicAmt']=this.BasicAmt;
    data['NetAmt']=this.NetAmt;
    data['LoginUserID']=this.LoginUserID;
    data['CompanyId']=this.CompanyID;

    return data;
  }
}
