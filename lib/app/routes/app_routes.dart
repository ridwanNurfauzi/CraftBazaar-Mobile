part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const NAVIGATOR = _Paths.NAVIGATOR;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PRODUCT = _Paths.PRODUCT;
  static const PRODUCTS_BY_CATEGORY = _Paths.PRODUCTS_BY_CATEGORY;
}

abstract class _Paths {
  _Paths._();
  static const NAVIGATOR = '/navigator';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PRODUCT = '/product';
  static const PRODUCTS_BY_CATEGORY = '/products-by-category';
}
