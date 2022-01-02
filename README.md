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
cd plotters
PATH="$(pwd)/bin:${PATH}"
```

## Usage

Then you can use the bash scripts to generate diagrams anywhere on the terminal, using relative or absolute path declarations for the source files. It will generate the diagram as sibling of the source file.

### Graphviz

> Graphviz is open source graph visualization software. Graph visualization is a way of representing structural information as diagrams of abstract graphs and networks. It has important applications in networking, bioinformatics, software engineering, database and web design, machine learning, and in visual interfaces for other technical domains. - [graphviz.org](https://graphviz.org/)

**Compile diagram**

Call `graphviz.sh` with the source file as positional parameter.

```
$ graphviz.sh examples/graphviz/hello-world.dot
Generating /home/janux/src/experimental-software/plotters/examples/graphviz/hello-world.png
```

**Target format**

With the help of the `-f` parameter, you can change the target format of the plotted diagram.

```
$ graphviz.sh -f svg examples/graphviz/hello-world.dot
Generating /home/janux/src/experimental-software/plotters/examples/graphviz/hello-world.svg
```

**Help**

To get an overview over which options are available for the script, call it with the `-h` flag.

```
$ graphviz.sh -h
graphviz.sh [-wh] [-f target_format] source_file

See https://graphviz.org/documentation for diagram syntax.
```

**Examples**

Examples for Graphviz digrams can be found [here](./examples/graphviz).

### Mermaid

> Mermaid lets you create diagrams and visualizations using text and code. It is a Javascript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically. - [mermaid-js.github.io](https://mermaid-js.github.io/mermaid/#/)

```
$ mermaid.sh examples/mermaid/hello-world.mm
Generating /home/janux/src/experimental-software/plotters/examples/mermaid/hello-world.png
Generating single mermaid chart
```

To get an overview over which options are available for the script, call it with the `-h` flag.

```
$ mermaid.sh -h
mermaid.sh [-wh] [-f format] diagram

See https://mermaid-js.github.io for syntax.
```

Examples for Mermaid digrams can be found [here](./examples/mermaid).

### PlantUML

> PlantUML is a component that allows to quickly write: Sequence diagram, usecase diagram, class diagram, object diagram, activity diagram, component diagram, deployment diagram, state diagram, timing diagram. (...) - [plantuml.com](https://plantuml.com/)

```
$ plantuml.sh examples/plantuml/hello-world.puml
Generating /home/janux/src/experimental-software/plotters/examples/plantuml/hello-world.png
```

To get an overview over which options are available for the script, call it with the `-h` flag.

```
$ plantuml.sh -h
```

Examples for PlantUML digrams can be found [here](./examples/plantuml).
