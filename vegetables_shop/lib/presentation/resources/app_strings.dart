class AppStrings {
  //App name
  static const String appName = 'Дары природы';

  //Tabs names
  static const String vegetables = 'Овощи';
  static const String spices = 'Специи';
  static const String fruits = 'Фрукты';
  static const String nuts = 'Орехи';
  static const String mushrooms = 'Грибы';

  //Drawer sections names
  static const String telephone = 'Контакты';
  static const String news = 'Новости';
  static const String terms = 'Правила и условия';

  //Product order page names
  static const String detailInfo = 'Информация о продукте';
  static const String moreInfo = 'Больше информации';
  static const String lessInfo = 'Меньше информации';
  static String finalPrice(double price) {
    return 'Цена: $price грн';
  }
  static const String enterNecessaryWeight =
      'Введите нужный вес товара в граммах';
  static const String addToCart = 'Добавить в карзину';

  //Default weight values
  static const String pricePerKg = 'За 1 кг';
  static const String pricePerHundredGram = 'За 100 г';

  //Cart page names
  static const String backToCartList = 'Вернуться к списку товаров в корзине';
  static const String changePaymentCart = 'Сменить карту';
  static const String pay = 'Оплатить';
}
