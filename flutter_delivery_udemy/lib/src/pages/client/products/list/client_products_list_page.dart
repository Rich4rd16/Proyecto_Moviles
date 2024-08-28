import 'package:flutter/material.dart';
import 'package:flutter_delivery_udemy/src/utils/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({super.key});

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  List<Product> products = [
    Product(name: 'Hamburguesa', price: 50.0, imageUrl: 'assets/img/burger1.png'),
    Product(name: 'Pizza', price: 45.0, imageUrl: 'assets/img/pizza2.png'),
    Product(name: 'Play5', price: 50.0, imageUrl: 'assets/img/play5.jpeg'),
    Product(name: 'Xbox Series', price: 45.0, imageUrl: 'assets/img/xbox.jpeg'),
    Product(name: 'Camiseta Real Madrid', price: 50.0, imageUrl: 'assets/img/madrid.jpeg'),
    Product(name: 'Camiseta Orense', price: 45.0, imageUrl: 'assets/img/orense.jpeg'),
  ];

  List<Product> cart = [];
  int cartQuantity = 0;

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
      cartQuantity++;
    });
  }

  void clearCart() {
    setState(() {
      cart.clear();
      cartQuantity = 0;
    });
  }

  void proceedToCheckout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gracias por su compra'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/img/buy.png', height: 100), // Ajusta la imagen según tu diseño
              SizedBox(height: 10),
              Text('Su compra ha sido realizada con éxito, un repartidor ha sido enviado a su ubicación'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearCart();
                openGoogleMaps(); // Abre Google Maps al hacer clic en Aceptar
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  void openCart() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Mueve el cálculo del total dentro del builder
        double total = cart.fold(0, (sum, item) => sum + item.price);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final product = cart[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                cart.removeAt(index);
                                cartQuantity--;
                                // Actualiza el total después de eliminar el producto
                                total = cart.fold(0, (sum, item) => sum + item.price);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Total a pagar: \$${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: proceedToCheckout,
                    child: Text(
                      'Pagar',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white, // Texto en blanco
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void openGoogleMaps() async {
    const url = 'https://www.google.com/maps/search/?api=1&query=Restaurante+Aleatorio'; // Dirección o negocio aleatorio
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RyR_Business',
          style: TextStyle(color: Colors.white), // Texto en blanco
        ),
        backgroundColor: MyColors.primaryColorDark,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white, // Ícono en blanco
                ),
                onPressed: openCart,
              ),
              if (cartQuantity > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartQuantity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.7, // Ajusta el aspecto para hacer los cuadrados más pequeños
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bordes más pequeños para un diseño compacto
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          height: 150, // Ajusta la altura de la imagen
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), // Tamaño de fuente reducido
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${product.price}',
                          style: TextStyle(fontSize: 10.0, color: Colors.grey[600]), // Tamaño de fuente reducido
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => addToCart(product),
                          child: Text(
                            'Agregar al carrito',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white, // Texto en blanco
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}
