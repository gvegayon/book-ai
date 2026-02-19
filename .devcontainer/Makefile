ifndef CNTBUILDER
  CNTBUILDER=podman
endif

build: Containerfile
	$(CNTBUILDER) build -t book-ai:latest .

run:
	$(CNTBUILDER) run --rm -i book-ai:latest

push:
	$(CNTBUILDER) tag book-ai:latest gvegayon/book-ai:latest && \
	$(CNTBUILDER) push gvegayon/book-ai:latest

# Run the container mapping the current folder to /appliedsnar
# and run the container in interactive mode. Also, expose the localhost
# port 8787 to the container port 8787.
dev:
	$(CNTBUILDER) run --rm -it \
		-p 8787:8787 \
		-v $(PWD)/..:/appliedsnar book-ai:latest