// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_species.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageSpecies extends PageSpecies {
  @override
  final BuiltList<Species> items;
  @override
  final int total;
  @override
  final int page;
  @override
  final int size;

  factory _$PageSpecies([void Function(PageSpeciesBuilder)? updates]) =>
      (new PageSpeciesBuilder()..update(updates))._build();

  _$PageSpecies._(
      {required this.items,
      required this.total,
      required this.page,
      required this.size})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(items, r'PageSpecies', 'items');
    BuiltValueNullFieldError.checkNotNull(total, r'PageSpecies', 'total');
    BuiltValueNullFieldError.checkNotNull(page, r'PageSpecies', 'page');
    BuiltValueNullFieldError.checkNotNull(size, r'PageSpecies', 'size');
  }

  @override
  PageSpecies rebuild(void Function(PageSpeciesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageSpeciesBuilder toBuilder() => new PageSpeciesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageSpecies &&
        items == other.items &&
        total == other.total &&
        page == other.page &&
        size == other.size;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, items.hashCode), total.hashCode), page.hashCode),
        size.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PageSpecies')
          ..add('items', items)
          ..add('total', total)
          ..add('page', page)
          ..add('size', size))
        .toString();
  }
}

class PageSpeciesBuilder implements Builder<PageSpecies, PageSpeciesBuilder> {
  _$PageSpecies? _$v;

  ListBuilder<Species>? _items;
  ListBuilder<Species> get items =>
      _$this._items ??= new ListBuilder<Species>();
  set items(ListBuilder<Species>? items) => _$this._items = items;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  PageSpeciesBuilder() {
    PageSpecies._defaults(this);
  }

  PageSpeciesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _total = $v.total;
      _page = $v.page;
      _size = $v.size;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageSpecies other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PageSpecies;
  }

  @override
  void update(void Function(PageSpeciesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageSpecies build() => _build();

  _$PageSpecies _build() {
    _$PageSpecies _$result;
    try {
      _$result = _$v ??
          new _$PageSpecies._(
              items: items.build(),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'PageSpecies', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'PageSpecies', 'page'),
              size: BuiltValueNullFieldError.checkNotNull(
                  size, r'PageSpecies', 'size'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PageSpecies', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
