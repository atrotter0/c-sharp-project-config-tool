# C# Project Configuration Tool

#### By Abel Trotter, 06.27.2018

## Description

A simple bash script to create Epicodus C# ASP.NET Core projects and initialize the git pairs file.

## Setup

1. Download and install .NET 1.1.4
1. Clone the repo
1. Navigate into the clone directory
1. Run $ chmod 777 ./config-tool.sh
1. Run $ ./config-tool.sh
1. Follow the prompt
1. Run `dotnet build` from project directory and fix any build errors
1. Run `dotnet test` from the test directory to run the testing suite
1. Run `dotnet watch run` to start the server with the dotnet watch tool (live server refresh of any changes made)
1. Alter `DbNameHere` in Startup.cs to connect to the database of your choice

## Usage

* Option available to set up your git pairs file at the root directory
* Option available to create a base C# ASP.NET project that includes:
  * Controllers directory with single HomeController file
  * Views directory with basic Home/Index view and Shared/Layout and Nav partials
  * Models directory with single class file
  * Database.cs file in Models directory
  * ModelTests directory with single test class file
  * ControllerTests directory with single test class file
  * csproj files with ASP.NET MVC, MySQL Connector, TagHelpers, and MSTest packages.
  * Startup.cs for ASP.NET
  * Program.cs for ASP.NET
  * wwwroot directory for static assets
  * README.md outline
* Initializes git and git pair in project directory
* Installs packages with `dotnet restore` in test directory and project directory

## Contribution Requirements

1. Clone the repo
1. Make a new branch
1. Commit and push your changes
1. Create a PR

## Technologies Used

* C#
* Bash
* Git

## Links

* [Github Repo] (https://github.com/atrotter0/c-sharp-project-config-tool)

## License

This software is licensed under the MIT license.

Copyright (c) 2018 **Abel Trotter**