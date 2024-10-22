import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_email/features/domain/email_entity.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
class DetailPage extends HookConsumerWidget {
   const DetailPage({
    super.key,
    required this.emailEntity,
  });

  final EmailEntity emailEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    void _copyToClipboard(String text) {
      Clipboard.setData(ClipboardData(text: text)).then((_) {
        // Optionally show a snackbar or a message to indicate success
        print('Copied to clipboard: $text');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Check and send'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Text("Subject: ${emailEntity.subject}"),
              ),
              const SizedBox(height: 12,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(emailEntity.text),
                    IconButton(icon: Icon(Icons.copy, color: theme.colorScheme.tertiary), onPressed: () {
                      _copyToClipboard(emailEntity.text);
                    },),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: (){
          // Share the email content
          Share.share('${emailEntity.subject}\n\n${emailEntity.text}');
        },
        child: Container(
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 16),
          color: theme.colorScheme.primaryContainer,
          child: const Center(child: Text('SEND')),
        ),
      ),
    );
  }
}
