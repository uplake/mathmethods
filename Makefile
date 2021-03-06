.PHONY: compile clean setup test

compile:
	@./node_modules/coffee-script/bin/coffee --compile --output lib src/mathmethods

clean:
	@rm -rf node_modules

setup:
	@npm install

test:
	@./node_modules/mocha/bin/mocha test --compilers coffee:coffee-script
