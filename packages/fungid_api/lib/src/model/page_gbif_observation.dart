//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:fungid_api/src/model/gbif_observation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_gbif_observation.g.dart';

/// PageGbifObservation
///
/// Properties:
/// * [items] 
/// * [total] 
/// * [page] 
/// * [size] 
abstract class PageGbifObservation implements Built<PageGbifObservation, PageGbifObservationBuilder> {
    @BuiltValueField(wireName: r'items')
    BuiltList<GbifObservation> get items;

    @BuiltValueField(wireName: r'total')
    int get total;

    @BuiltValueField(wireName: r'page')
    int get page;

    @BuiltValueField(wireName: r'size')
    int get size;

    PageGbifObservation._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PageGbifObservationBuilder b) => b;

    factory PageGbifObservation([void updates(PageGbifObservationBuilder b)]) = _$PageGbifObservation;

    @BuiltValueSerializer(custom: true)
    static Serializer<PageGbifObservation> get serializer => _$PageGbifObservationSerializer();
}

class _$PageGbifObservationSerializer implements StructuredSerializer<PageGbifObservation> {
    @override
    final Iterable<Type> types = const [PageGbifObservation, _$PageGbifObservation];

    @override
    final String wireName = r'PageGbifObservation';

    @override
    Iterable<Object?> serialize(Serializers serializers, PageGbifObservation object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'items')
            ..add(serializers.serialize(object.items,
                specifiedType: const FullType(BuiltList, [FullType(GbifObservation)])));
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
    PageGbifObservation deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PageGbifObservationBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'items':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(GbifObservation)])) as BuiltList<GbifObservation>;
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

