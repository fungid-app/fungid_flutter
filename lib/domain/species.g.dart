// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeciesImage _$SpeciesImageFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'SpeciesImage',
      json,
      ($checkedConvert) {
        final val = SpeciesImage(
          gbifid: $checkedConvert('gbifid', (v) => v as int),
          imgid: $checkedConvert('imgid', (v) => v as int),
          rightsHolder: $checkedConvert('rights_holder', (v) => v as String),
          creator: $checkedConvert('creator', (v) => v as String),
          license: $checkedConvert('license', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {'rightsHolder': 'rights_holder'},
    );

Map<String, dynamic> _$SpeciesImageToJson(SpeciesImage instance) =>
    <String, dynamic>{
      'gbifid': instance.gbifid,
      'imgid': instance.imgid,
      'rights_holder': instance.rightsHolder,
      'creator': instance.creator,
      'license': instance.license,
    };
