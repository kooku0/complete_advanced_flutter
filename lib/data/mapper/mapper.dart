// to convert the response into a non nullable object (model)

import 'package:complete_advanced_flutter/app/extensions.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      id: this?.id?.orEmpty() ?? EMPTY,
      name: this?.name?.orEmpty() ?? EMPTY,
      numOfNotifications: this?.numOfNotification?.orZero() ?? ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      email: this?.email?.orEmpty() ?? EMPTY,
      phone: this?.phone?.orEmpty() ?? EMPTY,
      link: this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer?.toDomain(),
      contacts: this?.contacts?.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  ForgotPassword toDomain() {
    return ForgotPassword(
      support: this?.support?.orEmpty() ?? EMPTY,
    );
  }
}
