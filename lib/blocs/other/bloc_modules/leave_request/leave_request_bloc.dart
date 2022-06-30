import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/attendance_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/followup_delete_request.dart';
import 'package:soleoserp/models/api_requests/leave_approval_save_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_list_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_save_request.dart';
import 'package:soleoserp/models/api_requests/leave_request_type_request.dart';
import 'package:soleoserp/models/api_responses/attendance_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_approval_save_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_delete_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_list_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_save_response.dart';
import 'package:soleoserp/models/api_responses/leave_request_type_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter/material.dart';

part 'leave_request_event.dart';

part 'leave_request_states.dart';

class LeaveRequestScreenBloc extends Bloc<LeaveRequestEvents, LeaveRequestStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  LeaveRequestScreenBloc(this.baseBloc) : super(LeaveRequestStatesInitialState());

  @override
  Stream<LeaveRequestStates> mapEventToState(LeaveRequestEvents event) async* {
    // TODO: implement mapEventToState
    if (event is LeaveRequestCallEvent) {
      yield* _mapLeaveRequestListCallEventToState(event);
    }
    if(event is LeaveRequestEmployeeListCallEvent)
    {
      yield* _mapAttendanceEmployeeListCallEventToState(event);
    }
    if(event is LeaveRequestDeleteByNameCallEvent)
      {
        yield*  _mapDeleteLeaveRequestCallEventToState(event);
      }

    if(event is LeaveRequestSaveCallEvent)
    {
      yield* _mapLeaveRequestSaveCallEventToState(event);
    }
    if(event is LeaveRequestApprovalSaveCallEvent)
      {
        yield* _mapLeaveApprovalSaveCallEventToState(event);
      }

    if(event is LeaveRequestTypeCallEvent)
    {
      yield* _mapLeaveRequestTypeCallEventToState(event);
    }

  }

  Stream<LeaveRequestStates> _mapLeaveRequestListCallEventToState(
      LeaveRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      LeaveRequestListResponse response =
      await userRepository.getLeaveRequestList(event.pageNo,event.leaveRequestListAPIRequest);
      yield LeaveRequestStatesResponseState(event.pageNo,response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<LeaveRequestStates> _mapAttendanceEmployeeListCallEventToState(
      LeaveRequestEmployeeListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      AttendanceEmployeeListResponse respo =  await userRepository.attendanceEmployeeList(event.attendanceEmployeeListRequest);
      yield LeaveRequestEmployeeListResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<LeaveRequestStates> _mapDeleteLeaveRequestCallEventToState(
      LeaveRequestDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      LeaveRequestDeleteResponse leaveRequestDeleteResponse = await userRepository.deleteLeaveRequest(event.pkID,event.leaverequestdelete);
      yield LeaveRequestDeleteCallResponseState(leaveRequestDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

///event functions to states implementation



  Stream<LeaveRequestStates> _mapLeaveRequestSaveCallEventToState(
      LeaveRequestSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      LeaveRequestSaveResponse response =
      await userRepository.getLeaveRequestSave(event.pkID,event.leaveRequestSaveAPIRequest);
      yield LeaveRequestSaveResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<LeaveRequestStates> _mapLeaveApprovalSaveCallEventToState(
      LeaveRequestApprovalSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      LeaveApprovalSaveResponse response =
      await userRepository.getLeaveApprovalSave(event.pkID,event.leaveApprovalSaveAPIRequest);
      yield LeaveApprovalSaveResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<LeaveRequestStates> _mapLeaveRequestTypeCallEventToState(
      LeaveRequestTypeCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      LeaveRequestTypeResponse response =
      await userRepository.getLeaveRequestType(event.leaveRequestTypeAPIRequest);
      yield LeaveRequestTypeResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}
