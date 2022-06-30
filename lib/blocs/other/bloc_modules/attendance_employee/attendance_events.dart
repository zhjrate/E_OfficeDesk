part of 'attendance_bloc.dart';



@immutable
abstract class AttendanceEvents {}

///all events of AuthenticationEvents
class AttendanceCallEvent extends AttendanceEvents
{
  final AttendanceApiRequest attendanceApiRequest;
AttendanceCallEvent(this.attendanceApiRequest);
}
class AttendanceSaveCallEvent extends AttendanceEvents
{
  final AttendanceSaveApiRequest attendanceSaveApiRequest;
  AttendanceSaveCallEvent(this.attendanceSaveApiRequest);
}
class AttendanceEmployeeListCallEvent extends AttendanceEvents
{
  final AttendanceEmployeeListRequest attendanceEmployeeListRequest;
  AttendanceEmployeeListCallEvent(this.attendanceEmployeeListRequest);
}
class LocationAddressCallEvent extends AttendanceEvents {
  final LocationAddressRequest locationAddressRequest;

  LocationAddressCallEvent(this.locationAddressRequest);
}