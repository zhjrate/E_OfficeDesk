 import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/api_responses/pagination_demo_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pagination_demo_screen_events.dart';

part 'pagination_demo_screen_states.dart';

class PaginationDemoScreenBloc
    extends Bloc<PaginationDemoScreenEvents, PaginationDemoScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  PaginationDemoScreenBloc(this.baseBloc)
      : super(PaginationDemoScreenInitialState());

  @override
  Stream<PaginationDemoScreenStates> mapEventToState(
      PaginationDemoScreenEvents event) async* {
    /// sets state based on events
    if (event is GetListCallEvent) {
      yield* _mapGetListCallEventToState(event);
    }
  }

  ///event functions to states implementation
  Stream<PaginationDemoScreenStates> _mapGetListCallEventToState(
      GetListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      PaginationDemoListResponse response =
          await userRepository.getList(event.pageNo);
      yield GetListCallEventResponseState(response,event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
