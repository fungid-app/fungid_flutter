// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Species extends Species {
  @override
  final int id;
  @override
  final String? phylum;
  @override
  final String? classname;
  @override
  final String? order;
  @override
  final String? family;
  @override
  final String? genus;
  @override
  final String? species;
  @override
  final String? description;
  @override
  final bool? includedInClassifier;
  @override
  final int? numberOfObservations;

  factory _$Species([void Function(SpeciesBuilder)? updates]) =>
      (new SpeciesBuilder()..update(updates))._build();

  _$Species._(
      {required this.id,
      this.phylum,
      this.classname,
      this.order,
      this.family,
      this.genus,
      this.species,
      this.description,
      this.includedInClassifier,
      this.numberOfObservations})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Species', 'id');
  }

  @override
  Species rebuild(void Function(SpeciesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SpeciesBuilder toBuilder() => new SpeciesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Species &&
        id == other.id &&
        phylum == other.phylum &&
        classname == other.classname &&
        order == other.order &&
        family == other.family &&
        genus == other.genus &&
        species == other.species &&
        description == other.description &&
        includedInClassifier == other.includedInClassifier &&
        numberOfObservations == other.numberOfObservations;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, id.hashCode), phylum.hashCode),
                                    classname.hashCode),
                                order.hashCode),
                            family.hashCode),
                        genus.hashCode),
                    species.hashCode),
                description.hashCode),
            includedInClassifier.hashCode),
        numberOfObservations.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Species')
          ..add('id', id)
          ..add('phylum', phylum)
          ..add('classname', classname)
          ..add('order', order)
          ..add('family', family)
          ..add('genus', genus)
          ..add('species', species)
          ..add('description', description)
          ..add('includedInClassifier', includedInClassifier)
          ..add('numberOfObservations', numberOfObservations))
        .toString();
  }
}

class SpeciesBuilder implements Builder<Species, SpeciesBuilder> {
  _$Species? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _phylum;
  String? get phylum => _$this._phylum;
  set phylum(String? phylum) => _$this._phylum = phylum;

  String? _classname;
  String? get classname => _$this._classname;
  set classname(String? classname) => _$this._classname = classname;

  String? _order;
  String? get order => _$this._order;
  set order(String? order) => _$this._order = order;

  String? _family;
  String? get family => _$this._family;
  set family(String? family) => _$this._family = family;

  String? _genus;
  String? get genus => _$this._genus;
  set genus(String? genus) => _$this._genus = genus;

  String? _species;
  String? get species => _$this._species;
  set species(String? species) => _$this._species = species;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _includedInClassifier;
  bool? get includedInClassifier => _$this._includedInClassifier;
  set includedInClassifier(bool? includedInClassifier) =>
      _$this._includedInClassifier = includedInClassifier;

  int? _numberOfObservations;
  int? get numberOfObservations => _$this._numberOfObservations;
  set numberOfObservations(int? numberOfObservations) =>
      _$this._numberOfObservations = numberOfObservations;

  SpeciesBuilder() {
    Species._defaults(this);
  }

  SpeciesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _phylum = $v.phylum;
      _classname = $v.classname;
      _order = $v.order;
      _family = $v.family;
      _genus = $v.genus;
      _species = $v.species;
      _description = $v.description;
      _includedInClassifier = $v.includedInClassifier;
      _numberOfObservations = $v.numberOfObservations;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Species other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Species;
  }

  @override
  void update(void Function(SpeciesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Species build() => _build();

  _$Species _build() {
    final _$result = _$v ??
        new _$Species._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Species', 'id'),
            phylum: phylum,
            classname: classname,
            order: order,
            family: family,
            genus: genus,
            species: species,
            description: description,
            includedInClassifier: includedInClassifier,
            numberOfObservations: numberOfObservations);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
