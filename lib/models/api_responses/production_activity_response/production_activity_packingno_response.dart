class PackingListResponse {
  List<PackingListDetails> details;
  int totalCount;

  PackingListResponse({this.details, this.totalCount});

  PackingListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new PackingListDetails.fromJson(v));
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

class PackingListDetails {
  String pCNo;

  PackingListDetails({this.pCNo});

  PackingListDetails.fromJson(Map<String, dynamic> json) {
    pCNo = json['PCNo']==null?"": json['PCNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PCNo'] = this.pCNo;
    return data;
  }
}