.DEFAULT_GOAL := message
message:
	# Please specify a *.so target.

# Allow using variable expansion in pre requisites.
.SECONDEXPANSION:

# Prevent make from deleting git repos that are created as intermediate files.
.PRECIOUS: src/%.git

# The repo + tag to build. Default to Javascript Treesitter.
REPO := tree-sitter/tree-sitter-$(LANG).git
REVISION := master

src/%.git:
	git clone \
		https://github.com/$*.git \
		$@
	cd $@ && git checkout $(REVISION)
	rm -rf $./.git


%/src/parser.c:  $$*
	cd $* && tree-sitter generate

src/$(REPO)/src/scanner.c:
	touch $@

src/$(REPO)/src/scanner.cc:
	touch $@

$(LANG).so: src/$(REPO)/src/parser.c src/$(REPO)/src/scanner.c src/$(REPO)/src/scanner.cc
# %.so: src/$(REPO)/src/scanner.c
	# -o: output
	# -I: add to search path for include files
	# -lstdc++: link stdc++ library
	# -Os: optimisation
	# -shared: create shared object (.so)
	cc -o $@ -I./src/$(REPO)/src -lstdc++ -Os -shared $^
	rm -rf ./src/$(REPO)
