import 'package:logger/logger.dart';

var loge = Logger(
  printer: PrettyPrinter(printEmojis: false, printTime: true),
);

var logi = Logger(
  printer: PrettyPrinter(methodCount: 0,printEmojis: true, printTime: true),
);
