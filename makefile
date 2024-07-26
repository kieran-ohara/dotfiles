SHELL:=zsh
DEPS=dependencies

ergodox_ez_default.hex: keyboards/ergodox_ez/default
	docker run -v $(PWD)/$<:/qmk_firmware/$< --name qmk-build \
		qmkfm/qmk_firmware \
		make ergodox_ez:default
	docker cp qmk-build:/qmk_firmware/$@ $@
	docker rm qmk-build

dep_graph.dot: config/homebrew/Brewfile
	brew graph --installed > $@

dep_graph.png: dep_graph.dot
	dot -Tpng $< -o $@

$(DEPS)/brew: config/homebrew/Brewfile.lock.json
	brew bundle
	touch $@

config/terminfo/db/61/alacritty-kieran: config/terminfo/src/alacritty-inline.terminfo
	tic -x $<
