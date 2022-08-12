class BankDetailsListResponse {
  List<BankDetailsListResponseDetails> details;
  int totalCount;

  BankDetailsListResponse({this.details, this.totalCount});

  BankDetailsListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new BankDetailsListResponseDetails.fromJson(v));
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

class BankDetailsListResponseDetails {
  int rowNum;
  int pkID;
  String orgCode;
  String bankName;
  String branchName;
  String bankAccountName;
  String bankAccountNo;
  String bankIFSC;
  String bankSWIFT;

  BankDetailsListResponseDetails(
      {this.rowNum,
      this.pkID,
      this.orgCode,
      this.bankName,
      this.branchName,
      this.bankAccountName,
      this.bankAccountNo,
      this.bankIFSC,
      this.bankSWIFT});

  BankDetailsListResponseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    orgCode = json['OrgCode'] == null ? "" : json['OrgCode'];
    bankName = json['BankName'] == null ? "" : json['BankName'];
    branchName = json['BranchName'] == null ? "" : json['BranchName'];
    bankAccountName =
        json['BankAccountName'] == null ? "" : json['BankAccountName'];
    bankAccountNo = json['BankAccountNo'] == null ? "" : json['BankAccountNo'];
    bankIFSC = json['BankIFSC'] == null ? "" : json['BankIFSC'];
    bankSWIFT = json['BankSWIFT'] == null ? "" : json['BankSWIFT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['OrgCode'] = this.orgCode;
    data['BankName'] = this.bankName;
    data['BranchName'] = this.branchName;
    data['BankAccountName'] = this.bankAccountName;
    data['BankAccountNo'] = this.bankAccountNo;
    data['BankIFSC'] = this.bankIFSC;
    data['BankSWIFT'] = this.bankSWIFT;
    return data;
  }
}
