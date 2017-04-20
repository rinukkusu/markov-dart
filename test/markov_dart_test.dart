// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:markov_dart/markov_dart.dart';
import 'package:test/test.dart';

void main() {
  var items = [
    ["test1", "test2", "test3"],
    ["test1", "test2", "test3"]
  ];

  group('Order 1 Tests:', () {
    MarkovChain<String> _chain;

    setUp(() {
      _chain = new MarkovChain(1);
    });

    test('Test 1', () {
      _chain.add(items[0]);

      expect(_chain.getNextStates([items[0][0]]).keys.first, items[0][1]);
    });

    test('Test 2', () {
      _chain.add(items[0]);
      _chain.add(items[1]);

      var nextStates = _chain.getNextStates([items[0][1]]);
      expect(nextStates.keys.first, items[0][2]);
    });
  });

  group('Order 2 Tests:', () {
    MarkovChain<String> _chain;

    setUp(() {
      _chain = new MarkovChain(2);
    });

    test('Test 1', () {
      _chain.add(items[0]);

      expect(_chain.getNextStates([items[0][0], items[0][1]]).keys.first,
          items[0][2]);
    });

    test('Test 2', () {
      _chain.add(items[0]);

      expect(_chain.getNextStates([items[0][1]]), null);
    });
  });
}
