import 'package:carro_comprasa/models.dart';
import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
  var cartItems = [CartItem(id:1, name: "name", price: 2000, quantity: 3)];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(child:
           _CartItem(cartItems[index]),
           color:  Colors.black45,);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 10,
            ),
        itemCount: cartItems.length);
  }
}

class _CartItem extends StatelessWidget {
  final CartItem cartItem;

  const _CartItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTextStyle.merge(
        style: TextStyle(fontSize: 20, color: Colors.white),
        child: Row(
          children: [
            Image.asset(
              'assets/laptop.png',
              width: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cartItem.name),
                  Text(cartItem.price.toString()),
                  Text(cartItem.quantity.toString() +"X unidades"),
                  Text("Total: " + cartItem.totalPrice.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
