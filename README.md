# Brief_din5008

## Description

Simple Script to create PDF Letters according to DIN 5008 from markdown source files

Based on [benedictdudel/pandoc-letter-din5008](https://github.com/benedictdudel/pandoc-letter-din5008)

## Usage

### Bulding a single document

``` bash
build.py [-h] input_file output_file
```

### (Re)-Building all documents from ./plaintxt

``` bash
./build_all.sh
```

## Dependencies

* Pandoc
* Python3.x
* curl
* bash