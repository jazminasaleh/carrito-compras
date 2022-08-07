import 'dart:ffi';

import 'package:carro_comprasa/models.dart';
import 'package:carro_comprasa/notifier.dart';
import 'package:carro_comprasa/shpo_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context, cart, child) {
      return FutureBuilder(
          future: ShopDatabase.instance.getAllItems(),
          builder:
              (BuildContext context, AsyncSnapshot<List<CartItem>> snapshot) {
            if (snapshot.hasData) {
              List<CartItem> cartItems = snapshot.data!;
              return cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay productos en tu carro',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                           decoration: BoxDecoration(
                               color: Color.fromRGBO(245, 244, 244, 1),
                               borderRadius: BorderRadius.circular(15)),
                          child: _CartItem(cartItems[index]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                            height: 10,
                          ),
                      itemCount: cartItems.length);
            } else {
              return Center(
                child: Text(
                  'No hay productos en tu carro',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          });
    });
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
        style: TextStyle(fontSize: 15),
        child: Row(
          children: [
            /*Image.asset(
              cartItem.img,
              width: 200,
            ),*/
            Image.asset('assets/laptop.png', width: 200,),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(cartItem.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 8,),
                  Text("\$"+cartItem.price.toString()+" unidad"),
                  SizedBox(height: 2,),
                  Text("Cantidad "+cartItem.quantity.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 8,),
                      ElevatedButton(
                        onPressed: () async {
                          cartItem.quantity++;
                          await ShopDatabase.instance.update(cartItem);
                          Provider.of<CartNotifier>(context, listen: false)
                          .shouldRefresh();
                        },
                        child: Text("+", style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          primary: Color.fromARGB(255, 241, 193, 125),
                        ),
                      ),
                      SizedBox(width: 8,),
                      ElevatedButton(
                        onPressed: () async{
                           cartItem.quantity--;
                           if(cartItem.quantity == 0){
                           await  ShopDatabase.instance.delete(cartItem.id);
                           } else{
                               await ShopDatabase.instance.update(cartItem);
                            }
                         
                          Provider.of<CartNotifier>(context, listen: false)
                          .shouldRefresh();
                        },
                        child: Text("-", style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          primary: Color.fromARGB(255, 241, 193, 125),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Text("Total: " + cartItem.totalPrice.toString()),
                  SizedBox(height: 5,),
                  ElevatedButton(
                    onPressed: () async {
                      await ShopDatabase.instance.delete(cartItem.id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Producto eliminado'),
                        duration: Duration(seconds: 1),
                      ));
                      Provider.of<CartNotifier>(context, listen: false)
                          .shouldRefresh();
                    },
                    child: Text("Eliminar"),
                    style: ElevatedButton.styleFrom(primary: Colors.red[800]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
