.DEFAULT_GOAL := parser.so

tsrepo = tree-sitter-javascript
tree-sitter = node_modules/.bin/tree-sitter

$(tsrepo):
	git clone \
		--branch v0.19.0 \
		--depth 1 \
		https://github.com/tree-sitter/tree-sitter-javascript.git \
		$(tsrepo)
	rm -rf $@/.git

$(tree-sitter):
	npm install tree-sitter-cli

$(tsrepo)/src/parser.c: $(tree-sitter) $(tsrepo)
	cd $(tsrepo) && $< generate

parser.so: $(tsrepo)/src/parser.c $(tsrepo)/src/scanner.c
	# -o: output,
	# -I: add to search path for include files
	# -lstdc++: link stdc++ library
	# -Os: optimisation
	# -shared: create shared object (.so)
	cc -o $@ -I./$(tsrepo)/src -lstdc++ -Os -shared $^

# File already exists in repo.
.PHONY: $(tsrepo)/src/scanner.c
