# Encapsulation Through Stable Contracts

A component exposes a contract and hides everything behind it. What is public
is a promise; what is private is free to change. The promise is the unit of
compatibility, not the code.

## Why it holds

Every internal detail that leaks becomes something you cannot change without
coordination. Callers bind to whatever they can see — a field name, a table, an
error string, a response's incidental ordering — and once they have, that
detail is part of the contract whether it was meant to be or not. Encapsulation
is how a team keeps the right to refactor.

## In practice

- Publish the narrowest contract that serves the caller's need. A method that
  returns the whole record because it was easier has published the record.
- Treat error shapes, status codes and ordering as part of the contract. They
  are the parts callers depend on without saying so.
- Version the contract, not the implementation, and keep old versions working
  for a stated window.
- Additive change first: adding an optional field is compatible, removing or
  re-meaning one is not.
- Let the contract be the *only* way in. A back door for one privileged caller
  is a contract with an undocumented second half.

## How to tell it is being violated

- A change to a private data structure breaks a consumer's test.
- Callers construct requests by copying an example rather than reading a schema.
- "Just this once" direct access — to a table, a cache, an internal queue — has
  a name in someone's code.
- You cannot rename an internal field without a migration plan.

## Pass

**Look for** — imports that reach past a package's public surface (deep paths
into `internal`, `impl`, `_private`); callers touching fields the owner treats
as private; functions returning a whole record because it was easier, where the
caller needs two fields; call sites depending on an error string, a status code
or an incidental ordering; a "just this once" direct read of another
component's table, cache or queue.

**Safe fix** — narrow inward. Give the module an explicit public surface
(`__all__`, an index or barrel file, an exported interface) and route the
repo's own callers through it. Adding a narrower accessor beside a wide one is
additive and safe; removing the wide one is not.

**Stop at** — removing or re-meaning anything reachable from outside the repo,
changing an error shape, status code or ordering, or versioning a published
contract. Those need a caller inventory and a window.
