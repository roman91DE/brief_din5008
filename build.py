#!/usr/bin/env python

from subprocess import run
import argparse
import os

def check_template_exists():
    home = os.path.expanduser("~")
    template_path = os.path.join(home, ".pandoc/templates/letter.latex")
    if os.path.exists(template_path):
        print(f"Template {template_path} exists.")
    else:
        run(
          ['curl',
          'https://raw.githubusercontent.com/benedictdudel/pandoc-letter-din5008/master/letter.latex',
          '--create-dirs',
          '-o',
          template_path
          ]
        )


def build(path_md: str, path_pdf: str):
  run(
    ['pandoc', path_md, '-o', path_pdf, '--template=letter']
  )
  

def main():
  parser = argparse.ArgumentParser(description='Convert a markdown Letter to a pdf according to DIN5008')
  parser.add_argument('input_file', type=str, help='The markdown file to convert')
  parser.add_argument('output_file', type=str, help='The name of the output pdf file')
  
  args = parser.parse_args()
  check_template_exists()
  build(args.input_file, args.output_file)

if __name__ == "__main__":
  main()
