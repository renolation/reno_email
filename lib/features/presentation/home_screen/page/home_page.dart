


import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_email/core/extensions.dart';

import '../../../../config/constants.dart';
import '../../../domain/email_entity.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "You are an assistant that helps write professional emails. Should have subject in response",
        ),

      ],
      role: OpenAIChatMessageRole.system,
    );

    // the user message that will be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "Write a friendly email inviting someone to party",
        ),

      ],
      role: OpenAIChatMessageRole.user,
    );


    onPressed() async {

      // all messages to be sent.
      final requestMessages = [
        systemMessage,
        userMessage,
      ];

      OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
        model: "gpt-4o-mini",
        seed: 6,
        messages: requestMessages,
        maxTokens: 250,  // Allow more tokens to ensure the full email is generated
        temperature: 0.7,  // Slightly higher creativity might make the email feel more natural
      );

      String contentText = chatCompletion.choices.first.message.content!.first.text!;
      String subject = contentText.extractSubject();
      bool isSubject = subject.isNotEmpty;

      EmailEntity email = EmailEntity(
        role: chatCompletion.choices.first.message.role.name,
        type: chatCompletion.choices.first.message.content!.first.type,
        subject: isSubject ? subject : '',
        text: isSubject
            ? contentText.extractTextAfterSubject()
            : contentText,
      );


      print(email.toString());
      print(chatCompletion.choices.first.message);

    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('home'),
           Text(openAiApiKey!),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: onPressed),
    );
  }
}
