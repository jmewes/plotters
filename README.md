# Plotters

This repository contains a collection of scripts which can plot diagrams into images.

## Dependencies

- **Bash**: The scripts are simple bash scripts.
- **Docker**: Docker is used to use the diagramming tool without installing them directly.
- **entr**: (Optional) If you have `entr` installed, you can use the `-w` option of the scripts which will automatically re-render the diagrams after the source file has been changed.

## Setup

For the setup it is recommended to clone this repository and then add it's `/bin` directory into your `PATH` variable.

```bash
git clone git@github.com:experimental-software/plotters.git
PATH="$(pwd)/plotters/bin:${PATH}"
```

## Usage

Then you can use the bash scripts to generate diagrams anywhere on the terminal, using relative or absolute path declarations for the source files. It will generate the diagram as sibling of the source file.

```bash
$ mermaid.sh examples/mermaid/hello-world.mm
Generating /home/janux/src/experimental-software/plotters/examples/mermaid/hello-world.png
Generating single mermaid chart
```

To see which options are available for the script, call it with the `-h` flag.

```bash
$ mermaid.sh -h
mermaid.sh [-wh] [-f format] diagram

See https://mermaid-js.github.io for syntax.
```

## Examples

- [Mermaid](./examples/mermaid)
- [PlantUML](./examples/PlantUML)
- [Draw.IO](./examples/drawio)
- [GraphViz](./examples/graphviz)
