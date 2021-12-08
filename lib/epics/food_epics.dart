import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import '../actions/get_food.dart';
import '../actions/put_food.dart';
import '../data/foods_api.dart';
import '../models/app_state.dart';
import '../models/food.dart';

class FoodEpics {
  FoodEpics(this.api);

  final FoodsApi api;

  Epic<AppState> get epics {
    // ignore: always_specify_types
    return combineEpics([TypedEpic<AppState, GetFoods>(getFoods), TypedEpic<AppState, PutFood>(putFoods)]);
  }

  Stream<dynamic> getFoods(Stream<GetFoods> actions, EpicStore<AppState> store) {
    return actions
        .whereType<GetFoods>()
        .flatMap((GetFoods action) => Stream<void>.value(null))
        .asyncMap((_) => api.getFoods())
        .map<Object>((List<Food> foods) => GetFoodsSuccessful(foods))
        .onErrorReturnWith((Object error, StackTrace stackTrace) => GetFoodsError(error));
  }

  Stream<dynamic> putFoods(Stream<PutFood> actions, EpicStore<AppState> store) {
    return actions.whereType<PutFood>().flatMap((PutFood action) => Stream<void>.value(null)
        .asyncMap((_) => api.putFood(action.food))
        .map<Object>((String respond) => PutFoodSuccessful(respond))
        .onErrorReturnWith((Object error, StackTrace stackTrace) => PutFoodError(error))
        .doOnData(action.result));
  }
}
