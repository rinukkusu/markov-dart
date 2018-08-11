// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of markov_dart;

class ChainState<T> {
  List<T> _items;

  ChainState(Iterable<T> items) {
    if (items == null) {
      throw new ArgumentError.notNull('items');
    }

    _items = new List<T>.from(items);
  }

  @override
  int get hashCode {
    var code = _items.length.hashCode;

    for (int i = 0; i < _items.length; i++) {
      code ^= _items[i].hashCode;
    }

    return code;
  }

  @override
  bool operator == (other) {
    if (other == null) return false;

    if (this._items.length != other._items.length) return false;

    return this.hashCode == other.hashCode;
  }

  @override
  String toString() {
    return "State($_items)";
  }
}
