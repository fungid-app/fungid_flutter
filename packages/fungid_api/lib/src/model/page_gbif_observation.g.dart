// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_gbif_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageGbifObservation extends PageGbifObservation {
  @override
  final BuiltList<GbifObservation> items;
  @override
  final int total;
  @override
  final int page;
  @override
  final int size;

  factory _$PageGbifObservation(
          [void Function(PageGbifObservationBuilder)? updates]) =>
      (new PageGbifObservationBuilder()..update(updates))._build();

  _$PageGbifObservation._(
      {required this.items,
      required this.total,
      required this.page,
      required this.size})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        items, r'PageGbifObservation', 'items');
    BuiltValueNullFieldError.checkNotNull(
        total, r'PageGbifObservation', 'total');
    BuiltValueNullFieldError.checkNotNull(page, r'PageGbifObservation', 'page');
    BuiltValueNullFieldError.checkNotNull(size, r'PageGbifObservation', 'size');
  }

  @override
  PageGbifObservation rebuild(
          void Function(PageGbifObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageGbifObservationBuilder toBuilder() =>
      new PageGbifObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageGbifObservation &&
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
    return (newBuiltValueToStringHelper(r'PageGbifObservation')
          ..add('items', items)
          ..add('total', total)
          ..add('page', page)
          ..add('size', size))
        .toString();
  }
}

class PageGbifObservationBuilder
    implements Builder<PageGbifObservation, PageGbifObservationBuilder> {
  _$PageGbifObservation? _$v;

  ListBuilder<GbifObservation>? _items;
  ListBuilder<GbifObservation> get items =>
      _$this._items ??= new ListBuilder<GbifObservation>();
  set items(ListBuilder<GbifObservation>? items) => _$this._items = items;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  PageGbifObservationBuilder() {
    PageGbifObservation._defaults(this);
  }

  PageGbifObservationBuilder get _$this {
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
  void replace(PageGbifObservation other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PageGbifObservation;
  }

  @override
  void update(void Function(PageGbifObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageGbifObservation build() => _build();

  _$PageGbifObservation _build() {
    _$PageGbifObservation _$result;
    try {
      _$result = _$v ??
          new _$PageGbifObservation._(
              items: items.build(),
              total: BuiltValueNullFieldError.checkNotNull(
                  total, r'PageGbifObservation', 'total'),
              page: BuiltValueNullFieldError.checkNotNull(
                  page, r'PageGbifObservation', 'page'),
              size: BuiltValueNullFieldError.checkNotNull(
                  size, r'PageGbifObservation', 'size'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PageGbifObservation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
