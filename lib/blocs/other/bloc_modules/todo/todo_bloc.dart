import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/task_category_list_request.dart';
import 'package:soleoserp/models/api_requests/to_do_header_save_request.dart';
import 'package:soleoserp/models/api_requests/to_do_save_sub_details_request.dart';
import 'package:soleoserp/models/api_requests/to_do_worklog_list_request.dart';
import 'package:soleoserp/models/api_requests/todo_list_request.dart';
import 'package:soleoserp/models/api_responses/task_category_list_response.dart';
import 'package:soleoserp/models/api_responses/to_do_header_save_response.dart';
import 'package:soleoserp/models/api_responses/to_do_save_sub_details_response.dart';
import 'package:soleoserp/models/api_responses/to_do_worklog_list_response.dart';
import 'package:soleoserp/models/api_responses/todo_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_events.dart';

part 'todo_states.dart';

class ToDoBloc extends Bloc<ToDoEvents, ToDoStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  ToDoBloc(this.baseBloc) : super(ToDoInitialState());

  @override
  Stream<ToDoStates> mapEventToState(ToDoEvents event) async* {
    /// sets state based on events
    if (event is ToDoListCallEvent) {
      yield* _mapToDoListCallEventToState(event);
    }
    if (event is TaskCategoryListCallEvent) {
      yield* _mapTaskCategoryCallEventToState(event);
    }
    if (event is ToDoSaveHeaderEvent) {
      yield* _mapToDoSaveHeaderEventToState(event);
    }

    if (event is ToDoSaveSubDetailsEvent) {
      yield* _mapToDoSaveSubDetailsEventToState(event);

    }
    if(event is ToDoWorkLogListEvent)
      {
        yield* _mapToDoWorkLogListEventToState(event);

      }
  }

  ///event functions to states implementation
  Stream<ToDoStates> _mapToDoListCallEventToState(
      ToDoListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ToDoListResponse response =
          await userRepository.getToDoList(event.toDoListApiRequest);
      yield ToDoListCallResponseState(
          response, event.toDoListApiRequest.PageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ToDoStates> _mapTaskCategoryCallEventToState(
      TaskCategoryListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      TaskCategoryResponse customerDeleteResponse = await userRepository
          .taskCategoryDetails(event.taskCategoryListRequest);
      yield TaskCategoryCallResponseState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ToDoStates> _mapToDoSaveHeaderEventToState(
      ToDoSaveHeaderEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ToDoSaveHeaderResponse customerDeleteResponse = await userRepository
          .todo_save_method(event.pkID, event.toDoHeaderSaveRequest);
      yield ToDoSaveHeaderState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ToDoStates> _mapToDoSaveSubDetailsEventToState(
      ToDoSaveSubDetailsEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ToDoSaveSubDetailsResponse customerDeleteResponse = await userRepository
          .todo_save_sub_method(event.pkID, event.toDoSaveSubDetailsRequest);
      yield ToDoSaveSubDetailsState(customerDeleteResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ToDoStates> _mapToDoWorkLogListEventToState(
      ToDoWorkLogListEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      ToDoWorkLogListResponse toDoWorkLogListResponse = await userRepository
          .toDoWorkLogListMethod(event.toDoWorkLogListRequest);
      yield ToDoWorkLogListState(toDoWorkLogListResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
