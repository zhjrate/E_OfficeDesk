class FinalCheckingSubDetailsSaveResponse {
  List<FinalCheckingSubDetailsSaveResponseDetails> details;
  int totalCount;

  FinalCheckingSubDetailsSaveResponse({this.details, this.totalCount});

  FinalCheckingSubDetailsSaveResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new FinalCheckingSubDetailsSaveResponseDetails.fromJson(v));
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

class FinalCheckingSubDetailsSaveResponseDetails {
  int column1;
  String column2;

  FinalCheckingSubDetailsSaveResponseDetails({this.column1, this.column2});

  FinalCheckingSubDetailsSaveResponseDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];
    column2 = json['Column2'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;

    return data;
  }
}