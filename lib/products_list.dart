import 'package:carro_comprasa/models.dart';
import 'package:carro_comprasa/shpo_database.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  var products = [
    Product(1, "laptop1", "un laptop muy eficinete", 2000),
    Product(2, "laptop2", "Este laptop esta en decuento", 1500),
    Product(3, "laptop3", "un laptop mas caro", 8000),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              child: _ProductItem(products[index]),
              color: Color.fromARGB(255, 99, 146, 152),
            ),
            onTap: () async {
              print('hola');
              await addToCart(products[index]);
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Producto agregado!"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 8,
            ),
        itemCount: products.length);
  }

  Future<void> addToCart(Product product) async {
    final item = CartItem(
        id: product.id, name: product.name, price: product.price, quantity: 1);
    await ShopDatabase.instance.insert(item);
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;
  const _ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/laptop.png',
            width: 100,
          ),
          Padding(padding: EdgeInsets.only(right: 3, left: 3)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name),
              Text(product.description),
              Text(product.price.toString()),
            ],
          )
        ],
      ),
    );
  }
}
