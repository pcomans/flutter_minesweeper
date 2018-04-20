typedef T MappingFun<T>(elem, idx);
Iterable<T> mapWithIndex<T>(Iterable it, MappingFun<T> f) {
  int i = 0;
  return it.map((elem) => f(elem, i++));
}
