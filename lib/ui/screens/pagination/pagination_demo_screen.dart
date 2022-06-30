import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/pagination_demo_screen/pagination_demo_screen_bloc.dart';
import 'package:soleoserp/models/api_responses/pagination_demo_list_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class PaginationDemoScreen extends BaseStatefulWidget {
  static const routeName = '/paginationDemoScreen';

  @override
  _PaginationDemoScreenState createState() => _PaginationDemoScreenState();
}

class _PaginationDemoScreenState extends BaseState<PaginationDemoScreen>
    with BasicScreen, WidgetsBindingObserver {
  PaginationDemoScreenBloc _paginationDemoScreenBloc;
  PaginationDemoListResponse _listResponse;
  List<Data> _listFiltered = [];
  int _page = 0;
  TextEditingController _searchController = TextEditingController();
  Function refreshList;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    _paginationDemoScreenBloc = PaginationDemoScreenBloc(baseBloc);
  }

  ///listener to multiple states of bloc to handles api responses
  ///use only BlocListener if only need to listen to events
/*
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaginationDemoScreenBloc, PaginationDemoScreenStates>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, PaginationDemoScreenStates state) {
        if (state is PaginationDemoScreenResponseState) {
          _onPaginationDemoScreenCallSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }
*/

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          _paginationDemoScreenBloc..add(GetListCallEvent(_page+1)),
      child: BlocConsumer<PaginationDemoScreenBloc, PaginationDemoScreenStates>(
        builder: (BuildContext context, PaginationDemoScreenStates state) {
          //handle states
          if (state is GetListCallEventResponseState) {
            _onGetListCallSuccess(state);
          }
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called
          if (currentState is GetListCallEventResponseState) {
            return true;
          }
          return false;
        },
        listener: (BuildContext context, PaginationDemoScreenStates state) {
          //handle states
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    if (_listResponse == null) {
      return Container(); //no data
    }
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: getCommonTextFormField(context, baseTheme,
                title: "Search",
                controller: _searchController, onTextChanged: (value) {
              filterList(_searchController.text.toString().trim());
            }),
          ),
          SizedBox(
            height: 10,
          ),
          getCommonButton(baseTheme, () {
            filterList(_searchController.text.toString().trim());
          }, "Search", width: 130),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) myState) {
        refreshList = myState;
        return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (shouldPaginate(scrollInfo)) {
                if (_listResponse.data.length < _listResponse.total) {
                  _paginationDemoScreenBloc.add(GetListCallEvent(_page + 1));
                }
              }
              return true;
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                Data _model = _listFiltered[index];
                return Container(
                    padding: EdgeInsets.all(20),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Image.network(
                              _model.avatar,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(_model.email),
                          ],
                        ),
                      ),
                    ));
              },
              shrinkWrap: true,
              itemCount: _listFiltered.length,
            ));
      },
    );
  }

  void _onGetListCallSuccess(GetListCallEventResponseState state) {
    if (state.page != _page) {
      //new api call

      print("_onGetListCallSuccess - ${state.response}");

      _page = state.page;
      if (_page == 1) {
        _listResponse = state.response;
      } else {
        _listResponse.data.addAll(state.response.data);
      }
      _listFiltered.clear();
      _listFiltered.addAll(_listResponse.data);
    }
  }

  void filterList(String query) {
    refreshList(() {
      _listFiltered.clear();
      _listFiltered.addAll(_listResponse.data
          .where((element) =>
              element.email.toLowerCase().contains(query.toLowerCase()))
          .toList());
      print("_listFiltered.data.length - ${_listFiltered.length}");
      print("_listResponse.data.length - ${_listResponse.data.length}");
    });
    //baseBloc.refreshScreen();
  }
}
