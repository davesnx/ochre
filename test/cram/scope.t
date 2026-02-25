Exact scope match
  $ ./test_scope.exe exact
  match (specificity: 12)

Prefix scope match (string.quoted matches string.quoted.double.js)
  $ ./test_scope.exe prefix
  match (specificity: 13)

No match when scope doesn't exist in stack
  $ ./test_scope.exe no-match
  no match

Multi-part selector (source.js variable.parameter)
  $ ./test_scope.exe multi-part
  match (specificity: 27)

Prefix matching respects dot boundaries (string must NOT match stringy)
  $ ./test_scope.exe prefix-boundary
  no match

Longer selectors have higher specificity
  $ ./test_scope.exe specificity
  string: match (specificity: 6)
  string.quoted: match (specificity: 13)
  string.quoted.double: match (specificity: 20)

find_best_match picks the most specific rule
  $ ./test_scope.exe find-best
  fg: #bb0000

Empty scope stack never matches
  $ ./test_scope.exe empty-scopes
  no match
