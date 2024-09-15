class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String link;
  String phone;
  String email;

  Contacts({
    required this.link,
    required this.phone,
    required this.email,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication({
    this.customer,
    this.contacts,
  });
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo({
    required this.name,
    required this.identifier,
    required this.version,
  });
}

class ForgotPassword {
  String support;

  ForgotPassword({
    required this.support,
  });
}

class Service {
  int id;
  String title;
  String image;

  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class Store {
  int id;
  String title;
  String image;

  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });
}

class HomeData {
  List<Service> services;
  List<Store> stores;
  List<BannerAd> banners;

  HomeData({
    required this.services,
    required this.stores,
    required this.banners,
  });
}

class HomeObject {
  HomeData data;

  HomeObject({
    required this.data,
  });
}
