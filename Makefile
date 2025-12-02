IMAGE_NAME ?= test-image
IMAGE_TAG ?= latest
IMAGE_TAG_SHA ?= sha-test
REGISTRY ?= test-registry
FALCON_HOME = test-user

SHOULD_PUSH = true

.PHONY: build copy-libs

copy-libs:
	rm -rf src/config_lib
	cp -r $(FALCON_HOME)/libs/config_lib ./src
	rm -rf src/platform_utils
	cp -r $(FALCON_HOME)/libs/platform_utils ./src

build: copy-libs
	@echo ">>> Building image WITHOUT cache ..."
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) .

	@if [ "$(SHOULD_PUSH)" = "true" ]; then \
		echo ">>> Pushing image to registry ..."; \
		docker push $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) ; \
	else \
		echo ">>> Skipping image push."; \
	fi
