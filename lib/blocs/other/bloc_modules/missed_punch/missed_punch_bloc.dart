
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/loan/loan_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/loan_approval_list_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_list_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/missed_punch_search_by_name_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_approval_list_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_list_response.dart';
import 'package:soleoserp/models/api_responses/missed_punch_search_by_name_response.dart';
import 'package:soleoserp/repositories/repository.dart';


part 'missed_punch_event.dart';

part 'missed_punch_state.dart';

class MissedPunchScreenBloc extends Bloc<MissedPunchScreenEvents, MissedPunchScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  MissedPunchScreenBloc(this.baseBloc) : super(MissedPunchScreenInitialState());

  @override
  Stream<MissedPunchScreenStates> mapEventToState(
      MissedPunchScreenEvents event) async* {
    if (event is MissedPunchListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }
    if(event is MissedPunchSearchByNameCallEvent)
      {
        yield* _mapMissedPunchSearchByNameCallEventToState(event);

      }
    if(event is MissedPunchSearchByIDCallEvent)
      {
        yield* _mapMissedPunchSearchByIDCallEventToState(event);

      }

    if(event is MissedPunchDeleteCallEvent)
      {
        yield* _mapMissedPunchDeleteCallEventToState(event);

      }
    if(event is MissedPunchApprovalListCallEvent)
      {
        yield* _mapMissedPunchApprovalListCallEventToState(event);

      }

  }

  Stream<MissedPunchScreenStates> _mapBankVoucherListCallEventToState(
      MissedPunchListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      MissedPunchListResponse response = await userRepository.getMissedPunchList(event.pageNo,event.listRequest);
      yield MissedPunchListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<MissedPunchScreenStates> _mapMissedPunchSearchByNameCallEventToState(
      MissedPunchSearchByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      MissedPunchSearchByNameResponse response =
      await userRepository.getMissedPunchSearchByName(event.missedPunchSearchByNameRequest);
      yield MissedPunchSearchByNameResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<MissedPunchScreenStates> _mapMissedPunchSearchByIDCallEventToState(
      MissedPunchSearchByIDCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      MissedPunchListResponse response =
      await userRepository.getMissedPunchSearchByID(event.pkID,event.missedPunchSearchByIDRequest);
      yield MissedPunchSearchByIDResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<MissedPunchScreenStates> _mapMissedPunchDeleteCallEventToState(
      MissedPunchDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      BankVoucherDeleteResponse response =
      await userRepository.getMissedDeleteByID(event.pkID,event.bankVoucherDeleteRequest);
      yield MissedPunchDeleteResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<MissedPunchScreenStates> _mapMissedPunchApprovalListCallEventToState(
      MissedPunchApprovalListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      MissedPunchApprovalListResponse response =
      await userRepository.getMissedPunchApprovalList(event.loanApprovalListRequest);
      yield MissedPunchApprovalListResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


}