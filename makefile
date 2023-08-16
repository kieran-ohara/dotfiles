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

$(DEPS)/node_modules: $(DEPS)/package-lock.json $(DEPS)/package.json
	npm ci --prefix $(@D) --omit=dev --omit=optional $(@D)
	touch $@

$(DEPS)/node_modules.zip: $(DEPS)/node_modules
	tar -czf $@ $<

$(DEPS)/venv:
	python3 -m virtualenv $@

$(DEPS)/venv/bin: $(DEPS)/venv $(DEPS)/requirements.txt
	$</bin/pip install -r $(DEPS)/requirements.txt

$(DEPS)/vscode-js-debug/package.json:
	git clone -b 'v1.72.1' --single-branch --depth 1 https://github.com/microsoft/vscode-js-debug $(@D)

$(DEPS)/vscode-js-debug/node_modules: $(DEPS)/vscode-js-debug/package.json
	cd $(<D) && npm install --legacy-peer-deps

$(DEPS)/vscode-js-debug/out/src/vsDebugServer.js: $(DEPS)/vscode-js-debug/package.json $(DEPS)/vscode-js-debug/node_modules
	cd $(<D) && npm run compile

config/terminfo/db/61/alacritty-kieran: config/terminfo/src/alacritty-inline.terminfo
	tic -x $<

prompts/prompts.csv: prompts/prompts prompts/mkprompts.sh
	./prompts/mkprompts.sh $< $@

prompts/prompts:
	touch $@
