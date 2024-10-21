import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:reno_email/core/enums.dart';
import 'package:reno_email/providers/providers.dart';
import '../../../domain/email_entity.dart';

class CreatePage extends HookConsumerWidget {
  const CreatePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
            Container(
              width: double.infinity,
              height: 130,
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
                        height: 130,
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
                                            .state = textLg.name;
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(textLg.name),
                                          textLg.name == textLength
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
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: Center(child: Text(textLength)),
                      ),
                    );
                  })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
