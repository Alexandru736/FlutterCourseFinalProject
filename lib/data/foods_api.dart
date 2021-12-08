import 'dart:convert';

import 'package:http/http.dart';

import '../models/food.dart';

class FoodsApi {
  Future<List<Food>> getFoods() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'fruityvice.com',
      pathSegments: <String>['api', 'fruit', 'all'],
    );

    final Response response = await get(uri);

    if (response.statusCode != 200) {
      throw StateError('Error fetching foods');
    }

    final List<dynamic> foods = jsonDecode(response.body) as List<dynamic>;

    return foods.map((dynamic foodElement) {
      final Map<String, dynamic> nutrition = foodElement['nutritions'] as Map<String, dynamic>;
      final Food food = Food(
        name: foodElement['name'] as String,
        nutrition: Nutrition(
          carbs: NutritionalValue(name: 'carbohydrates', value: nutrition['carbohydrates']),
          fat: NutritionalValue(name: 'fat', value: nutrition['fat']),
          calories: NutritionalValue(name: 'calories', value: nutrition['calories']),
          sugar: NutritionalValue(name: 'sugar', value: nutrition['sugar']),
          protein: NutritionalValue(name: 'protein', value: nutrition['protein']),
        ),
        id: foodElement['id'] as int,
        family: foodElement['family'] as String,
        order: foodElement['order'] as String,
        genus: foodElement['genus'] as String,
      );

      return food;
    }).toList();
  }

  Future<String> putFood(Food food) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'fruityvice.com',
      pathSegments: <String>['api', 'fruit'],
    );

    final Map<String, dynamic> foodMap = <String, dynamic>{
      'genus': food.genus,
      'name': food.name,
      'family': food.family,
      'order': food.order,
      'nutritions': <String, dynamic>{
        'carbohydrates': food.nutrition.carbs.value,
        'protein': food.nutrition.protein.value,
        'fat': food.nutrition.fat.value,
        'calories': food.nutrition.calories.value,
        'sugar': food.nutrition.sugar.value
      },
    };

    final String jsonFood = jsonEncode(foodMap);
    final Response response =
        await put(uri, body: jsonFood, headers: <String, String>{'content-type': 'application/json'});

    return response.body;
  }
}

/*void main() async {
  final FoodsApi api = FoodsApi();
  print(await api.getFoods());
  */ /*await api.putFood(
    Food(
      name: 'Cheese',
      id: 15,
      nutrition: Nutrition(
        carbs: NutritionalValue(name: 'carbs', value: 14.3),
        protein: NutritionalValue(name: 'protein', value: 15),
        sugar: NutritionalValue(name: 'sugar', value: 16),
        fat: NutritionalValue(name: 'fat', value: 17),
        calories: NutritionalValue(name: 'calories', value: 18),
      ),
    ),
  );*/ /*
}*/
