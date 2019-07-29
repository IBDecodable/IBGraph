# IBGraph
[![Build Status](https://travis-ci.org/IBDecodable/IBGraph.svg?branch=master)](https://travis-ci.org/IBDecodable/IBGraph)
[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://developer.apple.com/swift/)

A tool to create a graph representaton of your  `.storyboard` files.

## Usage

You can see all description by `ibgraph help`

```
$ ibgraph help
Available commands:

   help      Display general or command-specific help
   generate  Show graph (default command)
   version   Display the current version of SwiftLint
```

### Generate command

#### Using `default` reporter

```
$ ibgraph
FirstViewController -> ["SecondViewController"]
```

#### Using `dot` reporter
```
$ ibgraph
digraph {
    0 [label = "FirstViewController"];
    1 [label = "SecondViewController"];

    0 -> 1;
}
```

_[Visualize this graph online](http://bit.ly/2YtkuY5)_

### Xcode

Add a `Run Script Phase` to integrate IBGraph with Xcode

```sh
if which ibgraph >/dev/null; then
  ibgraph generate
else
  echo "warning: IBGraph not installed, download from https://github.com/IBDecodable/IBGraph"
fi
```

### Convert graph to png

First use `dot` reporter.

Then you can install `graphviz` using Homebrew

```
brew install graphviz
```

And finally launch the convertion using `dot` command

```
dot -Tpng MyStoryboards.dot -o MyStoryboards.png
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
| `reporter`           | Choose the output format between `default`, `dot`, `json`, `gml` and `graphml`. |

```yaml
included:
  - App/Views
reporter: "dot"
```
