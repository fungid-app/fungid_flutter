//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'full_prediction.g.dart';

/// FullPrediction
///
/// Properties:
/// * [species] 
/// * [probability] 
/// * [localProbability] 
/// * [imageScore] 
/// * [tabScore] 
/// * [localScore] 
/// * [isLocal] 
abstract class FullPrediction implements Built<FullPrediction, FullPredictionBuilder> {
    @BuiltValueField(wireName: r'species')
    String get species;

    @BuiltValueField(wireName: r'probability')
    num get probability;

    @BuiltValueField(wireName: r'local_probability')
    num get localProbability;

    @BuiltValueField(wireName: r'image_score')
    num get imageScore;

    @BuiltValueField(wireName: r'tab_score')
    num get tabScore;

    @BuiltValueField(wireName: r'local_score')
    num get localScore;

    @BuiltValueField(wireName: r'is_local')
    bool get isLocal;

    FullPrediction._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FullPredictionBuilder b) => b;

    factory FullPrediction([void updates(FullPredictionBuilder b)]) = _$FullPrediction;

    @BuiltValueSerializer(custom: true)
    static Serializer<FullPrediction> get serializer => _$FullPredictionSerializer();
}

class _$FullPredictionSerializer implements StructuredSerializer<FullPrediction> {
    @override
    final Iterable<Type> types = const [FullPrediction, _$FullPrediction];

    @override
    final String wireName = r'FullPrediction';

    @override
    Iterable<Object?> serialize(Serializers serializers, FullPrediction object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'species')
            ..add(serializers.serialize(object.species,
                specifiedType: const FullType(String)));
        result
            ..add(r'probability')
            ..add(serializers.serialize(object.probability,
                specifiedType: const FullType(num)));
        result
            ..add(r'local_probability')
            ..add(serializers.serialize(object.localProbability,
                specifiedType: const FullType(num)));
        result
            ..add(r'image_score')
            ..add(serializers.serialize(object.imageScore,
                specifiedType: const FullType(num)));
        result
            ..add(r'tab_score')
            ..add(serializers.serialize(object.tabScore,
                specifiedType: const FullType(num)));
        result
            ..add(r'local_score')
            ..add(serializers.serialize(object.localScore,
                specifiedType: const FullType(num)));
        result
            ..add(r'is_local')
            ..add(serializers.serialize(object.isLocal,
                specifiedType: const FullType(bool)));
        return result;
    }

    @override
    FullPrediction deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FullPredictionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'species':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.species = valueDes;
                    break;
                case r'probability':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.probability = valueDes;
                    break;
                case r'local_probability':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.localProbability = valueDes;
                    break;
                case r'image_score':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.imageScore = valueDes;
                    break;
                case r'tab_score':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.tabScore = valueDes;
                    break;
                case r'local_score':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(num)) as num;
                    result.localScore = valueDes;
                    break;
                case r'is_local':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(bool)) as bool;
                    result.isLocal = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

