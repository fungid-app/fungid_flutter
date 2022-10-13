//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'basic_prediction.g.dart';

/// BasicPrediction
///
/// Properties:
/// * [species] 
/// * [probability] 
abstract class BasicPrediction implements Built<BasicPrediction, BasicPredictionBuilder> {
    @BuiltValueField(wireName: r'species')
    String get species;

    @BuiltValueField(wireName: r'probability')
    num get probability;

    BasicPrediction._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(BasicPredictionBuilder b) => b;

    factory BasicPrediction([void updates(BasicPredictionBuilder b)]) = _$BasicPrediction;

    @BuiltValueSerializer(custom: true)
    static Serializer<BasicPrediction> get serializer => _$BasicPredictionSerializer();
}

class _$BasicPredictionSerializer implements StructuredSerializer<BasicPrediction> {
    @override
    final Iterable<Type> types = const [BasicPrediction, _$BasicPrediction];

    @override
    final String wireName = r'BasicPrediction';

    @override
    Iterable<Object?> serialize(Serializers serializers, BasicPrediction object,
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
        return result;
    }

    @override
    BasicPrediction deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = BasicPredictionBuilder();

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
            }
        }
        return result.build();
    }
}

