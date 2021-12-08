import '../models/food.dart';

class PutFood {
  const PutFood({required this.result, required this.food});

  final Food food;
  final void Function(dynamic action) result;
}

class PutFoodSuccessful {
  const PutFoodSuccessful(this.successfulMessage);

  final String successfulMessage;
}

class PutFoodError {
  const PutFoodError(this.error);

  final Object error;
}
