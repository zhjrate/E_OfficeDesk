import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/bank_voucher_delete_request.dart';
import 'package:soleoserp/models/api_requests/employee_list_request.dart';
import 'package:soleoserp/models/api_requests/employee_search_request.dart';
import 'package:soleoserp/models/api_responses/bank_voucher_delete_response.dart';
import 'package:soleoserp/models/api_responses/employee_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeScreenBloc extends Bloc<EmployeeScreenEvents, EmployeeScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  EmployeeScreenBloc(this.baseBloc) : super(EmployeeScreenInitialState());

  @override
  Stream<EmployeeScreenStates> mapEventToState(
      EmployeeScreenEvents event) async* {
    if (event is EmployeeListCallEvent) {
      yield* _mapBankVoucherListCallEventToState(event);
    }
    if(event is EmployeeSearchCallEvent)
      {
        yield* _mapEmployeeSearchCallEventToState(event);

      }
    if(event is EmployeeDeleteCallEvent)
      {
        yield* _mapDeletedBankVoucherCallEventToState(event);

      }
  }

  Stream<EmployeeScreenStates> _mapBankVoucherListCallEventToState(
      EmployeeListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      EmployeeListResponse response =
      await userRepository.getEmployeeList(event.pageNo,event.employeeListRequest);
      yield EmployeeListResponseState(event.pageNo,response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<EmployeeScreenStates> _mapEmployeeSearchCallEventToState(
      EmployeeSearchCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));

      EmployeeListResponse response =
      await userRepository.getEmployeeSearchResult(event.employeeSearchRequest);
      yield EmployeeSearchResponseState(response);

    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), (){});
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<EmployeeScreenStates> _mapDeletedBankVoucherCallEventToState(
      EmployeeDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankVoucherDeleteResponse bankVoucherDeleteResponse = await userRepository.getEmployeeDelete(event.pkID,event.bankVoucherDeleteRequest);
      yield EmployeeDeleteResponseState(bankVoucherDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}