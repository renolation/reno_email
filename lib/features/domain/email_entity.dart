import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_entity.freezed.dart';
part 'email_entity.g.dart';

@freezed
class EmailEntity with _$EmailEntity {
  const factory EmailEntity({
    required String role,      // The role (e.g., "user", "assistant")
    required String type,      // The type of the content (e.g., "text")
    required String subject,   // The extracted subject
    required String text,      // The actual text content after the subject
  }) = _EmailEntity;

  // Add a factory method for JSON serialization
  factory EmailEntity.fromJson(Map<String, dynamic> json) => _$EmailEntityFromJson(json);

  
}
