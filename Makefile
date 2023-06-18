MD_FILES = $(wildcard plaintxt/*.md)
PDF_FILES = $(patsubst plaintxt/%.md, pdfs/%.pdf, $(MD_FILES))

# create the pdfs directory if it doesn't exist
$(shell mkdir -p pdfs)

# build PDF files from Markdown files
all: $(PDF_FILES)

pdfs/%.pdf: plaintxt/%.md
    @if [ ! -f "$@" ]; then \
        echo "Building $@"; \
        ./build.py $< $@; \
    else \
        echo "$@ already exists"; \
    fi