//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'inferred_data.g.dart';

/// InferredData
///
/// Properties:
/// * [normalizedMonth] 
/// * [season] 
/// * [kg] 
/// * [eluClass1] 
/// * [eluClass2] 
/// * [eluClass3] 
abstract class InferredData implements Built<InferredData, InferredDataBuilder> {
    @BuiltValueField(wireName: r'normalized_month')
    int get normalizedMonth;

    @BuiltValueField(wireName: r'season')
    String get season;

    @BuiltValueField(wireName: r'kg')
    int get kg;

    @BuiltValueField(wireName: r'elu_class1')
    String? get eluClass1;

    @BuiltValueField(wireName: r'elu_class2')
    String? get eluClass2;

    @BuiltValueField(wireName: r'elu_class3')
    String? get eluClass3;

    InferredData._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(InferredDataBuilder b) => b;

    factory InferredData([void updates(InferredDataBuilder b)]) = _$InferredData;

    @BuiltValueSerializer(custom: true)
    static Serializer<InferredData> get serializer => _$InferredDataSerializer();
}

class _$InferredDataSerializer implements StructuredSerializer<InferredData> {
    @override
    final Iterable<Type> types = const [InferredData, _$InferredData];

    @override
    final String wireName = r'InferredData';

    @override
    Iterable<Object?> serialize(Serializers serializers, InferredData object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'normalized_month')
            ..add(serializers.serialize(object.normalizedMonth,
                specifiedType: const FullType(int)));
        result
            ..add(r'season')
            ..add(serializers.serialize(object.season,
                specifiedType: const FullType(String)));
        result
            ..add(r'kg')
            ..add(serializers.serialize(object.kg,
                specifiedType: const FullType(int)));
        if (object.eluClass1 != null) {
            result
                ..add(r'elu_class1')
                ..add(serializers.serialize(object.eluClass1,
                    specifiedType: const FullType(String)));
        }
        if (object.eluClass2 != null) {
            result
                ..add(r'elu_class2')
                ..add(serializers.serialize(object.eluClass2,
                    specifiedType: const FullType(String)));
        }
        if (object.eluClass3 != null) {
            result
                ..add(r'elu_class3')
                ..add(serializers.serialize(object.eluClass3,
                    specifiedType: const FullType(String)));
        }
        return result;
    }

    @override
    InferredData deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = InferredDataBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'normalized_month':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.normalizedMonth = valueDes;
                    break;
                case r'season':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.season = valueDes;
                    break;
                case r'kg':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.kg = valueDes;
                    break;
                case r'elu_class1':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eluClass1 = valueDes;
                    break;
                case r'elu_class2':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eluClass2 = valueDes;
                    break;
                case r'elu_class3':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.eluClass3 = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

