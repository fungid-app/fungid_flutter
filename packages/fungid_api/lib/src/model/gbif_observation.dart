//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gbif_observation.g.dart';

/// GbifObservation
///
/// Properties:
/// * [gbifid] 
/// * [datecreated] 
/// * [latitude] 
/// * [longitude] 
/// * [public] 
/// * [accesRights] 
/// * [rightsHolder] 
/// * [recordedBy] 
/// * [license] 
/// * [countrycode] 
/// * [stateProvince] 
/// * [county] 
/// * [municipality] 
/// * [locality] 
/// * [speciesId] 
/// * [observerId] 
abstract class GbifObservation implements Built<GbifObservation, GbifObservationBuilder> {
    @BuiltValueField(wireName: r'gbifid')
    int get gbifid;

    @BuiltValueField(wireName: r'datecreated')
    DateTime? get datecreated;

    @BuiltValueField(wireName: r'latitude')
    num? get latitude;

    @BuiltValueField(wireName: r'longitude')
    num? get longitude;

    @BuiltValueField(wireName: r'public')
    bool? get public;

    @BuiltValueField(wireName: r'acces_rights')
    String? get accesRights;

    @BuiltValueField(wireName: r'rights_holder')
    String? get rightsHolder;

    @BuiltValueField(wireName: r'recorded_by')
    String? get recordedBy;

    @BuiltValueField(wireName: r'license')
    String? get license;

    @BuiltValueField(wireName: r'countrycode')
    String? get countrycode;

    @BuiltValueField(wireName: r'state_province')
    String? get stateProvince;

    @BuiltValueField(wireName: r'county')
    String? get county;

    @BuiltValueField(wireName: r'municipality')
    String? get municipality;

    @BuiltValueField(wireName: r'locality')
    String? get locality;

    @BuiltValueField(wireName: r'species_id')
    int? get speciesId;

    @BuiltValueField(wireName: r'observer_id')
    int? get observerId;

    GbifObservation._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GbifObservationBuilder b) => b;

    factory GbifObservation([void updates(GbifObservationBuilder b)]) = _$GbifObservation;

    @BuiltValueSerializer(custom: true)
    static Serializer<GbifObservation> get serializer => _$GbifObservationSerializer();
}

class _$GbifObservationSerializer implements StructuredSerializer<GbifObservation> {
    @override
    final Iterable<Type> types = const [GbifObservation, _$GbifObservation];

    @override
    final String wireName = r'GbifObservation';

    @override
    Iterable<Object?> serialize(Serializers serializers, GbifObservation object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'gbifid')
            ..add(serializers.serialize(object.gbifid,
                specifiedType: const FullType(int)));
        if (object.datecreated != null) {
            result
                ..add(r'datecreated')
                ..add(serializers.serialize(object.datecreated,
                    specifiedType: const FullType(DateTime)));
        }
        if (object.latitude != null) {
            result
                ..add(r'latitude')
                ..add(serializers.serialize(object.latitude,
                    specifiedType: const FullType(num)));
        }
        if (object.longitude != null) {
            result
                ..add(r'longitude')
                ..add(serializers.serialize(object.longitude,
                    specifiedType: const FullType(num)));
        }
        if (object.public != null) {
            result
                ..add(r'public')
                ..add(serializers.serialize(object.public,
                    specifiedType: const FullType(bool)));
        }
        if (object.accesRights != null) {
            result
                ..add(r'acces_rights')
                ..add(serializers.serialize(object.accesRights,
                    specifiedType: const FullType(String)));
        }
        if (object.rightsHolder != null) {
            result
                ..add(r'rights_holder')
                ..add(serializers.serialize(object.rightsHolder,
                    specifiedType: const FullType(String)));
        }
        if (object.recordedBy != null) {
            result
                ..add(r'recorded_by')
                ..add(serializers.serialize(object.recordedBy,
                    specifiedType: const FullType(String)));
        }
        if (object.license != null) {
            result
                ..add(r'license')
                ..add(serializers.serialize(object.license,
                    specifiedType: const FullType(String)));
        }
        if (object.countrycode != null) {
            result
                ..add(r'countrycode')
                ..add(serializers.serialize(object.countrycode,
                    specifiedType: const FullType(String)));
        }
        if (object.stateProvince != null) {
            result
                ..add(r'state_province')
                ..add(serializers.serialize(object.stateProvince,
                    specifiedType: const FullType(String)));
        }
        if (object.county != null) {
            result
                ..add(r'county')
                ..add(serializers.serialize(object.county,
                    specifiedType: const FullType(String)));
        }
        if (object.municipality != null) {
            result
                ..add(r'municipality')
                ..add(serializers.serialize(object.municipality,
                    specifiedType: const FullType(String)));
        }
        if (object.locality != null) {
            result
                ..add(r'locality')
                ..add(serializers.serialize(object.locality,
                    specifiedType: const FullType(String)));
        }
        if (object.speciesId != null) {
            result
                ..add(r'species_id')
                ..add(serializers.serialize(object.speciesId,
                    specifiedType: const FullType(int)));
        }
        if (object.observerId != null) {
            result
                ..add(r'observer_id')
                ..add(serializers.serialize(object.observerId,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    GbifObservation deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GbifObservationBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'gbifid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.gbifid = valueDes;
                    break;
                case r'datecreated':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.datecreated = valueDes;
                    break;
                case r'latitude':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.latitude = valueDes;
                    break;
                case r'longitude':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.longitude = valueDes;
                    break;
                case r'public':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.public = valueDes;
                    break;
                case r'acces_rights':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.accesRights = valueDes;
                    break;
                case r'rights_holder':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.rightsHolder = valueDes;
                    break;
                case r'recorded_by':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.recordedBy = valueDes;
                    break;
                case r'license':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.license = valueDes;
                    break;
                case r'countrycode':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.countrycode = valueDes;
                    break;
                case r'state_province':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.stateProvince = valueDes;
                    break;
                case r'county':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.county = valueDes;
                    break;
                case r'municipality':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.municipality = valueDes;
                    break;
                case r'locality':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.locality = valueDes;
                    break;
                case r'species_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.speciesId = valueDes;
                    break;
                case r'observer_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.observerId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

