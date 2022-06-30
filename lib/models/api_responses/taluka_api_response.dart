class TalukaApiRespose {
  List<SearchTalukaDetails> details;
  int totalCount;

  TalukaApiRespose({this.details, this.totalCount});

  TalukaApiRespose.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchTalukaDetails.fromJson(v));
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

class SearchTalukaDetails {
  int talukaCode;
  String talukaName;

  SearchTalukaDetails({this.talukaCode, this.talukaName});

  SearchTalukaDetails.fromJson(Map<String, dynamic> json) {
    talukaCode = json['TalukaCode'];
    talukaName = json['TalukaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TalukaCode'] = this.talukaCode;
    data['TalukaName'] = this.talukaName;
    return data;
  }
}