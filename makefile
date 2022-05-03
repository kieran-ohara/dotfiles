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

$(DEPS)/node_modules/.bin/pnpm:
	npm install pnpm --prefix $(DEPS)

$(DEPS)/node_modules: $(DEPS)/node_modules/.bin/pnpm $(DEPS)/package.json $(DEPS)/package-lock.json
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
