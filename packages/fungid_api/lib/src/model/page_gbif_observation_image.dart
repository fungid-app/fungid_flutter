//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:fungid_api/src/model/gbif_observation_image.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_gbif_observation_image.g.dart';

/// PageGbifObservationImage
///
/// Properties:
/// * [items] 
/// * [total] 
/// * [page] 
/// * [size] 
abstract class PageGbifObservationImage implements Built<PageGbifObservationImage, PageGbifObservationImageBuilder> {
    @BuiltValueField(wireName: r'items')
    BuiltList<GbifObservationImage> get items;

    @BuiltValueField(wireName: r'total')
    int get total;

    @BuiltValueField(wireName: r'page')
    int get page;

    @BuiltValueField(wireName: r'size')
    int get size;

    PageGbifObservationImage._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PageGbifObservationImageBuilder b) => b;

    factory PageGbifObservationImage([void updates(PageGbifObservationImageBuilder b)]) = _$PageGbifObservationImage;

    @BuiltValueSerializer(custom: true)
    static Serializer<PageGbifObservationImage> get serializer => _$PageGbifObservationImageSerializer();
}

class _$PageGbifObservationImageSerializer implements StructuredSerializer<PageGbifObservationImage> {
    @override
    final Iterable<Type> types = const [PageGbifObservationImage, _$PageGbifObservationImage];

    @override
    final String wireName = r'PageGbifObservationImage';

    @override
    Iterable<Object?> serialize(Serializers serializers, PageGbifObservationImage object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'items')
            ..add(serializers.serialize(object.items,
                specifiedType: const FullType(BuiltList, [FullType(GbifObservationImage)])));
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
    PageGbifObservationImage deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PageGbifObservationImageBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'items':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(GbifObservationImage)])) as BuiltList<GbifObservationImage>;
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

