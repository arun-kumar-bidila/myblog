import 'package:envied/envied.dart';
import 'package:myblog/core/utils/enums.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  static const AppEnvironment currentEnv = AppEnvironment.production;

  static String get baseUrl {
    switch (currentEnv) {
      case AppEnvironment.production:
        return productionUrl;
      case AppEnvironment.dev:
        return devUrl;
      case AppEnvironment.staging:
        return devUrl;
    }
  }

  @EnviedField(varName: "DEV_URL", obfuscate: true)
  static final String devUrl = _Env.devUrl;

  @EnviedField(varName: "PRODUCTION_URL", obfuscate: true)
  static final String productionUrl = _Env.productionUrl;

  /* ********************************  AUTH SECTION  ********************************** */
  @EnviedField(varName: "SIGNUP_USER", obfuscate: true)
  static final String signupUser = _Env.signupUser;

  @EnviedField(varName: "LOGIN_USER", obfuscate: true)
  static final String loginUser = _Env.loginUser;

  @EnviedField(varName: "GET_USER_DATA", obfuscate: true)
  static final String getUserDate = _Env.getUserDate;

  @EnviedField(varName: "SEND_FCM_TOKEN", obfuscate: true)
  static final String sendFcmToken = _Env.sendFcmToken;

  /* ********************************  BLOG SECTION  ********************************** */

  @EnviedField(varName: "UPLOAD_BLOG", obfuscate: true)
  static final String uploadBlog = _Env.uploadBlog;

  @EnviedField(varName: "UPLOAD_BLOG_IMAGE", obfuscate: true)
  static final String uploadBlogImage = _Env.uploadBlogImage;

  @EnviedField(varName: "GET_ALL_BLOGS", obfuscate: true)
  static final String getAllBlogs = _Env.getAllBlogs;

  /* ********************************    PROFILE SECTION ****************************** */

  @EnviedField(varName: "CHANGE_PASSWORD", obfuscate: true)
  static final String changePassword = _Env.changePassword;

  @EnviedField(varName: "FETCH_BLOGS_BY_USER", obfuscate: true)
  static final String fetchBlogsByUser = _Env.fetchBlogsByUser;
}
