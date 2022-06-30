

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/loan_search_request.dart';
import 'package:soleoserp/models/api_requests/salary_upad_list_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/loan_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'salary_upad_event.dart';
part 'salary_upad_state.dart';

class SalaryUpadScreenBloc extends Bloc<SalaryUpadScreenEvents, SalaryUpadScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  SalaryUpadScreenBloc(this.baseBloc)
      : super(SalaryUpadScreenStatesInitialState());

  @override
  Stream<SalaryUpadScreenStates> mapEventToState(
      SalaryUpadScreenEvents event) async* {
    if (event is SalaryUpadListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }
    if (event is SalaryUpadSearchCallEvent) {
      yield* _mapEmployeeSearchCallEventToState(event);
    }
    if (event is SalaryUpadDeleteCallEvent) {
      yield* _mapMissedPunchDeleteCallEventToState(event);
    }




  }


  Stream<SalaryUpadScreenStates> _mapBankVoucherListCallEventToState(
      SalaryUpadListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      LoanListResponse response = await userRepository.getSalaryUpadList(event.pageNo,event.listRequest);
      yield SalaryUpadListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<SalaryUpadScreenStates> _mapMissedPunchDeleteCallEventToState(
      SalaryUpadDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      BankVoucherDeleteResponse response =
      await userRepository.getsalaryUpadDelete(event.pkID,event.bankVoucherDeleteRequest);
      yield SalaryUpadDeleteResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalaryUpadScreenStates> _mapEmployeeSearchCallEventToState(
      SalaryUpadSearchCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      LoanListResponse response =
      await userRepository.getLoanSearchResult(event.employeeSearchRequest);
      yield SalaryUpadSearchResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}