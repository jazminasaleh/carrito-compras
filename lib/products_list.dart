import 'package:carro_comprasa/models.dart';
import 'package:carro_comprasa/shpo_database.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  var products = [
    Product(1, "Laptop samsung", "un laptop muy eficinete", 2000000, 'assets/laptop.png'),
    Product(2, "Laptop Gammer", "Rendimiento de utima generacion", 3500000, 'assets/laptop2.jpg'),
    Product(3, "Laptop Asus", "El laptop mas caro", 8000000, 'assets/laptop1.png'),
    Product(4, "Laptop samsung", "un laptop muy eficinete", 2000000, 'assets/laptop3.png'),
    Product(5, "Laptop AMD", "intel core i7", 4500000, 'assets/laptop4.jpg'),
    Product(6, "Laptop Acer", "un laptop mas barato", 2300000, 'assets/laptop.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              child: _ProductItem(products[index]),
              
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
        id: product.id, 
        name: product.name, 
        price: product.price, 
        quantity: 1, 
        );
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
      child: Container(
         decoration: BoxDecoration(
          color: Color.fromRGBO(245, 244, 244, 1),
          borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
          Image.asset(product.img, width: 100, height: 100,),
            Padding(padding: EdgeInsets.only(right: 3, left: 3)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Text(product.description),
                Text("\$"+product.price.toString(), style: TextStyle(fontWeight: FontWeight.w300),), 
              ],
            )
          ],
        ),
      ),
    );
  }
}
