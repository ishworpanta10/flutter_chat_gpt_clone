import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/gpt_message_model.dart';

const String apiKey = 'sk-YOUR-API-KEY';
const String baseURL = 'https://api.openai.com/v1/chat/completions';

class GptService {
  Future<List<GptMessageModel>> getChatGPTResponse(String messages) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    if (messages.isEmpty) {
      return [
        GptMessageModel(role: 'bot', content: 'Hello! How can I help you?'),
      ];
    }

    final body = {
      "messages": [
        {"role": "user", "content": messages}
      ],
      'max_tokens': 100,
      'temperature': 0.5,
      'model': 'gpt-3.5-turbo',
    };

    try {
      final response = await http.post(
        Uri.parse(baseURL),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final completions = data['choices'][0]['message']['content'];
        final role = data['choices'][0]['message']['role'];

        return [
          GptMessageModel(role: 'user', content: messages),
          GptMessageModel(role: role, content: completions),
        ];
      } else {
        final data = jsonDecode(response.body);

        return [
          GptMessageModel(role: 'user', content: messages),
          GptMessageModel(role: 'error', content: data['error']['message'] ?? 'Something went wrong'),
        ];
      }
    } catch (error, stace) {
      log('Error : $error  ::::: StackTrace : $stace');
      return [
        GptMessageModel(role: 'bot', content: 'Something went wrong please try again later'),
      ];
    }
  }
}
