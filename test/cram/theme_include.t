Theme include: child theme inherits parent colors and rules

  $ cat > parent.json <<'EOF'
  > {
  >   "name": "parent",
  >   "colors": {
  >     "editor.foreground": "#111111",
  >     "editor.background": "#eeeeee"
  >   },
  >   "tokenColors": [
  >     { "scope": "comment", "settings": { "foreground": "#888888" } }
  >   ]
  > }
  > EOF
  $ cat > child.json <<'EOF'
  > {
  >   "name": "child",
  >   "include": "./parent.json",
  >   "colors": {
  >     "editor.foreground": "#222222"
  >   },
  >   "tokenColors": [
  >     { "scope": "keyword", "settings": { "foreground": "#ff0000" } }
  >   ]
  > }
  > EOF
  $ ./test_theme.exe load-file child.json
  name: child
  fg: #222222
  bg: #eeeeee
  rules: 2
    scopes: [comment]
    fg: #888888
    scopes: [keyword]
    fg: #ff0000

Include chains resolve transitively

  $ cat > grandchild.json <<'EOF'
  > {
  >   "include": "./child.json",
  >   "tokenColors": [
  >     { "scope": "string", "settings": { "foreground": "#00ff00" } }
  >   ]
  > }
  > EOF
  $ ./test_theme.exe load-file grandchild.json
  name: child
  fg: #222222
  bg: #eeeeee
  rules: 3
    scopes: [comment]
    fg: #888888
    scopes: [keyword]
    fg: #ff0000
    scopes: [string]
    fg: #00ff00

Include cycles are rejected

  $ cat > a.json <<'EOF'
  > { "name": "a", "include": "./b.json" }
  > EOF
  $ cat > b.json <<'EOF'
  > { "name": "b", "include": "./a.json" }
  > EOF
  $ ./test_theme.exe load-file a.json
  error: Theme include cycle detected at: a.json
  [1]

Missing include target errors

  $ cat > broken.json <<'EOF'
  > { "name": "broken", "include": "./does-not-exist.json" }
  > EOF
  $ ./test_theme.exe load-file broken.json
  error: Sys_error("does-not-exist.json: No such file or directory")
  [1]
