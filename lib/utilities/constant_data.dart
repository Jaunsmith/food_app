class ConstantData {
  static const String APP_NAME = 'OWOVICKKYFOOD';
  static const int APP_VERSION = 1;
  static const String BASE_URL = 'http://192.168.1.132:8000';
  static const String MAIN_FOOD_URL = '/api/v1/products/popular';
  static const String FOOD_LIST_URL = '/api/v1/products/recommended';
  static const String DRINK_LIST_URL = '/api/v1/products/drinks';
  static const String BEVERAGES_LIST_URL = '/api/v1/products/beverages';
  static const String REGISTRATION_URL = '/api/v1/auth/register';
  static const String LOGIN_URL = '/api/v1/auth/login';
  static const String USER_DATA_URL = '/api/v1/customer/info';
  // kindly not this endpoint required the (longitude and the latitude)
  static const String GEOCODEURL = '/api/v1/config/geocode-api';
  static const String USER_ADDRESS = 'user_address';
  // this will be done using post method in other to post data to the database
  static const String ADD_USER_ADDRESS = '/api/v1/customer/address/add';
  static const String TOKEN = '';
  static const String PHONE = '';
  static const String PASSWORD = '';
  static const String UPLOAD_URL = '/uploads/';
  static const String cartListItem = 'cart-List-Items';
  static const String cartHistoryItem = 'cart-History=Items';
}
