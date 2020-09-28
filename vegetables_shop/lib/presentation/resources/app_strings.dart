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
  static const String contacts = 'Контакты';
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
  static const String transitToPayment = 'Перейти к оплате';
  static const String yourProducts = 'Ваши продуты:';
  static String totalPrice(double price) {
    return 'Общая сумма: $price';
  }

  //Login page names
  static const String singUp = 'Зарегестрироваться';
  static const String singIn = 'Войти';

  //Registration page names
  static const String registration = 'Регестрация';
  static const String gallery = 'Галерея';
  static const String camera = 'Камера';
  static const String cancel = 'Отмена';
  static const String close = 'Закрыть';
  static const String search = 'Поиск';
  static const String notFound = 'Ничего не найдено';
  static const String selectedCountryCode = 'Выберете код страны';
  static const String next = 'Далее';
  static const String firstName = 'Имя';
  static const String secondName = 'Фамилия';
  static const String email = 'Почта';
  static const String telephone = 'Телефон';
  static const String cardNumberHint = '**** **** **** ****';
  static const String expiryDateHint = 'MM/ГГ';
  static const String cvvCode = 'CVV';
  static const String cardHolderHint = 'Владелец карты';
  static const String step1 = 'Шаг 1';
  static const String step2 = 'Шаг 2';
  static const String step3 = 'Шаг 3';
  static const String step4 = 'Шаг 4';
  static const String chooseImage = 'Выбрать изображение';
  static const String addInformationAboutPaymentCard = 'Введите информацию о карте';
  static const String country = 'Страна';
  static const String city = 'Город';
  static const String address = 'Адрес';
  static const String postCode = 'Почтовый код';
  static const String createPassword = 'Придумайте пароль';
  static const String newPassword = 'Новый пароль';
  static const String repeatPassword = 'Повторите пароль';
  static const String finishRegistration = 'Завершить регестрацию!';
  static const String registrationIsCompleted = 'Регестрация завершена!';
  static const String gotoProducts = 'Перейти к покупкам';
}
