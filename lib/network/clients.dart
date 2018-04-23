import 'dart:async';
import 'dart:convert';
import 'dart:io';

class QuoteClient {

  static const String _NETWORK_ERROR = "Error getting a random quote:\nHttp status ";
  static const String _METHOD_ERROR = "Failed invoking the getRandomQuote function.";
  static const String _url = "https://us-central1-random-quote-201917.cloudfunctions.net/getrandomquote-functions";
  static const String better_url = "https://favqs.com/api/qotd";
  final HttpClient httpClient = new HttpClient();

  static const String field_quote = "quote";
  static const String field_body = "body";
  static const String field_person = "author";

  Future<String> get() async {
    String result;
    try {
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(better_url));
      HttpClientResponse response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var jsonQuote = await response.transform(utf8.decoder).join();
        var data = json.decode(jsonQuote);
        result = "${data[field_quote][field_body]}\n - ${data[field_quote][field_person]}";
      } else {
        result = _NETWORK_ERROR + response.statusCode.toString();
      }
    } catch (exception) {
      result = _METHOD_ERROR;
    }

    return result;
  }


}