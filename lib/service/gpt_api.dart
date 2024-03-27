import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_reminder_app/service/supabase_services.dart';

class ChatGPT {
  
   final locator = GetIt.I.get<DBServices>();
  Future<String> getChatAnswer(String prompt) async {
    await dotenv.load(fileName: ".env");
    final uri = Uri.parse(dotenv.env["LinkGPT"]!);
    String answer = "";
    await http
        .post(
      uri,
      headers: {
        "Authorization":
            "Bearer ${dotenv.env["GPTApiKey"]}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "  startsSpeak to him by his name  ${  locator.nameUser} , play role you are a helpful medical  bot know about medicine and provide advice in a short words ,Just answer in Arabic and Just answer  For medical questions ",
            },
            {
              "role": "user",
              "content": prompt,
            }
          ],
        },
      ),
    )
        .then((value) {
      final response = jsonDecode(utf8.decode(value.bodyBytes) );
      answer = response["choices"][0]["message"]["content"];
    });
    return answer;
  }
}
