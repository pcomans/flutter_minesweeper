int getIdxFromCoords(int x, int y, int numColumns) {
  return y * numColumns + x;
}

List<int> getCoordsFromIdx(index, numColumns) {
  int x = index % numColumns;
  int y = index ~/ numColumns;

  return [x, y];
}

List<int> getNeighborIdxs(int idx, int numRows, int numColumns) {
  List<int> neighborIdxs = [];
  List<int> coords = getCoordsFromIdx(idx, numColumns);
  int x = coords[0];
  int y = coords[1];

  if (x > 0 && y > 0) {
    neighborIdxs.add(getIdxFromCoords(x - 1, y - 1, numColumns));
  }
  if (x < numColumns - 1 && y < numRows - 1) {
    neighborIdxs.add(getIdxFromCoords(x + 1, y + 1, numColumns));
  }
  if (x > 0) {
    neighborIdxs.add(getIdxFromCoords(x - 1, y, numColumns));
    if (y < numRows - 1) {
      neighborIdxs.add(getIdxFromCoords(x - 1, y + 1, numColumns));
    }
  }
  if (y > 0) {
    neighborIdxs.add(getIdxFromCoords(x, y - 1, numColumns));
    if (x < numColumns - 1) {
      neighborIdxs.add(getIdxFromCoords(x + 1, y - 1, numColumns));
    }
  }
  if (x < numColumns - 1) {
    neighborIdxs.add(getIdxFromCoords(x + 1, y, numColumns));
  }
  if (y < numRows - 1) {
    neighborIdxs.add(getIdxFromCoords(x, y + 1, numColumns));
  }
  return neighborIdxs;
}
