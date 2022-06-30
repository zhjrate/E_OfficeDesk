class Delete_ALL_Assambly_Response {
  List<Delete_ALL_Assambly_ResponseDetails> details;
  int totalCount;

  Delete_ALL_Assambly_Response({this.details, this.totalCount});

  Delete_ALL_Assambly_Response.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new Delete_ALL_Assambly_ResponseDetails.fromJson(v));
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

class Delete_ALL_Assambly_ResponseDetails {
  String column1;


  Delete_ALL_Assambly_ResponseDetails({this.column1});

  Delete_ALL_Assambly_ResponseDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;

    return data;
  }
}