import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reno_email/core/enums.dart';
import 'package:reno_email/core/extensions.dart';
import 'package:reno_email/providers/providers.dart';
import '../../../domain/email_entity.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double rowHeight = 100;
    QuillController controller = QuillController.basic();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create email'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              final languagePvd = ref.watch(languageProvider);
              return InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Select language'),
                            for (var language in Language.values)
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref.read(languageProvider.notifier).state =
                                      language.name;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(language.name),
                                    language.name == languagePvd
                                        ? Icon(Icons.check)
                                        : SizedBox()
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.red,
                  ),
                  child: Center(child: Text(languagePvd)),
                ),
              );
            }),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Consumer(builder: (context, ref, child) {
                    final toneType = ref.watch(toneTypeProvider);
                    return InkWell(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: SafeArea(
                              top: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Select tone'),
                                  for (var tone in ToneType.values)
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        ref
                                            .read(toneTypeProvider.notifier)
                                            .state = tone.name;
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(tone.name),
                                          tone.name == toneType
                                              ? Icon(Icons.check)
                                              : SizedBox()
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: rowHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: Center(child: Text(toneType)),
                      ),
                    );
                  })),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(child: Consumer(builder: (context, ref, child) {
                    final textLength = ref.watch(textLengthProvider);

                    return InkWell(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            controller: ModalScrollController.of(context),
                            child: SafeArea(
                              top: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Select text length'),
                                  for (var textLg in TextLength.values)
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        ref
                                            .read(textLengthProvider.notifier)
                                            .state = textLg;
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(textLg.name),
                                          textLg == textLength
                                              ? Icon(Icons.check)
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: rowHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: Center(child: Text(textLength.name)),
                      ),
                    );
                  })),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email instruction'),
                Text('Clear'),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
                color: Colors.grey.withOpacity(0.1),
              ),
              padding: EdgeInsets.all(12),
              child: QuillEditor.basic(
                controller: controller,
                configurations: const QuillEditorConfigurations(
                    placeholder:
                        "Type to provide instructions on what type of email you want the ai to write."),
              ),
            ),
            TextButton(
              onPressed: () async {
                final textLength = ref.read(textLengthProvider);

                int wordCount = switch (textLength) {
                  TextLength.Short => 100,
                  TextLength.Medium => 170,
                  TextLength.Long => 250,
                };

                // the system message that will be sent to the request.
                final systemMessage = OpenAIChatCompletionChoiceMessageModel(
                  content: [
                    OpenAIChatCompletionChoiceMessageContentItemModel.text(
                      "You are an assistant that helps write professional emails. Should have subject in response. Response in ${ref.read(languageProvider.notifier).state}. Response with tone ${ref.read(toneTypeProvider.notifier).state}. "
                      "With word count around $wordCount.",
                    ),
                  ],
                  role: OpenAIChatMessageRole.system,
                );

                // the user message that will be sent to the request.
                final userMessage = OpenAIChatCompletionChoiceMessageModel(
                  content: [
                    OpenAIChatCompletionChoiceMessageContentItemModel.text(
                      controller.document.toPlainText(),
                    ),
                  ],
                  role: OpenAIChatMessageRole.user,
                );

                // all messages to be sent.
                final requestMessages = [
                  systemMessage,
                  userMessage,
                ];

                OpenAIChatCompletionModel chatCompletion =
                    await OpenAI.instance.chat.create(
                  model: "gpt-4o-mini",
                  seed: 6,
                  messages: requestMessages,
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
                  type:
                      chatCompletion.choices.first.message.content!.first.type,
                  subject: isSubject ? subject : '',
                  text: isSubject
                      ? contentText.extractTextAfterSubject()
                      : contentText,
                );

                print(email.toString());
                // print(chatCompletion.choices.first.message);
                context.push(
                  '/detail',
                  extra: email,
                );
              },
              child: Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}
