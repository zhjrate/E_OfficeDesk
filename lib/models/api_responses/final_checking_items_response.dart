class FinalCheckingItemsResponse {
  List<FinalCheckingItemsResponseDetails> details;
  int totalCount;

  FinalCheckingItemsResponse({this.details, this.totalCount});

  FinalCheckingItemsResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new FinalCheckingItemsResponseDetails.fromJson(v));
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

class FinalCheckingItemsResponseDetails {
  int rowNum;
  int pkID;
  String category;
  String description;
  bool sRNo;
  String sRNoStatus;

  FinalCheckingItemsResponseDetails(
      {this.rowNum,
        this.pkID,
        this.category,
        this.description,
        this.sRNo,
        this.sRNoStatus});

  FinalCheckingItemsResponseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    category = json['Category']==null?"":json['Category'];
    description = json['Description']==null?"":json['Description'];
    sRNo = json['SRNo']==null?false:json['SRNo'];
    sRNoStatus = json['SRNoStatus']==null?"":json['SRNoStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['Category'] = this.category;
    data['Description'] = this.description;
    data['SRNo'] = this.sRNo;
    data['SRNoStatus'] = this.sRNoStatus;
    return data;
  }
}