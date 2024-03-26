import 'package:flutter/material.dart';
import '../models/category.dart';
import 'package:uuid/uuid.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> _categories = [];
  TextEditingController _textEditingController = TextEditingController();
  String newCategoryName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('todo_app'),
        centerTitle: true,
      ),
      body: Center(
        child: _categories.isEmpty
            ? Text(
          'Список категорий пуст',
          style: TextStyle(fontSize: 18.0),
        )
            : ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                _deleteCategory(index);
              },
              child: Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(category.name),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Введите название \nкатегории',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text('Название', style: TextStyle(color: Colors.blue)),
                  SizedBox(height: 0),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        newCategoryName = value;
                      });
                    },
                    maxLength: 40,
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                  ),
                  child: Text('Отмена', style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  child: Text('Сохранить', style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    if (newCategoryName.isNotEmpty) {
                      _addCategory(newCategoryName);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addCategory(String name) {
    setState(() {
      var uuid = const Uuid();
      _categories.add(Category(id: uuid.v4(), name: name, createdAt: DateTime.now()));
    });
  }

  void _deleteCategory(int index) {
    setState(() {
      _categories.removeAt(index);
    });
  }
}
