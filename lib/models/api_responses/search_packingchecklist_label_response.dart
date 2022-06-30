class SearchPackingchecklistLabelResponse {
  List<SearchPackingchecklistLabelDetails> details;
  int totalCount;

  SearchPackingchecklistLabelResponse({this.details, this.totalCount});

  SearchPackingchecklistLabelResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchPackingchecklistLabelDetails.fromJson(v));
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

class SearchPackingchecklistLabelDetails {
  String label;
  int value;
  String pCNo;
  int pkID;

  SearchPackingchecklistLabelDetails({this.label, this.value, this.pCNo, this.pkID});

  SearchPackingchecklistLabelDetails.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    pCNo = json['PCNo'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['PCNo'] = this.pCNo;
    data['pkID'] = this.pkID;
    return data;
  }
}