//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:fungid_api/src/model/basic_prediction.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_basic_prediction.g.dart';

/// PageBasicPrediction
///
/// Properties:
/// * [items] 
/// * [total] 
/// * [page] 
/// * [size] 
abstract class PageBasicPrediction implements Built<PageBasicPrediction, PageBasicPredictionBuilder> {
    @BuiltValueField(wireName: r'items')
    BuiltList<BasicPrediction> get items;

    @BuiltValueField(wireName: r'total')
    int get total;

    @BuiltValueField(wireName: r'page')
    int get page;

    @BuiltValueField(wireName: r'size')
    int get size;

    PageBasicPrediction._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PageBasicPredictionBuilder b) => b;

    factory PageBasicPrediction([void updates(PageBasicPredictionBuilder b)]) = _$PageBasicPrediction;

    @BuiltValueSerializer(custom: true)
    static Serializer<PageBasicPrediction> get serializer => _$PageBasicPredictionSerializer();
}

class _$PageBasicPredictionSerializer implements StructuredSerializer<PageBasicPrediction> {
    @override
    final Iterable<Type> types = const [PageBasicPrediction, _$PageBasicPrediction];

    @override
    final String wireName = r'PageBasicPrediction';

    @override
    Iterable<Object?> serialize(Serializers serializers, PageBasicPrediction object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'items')
            ..add(serializers.serialize(object.items,
                specifiedType: const FullType(BuiltList, [FullType(BasicPrediction)])));
        result
            ..add(r'total')
            ..add(serializers.serialize(object.total,
                specifiedType: const FullType(int)));
        result
            ..add(r'page')
            ..add(serializers.serialize(object.page,
                specifiedType: const FullType(int)));
        result
            ..add(r'size')
            ..add(serializers.serialize(object.size,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    PageBasicPrediction deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PageBasicPredictionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'items':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(BasicPrediction)])) as BuiltList<BasicPrediction>;
                    result.items.replace(valueDes);
                    break;
                case r'total':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.total = valueDes;
                    break;
                case r'page':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.page = valueDes;
                    break;
                case r'size':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.size = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

