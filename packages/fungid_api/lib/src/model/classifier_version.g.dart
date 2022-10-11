// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifier_version.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassifierVersion extends ClassifierVersion {
  @override
  final String version;
  @override
  final int imageSize;

  factory _$ClassifierVersion(
          [void Function(ClassifierVersionBuilder)? updates]) =>
      (new ClassifierVersionBuilder()..update(updates))._build();

  _$ClassifierVersion._({required this.version, required this.imageSize})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        version, r'ClassifierVersion', 'version');
    BuiltValueNullFieldError.checkNotNull(
        imageSize, r'ClassifierVersion', 'imageSize');
  }

  @override
  ClassifierVersion rebuild(void Function(ClassifierVersionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassifierVersionBuilder toBuilder() =>
      new ClassifierVersionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassifierVersion &&
        version == other.version &&
        imageSize == other.imageSize;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, version.hashCode), imageSize.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassifierVersion')
          ..add('version', version)
          ..add('imageSize', imageSize))
        .toString();
  }
}

class ClassifierVersionBuilder
    implements Builder<ClassifierVersion, ClassifierVersionBuilder> {
  _$ClassifierVersion? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  int? _imageSize;
  int? get imageSize => _$this._imageSize;
  set imageSize(int? imageSize) => _$this._imageSize = imageSize;

  ClassifierVersionBuilder() {
    ClassifierVersion._defaults(this);
  }

  ClassifierVersionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _imageSize = $v.imageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassifierVersion other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClassifierVersion;
  }

  @override
  void update(void Function(ClassifierVersionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassifierVersion build() => _build();

  _$ClassifierVersion _build() {
    final _$result = _$v ??
        new _$ClassifierVersion._(
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'ClassifierVersion', 'version'),
            imageSize: BuiltValueNullFieldError.checkNotNull(
                imageSize, r'ClassifierVersion', 'imageSize'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
