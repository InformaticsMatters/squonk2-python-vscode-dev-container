# Squonk2 VS Code Python Dev Container

![build](https://github.com/informaticsmatters/squonk2-python-vscode-dev-container/actions/workflows/build.yaml/badge.svg?branch=3.13)

An evolving set of files that can be used to create a [dev-container] to satisfy
our Python development with Visual Studio Code. Just put these files into
your project or workspace `.devcontainer` directory and VS Code should do the rest.

1.  `devcontainer.json`
2.  `Dockerfile`
3.  `requirements.txt`

The above creates an image with the following main components (amongst others): -

-   Python (3.13 "slim")
-   Poetry (1.8)
-   Pre-Commit (4.2)
-   Ansible (11.8)
-   Docker-in-Docker

>   Separate branches of this repository will be maintained
    for each active Major/Minor Python version in use. So you'll
    find a 3.13 branch for our Python 3.13 base container.

---

[dev-container]: https://code.visualstudio.com/docs/devcontainers/containers
