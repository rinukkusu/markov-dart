// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of markov_dart;

class MarkovChain<T> {
  int _order;

  final Map<ChainState<T>, Map<T, int>> _items = new Map();
  final Map<ChainState<T>, int> _terminals = new Map();

  MarkovChain(int order) {
    if (order < 0) {
      throw new ArgumentError.value(order, "Out of Range");
    }

    _order = order;
  }

  void add(Iterable<T> items, [int weight = 1]) {
    Queue<T> previous = new Queue<T>();

    items.forEach((item) {
      var key = new ChainState<T>(previous);

      _addState(key, item, weight);

      previous.addLast(item);
      if (previous.length > _order) previous.removeFirst();
    });

    var terminalKey = new ChainState<T>(previous);
    _terminals[terminalKey] = _terminals.containsKey(terminalKey)
        ? weight + _terminals[terminalKey]
        : weight;
  }

  void _addState(ChainState<T> state, T next, [int weight = 1]) {
    Map<T, int> weights;

    if (_items.containsKey(state)) {
      weights = _items[state];
    } else {
      weights = new Map();
      _items[state] = weights;
    }

    weights[next] = weights.containsKey(next) ? weight + weights[next] : weight;
  }

  Map<T, int> getInitialStates() {
    var startState = new ChainState<T>(new Iterable<T>.empty());

    Map<T, int> weights = null;
    if (_items.containsKey(startState)) {
      weights = new Map.from(_items[startState]);
    }

    return weights;
  }

  Map<T, int> getNextStates(Iterable<T> previous) {
    var state = new Queue<T>.from(previous);

    while (state.length > _order) {
      state.removeFirst();
    }

    return _getNextStatesByChainState(new ChainState<T>(state));
  }

  Map<T, int> _getNextStatesByChainState(ChainState<T> state) {
    Map<T, int> weights = null;
    if (_items.containsKey(state)) {
      weights = new Map.from(_items[state]);
    }

    return weights;
  }

  Iterable<T> chain([Iterable<T> previous = const []]) sync* {
    var rand = new Random.secure();

    var state = new Queue<T>.from(previous);
    while (true) {
      while (state.length > _order) {
        state.removeFirst();
      }

      var key = new ChainState<T>(state);

      Map<T, int> weights;
      if (!_items.containsKey(key)) {
        break;
      }

      weights = new Map.from(_items[key]);

      int terminalWeight = 0;
      if (_terminals.containsKey(key)) {
        terminalWeight = _terminals[key];
      }

      var total = weights.values.reduce((value, element) => value + element);
      var value = rand.nextInt(total + terminalWeight) + 1;

      if (value > total) {
        break;
      }

      var currentWeight = 0;
      var keys = weights.keys.toList();
      var values = weights.values.toList();
      for (int i = 0; i < weights.length; i++) {
        currentWeight += values[i];
        if (currentWeight >= value) {
          yield keys[i];
          state.addLast(keys[i]);
          break;
        }
      }
    }
  }

  void debug() {
    print(_items);
    print(_terminals);
  }
}
