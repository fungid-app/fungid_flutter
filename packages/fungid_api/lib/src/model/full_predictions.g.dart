// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_predictions.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FullPredictions extends FullPredictions {
  @override
  final BuiltList<FullPrediction> predictions;
  @override
  final DateTime date;
  @override
  final InferredData inferred;

  factory _$FullPredictions([void Function(FullPredictionsBuilder)? updates]) =>
      (new FullPredictionsBuilder()..update(updates))._build();

  _$FullPredictions._(
      {required this.predictions, required this.date, required this.inferred})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        predictions, r'FullPredictions', 'predictions');
    BuiltValueNullFieldError.checkNotNull(date, r'FullPredictions', 'date');
    BuiltValueNullFieldError.checkNotNull(
        inferred, r'FullPredictions', 'inferred');
  }

  @override
  FullPredictions rebuild(void Function(FullPredictionsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FullPredictionsBuilder toBuilder() =>
      new FullPredictionsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FullPredictions &&
        predictions == other.predictions &&
        date == other.date &&
        inferred == other.inferred;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, predictions.hashCode), date.hashCode), inferred.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FullPredictions')
          ..add('predictions', predictions)
          ..add('date', date)
          ..add('inferred', inferred))
        .toString();
  }
}

class FullPredictionsBuilder
    implements Builder<FullPredictions, FullPredictionsBuilder> {
  _$FullPredictions? _$v;

  ListBuilder<FullPrediction>? _predictions;
  ListBuilder<FullPrediction> get predictions =>
      _$this._predictions ??= new ListBuilder<FullPrediction>();
  set predictions(ListBuilder<FullPrediction>? predictions) =>
      _$this._predictions = predictions;

  DateTime? _date;
  DateTime? get date => _$this._date;
  set date(DateTime? date) => _$this._date = date;

  InferredDataBuilder? _inferred;
  InferredDataBuilder get inferred =>
      _$this._inferred ??= new InferredDataBuilder();
  set inferred(InferredDataBuilder? inferred) => _$this._inferred = inferred;

  FullPredictionsBuilder() {
    FullPredictions._defaults(this);
  }

  FullPredictionsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _predictions = $v.predictions.toBuilder();
      _date = $v.date;
      _inferred = $v.inferred.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FullPredictions other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FullPredictions;
  }

  @override
  void update(void Function(FullPredictionsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FullPredictions build() => _build();

  _$FullPredictions _build() {
    _$FullPredictions _$result;
    try {
      _$result = _$v ??
          new _$FullPredictions._(
              predictions: predictions.build(),
              date: BuiltValueNullFieldError.checkNotNull(
                  date, r'FullPredictions', 'date'),
              inferred: inferred.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'predictions';
        predictions.build();

        _$failedField = 'inferred';
        inferred.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'FullPredictions', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
