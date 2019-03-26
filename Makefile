run: build
	@./calcy
.PHONY: run

build:
	@mix compile
	@mix escript.build
.PHONY: build

clean:
	@mix clean
	@rm -rf ./calcy	
.PHONY: clean
	
console:
	@iex -S mix
.PHONY: console
