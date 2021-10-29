.PHONY: rescript-clean rescript-build rescript-start
.PHONY: clean build start

NODE_BINS = node_modules/.bin

rescript-clean:
	$(NODE_BINS)/rescript clean -with-deps

rescript-build:
	$(NODE_BINS)/rescript

rescript-start:
	$(NODE_BINS)/rescript build -w

clean:
	make rescript-clean

build: clean
	make rescript-build

start: clean
	make rescript-start
