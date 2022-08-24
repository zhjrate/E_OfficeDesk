import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/all_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/api_token/api_token_update_request.dart';
import 'package:soleoserp/models/api_requests/attendance_list_request.dart';
import 'package:soleoserp/models/api_requests/attendance_save_request.dart';
import 'package:soleoserp/models/api_requests/employee_list_request.dart';
import 'package:soleoserp/models/api_requests/follower_employee_list_request.dart';
import 'package:soleoserp/models/api_requests/inquiry_status_list_request.dart';
import 'package:soleoserp/models/api_requests/menu_rights_request.dart';
import 'package:soleoserp/models/api_responses/all_employee_List_response.dart';
import 'package:soleoserp/models/api_responses/attendance_response_list.dart';
import 'package:soleoserp/models/api_responses/attendance_save_response.dart';
import 'package:soleoserp/models/api_responses/employee_list_response.dart';
import 'package:soleoserp/models/api_responses/follower_employee_list_response.dart';
import 'package:soleoserp/models/api_responses/inquiry_status_list_response.dart';
import 'package:soleoserp/models/api_responses/menu_rights_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'dashboard_user_rights_screen_event.dart';
part 'dashboard_user_rights_screen_state.dart';

class DashBoardScreenBloc
    extends Bloc<DashBoardScreenEvents, DashBoardScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  DashBoardScreenBloc(this.baseBloc) : super(MenuRightsScreenInitialState());

  @override
  Stream<DashBoardScreenStates> mapEventToState(
      DashBoardScreenEvents event) async* {
    // TODO: implement mapEventToState
    if (event is MenuRightsCallEvent) {
      yield* _mapMenuRightsCallEventToState(event);
    }
    /*if(event is CustomerCategoryCallEvent)
    {
      yield* _mapCustomerCategoryCallEventToState(event);
    }*/
    /* if(event is CustomerSourceCallEvent)
    {
      yield* _mapCustomerSourceCallEventToState(event);
    }*/
    /* if(event is DesignationCallEvent)
    {
      yield* _mapDesignationListCallEventToState(event);
    }*/
    /* if(event is InquiryLeadStatusTypeListByNameCallEvent){
      yield* _mapFollowupInquiryStatusListCallEventToState(event);
    }*/
    if (event is FollowerEmployeeListCallEvent) {
      yield* _mapFollowerEmployeeByStatusCallEventToState(event);
    }
    if (event is ALLEmployeeNameCallEvent) {
      yield* _mapALLEmployeeNameListCallEventToState(event);
    }

    if (event is AttendanceCallEvent) {
      yield* _mapAttendanceCallEventToState(event);
    }

    if (event is AttendanceSaveCallEvent) {
      yield* _mapAttendanceSaveCallEventToState(event);
    }

    if (event is EmployeeListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }
    if (event is APITokenUpdateRequestEvent) {
      yield* _map_api_token_updateEventState(event);
    }
/*    if(event is CloserReasonTypeListByNameCallEvent)
    {
      yield* _mapCloserReasonStatusListCallEventToState(event);

    }*/
/*    if(event is LeaveRequestTypeCallEvent)
    {
      yield* _mapLeaveRequestTypeCallEventToState(event);
    }*/
    /*if(event is ExpenseTypeByNameCallEvent)
    {
      yield* _mapExpenseTypeCallEventToState(event);

    }*/
  }

  Stream<DashBoardScreenStates> _mapMenuRightsCallEventToState(
      MenuRightsCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      // CustomerCategoryResponse loginResponse =

      /* List<CustomerCategoryResponse> customercategoryresponse*/
      MenuRightsResponse respo =
          await userRepository.menu_rights_api(event.menuRightsRequest);
      //print("TypeErrorSolved : " + respo.toString());
      //CustomerCategoryResponseFromJson(respo);
      yield MenuRightsEventResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

/*  Stream<InquiryStates> _mapSearchInquiryListByNumberCallEventToState(
      SearchInquiryListByNumberCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryListResponse response =
      await userRepository.getInquiryListSearchByNumber(event.request);
      yield SearchInquiryListByNumberCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/
  /* Stream<DashBoardScreenStates> _mapCustomerCategoryCallEventToState(
      CustomerCategoryCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerCategoryResponse respo =  await userRepository.customer_Category_List_call(event.request1);
      yield CustomerCategoryCallEventResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/
  /*Stream<DashBoardScreenStates> _mapCustomerSourceCallEventToState(
      CustomerSourceCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      CustomerSourceResponse respo =  await userRepository.customer_Source_List_call(event.request1);
      yield CustomerSourceCallEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

/*  Stream<DashBoardScreenStates> _mapDesignationListCallEventToState(
      DesignationCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DesignationApiResponse respo =  await userRepository.designation_list_details(event.designationApiRequest);
      yield DesignationListEventResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  /* Stream<DashBoardScreenStates> _mapFollowupInquiryStatusListCallEventToState(
      InquiryLeadStatusTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      InquiryStatusListResponse response =
      await userRepository.getFollowupInquiryStatusList(event.followupInquiryStatusTypeListRequest);
      yield InquiryLeadStatusListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/
  Stream<DashBoardScreenStates> _mapFollowerEmployeeByStatusCallEventToState(
      FollowerEmployeeListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowerEmployeeListResponse response = await userRepository
          .getFollowerEmployeeList(event.followerEmployeeListRequest);
      yield FollowerEmployeeListByStatusCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  ///event functions to states implementation
  /* Stream<DashBoardScreenStates> _mapFollowupTypeListCallEventToState(
      FollowupTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      FollowupTypeListResponse response =
      await userRepository.getFollowupTypeList(event.followupTypeListRequest);
      yield FollowupTypeListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  /* Stream<DashBoardScreenStates> _mapCloserReasonStatusListCallEventToState(
      CloserReasonTypeListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CloserReasonListResponse response =
      await userRepository.getCloserReasonStatusList(event.closerReasonTypeListRequest);
      yield CloserReasonListCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

/*  Stream<DashBoardScreenStates> _mapLeaveRequestTypeCallEventToState(
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
  }*/

  /* Stream<DashBoardScreenStates> _mapExpenseTypeCallEventToState(
      ExpenseTypeByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ExpenseTypeResponse response =
      await userRepository.getExpenseType(event.expenseTypeAPIRequest);
      yield ExpenseTypeCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  Stream<DashBoardScreenStates> _mapALLEmployeeNameListCallEventToState(
      ALLEmployeeNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ALL_EmployeeList_Response response =
          await userRepository.getALLEmployeeList(event.allEmployeeNameRequest);
      yield ALL_EmployeeNameListResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DashBoardScreenStates> _mapAttendanceCallEventToState(
      AttendanceCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      // CustomerCategoryResponse loginResponse =

      /* List<CustomerCategoryResponse> customercategoryresponse*/
      Attendance_List_Response respo =
          await userRepository.getAttendanceList(event.attendanceApiRequest);

      yield AttendanceListCallResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DashBoardScreenStates> _mapAttendanceSaveCallEventToState(
      AttendanceSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      AttendanceSaveResponse respo =
          await userRepository.DashBoardattendanceSave(
              event.attendanceSaveApiRequest);
      yield AttendanceSaveCallResponseState(respo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DashBoardScreenStates> _mapBankVoucherListCallEventToState(
      EmployeeListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      EmployeeListResponse response = await userRepository
          .getEmployeeListWithOneImage(event.pageNo, event.employeeListRequest);
      yield EmployeeListResponseState(event.pageNo, response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), () {});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DashBoardScreenStates> _map_api_token_updateEventState(
      APITokenUpdateRequestEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      String response = await userRepository
          .getAPIUpdateTokenAPI(event.apiTokenUpdateRequest);

      yield APITokenUpdateState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), () {});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
