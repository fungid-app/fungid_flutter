//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'species.g.dart';

/// Species
///
/// Properties:
/// * [id] 
/// * [phylum] 
/// * [classname] 
/// * [order] 
/// * [family] 
/// * [genus] 
/// * [species] 
/// * [description] 
/// * [includedInClassifier] 
/// * [numberOfObservations] 
abstract class Species implements Built<Species, SpeciesBuilder> {
    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'phylum')
    String? get phylum;

    @BuiltValueField(wireName: r'classname')
    String? get classname;

    @BuiltValueField(wireName: r'order')
    String? get order;

    @BuiltValueField(wireName: r'family')
    String? get family;

    @BuiltValueField(wireName: r'genus')
    String? get genus;

    @BuiltValueField(wireName: r'species')
    String? get species;

    @BuiltValueField(wireName: r'description')
    String? get description;

    @BuiltValueField(wireName: r'included_in_classifier')
    bool? get includedInClassifier;

    @BuiltValueField(wireName: r'number_of_observations')
    int? get numberOfObservations;

    Species._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(SpeciesBuilder b) => b
        ..includedInClassifier = false;

    factory Species([void updates(SpeciesBuilder b)]) = _$Species;

    @BuiltValueSerializer(custom: true)
    static Serializer<Species> get serializer => _$SpeciesSerializer();
}

class _$SpeciesSerializer implements StructuredSerializer<Species> {
    @override
    final Iterable<Type> types = const [Species, _$Species];

    @override
    final String wireName = r'Species';

    @override
    Iterable<Object?> serialize(Serializers serializers, Species object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        if (object.phylum != null) {
            result
                ..add(r'phylum')
                ..add(serializers.serialize(object.phylum,
                    specifiedType: const FullType(String)));
        }
        if (object.classname != null) {
            result
                ..add(r'classname')
                ..add(serializers.serialize(object.classname,
                    specifiedType: const FullType(String)));
        }
        if (object.order != null) {
            result
                ..add(r'order')
                ..add(serializers.serialize(object.order,
                    specifiedType: const FullType(String)));
        }
        if (object.family != null) {
            result
                ..add(r'family')
                ..add(serializers.serialize(object.family,
                    specifiedType: const FullType(String)));
        }
        if (object.genus != null) {
            result
                ..add(r'genus')
                ..add(serializers.serialize(object.genus,
                    specifiedType: const FullType(String)));
        }
        if (object.species != null) {
            result
                ..add(r'species')
                ..add(serializers.serialize(object.species,
                    specifiedType: const FullType(String)));
        }
        if (object.description != null) {
            result
                ..add(r'description')
                ..add(serializers.serialize(object.description,
                    specifiedType: const FullType(String)));
        }
        if (object.includedInClassifier != null) {
            result
                ..add(r'included_in_classifier')
                ..add(serializers.serialize(object.includedInClassifier,
                    specifiedType: const FullType(bool)));
        }
        if (object.numberOfObservations != null) {
            result
                ..add(r'number_of_observations')
                ..add(serializers.serialize(object.numberOfObservations,
                    specifiedType: const FullType(int)));
        }
        return result;
    }

    @override
    Species deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = SpeciesBuilder();

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
                case r'phylum':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.phylum = valueDes;
                    break;
                case r'classname':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.classname = valueDes;
                    break;
                case r'order':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.order = valueDes;
                    break;
                case r'family':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.family = valueDes;
                    break;
                case r'genus':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.genus = valueDes;
                    break;
                case r'species':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.species = valueDes;
                    break;
                case r'description':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.description = valueDes;
                    break;
                case r'included_in_classifier':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.includedInClassifier = valueDes;
                    break;
                case r'number_of_observations':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.numberOfObservations = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

