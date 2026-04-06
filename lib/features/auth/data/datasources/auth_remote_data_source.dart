import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myblog/core/error/exceptions.dart';
import 'package:myblog/env/env.dart';
import 'package:myblog/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> getUserData();

  Future<void> userLogOut();
  Future<void> sendFcmToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final SupabaseClient supabaseClient;
  final Dio dio;
  final FlutterSecureStorage storage;
  AuthRemoteDataSourceImpl(
    // this.supabaseClient,
    this.dio,
    this.storage,
  );
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        Env.loginUser,
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await storage.write(key: "token", value: data["accessToken"]);

        final token = await storage.read(key: "token");

        dio.options.headers["Authorization"] = "Bearer $token";

        await sendFcmToken();

        return UserModel.fromJson(data["user"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        Env.signupUser,
        data: {"name": name, "email": email, "password": password},
      );

      if (response.statusCode == 201) {
        final data = response.data;
        await storage.write(key: "token", value: data["accessToken"]);

        final token = await storage.read(key: "token");

        dio.options.headers["Authorization"] = "Bearer $token";
        await sendFcmToken();
        return UserModel.fromJson(data["user"]);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final token = await storage.read(key: "token");

      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(Env.getUserDate);

      if (response.statusCode != 200) {
        throw ServerException(response.data["message"]);
      }
      await sendFcmToken();
      return UserModel.fromJson(response.data["user"]);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> userLogOut() async {
    try {
      await storage.write(key: "token", value: "");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> sendFcmToken() async {
    try {
      final fcm = FirebaseMessaging.instance;
      final fcmToken = await fcm.getToken();
      await dio.post(Env.sendFcmToken, data: {'fcmToken': fcmToken});
    } catch (e) {
      debugPrint('Fcm token error:${e.toString()}');
    }
  }
}
