import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'message')
  String? message;

  BaseResponse({this.status, this.message});
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'numOfNotification')
  int? numOfNotification;

  CustomerResponse({this.id, this.name, this.numOfNotification});

  // from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'link')
  String? link;

  ContactsResponse({this.email, this.phone, this.link});

  // from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'customer')
  CustomerResponse? customer;
  @JsonKey(name: 'contacts')
  ContactsResponse? contacts;

  AuthenticationResponse({this.customer, this.contacts});

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;

  ForgotPasswordResponse({this.support});

  // from json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse({this.id, this.title, this.image});

  // toJSon
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  // fromJson
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  StoreResponse({this.id, this.title, this.image});

  // toJSon
  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  // fromJson
  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'link')
  String? link;

  BannerResponse({this.id, this.title, this.image, this.link});

  // toJSon
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

  // fromJson
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;
  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;

  HomeDataResponse({this.services, this.stores, this.banners});

  // toJSon
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  // fromJson
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse({this.data});

  // from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'details')
  String? details;
  @JsonKey(name: 'services')
  String? services;
  @JsonKey(name: 'about')
  String? about;

  StoreDetailsResponse({
    this.id,
    this.title,
    this.image,
    this.details,
    this.services,
    this.about,
  });

  // from json
  factory StoreDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreDetailsResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$StoreDetailsResponseToJson(this);
}
