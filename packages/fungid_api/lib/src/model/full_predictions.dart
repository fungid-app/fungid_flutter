//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:fungid_api/src/model/inferred_data.dart';
import 'package:fungid_api/src/model/full_prediction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'full_predictions.g.dart';

/// FullPredictions
///
/// Properties:
/// * [predictions] 
/// * [date] 
/// * [inferred] 
/// * [version] 
abstract class FullPredictions implements Built<FullPredictions, FullPredictionsBuilder> {
    @BuiltValueField(wireName: r'predictions')
    BuiltList<FullPrediction> get predictions;

    @BuiltValueField(wireName: r'date')
    DateTime get date;

    @BuiltValueField(wireName: r'inferred')
    InferredData get inferred;

    @BuiltValueField(wireName: r'version')
    String get version;

    FullPredictions._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(FullPredictionsBuilder b) => b;

    factory FullPredictions([void updates(FullPredictionsBuilder b)]) = _$FullPredictions;

    @BuiltValueSerializer(custom: true)
    static Serializer<FullPredictions> get serializer => _$FullPredictionsSerializer();
}

class _$FullPredictionsSerializer implements StructuredSerializer<FullPredictions> {
    @override
    final Iterable<Type> types = const [FullPredictions, _$FullPredictions];

    @override
    final String wireName = r'FullPredictions';

    @override
    Iterable<Object?> serialize(Serializers serializers, FullPredictions object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'predictions')
            ..add(serializers.serialize(object.predictions,
                specifiedType: const FullType(BuiltList, [FullType(FullPrediction)])));
        result
            ..add(r'date')
            ..add(serializers.serialize(object.date,
                specifiedType: const FullType(DateTime)));
        result
            ..add(r'inferred')
            ..add(serializers.serialize(object.inferred,
                specifiedType: const FullType(InferredData)));
        result
            ..add(r'version')
            ..add(serializers.serialize(object.version,
                specifiedType: const FullType(String)));
        return result;
    }

    @override
    FullPredictions deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = FullPredictionsBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'predictions':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(FullPrediction)])) as BuiltList<FullPrediction>;
                    result.predictions.replace(valueDes);
                    break;
                case r'date':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(DateTime)) as DateTime;
                    result.date = valueDes;
                    break;
                case r'inferred':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(InferredData)) as InferredData;
                    result.inferred.replace(valueDes);
                    break;
                case r'version':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.version = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

