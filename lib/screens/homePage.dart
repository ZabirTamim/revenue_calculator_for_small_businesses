import 'package:flutter/material.dart';
import 'package:revenue_calculator_for_small_businesses/models/product.dart';
import 'package:revenue_calculator_for_small_businesses/components/produtItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = <Product>[];
  final TextEditingController _textNameController = TextEditingController();
  final TextEditingController _textPriceController = TextEditingController();
  final TextEditingController _textDescController = TextEditingController();

  @override
  Future _getProduct() async {
    SharedPreferences sharedProduct = await SharedPreferences.getInstance();
    Map<String, dynamic> productMap =
        jsonDecode(sharedProduct.getString('product')!);
    var product = Product.fromJson(productMap);
    products.add(
      Product(
        name: product.name,
        description: product.description,
        price: product.price,
      ),
    );
    return products;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Revenue Calculator',
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder(
        future: _getProduct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: products.isEmpty
                ? const Text('Add products...')
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: products.map((Product product) {
                      return ProductItem(
                        product: product,
                      );
                    }).toList(),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '+Product',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          _displayDialog();
        },
      ),
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new Product'),
          content: Column(
            children: [
              TextField(
                controller: _textNameController,
                decoration: const InputDecoration(
                    hintText: 'Type name of your product'),
              ),
              TextField(
                controller: _textDescController,
                decoration: const InputDecoration(hintText: 'Type Description'),
              ),
              TextField(
                controller: _textPriceController,
                decoration: const InputDecoration(hintText: 'Enter price'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();

                _addProductItem(
                  _textNameController.text,
                  _textDescController.text,
                  int.parse(_textPriceController.text),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _addProductItem(String name, String descript, int price) async {
    setState(() {
      products.add(Product(name: name, description: descript, price: price));
    });

    _textNameController.clear();
    _textDescController.clear();
    _textPriceController.clear();
  }

  void _sharedProduct(String name, String descript, int price) async {
    SharedPreferences sharedProduct = await SharedPreferences.getInstance();
    String product = jsonEncode(
      Product.fromJson(
        Product(name: name, description: descript, price: price).toJson(),
      ),
    );
    sharedProduct.setString('product', product);
    print(product);
  }
}
