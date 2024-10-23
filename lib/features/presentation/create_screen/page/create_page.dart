import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reno_email/core/enums.dart';
import 'package:reno_email/providers/providers.dart';
import '../../../../utils/functions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double rowHeight = 120;
    final textEditController = useTextEditingController();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Create email'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            buildLanguage(theme),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: buildTone(rowHeight, theme)),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(child: buildLength(rowHeight, theme)),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Email instruction',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    textEditController.text = '';
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Consumer(builder: (context, ref, child) {
              final isGenerating = ref.watch(isGeneratingProvider);
              return isGenerating
                  ? SizedBox(
                      height: 300,
                      width: 100,
                      child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.red, size: 100))
                  : SizedBox(
                      height: 300, // <-- TextField height
                      child: TextField(
                        maxLines: null,
                        expands: true,
                        controller: textEditController,
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Type to provide instructions on what type of email you want the ai to write..."',
                          // Placeholder text
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), // Border radius
                            borderSide: BorderSide(color: theme.colorScheme.primaryContainer), // Border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), // Focused border radius
                            borderSide: BorderSide(color: theme.colorScheme.primary), // Focused border color
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12), // Enabled border radius
                            borderSide: BorderSide(color: theme.colorScheme.primaryContainer), // Enabled border color
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10), // Adjust padding
                        ),
                      ),
                    );
            }),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: theme.colorScheme.onSurface, // Set the background color
                backgroundColor: theme.colorScheme.primaryContainer, // Set the text (and icon) color

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () async {
                ref.read(isGeneratingProvider.notifier).update((state) => true);
                final textLength = ref.read(textLengthProvider);
                int wordCount = switch (textLength) {
                  TextLength.Short => 100,
                  TextLength.Medium => 170,
                  TextLength.Long => 250,
                };

                final systemMessage = OpenAIChatCompletionChoiceMessageModel(
                  content: [
                    OpenAIChatCompletionChoiceMessageContentItemModel.text(
                      "You are an assistant that helps write professional emails. Should have subject in response. Response in ${ref.read(languageProvider.notifier).state}. Response with tone ${ref.read(toneTypeProvider.notifier).state}. "
                      "With word count around $wordCount.",
                    ),
                  ],
                  role: OpenAIChatMessageRole.system,
                );

                final userMessage = OpenAIChatCompletionChoiceMessageModel(
                  content: [
                    OpenAIChatCompletionChoiceMessageContentItemModel.text(
                      textEditController.text,
                    ),
                  ],
                  role: OpenAIChatMessageRole.user,
                );

                final requestMessages = [
                  systemMessage,
                  userMessage,
                ];

                await generateResponse(requestMessages).then((email) {
                  ref.read(isGeneratingProvider.notifier).update((state) => false);
                  if (context.mounted) context.push('/detail', extra: email);
                });
              },
              child: const Text('GENERATE'),
            ),
          ],
        ),
      ),
    );
  }

  Consumer buildLength(double rowHeight, ThemeData theme) {
    return Consumer(builder: (context, ref, child) {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Select text length',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        for (var textLg in TextLength.values)
                          ChoiceChip(
                            label: Text(textLg.name),
                            selected: textLg == textLength,
                            selectedColor: theme.colorScheme.primaryFixedDim,
                            onSelected: (value) {
                              ref.read(textLengthProvider.notifier).state = textLg;
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                    // for (var textLg in TextLength.values)
                    //   InkWell(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //       ref.read(textLengthProvider.notifier).state = textLg;
                    //     },
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [Text(textLg.name), textLg == textLength ? Icon(Icons.check) : SizedBox()],
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          height: rowHeight,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.inversePrimary,
                    child: const Icon(
                      Icons.history_edu,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    textLength.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Text length',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }

  Consumer buildTone(double rowHeight, ThemeData theme) {
    return Consumer(builder: (context, ref, child) {
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Select tone',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (var tone in ToneType.values)
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //     ref.read(toneTypeProvider.notifier).state = tone.name;
                          //   },
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(tone.name),
                          //       tone.name == toneType ? Icon(Icons.check) : SizedBox()
                          //     ],
                          //   ),
                          // )
                          ChoiceChip(
                            label: Text(tone.name),
                            labelStyle: TextStyle(color: Colors.black),
                            selected: tone.name == toneType,
                            selectedColor: theme.colorScheme.primaryFixedDim,
                            onSelected: (value) {
                              ref.read(toneTypeProvider.notifier).state = tone.name;
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          height: rowHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.inversePrimary,
                    child: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    toneType,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 20),
                    minFontSize: 12,
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Writing tone',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    });
  }

  Consumer buildLanguage(ThemeData theme) {
    return Consumer(builder: (context, ref, child) {
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Select language',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    for (var language in Language.values)
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          ref.read(languageProvider.notifier).state = language.name;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CountryFlag.fromCountryCode(
                                language.languageCode,
                                shape: const Circle(),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(language.name),
                              Spacer(),
                              language.name == languagePvd
                                  ? Icon(
                                      Icons.check,
                                      color: theme.colorScheme.primary,
                                      size: 26,
                                    )
                                  : SizedBox()
                            ],
                          ),
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
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.primaryContainer,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.inversePrimary,
                child: const Icon(
                  Icons.translate_rounded,
                  size: 30,
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                languagePvd,
                style: TextStyle(fontSize: 20),
              ))),
            ],
          ),
        ),
      );
    });
  }
}
