// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gbif_observation_image.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GbifObservationImage extends GbifObservationImage {
  @override
  final int id;
  @override
  final int? imgid;
  @override
  final String? externalUrl;
  @override
  final String? rightsHolder;
  @override
  final String? creator;
  @override
  final String? license;
  @override
  final bool? isThumbnail;
  @override
  final int? observationId;

  factory _$GbifObservationImage(
          [void Function(GbifObservationImageBuilder)? updates]) =>
      (new GbifObservationImageBuilder()..update(updates))._build();

  _$GbifObservationImage._(
      {required this.id,
      this.imgid,
      this.externalUrl,
      this.rightsHolder,
      this.creator,
      this.license,
      this.isThumbnail,
      this.observationId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GbifObservationImage', 'id');
  }

  @override
  GbifObservationImage rebuild(
          void Function(GbifObservationImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GbifObservationImageBuilder toBuilder() =>
      new GbifObservationImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GbifObservationImage &&
        id == other.id &&
        imgid == other.imgid &&
        externalUrl == other.externalUrl &&
        rightsHolder == other.rightsHolder &&
        creator == other.creator &&
        license == other.license &&
        isThumbnail == other.isThumbnail &&
        observationId == other.observationId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), imgid.hashCode),
                            externalUrl.hashCode),
                        rightsHolder.hashCode),
                    creator.hashCode),
                license.hashCode),
            isThumbnail.hashCode),
        observationId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GbifObservationImage')
          ..add('id', id)
          ..add('imgid', imgid)
          ..add('externalUrl', externalUrl)
          ..add('rightsHolder', rightsHolder)
          ..add('creator', creator)
          ..add('license', license)
          ..add('isThumbnail', isThumbnail)
          ..add('observationId', observationId))
        .toString();
  }
}

class GbifObservationImageBuilder
    implements Builder<GbifObservationImage, GbifObservationImageBuilder> {
  _$GbifObservationImage? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _imgid;
  int? get imgid => _$this._imgid;
  set imgid(int? imgid) => _$this._imgid = imgid;

  String? _externalUrl;
  String? get externalUrl => _$this._externalUrl;
  set externalUrl(String? externalUrl) => _$this._externalUrl = externalUrl;

  String? _rightsHolder;
  String? get rightsHolder => _$this._rightsHolder;
  set rightsHolder(String? rightsHolder) => _$this._rightsHolder = rightsHolder;

  String? _creator;
  String? get creator => _$this._creator;
  set creator(String? creator) => _$this._creator = creator;

  String? _license;
  String? get license => _$this._license;
  set license(String? license) => _$this._license = license;

  bool? _isThumbnail;
  bool? get isThumbnail => _$this._isThumbnail;
  set isThumbnail(bool? isThumbnail) => _$this._isThumbnail = isThumbnail;

  int? _observationId;
  int? get observationId => _$this._observationId;
  set observationId(int? observationId) =>
      _$this._observationId = observationId;

  GbifObservationImageBuilder() {
    GbifObservationImage._defaults(this);
  }

  GbifObservationImageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _imgid = $v.imgid;
      _externalUrl = $v.externalUrl;
      _rightsHolder = $v.rightsHolder;
      _creator = $v.creator;
      _license = $v.license;
      _isThumbnail = $v.isThumbnail;
      _observationId = $v.observationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GbifObservationImage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GbifObservationImage;
  }

  @override
  void update(void Function(GbifObservationImageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GbifObservationImage build() => _build();

  _$GbifObservationImage _build() {
    final _$result = _$v ??
        new _$GbifObservationImage._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GbifObservationImage', 'id'),
            imgid: imgid,
            externalUrl: externalUrl,
            rightsHolder: rightsHolder,
            creator: creator,
            license: license,
            isThumbnail: isThumbnail,
            observationId: observationId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
