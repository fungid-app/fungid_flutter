//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'gbif_observation_image.g.dart';

/// GbifObservationImage
///
/// Properties:
/// * [id] 
/// * [imgid] 
/// * [externalUrl] 
/// * [rightsHolder] 
/// * [creator] 
/// * [license] 
/// * [isThumbnail] 
/// * [observationId] 
abstract class GbifObservationImage implements Built<GbifObservationImage, GbifObservationImageBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'imgid')
    int? get imgid;

    @BuiltValueField(wireName: r'external_url')
    String? get externalUrl;

    @BuiltValueField(wireName: r'rights_holder')
    String? get rightsHolder;

    @BuiltValueField(wireName: r'creator')
    String? get creator;

    @BuiltValueField(wireName: r'license')
    String? get license;

    @BuiltValueField(wireName: r'is_thumbnail')
    bool? get isThumbnail;

    @BuiltValueField(wireName: r'observation_id')
    int? get observationId;

    GbifObservationImage._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(GbifObservationImageBuilder b) => b
        ..isThumbnail = false;

    factory GbifObservationImage([void updates(GbifObservationImageBuilder b)]) = _$GbifObservationImage;

    @BuiltValueSerializer(custom: true)
    static Serializer<GbifObservationImage> get serializer => _$GbifObservationImageSerializer();
}

class _$GbifObservationImageSerializer implements StructuredSerializer<GbifObservationImage> {
    @override
    final Iterable<Type> types = const [GbifObservationImage, _$GbifObservationImage];

    @override
    final String wireName = r'GbifObservationImage';

    @override
    Iterable<Object?> serialize(Serializers serializers, GbifObservationImage object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        if (object.imgid != null) {
            result
                ..add(r'imgid')
                ..add(serializers.serialize(object.imgid,
                    specifiedType: const FullType(int)));
        }
        if (object.externalUrl != null) {
            result
                ..add(r'external_url')
                ..add(serializers.serialize(object.externalUrl,
                    specifiedType: const FullType(String)));
        }
        if (object.rightsHolder != null) {
            result
                ..add(r'rights_holder')
                ..add(serializers.serialize(object.rightsHolder,
                    specifiedType: const FullType(String)));
        }
        if (object.creator != null) {
            result
                ..add(r'creator')
                ..add(serializers.serialize(object.creator,
                    specifiedType: const FullType(String)));
        }
        if (object.license != null) {
            result
                ..add(r'license')
                ..add(serializers.serialize(object.license,
                    specifiedType: const FullType(String)));
        }
        if (object.isThumbnail != null) {
            result
                ..add(r'is_thumbnail')
                ..add(serializers.serialize(object.isThumbnail,
                    specifiedType: const FullType(bool)));
        }
        if (object.observationId != null) {
            result
                ..add(r'observation_id')
                ..add(serializers.serialize(object.observationId,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    GbifObservationImage deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = GbifObservationImageBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.id = valueDes;
                    break;
                case r'imgid':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.imgid = valueDes;
                    break;
                case r'external_url':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.externalUrl = valueDes;
                    break;
                case r'rights_holder':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.rightsHolder = valueDes;
                    break;
                case r'creator':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.creator = valueDes;
                    break;
                case r'license':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.license = valueDes;
                    break;
                case r'is_thumbnail':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isThumbnail = valueDes;
                    break;
                case r'observation_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.observationId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

