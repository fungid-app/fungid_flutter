//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'classifier_version.g.dart';

/// ClassifierVersion
///
/// Properties:
/// * [version] 
/// * [imageSize] 
abstract class ClassifierVersion implements Built<ClassifierVersion, ClassifierVersionBuilder> {
    @BuiltValueField(wireName: r'version')
    String get version;

    @BuiltValueField(wireName: r'image_size')
    int get imageSize;

    ClassifierVersion._();

    @BuiltValueHook(initializeBuilder: true)
    static void _defaults(ClassifierVersionBuilder b) => b;

    factory ClassifierVersion([void updates(ClassifierVersionBuilder b)]) = _$ClassifierVersion;

    @BuiltValueSerializer(custom: true)
    static Serializer<ClassifierVersion> get serializer => _$ClassifierVersionSerializer();
}

class _$ClassifierVersionSerializer implements StructuredSerializer<ClassifierVersion> {
    @override
    final Iterable<Type> types = const [ClassifierVersion, _$ClassifierVersion];

    @override
    final String wireName = r'ClassifierVersion';

    @override
    Iterable<Object?> serialize(Serializers serializers, ClassifierVersion object,
        {FullType specifiedType = FullType.unspecified}) {
        final result = <Object?>[];
        result
            ..add(r'version')
            ..add(serializers.serialize(object.version,
                specifiedType: const FullType(String)));
        result
            ..add(r'image_size')
            ..add(serializers.serialize(object.imageSize,
                specifiedType: const FullType(int)));
        return result;
    }

    @override
    ClassifierVersion deserialize(Serializers serializers, Iterable<Object?> serialized,
        {FullType specifiedType = FullType.unspecified}) {
        final result = ClassifierVersionBuilder();

        final iterator = serialized.iterator;
        while (iterator.moveNext()) {
            final key = iterator.current as String;
            iterator.moveNext();
            final Object? value = iterator.current;
            
            switch (key) {
                case r'version':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(String)) as String;
                    result.version = valueDes;
                    break;
                case r'image_size':
                    final valueDes = serializers.deserialize(value,
                        specifiedType: const FullType(int)) as int;
                    result.imageSize = valueDes;
                    break;
            }
        }
        return result.build();
    }
}

