import '../models/food.dart';

class GetFoods {}

class GetFoodsSuccessful {
  GetFoodsSuccessful(this.food);

  final List<Food> food;
}

class GetFoodsError {
  GetFoodsError(this.error);

  final Object error;
}
