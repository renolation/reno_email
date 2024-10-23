import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reno_email/config/router.dart';
import 'package:reno_email/core/extensions.dart';

import '../../../../config/constants.dart';
import '../../../../config/data.dart';
import '../../../domain/email_entity.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("AI Email writer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SvgPicture.asset(
                        'assets/robot.svg',
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text('AI Email Writer', style: TextStyle(fontSize: 20),),
                          ),
                          AutoSizeText('Craft perfect emails in seconds with AI, edit and send professional messages!',style: TextStyle(fontSize: 14),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => context.push('/create'),
                        child: Container(
                          height: 120,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: theme.colorScheme.primaryContainer,
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.mail,
                                size: 36,
                              ),
                              Text('Create email', style: TextStyle(fontSize: 22),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: theme.colorScheme.primaryContainer,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 36,
                            ),
                            Text('Favorite', style: TextStyle(fontSize: 22),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8,),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email templates', style: TextStyle(fontSize: 22),)),
              const SizedBox(height: 8,),
              ListView.builder(
                itemCount: listTemplate.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    context.push('/detail', extra: listTemplate[index]);
                  },
                  child: Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.secondaryFixed,
                    ),
                    child: Center(child: Text(listTemplate[index].subject)),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
