import 'package:elite/features/auth/binding/auth_binding.dart';
import 'package:elite/features/home/binding/home_bindings.dart';

/// init all binding
void setUpLocator() {
  AuthenticationBinding().dependencies();
  HomeBinding().dependencies();
}
