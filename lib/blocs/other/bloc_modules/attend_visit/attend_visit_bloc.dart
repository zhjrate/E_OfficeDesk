import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/attend_visit_list_request.dart';
import 'package:soleoserp/models/api_requests/attend_visit_save_request.dart';
import 'package:soleoserp/models/api_requests/complaint_no_list_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_by_Id_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/transection_mode_list_request.dart';
import 'package:soleoserp/models/api_responses/attend_visit_list_response.dart';
import 'package:soleoserp/models/api_responses/attend_visit_save_response.dart';
import 'package:soleoserp/models/api_responses/complaint_no_list_response.dart';
import 'package:soleoserp/models/api_responses/complaint_search_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/transection_mode_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'attend_visit_events.dart';
part 'attend_visit_states.dart';

class AttendVisitBloc extends Bloc<AttendVisitEvents, AttendVisitStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  AttendVisitBloc(this.baseBloc) : super(AttendVisitInitialState());

  @override
  Stream<AttendVisitStates> mapEventToState(
      AttendVisitEvents event) async* {
    if(event is AttendVisitListCallEvent)
    {
      yield* _mapAttenVisitCallEventToState(event);
    }
    if(event is ComplaintNoListCallEvent)
      {
        yield* _mapComplaintNoListEventToState(event);

      }

    if(event is CustomerSourceCallEvent)
    {
      yield* _mapCustomerSourceCallEventToState(event);

    }

    if(event is TransectionModeCallEvent){
      yield* _mapTransectionModeCallEventToState(event);
    }
    if(event is AttendVisitSaveCallEvent){
      yield* _mapAttendVisitSaveCallEventToState(event);
    }
    if(event is ComplaintSearchByNameCallEvent)
    {
      yield* _mapSearchByNameCallEventToState(event);

    }

    if(event is AttendVisitSearchByIDCallEvent)
    {
      yield* _mapSearchByIDCallEventToState(event);

    }

  }

  Stream<AttendVisitStates> _mapAttenVisitCallEventToState(
      AttendVisitListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      // CustomerCategoryResponse loginResponse =

      /* List<CustomerCategoryResponse> customercategoryresponse*/
      AttendVisitListResponse respo =  await userRepository.getAttenVisitList(event.pageNo,event.attendVisitListRequest);

      yield AttendVisitListCallResponseState(event.pageNo,respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<AttendVisitStates> _mapComplaintNoListEventToState(
      ComplaintNoListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      // CustomerCategoryResponse loginResponse =

      /* List<CustomerCategoryResponse> customercategoryresponse*/
      ComplaintNoListResponse respo =  await userRepository.getComplaintNoList(event.complaintNoListRequest);

      yield ComplaintNoListCallResponseState(respo);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<AttendVisitStates> _mapCustomerSourceCallEventToState(
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
  }

  Stream<AttendVisitStates> _mapTransectionModeCallEventToState(
      TransectionModeCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      TransectionModeListResponse bankVoucherDeleteResponse = await userRepository.getTransectionModeList(event.request);
      yield TransectionModeResponseState(bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<AttendVisitStates> _mapAttendVisitSaveCallEventToState(
      AttendVisitSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      AttendVisitSaveResponse bankVoucherDeleteResponse = await userRepository.getAttendVisitSave(event.pkID,event.request);
      yield AttendVisitSaveResponseState(event.context,bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<AttendVisitStates> _mapSearchByNameCallEventToState(
      ComplaintSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintSearchResponse response =
      await userRepository.getVisitSearchByName(event.complaintSearchRequest);
      yield ComplaintSearchByNameResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }




  Stream<AttendVisitStates> _mapSearchByIDCallEventToState(
      AttendVisitSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      AttendVisitListResponse response = await userRepository.getVisitSearchByID(event.pkID,event.complaintSearchByIDRequest);
      yield AttendVisitSearchByIDResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}