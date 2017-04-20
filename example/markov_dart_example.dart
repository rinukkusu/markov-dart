// Copyright (c) 2017, 'rinukkusu'. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:markov_dart/markov_dart.dart';

main() {
  var _chain = new MarkovChain<String>(1);

  var items = [
    ["This", "is", "a", "simple", "markov", "chain"],
    ["This", "is", "some", "simple", "magic"],
    ["This", "is", "a", "wild", "ride"]
  ];

  _chain.add(items[0]);
  _chain.add(items[1]);
  _chain.add(items[2]);

  print(_chain.chain(["This"]));

  // generated examples:
  // (is, some, simple, markov, chain)
  // (is, a, simple, magic)
  // (is, a, wild, ride)
}
