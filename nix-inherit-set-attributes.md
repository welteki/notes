---
date: 2021-07-07T17:55
---

# Inheriting attributes from a set
```nix
inherit (src-set) a b c;
```
is equivalent to
```nix
a = src-set.a; b = src-set.b; c = src-set.c;
```
when used while defining local variables in a let-expression or while defining a set.

It is good practice to use this technique instead of using the with expression because it does not bring all the attributes in a set into scope.

> Note: the [nix.dev also mentions this](https://nix.dev/anti-patterns/language#with-attrset-expression).
