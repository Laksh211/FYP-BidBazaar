import 'package:bidbazar/Views/Login.dart';
import 'package:bidbazar/Views/Signup.dart';
import 'package:bidbazar/Views/admin_home.dart';
import 'package:bidbazar/Views/buyer_home.dart';
import 'package:bidbazar/Views/seller_home.dart';
import 'package:bidbazar/Views/splash.dart';
import 'package:bidbazar/widgets/addproduct.dart';
import 'package:bidbazar/widgets/filter.dart';
import 'package:bidbazar/widgets/product_detail_screen.dart';
import 'package:bidbazar/widgets/search.dart';
import 'package:bidbazar/widgets/wishList.dart';

class AppRoutes {
  static const String splash = SplashScreen.routeName;
  static const String login = loginScreen.routeName;
  static const String signup = signUp.routeName;
  static const String seller = Seller.routeName;
  static const String buyer = Buyer.routeName;
  static const String admin = Admin.routeName;
  static const String productdetailscreen = ProductDetailScreen.routeName;
  static const String addproduct = addProduct.routeName;
  static const String search = CustomSearch.routeName;
  static const String wishlist = WishList.routeName;
  static const String filter = FilterProduct.routeName;
}
