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
LOCATION := .
REPOLOCATION := $(REPO)/$(LOCATION)
USE_NPM := false

ifeq ($(USE_NPM),true)
	cmd=cd $* && npm install
else
	cmd=echo 'no npm install'
endif

src/%.git:
	git clone \
		https://github.com/$*.git \
		$@
	cd $@ && git checkout $(REVISION)
	rm -rf $./.git

%/$(LOCATION)/src/parser.c:  $$*
	$(cmd)
	cd $*/$(LOCATION) && tree-sitter generate

src/$(REPOLOCATION)/src/scanner.c:
	touch $@

src/$(REPOLOCATION)/src/scanner.cc:
	touch $@

build/$(LANG).so: src/$(REPOLOCATION)/src/parser.c src/$(REPOLOCATION)/src/scanner.c src/$(REPOLOCATION)/src/scanner.cc
	mkdir -p $(@D)
# %.so: src/$(REPO)/src/scanner.c
	# -o: output
	# -I: add to search path for include files
	# -lstdc++: link stdc++ library
	# -Os: optimisation
	# -shared: create shared object (.so)
	cc -o $@ -I./src/$(REPOLOCATION)/src -lstdc++ -Os -shared $^
	# rm -rf ./src/$(REPO)
