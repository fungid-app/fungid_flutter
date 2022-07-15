// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ValidationError extends ValidationError {
  @override
  final BuiltList<LocationInner> loc;
  @override
  final String msg;
  @override
  final String type;

  factory _$ValidationError([void Function(ValidationErrorBuilder)? updates]) =>
      (new ValidationErrorBuilder()..update(updates))._build();

  _$ValidationError._(
      {required this.loc, required this.msg, required this.type})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(loc, r'ValidationError', 'loc');
    BuiltValueNullFieldError.checkNotNull(msg, r'ValidationError', 'msg');
    BuiltValueNullFieldError.checkNotNull(type, r'ValidationError', 'type');
  }

  @override
  ValidationError rebuild(void Function(ValidationErrorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ValidationErrorBuilder toBuilder() =>
      new ValidationErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidationError &&
        loc == other.loc &&
        msg == other.msg &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, loc.hashCode), msg.hashCode), type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidationError')
          ..add('loc', loc)
          ..add('msg', msg)
          ..add('type', type))
        .toString();
  }
}

class ValidationErrorBuilder
    implements Builder<ValidationError, ValidationErrorBuilder> {
  _$ValidationError? _$v;

  ListBuilder<LocationInner>? _loc;
  ListBuilder<LocationInner> get loc =>
      _$this._loc ??= new ListBuilder<LocationInner>();
  set loc(ListBuilder<LocationInner>? loc) => _$this._loc = loc;

  String? _msg;
  String? get msg => _$this._msg;
  set msg(String? msg) => _$this._msg = msg;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  ValidationErrorBuilder() {
    ValidationError._defaults(this);
  }

  ValidationErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loc = $v.loc.toBuilder();
      _msg = $v.msg;
      _type = $v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidationError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ValidationError;
  }

  @override
  void update(void Function(ValidationErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidationError build() => _build();

  _$ValidationError _build() {
    _$ValidationError _$result;
    try {
      _$result = _$v ??
          new _$ValidationError._(
              loc: loc.build(),
              msg: BuiltValueNullFieldError.checkNotNull(
                  msg, r'ValidationError', 'msg'),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'ValidationError', 'type'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loc';
        loc.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ValidationError', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
