import 'package:ecommerce_responsive/screens/screen_search_product.dart';
import 'package:ecommerce_responsive/screens/screen_contact_us.dart';
import 'package:ecommerce_responsive/screens/screen_faq.dart';
import 'package:ecommerce_responsive/screens/screen_order_list.dart';
import 'package:ecommerce_responsive/screens/screen_account.dart';
import 'package:ecommerce_responsive/screens/screen_add_card.dart';
import 'package:ecommerce_responsive/screens/screen_add_new_address.dart';
import 'package:ecommerce_responsive/screens/screen_address_manager.dart';
import 'package:ecommerce_responsive/screens/screen_cart.dart';
import 'package:ecommerce_responsive/screens/screen_order_summary.dart';
import 'package:ecommerce_responsive/screens/screen_payments_screen.dart';
import 'package:ecommerce_responsive/screens/screen_product_detail.dart';
import 'package:ecommerce_responsive/screens/screen_profile.dart';
import 'package:ecommerce_responsive/screens/screen_quick_pay_cards.dart';
import 'package:ecommerce_responsive/screens/screen_sign_in.dart';
import 'package:ecommerce_responsive/screens/screen_sign_up.dart';
import 'package:ecommerce_responsive/screens/screen_splash.dart';
import 'package:ecommerce_responsive/screens/screen_home.dart';
import 'package:ecommerce_responsive/screens/screen_wishlist.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteGenerator {

  static List<GetPage> routes = [
    GetPage(name: ScreenSplash.tag, page: () => const ScreenSplash()), ///Splash screen

    GetPage(name: ScreenHome.tag, page: () => const ScreenHome()), ///Home Screen

    GetPage(name: ScreenSearchProduct.tag, page: () => const ScreenSearchProduct()), ///Product Search

    GetPage(name: ScreenSignIn.tag, page: () => const ScreenSignIn()), ///Login

    GetPage(name: ScreenSignUp.tag, page: () => const ScreenSignUp()), ///Register

    GetPage(name: ScreenAccount.tag, page: () => const ScreenAccount()), ///User Account

    GetPage(name: ScreenProfile.tag, page: () => const ScreenProfile()), ///User Profile

    GetPage(name: ScreenContactUs.tag, page: () => const ScreenContactUs()), ///Contact us

    GetPage(name: ScreenWishlist.tag, page: () => const ScreenWishlist()), ///Wish list

    GetPage(name: ScreenCart.tag, page: () => const ScreenCart()), ///Cart

    GetPage(name: ScreenProductDetail.tag, page: () => const ScreenProductDetail()), ///Product detail

    GetPage(name: ScreenOrderSummary.tag, page: () => const ScreenOrderSummary()), ///Order Summary

    GetPage(name: ScreenAddressManager.tag, page: () => const ScreenAddressManager()), ///Address Manage

    GetPage(name: ScreenAddNewAddress.tag, page: () => const ScreenAddNewAddress()), ///Add new Address

    GetPage(name: ScreenPayments.tag, page: () => const ScreenPayments()), ///Payments

    GetPage(name: ScreenAddCard.tag, page: () => const ScreenAddCard()), ///Add new Payment card

    GetPage(name: ScreenQuickPayCards.tag, page: () => const ScreenQuickPayCards()), ///Quick Payment card

    GetPage(name: ScreenOrderList.tag, page: () => const ScreenOrderList()), ///User Order list

    GetPage(name: ScreenFAQ.tag, page: () => const ScreenFAQ()), ///Frequently Asked Questions
  ];
}
