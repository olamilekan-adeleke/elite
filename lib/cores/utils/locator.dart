import 'package:elite/features/auth/binding/auth_binding.dart';

/// init all binding
void setUpLocator() {
  AuthenticationBinding().dependencies();
}
