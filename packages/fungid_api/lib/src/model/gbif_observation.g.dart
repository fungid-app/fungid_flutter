// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gbif_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GbifObservation extends GbifObservation {
  @override
  final int gbifid;
  @override
  final DateTime? datecreated;
  @override
  final num? latitude;
  @override
  final num? longitude;
  @override
  final bool? public;
  @override
  final String? accesRights;
  @override
  final String? rightsHolder;
  @override
  final String? recordedBy;
  @override
  final String? license;
  @override
  final String? countrycode;
  @override
  final String? stateProvince;
  @override
  final String? county;
  @override
  final String? municipality;
  @override
  final String? locality;
  @override
  final int? speciesId;
  @override
  final int? observerId;

  factory _$GbifObservation([void Function(GbifObservationBuilder)? updates]) =>
      (new GbifObservationBuilder()..update(updates))._build();

  _$GbifObservation._(
      {required this.gbifid,
      this.datecreated,
      this.latitude,
      this.longitude,
      this.public,
      this.accesRights,
      this.rightsHolder,
      this.recordedBy,
      this.license,
      this.countrycode,
      this.stateProvince,
      this.county,
      this.municipality,
      this.locality,
      this.speciesId,
      this.observerId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(gbifid, r'GbifObservation', 'gbifid');
  }

  @override
  GbifObservation rebuild(void Function(GbifObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GbifObservationBuilder toBuilder() =>
      new GbifObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GbifObservation &&
        gbifid == other.gbifid &&
        datecreated == other.datecreated &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        public == other.public &&
        accesRights == other.accesRights &&
        rightsHolder == other.rightsHolder &&
        recordedBy == other.recordedBy &&
        license == other.license &&
        countrycode == other.countrycode &&
        stateProvince == other.stateProvince &&
        county == other.county &&
        municipality == other.municipality &&
        locality == other.locality &&
        speciesId == other.speciesId &&
        observerId == other.observerId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    gbifid
                                                                        .hashCode),
                                                                datecreated
                                                                    .hashCode),
                                                            latitude.hashCode),
                                                        longitude.hashCode),
                                                    public.hashCode),
                                                accesRights.hashCode),
                                            rightsHolder.hashCode),
                                        recordedBy.hashCode),
                                    license.hashCode),
                                countrycode.hashCode),
                            stateProvince.hashCode),
                        county.hashCode),
                    municipality.hashCode),
                locality.hashCode),
            speciesId.hashCode),
        observerId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GbifObservation')
          ..add('gbifid', gbifid)
          ..add('datecreated', datecreated)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('public', public)
          ..add('accesRights', accesRights)
          ..add('rightsHolder', rightsHolder)
          ..add('recordedBy', recordedBy)
          ..add('license', license)
          ..add('countrycode', countrycode)
          ..add('stateProvince', stateProvince)
          ..add('county', county)
          ..add('municipality', municipality)
          ..add('locality', locality)
          ..add('speciesId', speciesId)
          ..add('observerId', observerId))
        .toString();
  }
}

class GbifObservationBuilder
    implements Builder<GbifObservation, GbifObservationBuilder> {
  _$GbifObservation? _$v;

  int? _gbifid;
  int? get gbifid => _$this._gbifid;
  set gbifid(int? gbifid) => _$this._gbifid = gbifid;

  DateTime? _datecreated;
  DateTime? get datecreated => _$this._datecreated;
  set datecreated(DateTime? datecreated) => _$this._datecreated = datecreated;

  num? _latitude;
  num? get latitude => _$this._latitude;
  set latitude(num? latitude) => _$this._latitude = latitude;

  num? _longitude;
  num? get longitude => _$this._longitude;
  set longitude(num? longitude) => _$this._longitude = longitude;

  bool? _public;
  bool? get public => _$this._public;
  set public(bool? public) => _$this._public = public;

  String? _accesRights;
  String? get accesRights => _$this._accesRights;
  set accesRights(String? accesRights) => _$this._accesRights = accesRights;

  String? _rightsHolder;
  String? get rightsHolder => _$this._rightsHolder;
  set rightsHolder(String? rightsHolder) => _$this._rightsHolder = rightsHolder;

  String? _recordedBy;
  String? get recordedBy => _$this._recordedBy;
  set recordedBy(String? recordedBy) => _$this._recordedBy = recordedBy;

  String? _license;
  String? get license => _$this._license;
  set license(String? license) => _$this._license = license;

  String? _countrycode;
  String? get countrycode => _$this._countrycode;
  set countrycode(String? countrycode) => _$this._countrycode = countrycode;

  String? _stateProvince;
  String? get stateProvince => _$this._stateProvince;
  set stateProvince(String? stateProvince) =>
      _$this._stateProvince = stateProvince;

  String? _county;
  String? get county => _$this._county;
  set county(String? county) => _$this._county = county;

  String? _municipality;
  String? get municipality => _$this._municipality;
  set municipality(String? municipality) => _$this._municipality = municipality;

  String? _locality;
  String? get locality => _$this._locality;
  set locality(String? locality) => _$this._locality = locality;

  int? _speciesId;
  int? get speciesId => _$this._speciesId;
  set speciesId(int? speciesId) => _$this._speciesId = speciesId;

  int? _observerId;
  int? get observerId => _$this._observerId;
  set observerId(int? observerId) => _$this._observerId = observerId;

  GbifObservationBuilder() {
    GbifObservation._defaults(this);
  }

  GbifObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gbifid = $v.gbifid;
      _datecreated = $v.datecreated;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _public = $v.public;
      _accesRights = $v.accesRights;
      _rightsHolder = $v.rightsHolder;
      _recordedBy = $v.recordedBy;
      _license = $v.license;
      _countrycode = $v.countrycode;
      _stateProvince = $v.stateProvince;
      _county = $v.county;
      _municipality = $v.municipality;
      _locality = $v.locality;
      _speciesId = $v.speciesId;
      _observerId = $v.observerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GbifObservation other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GbifObservation;
  }

  @override
  void update(void Function(GbifObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GbifObservation build() => _build();

  _$GbifObservation _build() {
    final _$result = _$v ??
        new _$GbifObservation._(
            gbifid: BuiltValueNullFieldError.checkNotNull(
                gbifid, r'GbifObservation', 'gbifid'),
            datecreated: datecreated,
            latitude: latitude,
            longitude: longitude,
            public: public,
            accesRights: accesRights,
            rightsHolder: rightsHolder,
            recordedBy: recordedBy,
            license: license,
            countrycode: countrycode,
            stateProvince: stateProvince,
            county: county,
            municipality: municipality,
            locality: locality,
            speciesId: speciesId,
            observerId: observerId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
