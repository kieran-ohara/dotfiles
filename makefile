SHELL=zsh
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

$(DEPS)/node_modules: $(DEPS)/package.json $(DEPS)/package-lock.json
	npm install --prefix $(@D)
	touch $@

venv:
	python3 -m virtualenv venv

venv/installed: requirements.txt venv
	venv/bin/pip install -r $<
	touch $@
