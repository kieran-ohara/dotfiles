.DEFAULT_GOAL := message
message:
	# Please specify a *.so target.

# Allow using variable expansion in pre requisites.
.SECONDEXPANSION:

# Prevent make from deleting git repos that are created as intermediate files.
.PRECIOUS: src/%.git

# The repo + tag to build. Default to Javascript Treesitter.
REPO := tree-sitter/tree-sitter-javascript.git
TAG := v0.19.0

# Quick access to tree-sitter CLI.
tree-sitter = node_modules/.bin/tree-sitter

src/%.git:
	git clone \
		--branch $(TAG) \
		--depth 1 \
		https://github.com/$*.git \
		$@
	rm -rf $./.git

$(tree-sitter):
	npm install tree-sitter-cli

%/src/parser.c: $(tree-sitter) $$*
	cd $* && ../../../$< generate

src/$(REPO)/src/scanner.c:
	touch $@

%.so: src/$(REPO)/src/parser.c src/$(REPO)/src/scanner.c
	# -o: output
	# -I: add to search path for include files
	# -lstdc++: link stdc++ library
	# -Os: optimisation
	# -shared: create shared object (.so)
	cc -o $@ -I./src/$(REPO)/src -lstdc++ -Os -shared $^
