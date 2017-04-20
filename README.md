# markov_dart

A dart library for creating markov chains inspired by [otac0n/markov][original].

## Usage

A simple usage example:

```dart
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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/markov-dart/issues
[original]: https://github.com/otac0n/markov