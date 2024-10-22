import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_email/features/domain/email_entity.dart';

class DetailPage extends HookConsumerWidget {
   const DetailPage({
    super.key,
    required this.emailEntity,
  });

  final EmailEntity emailEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Text(emailEntity.text),),
    );
  }
}
