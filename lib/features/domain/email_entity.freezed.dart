// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmailEntity _$EmailEntityFromJson(Map<String, dynamic> json) {
  return _EmailEntity.fromJson(json);
}

/// @nodoc
mixin _$EmailEntity {
  String get role =>
      throw _privateConstructorUsedError; // The role (e.g., "user", "assistant")
  String get type =>
      throw _privateConstructorUsedError; // The type of the content (e.g., "text")
  String get subject =>
      throw _privateConstructorUsedError; // The extracted subject
  String get text => throw _privateConstructorUsedError;

  /// Serializes this EmailEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailEntityCopyWith<EmailEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailEntityCopyWith<$Res> {
  factory $EmailEntityCopyWith(
          EmailEntity value, $Res Function(EmailEntity) then) =
      _$EmailEntityCopyWithImpl<$Res, EmailEntity>;
  @useResult
  $Res call({String role, String type, String subject, String text});
}

/// @nodoc
class _$EmailEntityCopyWithImpl<$Res, $Val extends EmailEntity>
    implements $EmailEntityCopyWith<$Res> {
  _$EmailEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? type = null,
    Object? subject = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailEntityImplCopyWith<$Res>
    implements $EmailEntityCopyWith<$Res> {
  factory _$$EmailEntityImplCopyWith(
          _$EmailEntityImpl value, $Res Function(_$EmailEntityImpl) then) =
      __$$EmailEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String role, String type, String subject, String text});
}

/// @nodoc
class __$$EmailEntityImplCopyWithImpl<$Res>
    extends _$EmailEntityCopyWithImpl<$Res, _$EmailEntityImpl>
    implements _$$EmailEntityImplCopyWith<$Res> {
  __$$EmailEntityImplCopyWithImpl(
      _$EmailEntityImpl _value, $Res Function(_$EmailEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? type = null,
    Object? subject = null,
    Object? text = null,
  }) {
    return _then(_$EmailEntityImpl(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailEntityImpl implements _EmailEntity {
  const _$EmailEntityImpl(
      {required this.role,
      required this.type,
      required this.subject,
      required this.text});

  factory _$EmailEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailEntityImplFromJson(json);

  @override
  final String role;
// The role (e.g., "user", "assistant")
  @override
  final String type;
// The type of the content (e.g., "text")
  @override
  final String subject;
// The extracted subject
  @override
  final String text;

  @override
  String toString() {
    return 'EmailEntity(role: $role, type: $type, subject: $subject, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailEntityImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, type, subject, text);

  /// Create a copy of EmailEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailEntityImplCopyWith<_$EmailEntityImpl> get copyWith =>
      __$$EmailEntityImplCopyWithImpl<_$EmailEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailEntityImplToJson(
      this,
    );
  }
}

abstract class _EmailEntity implements EmailEntity {
  const factory _EmailEntity(
      {required final String role,
      required final String type,
      required final String subject,
      required final String text}) = _$EmailEntityImpl;

  factory _EmailEntity.fromJson(Map<String, dynamic> json) =
      _$EmailEntityImpl.fromJson;

  @override
  String get role; // The role (e.g., "user", "assistant")
  @override
  String get type; // The type of the content (e.g., "text")
  @override
  String get subject; // The extracted subject
  @override
  String get text;

  /// Create a copy of EmailEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailEntityImplCopyWith<_$EmailEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
