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
