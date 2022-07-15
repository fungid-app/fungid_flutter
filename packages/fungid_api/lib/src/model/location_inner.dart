//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'location_inner.g.dart';

/// LocationInner
abstract class LocationInner implements Built<LocationInner, LocationInnerBuilder> {
    LocationInner._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(LocationInnerBuilder b) => b;

    factory LocationInner([void updates(LocationInnerBuilder b)]) = _$LocationInner;

    @BuiltValueSerializer(custom: true)
    static Serializer<LocationInner> get serializer => _$LocationInnerSerializer();
}

class _$LocationInnerSerializer implements StructuredSerializer<LocationInner> {
    @override
    final Iterable<Type> types = const [LocationInner, _$LocationInner];

    @override
    final String wireName = r'LocationInner';

    @override
    Iterable<Object?> serialize(Serializers serializers, LocationInner object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        return result;
    }

    @override
    LocationInner deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = LocationInnerBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
            }
        }
        return result.build();
    }
}

