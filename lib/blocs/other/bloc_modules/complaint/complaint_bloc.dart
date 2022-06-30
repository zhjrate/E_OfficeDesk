import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/complaint_delete_request.dart';
import 'package:soleoserp/models/api_requests/complaint_save_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_by_Id_request.dart';
import 'package:soleoserp/models/api_requests/complaint_search_request.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_list_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_save_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/complaint_list_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/transection_mode_list_request.dart';
import 'package:soleoserp/models/api_responses/bank_drop_down_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_list_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_save_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/complaint_delete_response.dart';
import 'package:soleoserp/models/api_responses/complaint_list_response.dart';
import 'package:soleoserp/models/api_responses/complaint_save_response.dart';
import 'package:soleoserp/models/api_responses/complaint_search_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/transection_mode_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintScreenBloc extends Bloc<ComplaintScreenEvents, ComplaintScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  ComplaintScreenBloc(this.baseBloc) : super(ComplaintScreenInitialState());

  @override
  Stream<ComplaintScreenStates> mapEventToState(ComplaintScreenEvents event) async* {

    if (event is ComplaintListCallEvent) {
      yield* _mapComplaintListCallEventToState(event);
    }
    if(event is ComplaintSearchByNameCallEvent)
      {
        yield* _mapSearchByNameCallEventToState(event);

      }
    if(event is ComplaintSearchByIDCallEvent)
      {
        yield* _mapSearchByIDCallEventToState(event);

      }
    if(event is ComplaintDeleteCallEvent)
      {
        yield* _mapDeleteCallEventToState(event);
      }

    if(event is SearchFollowupCustomerListByNameCallEvent)
    {
      yield* _mapFollowupCustomerListByNameCallEventToState(event);

    }
    if(event is CustomerSourceCallEvent)
      {
        yield*  _mapCustomerSourceCallEventToState(event);
      }
    if(event is ComplaintSaveCallEvent)
    {
      yield*  _mapSaveCallEventToState(event);
    }


  }


  Stream<ComplaintScreenStates> _mapComplaintListCallEventToState(
      ComplaintListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintListResponse response =
      await userRepository.getComplaintList(event.pageNo,event.complaintListRequest);
      yield ComplaintListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<ComplaintScreenStates> _mapSearchByNameCallEventToState(
      ComplaintSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintSearchResponse response =
      await userRepository.getComplaintSearchByName(event.complaintSearchRequest);
      yield ComplaintSearchByNameResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ComplaintScreenStates> _mapSearchByIDCallEventToState(
      ComplaintSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintListResponse response =
      await userRepository.getComplaintSearchByID(event.pkID,event.complaintSearchByIDRequest);
      yield ComplaintSearchByIDResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ComplaintScreenStates> _mapDeleteCallEventToState(
      ComplaintDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintDeleteResponse response =
      await userRepository.DeleteComplaintBypkID(event.pkID,event.complaintDeleteRequest);
      yield ComplaintDeleteResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ComplaintScreenStates> _mapFollowupCustomerListByNameCallEventToState(
      SearchFollowupCustomerListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerLabelvalueRsponse response =
      await userRepository.getCustomerListSearchByName(event.request);
      yield FollowupCustomerListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ComplaintScreenStates> _mapCustomerSourceCallEventToState(
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


  Stream<ComplaintScreenStates> _mapSaveCallEventToState(
      ComplaintSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      ComplaintSaveResponse response =
      await userRepository.getComplaintSave(event.pkID,event.complaintSaveRequest);
      yield ComplaintSaveResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}
