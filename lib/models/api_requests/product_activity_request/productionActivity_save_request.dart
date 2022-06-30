
class SaveProductionActivityRequest {


  String ActivityDate;
  String TaskCategoryID;
  String TaskDescription;
  String TaskDuration;
  String PCNo;
  String Status;
  String LoginUserID;
  String CompanyId;




  SaveProductionActivityRequest({
    this.ActivityDate,
    this.TaskCategoryID,
    this.TaskDescription,
    this.TaskDuration,
    this.PCNo,
    this.Status,
    this.LoginUserID,
    this.CompanyId,
  });

  SaveProductionActivityRequest.fromJson(Map<String, dynamic> json) {
    ActivityDate=json["ActivityDate"];
    TaskCategoryID=json["TaskCategoryID"];
    TaskDescription=json["TaskDescription"];
    TaskDuration=json["TaskDuration"];
    PCNo=json["PCNo"];
    Status=json["Status"];
    LoginUserID=json["LoginUserID"];
    CompanyId=json["CompanyId"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["ActivityDate"] = this.ActivityDate;
    data["TaskCategoryID"] = this.TaskCategoryID;
    data["TaskDescription"] = this.TaskDescription;
    data["TaskDuration"] = this.TaskDuration;
    data["PCNo"] = this.PCNo;
    data["Status"] = this.Status;
    data["LoginUserID"] = this.LoginUserID;
    data["CompanyId"] = this.CompanyId;


    return data;
  }
}
