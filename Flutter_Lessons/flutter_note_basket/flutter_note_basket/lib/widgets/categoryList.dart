// ignore_for_file: file_names, unused_local_variable, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_note_basket/models/category.dart';
import 'package:flutter_note_basket/utils/database_helper.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late DatabaseHelper _databaseHelper;
  late List<Category> _allCategory;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (_allCategory.isEmpty) {
      _allCategory = [];
      _selectCategoryList();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          Category _selectedCategory = _allCategory[index];
          return ListTile(
            onTap: () => _updateCategory(_selectedCategory, context),
            leading: const Icon(
              Icons.import_contacts,
              color: Colors.blueGrey,
            ),
            title: Text(_selectedCategory.categoryName!),
            trailing: InkWell(
                onTap: () => _deleteCategory(_selectedCategory.categoryId),
                child: const Icon(
                  Icons.delete,
                  color: Colors.orange,
                )),
          );
        },
        itemCount: _allCategory.length,
      ),
    );
  }

  void _selectCategoryList() {
    _databaseHelper.selectedCategoryList().then((categoryList) {
      setState(() {
        _allCategory = categoryList;
      });
    });
  }

  _deleteCategory(int? categoryId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Category',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Raleway')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    'If you delete this category, will be delete the all notes interest with this. Are You Sure ?'),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        _databaseHelper
                            .deleteCategory(categoryId!)
                            .then((deleteCategoryId) {
                          if (deleteCategoryId != 0) {
                            setState(() {
                              _selectCategoryList();
                              Navigator.of(context).pop();
                            });
                          }
                        });
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  _updateCategory(Category updateCategory, BuildContext c) {
    _updateCategoryDialog(c, updateCategory);
  }

  Future<dynamic> _updateCategoryDialog(
      BuildContext myContext, Category updateCategory) {
    var formKey = GlobalKey<FormState>();
    String updateCategoryName = "";

    return showDialog(
        barrierDismissible: false,
        context: myContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              'Update Category',
              style: TextStyle(
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: updateCategory.categoryName,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (categoryValue) {
                      if (categoryValue!.length < 3) {
                        return "You Have To Enter Least 3 Characters.";
                      }
                    },
                    onSaved: (categoryValue) {
                      updateCategoryName = categoryValue!;
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        _databaseHelper
                            .updateCategory(Category.withID(
                                updateCategory.categoryId, updateCategoryName))
                            .then((updateCategoryId) {
                          if (updateCategoryId != 0) {
                            _scaffoldKey.currentState!
                                .showBottomSheet<void>((BuildContext context) {
                              return Container(
                                child: const SnackBar(
                                  content: Text('Updated Category'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            });
                            _selectCategoryList();
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
