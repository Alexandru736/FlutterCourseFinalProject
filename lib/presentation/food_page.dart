import 'package:flutter/material.dart';
import '../models/food.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key, required this.food}) : super(key: key);

  final Food food;

  //const List<NutritionalValue> nutritionalValues; = <NutritionalValue>[food.nutrition.carbs];

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<NutritionalValue> nutritionalValues = <NutritionalValue>[];

  void onPressedBackButton() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    nutritionalValues = <NutritionalValue>[
      widget.food.nutrition.carbs,
      widget.food.nutrition.calories,
      widget.food.nutrition.protein,
      widget.food.nutrition.fat,
      widget.food.nutrition.sugar
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
        leading: IconButton(
          onPressed: onPressedBackButton,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: ListTile(
                leading: const Text(
                  'Family',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  widget.food.family,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: ListTile(
                leading: const Text(
                  'Order',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  widget.food.order,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: ListTile(
                leading: const Text(
                  'Genus',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Text(
                  widget.food.genus,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: ListTile(
                    leading: Text(
                      nutritionalValues[index].name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: Text(
                      '${nutritionalValues[index].value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
