import 'package:dart_openai/dart_openai.dart';
import 'package:reno_email/core/extensions.dart';

import '../features/domain/email_entity.dart';

Future<EmailEntity> generateResponse(
    List<OpenAIChatCompletionChoiceMessageModel> messages) async {
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-4o-mini",
    seed: 6,
    messages: messages,
    maxTokens: 250,
    // Allow more tokens to ensure the full email is generated
    temperature:
        0.7, // Slightly higher creativity might make the email feel more natural
  );
  String contentText =
      chatCompletion.choices.first.message.content!.first.text!;
  String subject = contentText.extractSubject();
  bool isSubject = subject.isNotEmpty;

  EmailEntity email = EmailEntity(
    role: chatCompletion.choices.first.message.role.name,
    type: chatCompletion.choices.first.message.content!.first.type,
    subject: isSubject ? subject : '',
    text: isSubject ? contentText.extractTextAfterSubject() : contentText,
  );
  return email;
}
