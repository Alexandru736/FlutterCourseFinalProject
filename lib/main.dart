import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

import 'data/foods_api.dart';
import 'epics/food_epics.dart';
import 'models/app_state.dart';
import 'presentation/homepage.dart';
import 'reducer/reducer.dart';

void main() {

  final FoodsApi foodsApi = FoodsApi();
  final FoodEpics epics = FoodEpics(foodsApi);

  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: <Middleware<AppState>>[
      (Store<AppState> store, dynamic action, NextDispatcher next) {
        next(action);
      },
      EpicMiddleware<AppState>(epics.epics),
    ]
  );
  runApp(FinalApp(store: store));

}

class FinalApp extends StatelessWidget {
  const FinalApp({Key? key, required this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        title: 'Foods',
        home: HomePage(),
      ),
    );
  }
}
