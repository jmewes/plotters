# Plotters

This repository contains a collection of Docker-based Bash scripts which can plot diagram source files into binary images.

The following diagramming tools are supported:

- [Graphviz](#graphviz)
- [Mermaid](#mermaid)
- [PlantUML](#plantuml)

## Dependencies

To be able to use the scripts, you need to have the following tools installed:

- **[Bash](https://www.gnu.org/software/bash/)**: The plotters are Bash scripts which wrap the diagramming tools.
- **[Docker](https://www.docker.com)**: The diagramming tools are packaged in a Docker container, to use them without the need to install them natively on your PC.
- **[entr](https://dev.to/janux_de/run-a-bash-command-after-file-changes-unix-24jj)**: (Optional) If you have `entr` installed, you can use the `-w` option of the scripts which will automatically re-render the diagrams after the source file has been changed.

The plotters are tested on Ubuntu and macOS.

## Setup

For the setup, it is recommended to clone this repository and then add its `/bin` directory into your `PATH` variable.

```bash
git clone git@github.com:experimental-software/plotters.git
cd plotters
PATH="$(pwd)/bin:${PATH}"
```

To have access to the plotters every time you start a new terminal, add the path extension into your `~/.bashrc` or `~/.bash_profile`, e.g. like this:

```bash
PATH="~/src/experimental-software/plotters/bin:${PATH}"
```

## Usage

Then you can use the bash scripts to generate diagrams anywhere on the terminal, using relative or absolute path declarations for the source files. It will generate the diagram as a sibling of the source file.

### PlantUML

> PlantUML is a component that allows to quickly write: Sequence diagram, usecase diagram, class diagram, object diagram, activity diagram, component diagram, deployment diagram, state diagram, timing diagram. (...) [[plantuml.com]](https://plantuml.com/)

**Plot diagram**

Call `plantuml.sh` with the source file as a positional parameter to plot the diagram to the default format (PNG).

```
$ plantuml.sh examples/plantuml/hello-world.puml
Generating /home/janux/src/experimental-software/plotters/examples/plantuml/hello-world.png
```

**Target format**

```
$ plantuml.sh -f svg examples/plantuml/hello-world.puml
Generating /home/janux/src/experimental-software/plotters/examples/plantuml/hello-world.svg
```

**Help**

To get an overview of which options are available for the script, call it with the `-h` flag.

```
plantuml.sh -h
```


### Mermaid

> Mermaid lets you create diagrams and visualizations using text and code. It is a Javascript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically. [[mermaid-js.github.io]](https://mermaid-js.github.io/mermaid/#/)

**Plot diagram**

Call `mermaid.sh` with the source file as a positional parameter to plot the diagram to the default format (PNG).

```
$ mermaid.sh examples/mermaid/hello-world.txt
Generating /home/janux/src/experimental-software/plotters/examples/mermaid/hello-world.png
Generating single mermaid chart
```

**Target format**

With the help of the `-f` parameter, you can change the target format of the plotted diagram.

```
$ mermaid.sh -f svg examples/mermaid/hello-world.mm
Generating /home/janux/src/experimental-software/plotters/examples/mermaid/hello-world.svg
Generating single mermaid chart
```

**Help**

To get an overview of which options are available for the script, call it with the `-h` flag.

```
mermaid.sh -h
```

**Examples**

Examples for Mermaid digrams can be found [here](./examples/mermaid).


### Graphviz

> Graphviz is open source graph visualization software. Graph visualization is a way of representing structural information as diagrams of abstract graphs and networks. It has important applications in networking, bioinformatics, software engineering, database and web design, machine learning, and in visual interfaces for other technical domains. [[graphviz.org]](https://graphviz.org/)

**Plot diagram**

Call `graphviz.sh` with the source file as a positional parameter to plot the diagram to the default format (PNG).

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

To get an overview of which options are available for the script, call it with the `-h` flag.

```
graphviz.sh -h
```

**Examples**

Examples for Graphviz digrams can be found [here](./examples/graphviz).
