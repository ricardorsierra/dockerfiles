## dockerfiles

Almost all of these live on dockerhub under [sierratecnologia](https://hub.docker.com/u/sierratecnologia/).
[![make test](https://github.com/sierratecnologia/dockerfiles/workflows/make%20test/badge.svg)](https://github.com/sierratecnologia/dockerfiles/actions?query=workflow%3A%22make+test%22+branch%3Amaster)

You may also want to checkout my [dotfiles](https://github.com/ricardosierra/dotfiles), specifically the aliases for all these files which are here: [github.com/ricardosierra/dotfiles/blob/master/.dockerfunc](https://github.com/ricardosierra/dotfiles/blob/master/.dockerfunc).

Others Links:
[Ricardo Sierra](https://ricardosierra.com.br/)
[Sierra Tecnologia](https://ricardosierra.com.br/)

**Table of Contents**

<!-- toc -->

- [About](#about)
- [Resources](#resources)
  * [My dotfiles](#my-dotfiles)
- [Contributing](#contributing)
  * [Using the `Makefile`](#using-the-makefile)

<!-- tocstop -->

## About




## Changelog

Refer to the [Changelog](CHANGELOG.md) for a full history of the project.


## Support

The following support channels are available at your fingertips:

- [Chat on Slack](https://bit.ly/sierratecnologia-slack)
- [Help on Email](mailto:help@sierratecnologia.com.br)
- [Follow on Twitter](https://twitter.com/sierratecnologia)


## Contributing & Protocols

Thank you for considering contributing to this project! The contribution guide can be found in [CONTRIBUTING.md](CONTRIBUTING.md).

Bug reports, feature requests, and pull requests are very welcome.

- [Versioning](CONTRIBUTING.md#versioning)
- [Pull Requests](CONTRIBUTING.md#pull-requests)
- [Coding Standards](CONTRIBUTING.md#coding-standards)
- [Feature Requests](CONTRIBUTING.md#feature-requests)
- [Git Flow](CONTRIBUTING.md#git-flow)


## Security Vulnerabilities

If you discover a security vulnerability within this project, please send an e-mail to [help@sierratecnologia.com.br](help@sierratecnologia.com.br). All security vulnerabilities will be promptly addressed.


## About SierraTecnologia

SierraTecnologia is a software solutions startup, specialized in integrated enterprise solutions for SMEs established in Rio de Janeiro, Brazil since June 2008. We believe that our drive The Value, The Reach, and The Impact is what differentiates us and unleash the endless possibilities of our philosophy through the power of software. We like to call it Innovation At The Speed Of Life. That’s how we do our share of advancing humanity.


## License

This software is released under [The MIT License (MIT)](LICENSE).

(c) 2008-2020 SierraTecnologia, Some rights reserved.
## Resources

### My dotfiles

You may also want to checkout my [dotfiles](https://github.com/sierratecnologia/dotfiles), specifically the aliases for all these files which are here: [github.com/sierratecnologia/dotfiles/blob/master/.dockerfunc](https://github.com/sierratecnologia/dotfiles/blob/master/.dockerfunc).

## Contributing

I try to make sure each Dockerfile has a command at the top to document running it,
if a file you are looking at does not have a command, please
pull request it!


### Using the `Makefile`

```
$ make help
build                          Builds all the dockerfiles in the repository.
dockerfiles                    Tests the changes to the Dockerfiles build.
image                          Build a Dockerfile (ex. DIR=telnet).
latest-versions                Checks all the latest versions of the Dockerfile contents.
run                            Run a Dockerfile from the command at the top of the file (ex. DIR=telnet).
shellcheck                     Runs the shellcheck tests on the scripts.
test                           Runs the tests on the repository.
```
