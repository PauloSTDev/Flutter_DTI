import 'package:dti/models/cart.dart';
import 'package:dti/models/read_examples.dart';
import 'package:dti/pages/write_examples.dart';
import 'package:dti/pages/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({key}) : super(key: key);

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: Material(
        color: Colors.blueAccent,
        child: ListView(
          padding: padding,
          children: [
            buildHeader(
              urlImage: user.photoURL!,
              name: user.displayName!,
              email: user.email!,
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoggedInWidget(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            buildSearchField(),
            const SizedBox(height: 30),
            buildMenuItem(text: 'Perfil', icon: Icons.engineering, onClicked: () => selectedItem(context, 0)),
            const SizedBox(height: 30),
            buildMenuItem(text: 'Equipamentos', icon: Icons.wallet_travel, onClicked: () => selectedItem(context, 1)),
            const SizedBox(height: 30),
            buildMenuItem(
                text: 'Carrinho de Compras', icon: Icons.add_shopping_cart, onClicked: () => selectedItem(context, 2)),
            const SizedBox(height: 30),
            buildMenuItem(text: 'Minhas Compras', icon: Icons.shopping_cart, onClicked: () => selectedItem(context, 7)),
            const SizedBox(height: 30),
            buildMenuItem(
              text: 'Favoritos',
              icon: Icons.favorite_border,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.black),
            const SizedBox(height: 30),
            buildMenuItem(
                text: 'Definir equipamentos', icon: Icons.wallet_travel, onClicked: () => selectedItem(context, 4)),
            const SizedBox(height: 30),
            buildMenuItem(text: 'Atualizar', icon: Icons.update, onClicked: () => selectedItem(context, 5)),
            const SizedBox(height: 30),
            buildMenuItem(text: 'Configurações', icon: Icons.edit, onClicked: () => selectedItem(context, 6)),
          ],
        ),
      ),
    );
  }

  ///Widget de barra de pesquisa
  Widget buildSearchField() {
    const color = Colors.black;

    return TextField(
      style: const TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Pesquisa',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  ///Widget para apresentar o perfil
  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      );

  ///Opções da barra lateral
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;
    const pressColor = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      onTap: onClicked,
      hoverColor: pressColor,
    );
  }

  ///Navegação de pages por índice
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoggedInWidget(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReadExamples(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Cart(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Cart(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WriteExamples(),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Cart(),
          ),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Cart(),
          ),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoggedInWidget(),
          ),
        );
        break;
    }
  }
}
