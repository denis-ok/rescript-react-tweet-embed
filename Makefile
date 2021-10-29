.PHONY: rescript-clean rescript-build rescript-start
.PHONY: clean build start

NODE_BINS = node_modules/.bin

rescript-clean:
	$(NODE_BINS)/rescript clean -with-deps

rescript-build: rescript-clean
	$(NODE_BINS)/rescript

rescript-start:
	$(NODE_BINS)/rescript build -w

parcel-clean:
	rm -rf dist
	rm -rf .parcel-cache

parcel-build: parcel-clean
	$(NODE_BINS)/parcel build demo/index.html

parcel-start: parcel-clean
	$(NODE_BINS)/parcel demo/index.html

clean:
	make rescript-clean
	make parcel-clean

build: clean
	make rescript-build
	make parcel-build

start: clean rescript-build
	make -j 2 rescript-start parcel-start
