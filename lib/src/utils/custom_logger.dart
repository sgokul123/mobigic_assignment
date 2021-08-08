
class CustomLogger {
  static void log(dynamic message) {
    try {
      if (message is String) {
        final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
        pattern
            .allMatches(message + "")
            .forEach((match) => print(match.group(0)));
      } else
        print(message);
    } on Exception catch (e) {
    }
  }
}
