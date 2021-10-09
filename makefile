ergodox_ez_default.hex: keyboards/ergodox_ez/default
	docker run -v $(PWD)/$<:/qmk_firmware/$< --name qmk-build \
		qmkfm/qmk_firmware \
		make ergodox_ez:default
	docker cp qmk-build:/qmk_firmware/$@ $@
	docker rm qmk-build

flash_keyboard: ergodox_ez_default.hex
	teensy_loader_cli -mmcu=atmega32u4 -w -v $<

dep_graph.dot: .Brewfile
	brew graph --installed > $@

dep_graph.png: dep_graph.dot
	dot -Tpng $< -o $@

dotfiledeps: Dockerfile
	docker build -t kieranbamforth:dotfiledeps .
	docker save kieranbamforth:dotfiledeps > $@

