# node-browsers

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Liberapay](http://img.shields.io/liberapay/patrons/GreatWizard.svg?logo=liberapay)](https://liberapay.com/GreatWizard/)

Node.js docker images bundled with ready-to-use headless browsers:

- Firefox with geckodriver
- Chrome with chromedriver

The entrypoint of images uses [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) with the display port `:99`.

When the images are rebuilt, the latest versions of browsers are installed.

## Getting started

The available images are based on different versions of Node.js.

| Image tag                      | Base Image       | Image Size |
| ------------------------------ | ---------------- | ---------- |
| `greatwizard/node-browsers:10` | `node:10-buster` | ~926 MB    |
| `greatwizard/node-browsers:12` | `node:12-buster` | ~928 MB    |
| `greatwizard/node-browsers:13` | `node:13-buster` | ~939 MB    |
| `greatwizard/node-browsers:14` | `node:14-buster` | ~938 MB    |
| `greatwizard/node-browsers:15` | `node:15-buster` | ~938 MB    |
| `greatwizard/node-browsers:16` | `node:16-buster` | ~938 MB    |
| `greatwizard/node-browsers:17` | `node:17-buster` | ~938 MB    |

## License

- [MIT License](https://github.com/greatwizard/node-browsers/blob/master/LICENSE)
