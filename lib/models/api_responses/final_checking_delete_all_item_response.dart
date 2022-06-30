class FinalCheckingDeleteAllItemResponse {
  List<FinalCheckingDeleteAllItemResponseDetails> details;
  int totalCount;

  FinalCheckingDeleteAllItemResponse({this.details, this.totalCount});

  FinalCheckingDeleteAllItemResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new FinalCheckingDeleteAllItemResponseDetails.fromJson(v));
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

class FinalCheckingDeleteAllItemResponseDetails {
  String column1;


  FinalCheckingDeleteAllItemResponseDetails({this.column1});

  FinalCheckingDeleteAllItemResponseDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;

    return data;
  }
}