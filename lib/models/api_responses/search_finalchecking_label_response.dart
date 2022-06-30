class SearchFinalCheckingLabelResponse {
  List<SearchFinalcheckingLabelDetails> details;
  int totalCount;

  SearchFinalCheckingLabelResponse({this.details, this.totalCount});

  SearchFinalCheckingLabelResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchFinalcheckingLabelDetails.fromJson(v));
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

class SearchFinalcheckingLabelDetails {
  String label;
  int value;
  String pCNo;
  String checkingNo;
  int pkID;

  SearchFinalcheckingLabelDetails({this.label, this.value, this.pCNo, this.checkingNo, this.pkID});

  SearchFinalcheckingLabelDetails.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    pCNo = json['PCNo'];
    checkingNo = json['CheckingNo'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['PCNo'] = this.pCNo;
    data['CheckingNo'] = this.checkingNo;
    data['pkID'] = this.pkID;
    return data;
  }
}