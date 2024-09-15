import 'package:complete_advanced_flutter/data/data_source/local_data_source.dart';
import 'package:complete_advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/network/network_info.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          return Right(response.toDomain());
        } else {
          // return biz logic error
          return Left(
            Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        // return server error
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      // return connection error
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response =
            await _remoteDataSource.forgotPassword(forgotPasswordRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          return Right(response.toDomain());
        } else {
          // return biz logic error
          return Left(
            Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        // return server error
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      // return connection error
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          return Right(response.toDomain());
        } else {
          // return biz logic error
          return Left(
            Failure(
              code: response.status ?? ResponseCode.DEFAULT,
              message: response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        // return server error
        return Left(
          ErrorHandler.handle(error).failure,
        );
      }
    } else {
      // return connection error
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // get from cache
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // we have cache error so we should call API
      if (await _networkInfo.isConnected) {
        try {
          // its safe to call the API
          final response = await _remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) {
            // return data (success)
            // return right
            // save response to local data source
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left
            return Left(
              Failure(
                code: response.status ?? ResponseCode.DEFAULT,
                message: response.message ?? ResponseMessage.DEFAULT,
              ),
            );
          }
        } catch (error) {
          // return server error
          return Left(
            ErrorHandler.handle(error).failure,
          );
        }
      } else {
        // return connection error
        return Left(
          DataSource.NO_INTERNET_CONNECTION.getFailure(),
        );
      }
    }
  }
}
