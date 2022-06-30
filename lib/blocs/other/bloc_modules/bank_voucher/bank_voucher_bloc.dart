import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_drop_down_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_list_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_save_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/customer_label_value_request.dart';
import 'package:soleoserp/models/api_requests/transection_mode_list_request.dart';
import 'package:soleoserp/models/api_responses/bank_drop_down_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_list_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_save_response.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/customer_label_value_response.dart';
import 'package:soleoserp/models/api_responses/transection_mode_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';

part 'banck_voucher_events.dart';
part 'bank_voucher_states.dart';

class BankVoucherScreenBloc extends Bloc<BankVoucherScreenEvents, BankVoucherScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  BankVoucherScreenBloc(this.baseBloc) : super(BankVoucherScreenInitialState());

  @override
  Stream<BankVoucherScreenStates> mapEventToState(BankVoucherScreenEvents event) async* {

    if (event is BankVoucherListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }

    if(event is BankVoucherSearchByNameCallEvent)
      {
        yield* _mapBAnkVoucherSearchByNameCallEventToState(event);
      }
    if(event is BankVoucherSearchByIDCallEvent)
    {
      yield* _mapBAnkVoucherSearchByIDCallEventToState(event);
    }

    if(event is BankVoucherDeleteCallEvent)
    {
      yield* _mapDeletedBankVoucherCallEventToState(event);

    }


    if(event is TransectionModeCallEvent){
      yield* _mapTransectionModeCallEventToState(event);
    }

    if(event is SearchBankVoucherCustomerListByNameCallEvent)
    {
      yield* _mapFollowupCustomerListByNameCallEventToState(event);

    }

    if(event is BankDropDownCallEvent)
      {
        yield* _mapBankDropDownEventToState(event);

      }
    if(event is BankVoucherSaveCallEvent)
      {
        yield* _mapSavedBankVoucherCallEventToState(event);

      }
    /* if (event is DailyActivityListCallEvent) {
      yield* _mapDailyActivityListCallEventToState(event);
    }
    if(event is DailyActivityDeleteByNameCallEvent)
    {
      yield* _mapDeletedDailyActivityCallEventToState(event);

    }

    if(event is TaskCategoryListCallEvent)
    {
      yield* _mapTaskCategoryCallEventToState(event);

    }


    if(event is DailyActivitySaveByNameCallEvent)
    {
      yield* _mapSaveDailyActivityCallEventToState(event);

    }*/
  }


  Stream<BankVoucherScreenStates> _mapBankVoucherListCallEventToState(
      BankVoucherListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      BankVoucherListResponse response =
      await userRepository.getBankVoucherList(event.pageNo,event.bankVoucherListRequest);
      yield BankvoucherListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<BankVoucherScreenStates> _mapBAnkVoucherSearchByNameCallEventToState(
      BankVoucherSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankVoucherSearchByNameResponse response =
      await userRepository.getBankVoucherSearchByName(event.request);
      yield BankVoucherSearchByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<BankVoucherScreenStates> _mapBAnkVoucherSearchByIDCallEventToState(
      BankVoucherSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      BankVoucherListResponse response =
      await userRepository.getBankVoucherSearchByIDResponse(event.id,event.request);
      yield BankVoucherSearchByIDCallResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<BankVoucherScreenStates> _mapDeletedBankVoucherCallEventToState(
      BankVoucherDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankVoucherDeleteResponse bankVoucherDeleteResponse = await userRepository.getbankvoucherDelete(event.pkID,event.bankVoucherDeleteRequest);
      yield BankVoucherDeleteResponseState(bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<BankVoucherScreenStates> _mapTransectionModeCallEventToState(
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


  Stream<BankVoucherScreenStates> _mapFollowupCustomerListByNameCallEventToState(
      SearchBankVoucherCustomerListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      CustomerLabelvalueRsponse response =
      await userRepository.getCustomerListSearchByName(event.request);
      yield BankVoucherCustomerListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<BankVoucherScreenStates> _mapBankDropDownEventToState(
      BankDropDownCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankDorpDownResponse response =
      await userRepository.getBankDropDown(event.request);
      yield BankDropDownResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<BankVoucherScreenStates> _mapSavedBankVoucherCallEventToState(
      BankVoucherSaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankVoucherSaveResponse bankVoucherDeleteResponse = await userRepository.getbankvoucherSave(event.pkID,event.bankVoucherSaveRequest);
      yield BankVoucherSaveResponseState(event.context,bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

 /* Stream<DailyActivityScreenStates> _mapDailyActivityListCallEventToState(
      DailyActivityListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      DailyActivityListResponse response =
      await userRepository.getDailyActivityList(event.pageNo,event.dailyActivityListRequest);
      yield DailyActivityCallResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DailyActivityScreenStates> _mapDeletedDailyActivityCallEventToState(
      DailyActivityDeleteByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      DailyActivityDeleteResponse customerDeleteResponse = await userRepository.deleteDailyActivity(event.pkID,event.dailyActivityDeleteRequest);
      yield DailyActivityDeleteCallResponseState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DailyActivityScreenStates> _mapTaskCategoryCallEventToState(
      TaskCategoryListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      TaskCategoryResponse customerDeleteResponse = await userRepository.taskCategoryDetails(event.taskCategoryListRequest);
      yield TaskCategoryCallResponseState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<DailyActivityScreenStates> _mapSaveDailyActivityCallEventToState(
      DailyActivitySaveByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      DailyActivitySaveResponse dailyActivitySaveResponse = await userRepository.saveDailyActivity(event.pkID,event.dailyActivitySaveRequest);
      yield DailyActivitySaveCallResponseState(dailyActivitySaveResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
*/

}
