import 'package:flutter/material.dart';
import 'package:revenue_calculator_for_small_businesses/models/product.dart';

class ProductItem extends StatefulWidget {
  ProductItem({this.product}) : super(key: ObjectKey(product));

  final Product? product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        widget.product!.name!,
      ),
      title: Text(
        widget.product!.description!,
      ),
      trailing: Text(
        "${widget.product!.price!}",
      ),
    );
  }
}
