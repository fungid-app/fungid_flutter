//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_collection/built_collection.dart';
import 'package:fungid_api/src/model/species.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_species.g.dart';

/// PageSpecies
///
/// Properties:
/// * [items] 
/// * [total] 
/// * [page] 
/// * [size] 
abstract class PageSpecies implements Built<PageSpecies, PageSpeciesBuilder> {
    @BuiltValueField(wireName: r'items')
    BuiltList<Species> get items;

    @BuiltValueField(wireName: r'total')
    int get total;

    @BuiltValueField(wireName: r'page')
    int get page;

    @BuiltValueField(wireName: r'size')
    int get size;

    PageSpecies._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(PageSpeciesBuilder b) => b;

    factory PageSpecies([void updates(PageSpeciesBuilder b)]) = _$PageSpecies;

    @BuiltValueSerializer(custom: true)
    static Serializer<PageSpecies> get serializer => _$PageSpeciesSerializer();
}

class _$PageSpeciesSerializer implements StructuredSerializer<PageSpecies> {
    @override
    final Iterable<Type> types = const [PageSpecies, _$PageSpecies];

    @override
    final String wireName = r'PageSpecies';

    @override
    Iterable<Object?> serialize(Serializers serializers, PageSpecies object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'items')
            ..add(serializers.serialize(object.items,
                specifiedType: const FullType(BuiltList, [FullType(Species)])));
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
    PageSpecies deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = PageSpeciesBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'items':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(BuiltList, [FullType(Species)])) as BuiltList<Species>;
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

