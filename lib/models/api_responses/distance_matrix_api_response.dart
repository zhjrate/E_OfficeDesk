class DistanceMatrixResponse {
  List<String> destinationAddresses;
  List<String> originAddresses;
  List<DistanceRows> rows;
  String status;

  DistanceMatrixResponse(
      {this.destinationAddresses,
        this.originAddresses,
        this.rows,
        this.status});

  DistanceMatrixResponse.fromJson(Map<String, dynamic> json) {
    destinationAddresses = json['destination_addresses'].cast<String>();
    originAddresses = json['origin_addresses'].cast<String>();
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows.add(new DistanceRows.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_addresses'] = this.destinationAddresses;
    data['origin_addresses'] = this.originAddresses;
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class DistanceRows {
  List<DistanceElements> elements;

  DistanceRows({this.elements});

  DistanceRows.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {
      elements = [];
      json['elements'].forEach((v) {
        elements.add(new DistanceElements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistanceElements {
  DistanceMatrixDistance distance;
  DistanceMatrixDistance duration;
  String status;

  DistanceElements({this.distance, this.duration, this.status});

  DistanceElements.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new DistanceMatrixDistance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new DistanceMatrixDistance.fromJson(json['duration'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class DistanceMatrixDistance {
  String text;
  int value;

  DistanceMatrixDistance({this.text, this.value});

  DistanceMatrixDistance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    return data;
  }
}