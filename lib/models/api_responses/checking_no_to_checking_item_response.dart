class CheckingNoToCheckingItemsResponse {
  List<CheckingNoToCheckingItemsResponseDetails> details;
  int totalCount;

  CheckingNoToCheckingItemsResponse({this.details, this.totalCount});

  CheckingNoToCheckingItemsResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new CheckingNoToCheckingItemsResponseDetails.fromJson(v));
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

class CheckingNoToCheckingItemsResponseDetails {
  int rowNum;
  String checkingNo;
  String item;
  bool checked;
  String serialNo;
  bool sRno;

  CheckingNoToCheckingItemsResponseDetails(
      {this.rowNum,
        this.checkingNo,
        this.item,
        this.checked,
        this.serialNo,
        this.sRno});

  CheckingNoToCheckingItemsResponseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    checkingNo = json['CheckingNo'];
    item = json['Item'];
    checked = json['Checked'];
    serialNo = json['SerialNo'];
    sRno = json['SRno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['CheckingNo'] = this.checkingNo;
    data['Item'] = this.item;
    data['Checked'] = this.checked;
    data['SerialNo'] = this.serialNo;
    data['SRno'] = this.sRno;
    return data;
  }
}