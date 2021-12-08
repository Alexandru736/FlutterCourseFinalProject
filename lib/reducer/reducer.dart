
import 'package:redux/redux.dart';

import '../actions/get_food.dart';
import '../actions/put_food.dart';
import '../models/app_state.dart';
import '../models/food.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetFoods>(_getFoods),
  TypedReducer<AppState, GetFoodsSuccessful>(_getFoodsSuccessful),
  TypedReducer<AppState, GetFoodsError>(_getFoodsError),
  TypedReducer<AppState, PutFood>(_putFoods),
  TypedReducer<AppState, PutFoodSuccessful>(_putFoodsSuccessful),
  TypedReducer<AppState, PutFoodError>(_putFoodsError),
]);

AppState _getFoods(AppState state, GetFoods action) {
  return state;
}


AppState _getFoodsSuccessful(AppState state, GetFoodsSuccessful action) {

  final List<Food> foods = <Food>[];

  foods.addAll(state.foods);
  foods.addAll(action.food);

  return state.copyWith(foods: foods);
}

AppState _getFoodsError(AppState state, GetFoodsError action) {
  return state;
}

AppState _putFoods(AppState state, PutFood action) {
  return state;
}


AppState _putFoodsSuccessful(AppState state, PutFoodSuccessful action) {
  return state;
}

AppState _putFoodsError(AppState state, PutFoodError action) {
  return state;
}
