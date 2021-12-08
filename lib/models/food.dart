class Food {
  Food({
    required this.name,
    required this.nutrition,
    this.id,
    required this.order,
    required this.family,
    required this.genus,
  });

  final String name;
  final Nutrition nutrition;
  final int? id;
  final String order;
  final String family;
  final String genus;

  @override
  String toString() {
    return 'Food($name, $id, $order, $family, $genus, $nutrition)\n';
  }
}

class Nutrition {
  Nutrition({
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.calories,
    required this.sugar,
  });

  final NutritionalValue carbs;
  final NutritionalValue protein;
  final NutritionalValue fat;
  final NutritionalValue calories;
  final NutritionalValue sugar;

  @override
  String toString() {
    return 'Nutrition($carbs, $protein, $fat, $calories, $sugar)';
  }
}

class NutritionalValue {
  NutritionalValue({required this.name, required this.value});

  final String name;
  final dynamic value;

  @override
  String toString() {
    return 'NutritionalValue(name: $name, value: $value)';
  }
}
