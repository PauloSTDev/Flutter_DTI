import 'dart:async';
import 'package:dti/models/cart.dart';
import 'package:dti/controllers/total_controller.dart';
import 'package:dti/models/drawer_widget.dart';
import 'package:dti/pages/write_examples.dart';
import 'package:dti/pages/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:provider/provider.dart';
import 'package:dti/models/sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({Key? key}) : super(key: key);

  @override
  _ReadExamplesState createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  late Query _ref;
  //String _displayText = "Resuls go here";
  final database = FirebaseDatabase.instance.reference();
  final user = FirebaseAuth.instance.currentUser!;

  StreamSubscription? _productStream;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('products').orderByChild('name');
  }

  /// Build para fazer os Carts**/
  Widget _buildEquipmentItem({required Map equipment}) {
    final yourCart = database.child('${user.displayName.toString()} cart');
    return Container(
      padding: const EdgeInsets.all(4),
      height: 100,
      color: Colors.white,
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.wallet_travel,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  equipment["equipment"],
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black, //Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.monetization_on,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "R\$ " + equipment["price_day"].toString() + ",00 por dia",
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 110,
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  color: Colors.green,
                  onPressed: () {
                    Provider.of<TotalController>(context, listen: false).totalNumber(int.parse(equipment["price_day"]));
                    final produto = <String, dynamic>{
                      'equipment': '${equipment["equipment"]}',
                      'price_day': '${equipment["price_day"]}',
                      'quantity': 1,
                    };
                    yourCart
                        .child("${equipment["equipment"]}")
                        .update(produto)
                        .then((_) => print("Order has been written!"));
                    Container();
                  },
                ),
              ],
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Equipamentos'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueAccent,
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            ),
            child: const Icon(
              Icons.logout,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
            Map equipment = snapshot.value;
            return _buildEquipmentItem(equipment: equipment);
          }),
      /**floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
        ),
        tooltip: 'Cart',
        child: const Icon(Icons.shopping_cart, color: Colors.black),
      ),

      **/

      backgroundColor: Colors.blueAccent,
      persistentFooterButtons: <Widget>[
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          ),
          child: const Icon(
            Icons.engineering,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoggedInWidget(),
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          ),
          child: const Icon(
            Icons.shop,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WriteExamples(),
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
          ),
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
      ],
    );
  }

  @override
  void deactivate() {
    _productStream?.cancel();
    super.deactivate();
  }
}
