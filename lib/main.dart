import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'views/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/order_confirmation_screen.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';
import 'firebase_options.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: ShopEaseApp(),
    ),
  );
}

class ShopEaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/cart', // Changed from '/' to '/login'
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/cart':
            return MaterialPageRoute(builder: (_) => CartScreen());
          case '/checkout':
            final cartItems = settings.arguments as List<Product>;
            return MaterialPageRoute(
              builder: (_) => CheckoutScreen(cartItems: cartItems),
            );
          case '/order_confirmation':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => OrderConfirmationScreen(
                name: args['name'],
                address: args['address'],
                totalAmount: args['totalAmount'],
              ),
            );
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      },
    );
  }
}
