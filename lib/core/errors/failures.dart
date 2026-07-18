import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'حدث خطأ في الخادم'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'خطأ في الاتصال بالشبكة'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'حدث خطأ في التخزين المحلي'});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class PermissionFailure extends Failure {
  const PermissionFailure({super.message = 'ليس لديك صلاحية الوصول'});
}
