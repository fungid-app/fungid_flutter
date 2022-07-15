//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'common_name.g.dart';

/// CommonName
///
/// Properties:
/// * [name] 
/// * [language] 
/// * [id] 
/// * [speciesId] 
abstract class CommonName implements Built<CommonName, CommonNameBuilder> {
    @BuiltValueField(wireName: r'name')
    String get name;

    @BuiltValueField(wireName: r'language')
    String? get language;

    @BuiltValueField(wireName: r'id')
    int get id;

    @BuiltValueField(wireName: r'species_id')
    int get speciesId;

    CommonName._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(CommonNameBuilder b) => b;

    factory CommonName([void updates(CommonNameBuilder b)]) = _$CommonName;

    @BuiltValueSerializer(custom: true)
    static Serializer<CommonName> get serializer => _$CommonNameSerializer();
}

class _$CommonNameSerializer implements StructuredSerializer<CommonName> {
    @override
    final Iterable<Type> types = const [CommonName, _$CommonName];

    @override
    final String wireName = r'CommonName';

    @override
    Iterable<Object?> serialize(Serializers serializers, CommonName object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'name')
            ..add(serializers.serialize(object.name,
                specifiedType: const FullType(String)));
        if (object.language != null) {
            result
                ..add(r'language')
                ..add(serializers.serialize(object.language,
                    specifiedType: const FullType(String)));
        }
        result
            ..add(r'id')
            ..add(serializers.serialize(object.id,
                specifiedType: const FullType(int)));
        result
            ..add(r'species_id')
            ..add(serializers.serialize(object.speciesId,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    CommonName deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = CommonNameBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'name':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.name = valueDes;
                    break;
                case r'language':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.language = valueDes;
                    break;
                case r'id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.id = valueDes;
                    break;
                case r'species_id':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.speciesId = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

