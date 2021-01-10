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
  static const String exit = 'Выйти';

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
    return 'Общая сумма: ${price ?? 0.0}';
  }

  static const String back = 'Назад';

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
  static const String expiryDateHint = 'MM/ГГГГ';
  static const String cvvCode = 'CVV';
  static const String cardHolderHint = 'Владелец карты';
  static const String step1 = 'Шаг 1';
  static const String step2 = 'Шаг 2';
  static const String step3 = 'Шаг 3';
  static const String step4 = 'Шаг 4';
  static const String chooseImage = 'Выбрать изображение';
  static const String addInformationAboutPaymentCard =
      'Введите информацию о карте';
  static const String country = 'Страна';
  static const String city = 'Город';
  static const String address = 'Адрес';
  static const String postCode = 'Почтовый код';
  static const String createPassword = 'Придумайте пароль';
  static const String newPassword = 'Новый пароль';
  static const String repeatPassword = 'Повторите пароль';
  static const String finishRegistration = 'Завершить регестрацию!';
  static const String registrationIsCompleted = 'Регестрация завершена!';
  static const String goToProducts = 'Перейти к покупкам';

  //Product grid cell
  static const String packagedName = 'Упаковка';
  static const String notPackagedName = 'На вес';
  //Success alert texts
  static const String addToCartIsSuccess = 'Товар добавлен в корзину';
  static const String warning = 'Ошибка!';
  static const String ok = 'Ok';
  static const String orderSuccessCompleted = 'Ваш заказ успешно оформлен!';
  //Cart
  static const String cart = 'Корзина';
  static const String cartIsEmpty = 'Корзина пуста';
  static const String iAgree = 'Я соглашаюсь с ';

  //Log in page
  static const String notFoundUser = 'Пользователь не найден';
  //Update profile page
  static const String mainInfo = 'Основная информация';
  static const String updateProfileInfo = 'Профиль';
  static const String updatePassword = 'Сменить пароль';
  static const String updateProfile = 'Обновить профиль';
  //Update address
  static const String updateAddressTitle = 'Обновить адрес';
  //Update payment card
  static const String updatePaymentCard = 'Обновить карту';
  static const String cardName = 'Карта';
  //Cheque
  static const String chequeTitle = 'Чеки';
  static String chequeTotalPrice(double price) {
    return 'Общая сума: $price';
  }

  static String chequeDate(String date) {
    return 'Дата покупки: $date';
  }

  static const String emptyCheque = 'У вас нет чеков!';

  static const String dontShowAgain = 'Больше не показывать';
  static const String chequeTipTitle = 'Раздел "Чеки"';
  static const String chequeTipContent =
      'Здесь вы можете просмотреть все ваши чеки. Для перехода на следующий чек свайпните вверх';
  //Top 5 product for you page
  static const String topFiveProductForYouTitle = 'Топ 5 продуктов для вас';
  static const String desiredCalories = 'Желаемое кол-во коллорий';
  static const String topFive = 'Топ 5 для вас';
  static const String kal = 'Кал';
  static const String priorityVitamin = 'Приоритетный витамин';
  static const String vitaminA = 'A';
  static const String vitaminB = 'B';
  static const String vitaminC = 'C';
  static String priorityVitaminIs(String vitamin, double content) {
    return '$vitamin: $content мг';
  }
  static const String carbohydrates = 'углеводы';
  static const String fats = 'жиры';
  static const String proteins = 'белки';
  static const String priorityNutrients = 'Приоритетное питательное вещество';
}
