Iterable<T> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
  final ita = a.iterator;
  final itb = b.iterator;
  bool hasa, hasb;
  while ((hasa = ita.moveNext()) | (hasb = itb.moveNext())) {
    if (hasa) yield ita.current;
    if (hasb) yield itb.current;
  }
}
