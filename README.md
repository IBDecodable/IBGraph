# IBGraph
[![Build Status](https://travis-ci.org/IBDecodable/IBGraph.svg?branch=master)](https://travis-ci.org/IBDecodable/IBGraph)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://developer.apple.com/swift/)

A tool to create a graph representaton of your  `.storyboard` files.

## Install

### Using sources

```
git clone https://github.com/IBDecodable/IBGraph.git
cd IBGraph
make install
```

### Using Homebrew (swiftbrew)

If not already installed yet, install [Swiftbrew](https://github.com/swiftbrew/Swiftbrew) with [Homebrew](https://brew.sh/index_fr)

```
brew install swiftbrew/tap/swiftbrew
```

then type 
```
swift brew install IBDecodable/IBGraph
```

## Usage

You can see all description by `ibgraph help`

```
$ ibgraph help
Available commands:

   help      Display general or command-specific help
   generate  Show graph (default command)
   version   Display the current version of ibgraph
```

### Generate command

#### Using `default` reporter

```
$ ibgraph
FirstViewController -> ["SecondViewController"]
```

#### Using `dot` reporter
```
$ ibgraph --reporter dot
digraph {
    0 [label = "FirstViewController"];
    1 [label = "SecondViewController"];

    0 -> 1;
}
# or ibgraph if reporter defined in configuration file
```

_[Visualize this graph online](http://bit.ly/2YtkuY5)_

_[Example on IBAnimatable demo app](http://bit.ly/2STM1wW)_

or if you ave `graphviz` installed you can open preview

```bash
ibgraph --reporter dot | dot -Tpng | open -Wfa preview
```

#### Using `online` reporter

This reporter open the graph on https://dreampuf.github.io/GraphvizOnline/

```
$ ibgraph --reporter online
Open url https://dreampuf.github.io/GraphvizOnline/#digraph....
```

### Convert graph to png

First use `dot` reporter.


Then you can install `graphviz` using Homebrew

```
brew install graphviz
```

And finally launch the convertion using `dot` command on your result file

```
dot -Tpng MyStoryboards.dot -o MyStoryboards.png
```

or directly after `ibgraph` launch

```
 ibgraph --reporter dot | dot -Tpng -o MyStoryboards.png
```

#### Xcode

Add a `Run Script Phase` to integrate IBGraph with Xcode

```sh
if which ibgraph >/dev/null; then
  if which dot >/dev/null; then
    ibgraph generate --reporter dot | dot -Tpng -o storyboards.png
  else
    echo "warning: dot from graphviz is not installed, check how to install here https://github.com/IBDecodable/IBGraph#convert-graph-to-png"
  fi
fi
else
  echo "warning: IBGraph not installed, download from https://github.com/IBDecodable/IBGraph"
fi
```

## Requirements

IBGraph requires Swift5.0 runtime. Please satisfy at least one of following requirements.

 - macOS 10.14.4 or later
 - Install `Swift 5 Runtime Support for Command Line Tools` from [More Downloads for Apple Developers](https://developer.apple.com/download/more/)
 
## Configuration

You can configure IBGraph by adding a `.ibgraph.yml` file from project root directory.


| key                  | description                 |
|:---------------------|:--------------------------- |
| `excluded`           | Path to ignore.    |
| `included`           | Path to include.   |
| `reporter`           | Choose the output format between `default`, `dot`, `json`, `gml` and `graphml`. Or `online` to open graph on default browser.|

```yaml
included:
  - App/Views
reporter: "dot"
```
