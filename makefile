SHELL:=zsh
DEPS=dependencies

dep_graph.dot: config/homebrew/Brewfile
	brew graph --installed > $@

dep_graph.png: dep_graph.dot
	dot -Tpng $< -o $@

$(DEPS)/brew: config/homebrew/Brewfile.lock.json
	brew bundle
	mkdir -p $(DEPS)
	touch $@

config/terminfo/db/61/alacritty-kieran: config/terminfo/src/alacritty-inline.terminfo
	tic -x $<
