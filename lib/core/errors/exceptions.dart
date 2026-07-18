// Core Errors

class ServerException implements Exception {
  final String message;
  const ServerException({this.message = 'حدث خطأ في الخادم'});
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'خطأ في الاتصال بالشبكة'});
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'حدث خطأ في التخزين المحلي'});
}

class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});
}

class PermissionException implements Exception {
  final String message;
  const PermissionException({this.message = 'ليس لديك صلاحية الوصول'});
}
