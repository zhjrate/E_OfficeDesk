class BankVoucherListResponse {
  List<BankVoucherDetails> details;
  int totalCount;

  BankVoucherListResponse({this.details, this.totalCount});

  BankVoucherListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new BankVoucherDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class BankVoucherDetails {
  int rowNum;
  int pkID;
  String voucherType;
  String recPay;
  String voucherNo;
  String voucherDate;
  int accountID;
  String accountName;
  int customerID;
  String customerName;
  String transType;
  int transModeID;
  String transModeName;
  String transID;
  String transDate;
  double voucherAmount;
  String bankName;
  String remark;
  double basicAmt;
  double netAmt;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String employeeName;
  int employeeID;

  BankVoucherDetails(
      {this.rowNum,
        this.pkID,
        this.voucherType,
        this.recPay,
        this.voucherNo,
        this.voucherDate,
        this.accountID,
        this.accountName,
        this.customerID,
        this.customerName,
        this.transType,
        this.transModeID,
        this.transModeName,
        this.transID,
        this.transDate,
        this.voucherAmount,
        this.bankName,
        this.remark,
        this.basicAmt,
        this.netAmt,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.employeeName,
        this.employeeID
      });

  BankVoucherDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0: json['RowNum'];
    pkID = json['pkID']==null?0: json['pkID'];
    voucherType = json['VoucherType']==null?"": json['VoucherType'];
    recPay = json['RecPay']==null?"": json['RecPay'];
    voucherNo = json['VoucherNo']==null?"": json['VoucherNo'];
    voucherDate = json['VoucherDate']==null?"": json['VoucherDate'];
    accountID = json['AccountID']==null?0: json['AccountID'];
    accountName = json['AccountName']==null?"": json['AccountName'];
    customerID = json['CustomerID']==null?0: json['CustomerID'];
    customerName = json['CustomerName']==null?"": json['CustomerName'];
    transType = json['TransType']==null?"": json['TransType'];
    transModeID = json['TransModeID']==null?0: json['TransModeID'];
    transModeName = json['TransModeName']==null?"": json['TransModeName'];
    transID = json['TransID']==null?"": json['TransID'];
    transDate = json['TransDate']==null?"": json['TransDate'];
    voucherAmount = json['VoucherAmount']==null?0.00: json['VoucherAmount'];
    bankName = json['BankName']==null?"": json['BankName'];
    remark = json['Remark']==null?"": json['Remark'];
    basicAmt = json['BasicAmt']==null?0.00: json['BasicAmt'];
    netAmt = json['NetAmt']==null?0.00: json['NetAmt'];
    createdBy = json['CreatedBy']==null?"": json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"": json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"": json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"": json['UpdatedDate'];
    employeeName =json['EmployeeName']==null?"":json['EmployeeName'];
    employeeID =json['EmployeeID']==null?0:json['EmployeeID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['VoucherType'] = this.voucherType;
    data['RecPay'] = this.recPay;
    data['VoucherNo'] = this.voucherNo;
    data['VoucherDate'] = this.voucherDate;
    data['AccountID'] = this.accountID;
    data['AccountName'] = this.accountName;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['TransType'] = this.transType;
    data['TransModeID'] = this.transModeID;
    data['TransModeName'] = this.transModeName;
    data['TransID'] = this.transID;
    data['TransDate'] = this.transDate;
    data['VoucherAmount'] = this.voucherAmount;
    data['BankName'] = this.bankName;
    data['Remark'] = this.remark;
    data['BasicAmt'] = this.basicAmt;
    data['NetAmt'] = this.netAmt;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeID'] = this.employeeID;


    return data;
  }
}