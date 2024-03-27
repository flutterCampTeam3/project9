import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<String> getChatAnswer(String prompt) async {
    await dotenv.load(fileName: ".env");
    final uri = Uri.parse(dotenv.env["LinkGPT"]!);
    String answer = "";
    await http
        .post(
      uri,
      headers: {
        "Authorization": "Bearer ${dotenv.env["GPTApiKey"]}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "you are a helpful doctor know about medicine and provide advice in a short words",
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
      final response = jsonDecode(utf8.decode(value.bodyBytes));
      answer = response["choices"][0]["message"]["content"];
    });
    return answer;
  }

  Future<Map<String, dynamic>> fetchMedicationData(String barcode) async {
    final String apiUrl =
        'https://api.example.com/medications?barcode=$barcode';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Successful API call
      return jsonDecode(response.body);
    } else {
      // Handle errors, return null, or throw an exception
      throw Exception('Failed to load medication data');
    }
  }
}
