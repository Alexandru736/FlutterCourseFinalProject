import 'food.dart';

class AppState {
  AppState({
    this.foods = const <Food>[],
  });

  final List<Food> foods;

  AppState copyWith({
    final List<Food>? foods,
  }) {
    return AppState(
        foods: foods ?? this.foods,
    );
  }

  @override
  String toString() {
    return 'AppState(foods: $foods)';
  }
}
