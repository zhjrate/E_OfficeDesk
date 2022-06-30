import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/employee_search_request.dart';
import 'package:soleoserp/models/api_requests/loan_approval_list_request.dart';
import 'package:soleoserp/models/api_requests/loan_list_request.dart';
import 'package:soleoserp/models/api_requests/loan_search_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/loan_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanScreenBloc extends Bloc<LoanScreenEvents, LoanScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  LoanScreenBloc(this.baseBloc) : super(LoanScreenInitialState());

  @override
  Stream<LoanScreenStates> mapEventToState(
      LoanScreenEvents event) async* {
    if (event is LoanListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }
    if(event is LoanSearchCallEvent)
    {
      yield* _mapEmployeeSearchCallEventToState(event);

    }
    if(event is LoanDeleteCallEvent)
    {
      yield* _mapDeletedBankVoucherCallEventToState(event);

    }
    if(event is LoanApprovalListCallEvent)
    {
      yield* _mapLoanApprovalListCallEventToState(event);

    }

  }

  Stream<LoanScreenStates> _mapBankVoucherListCallEventToState(
      LoanListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      LoanListResponse response = await userRepository.getLoanList(event.pageNo,event.listRequest);
      yield LoanListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<LoanScreenStates> _mapEmployeeSearchCallEventToState(
      LoanSearchCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      LoanListResponse response =
      await userRepository.getLoanSearchResult(event.employeeSearchRequest);
      yield LoanSearchResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<LoanScreenStates> _mapDeletedBankVoucherCallEventToState(
      LoanDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankVoucherDeleteResponse bankVoucherDeleteResponse = await userRepository.getLoanDelete(event.pkID,event.bankVoucherDeleteRequest);
      yield LoanDeleteResponseState(bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }



  Stream<LoanScreenStates> _mapLoanApprovalListCallEventToState(
      LoanApprovalListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      LoanListResponse response =
      await userRepository.getLoanApprovalList(event.loanApprovalListRequest);
      yield LoanApprovalListResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


}