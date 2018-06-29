# C# Project Configuration Tool

#### By Abel Trotter, 06.27.2018

## Description

A simple bash script to create Epicodus C# projects and intialize the git pairs file.

## Setup

1. Clone the repo
1. Navigate into the clone directory
1. Run $ chmod 777 ./config-tool.sh
1. Run $ ./config-tool.sh
1. Follow the prompt
1. Run `dotnet test` from the Project.Tests directory to ensure the project has been built correctly.

## Usage

This can:
* Option to set up your git pairs file at the root directory
* Option to create a basic C# project structure that includes:
  * Models directory
  * ModelTests directory
  * csproj files
  * .cs files
  * README.md
* Initialize git and git pair in project directory
* Runs `dotnet restore`

## Contribution Requirements

1. Clone the repo
1. Make a new branch
1. Commit and push your changes
1. Create a PR

## Technologies Used

* Bash
* Git

## Links

* [Github Repo] (https://github.com/atrotter0/c-sharp-project-config-tool)

## License

This software is licensed under the MIT license.

Copyright (c) 2018 **Abel Trotter**