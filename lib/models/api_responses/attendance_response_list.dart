class Attendance_List_Response {
  List<AttendanceList> details;
  int totalCount;

  Attendance_List_Response({this.details, this.totalCount});

  Attendance_List_Response.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new AttendanceList.fromJson(v));
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

class AttendanceList {
  int pkID;
  int employeeID;
  String employeeName;
  String presenceDate;
  String timeIn;
  String timeOut;
  String notes;
  int workingHrs;

  AttendanceList(
      {this.pkID,
        this.employeeID,
        this.employeeName,
        this.presenceDate,
        this.timeIn,
        this.timeOut,
        this.workingHrs,this.notes});

  AttendanceList.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    employeeID = json['EmployeeID'];
    employeeName = json['EmployeeName'];
    presenceDate = json['PresenceDate'];
    timeIn = json['TimeIn'];
    timeOut = json['TimeOut'];
    workingHrs = json['WorkingHrs'];
    notes = json['Notes'] == null ? "" : json['Notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['PresenceDate'] = this.presenceDate;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['WorkingHrs'] = this.workingHrs;
    data['Notes'] = this.notes;
    return data;
  }
}