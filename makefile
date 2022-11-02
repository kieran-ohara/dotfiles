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

$(DEPS)/brew: config/homebrew/Brewfile.lock.json
	brew bundle
	touch $@

$(DEPS)/node_modules/.bin/pnpm:
	npm install pnpm --prefix $(DEPS)

$(DEPS)/node_modules: $(DEPS)/node_modules/.bin/pnpm $(DEPS)/pnpm-lock.yaml
	$< install --prefix $(@D)
	touch $@

$(DEPS)/venv:
	python3 -m virtualenv $@

$(DEPS)/venv/bin: $(DEPS)/venv $(DEPS)/requirements.txt
	$</bin/pip install -r $(DEPS)/requirements.txt

$(DEPS)/aws/install.pkg:
	mkdir -p $(@D)
	curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o $@

$(DEPS)/aws/contents/aws-cli.pkg/Payload/aws-cli: $(DEPS)/aws/install.pkg
	pkgutil --expand-full $< $(DEPS)/aws/contents
	touch $@

$(DEPS)/aws/cli: $(DEPS)/aws/contents/aws-cli.pkg/Payload/aws-cli
	ln -s ../../$< $@

$(DEPS)/vscode-js-debug/package.json:
	git clone -b 'v1.72.1' --single-branch --depth 1 https://github.com/microsoft/vscode-js-debug $(@D)

$(DEPS)/vscode-js-debug/node_modules: $(DEPS)/vscode-js-debug/package.json
	cd $(<D) && npm install --legacy-peer-deps

$(DEPS)/vscode-js-debug/out/src/vsDebugServer.js: $(DEPS)/vscode-js-debug/package.json $(DEPS)/vscode-js-debug/node_modules
	cd $(<D) && npm run compile

config/terminfo/db/61: config/terminfo/src/alacritty-inline.terminfo
	tic -x $<
