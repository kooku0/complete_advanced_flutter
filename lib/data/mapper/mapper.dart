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

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      id: this?.id?.orZero() ?? ZERO,
      title: this?.title?.orEmpty() ?? EMPTY,
      image: this?.image?.orEmpty() ?? EMPTY,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      id: this?.id?.orZero() ?? ZERO,
      title: this?.title?.orEmpty() ?? EMPTY,
      image: this?.image?.orEmpty() ?? EMPTY,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
      id: this?.id?.orZero() ?? ZERO,
      title: this?.title?.orEmpty() ?? EMPTY,
      image: this?.image?.orEmpty() ?? EMPTY,
      link: this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                const Iterable.empty())
            .cast<Service>()
            .toList();

    List<Store> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();

    List<Banner> mappedBanners =
        (this?.data?.banners?.map((banner) => banner.toDomain()) ??
                const Iterable.empty())
            .cast<Banner>()
            .toList();

    var homeData = HomeData(
      services: mappedServices,
      stores: mappedStores,
      banners: mappedBanners,
    );

    return HomeObject(
      homeData: homeData,
    );
  }
}
