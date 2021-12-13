import 'package:logger/logger.dart';

var loge = Logger(
  printer: PrettyPrinter(printEmojis: false, printTime: false),
);

var logi = Logger(
  printer: PrettyPrinter(methodCount: 0, printEmojis: false, printTime: false),
);
