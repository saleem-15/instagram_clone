import 'package:dio/dio.dart';

import '../../app/storage/my_shared_pref.dart';

// ignore_for_file: constant_identifier_names

late final apiUrl;
// const apiUrl = 'http://192.168.56.1:80/laravel9/e-commerce/public/api';
const apikey = 'p@ssword123';

//auth
const signIn = '/auth/customer/login';
const signUp = '/auth/customer/register';
const logout = '/auth/customer/logout';
const checkisEmailUsed = '/auth/customer/email';

//category
const CATEGORY_PATH =
    '/category'; //used to get the categories && and category products

//products
const PRODUCTS_PATH = '/product';

//orders
const InCOMPLETE_ORDER_PATH = '/order';
const COMPLETED_ORDERS_PATH = '/order/complete';

//checkout
const CHECKOUT_PATH = '/cart/item/checkout';

//profile
const USER_PATH = '/customer/update';

//cart
const CART_PATH = '/cart/item';

//shipping address
const SHIPPING_ADDRESS_PATH = '/shipping/address';

//shipping type
const SHIPPIN_TYPE_PATH = '/shipping/type';

//search
const SEARCH_PATH = '/product/search';

final dio = Dio(
  BaseOptions(
    baseUrl: apiUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'apiKey': apikey,
      'Authorization': 'Bearer ${MySharedPref.getToken}',
    },
  ),
);
