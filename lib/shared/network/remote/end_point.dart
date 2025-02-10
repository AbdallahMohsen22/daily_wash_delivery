import '../../components/constants.dart';

class EndPoints{
  static const String log = 'delivery-men/login';
  static const String verification = 'delivery-men/verify-delivery-man';
  static String getDelivery = 'delivery-men/single-delivery-man/$userId';
  static const String updateProfileImage = 'delivery-men/update-personal-image';
  static const String contactUs = 'contact-us/create-contact-us';
  static const String getStaticPages = 'static-pages/all';
  static const String getSettings = 'settings';
  static const String getNearOrders = 'orders/all-near-by-orders';
  static const String getOrders = 'orders/all-orders-with-status';
  static const String updateLocation = 'delivery-men/update-delivery-man-info';
  static const String bookOrder = 'orders/delivery-book-order/';
  static const String allBookOrder = 'orders/delivery-book-all-order/';
  static String deleteAccount = 'delivery-men/delete-delivery-man/$userId';
  static const String changeOrderStatus = 'orders/change-order-status';
  static const String notification = 'notification/all-notifications?page=';
  static const String changeOnlineStatus = 'delivery-men/change-delivery-man-online-status';



}