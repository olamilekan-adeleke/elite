import 'dart:developer';

void errorLog(String error, String info, {String? trace, String? title}) {
  log('${'==' * 10} Error $title ${'==' * 10}');
  log('Error: $error \n Info: $info \n Trace: $trace');
  log('${'==' * 10} ${'==' * 10}');
}

void infoLog(String info, {String? message, String? title}) {
  log('${'==' * 10} Begin $title ${'==' * 10}');
  log('Info== $info \n message: $message \n Title== $title');
  log('${'==' * 10} End $title ${'==' * 10}');
}
