#!/bin/bash
# A Bash script to configure the git pairs file and construct a basic C# Model & ModelTests project structure.

# set base directory to copy assets from
baseDirectory=$(pwd)

# Prompt and set up git pairs file
echo Do you need to set up your git pairs file? Enter y/n
read input

if [ $input == "yes" ] || [ $input == "y" ] || [ $input == "Y" ]
then
  # Get user 1 data
  echo Enter first pair initials, first name, last name, and email with spaces between each value.
  echo example: gt Gandalf Thewhite gandalf@middledearth.com
  read user1Initials user1FirstName user1LastName user1Email

  # Get user 2 data
  echo Enter second pair initials, first name, last name, and email with spaces between each value.
  echo example: lg Legolas Greenleaf legolas@middleearth.com
  read user2Initials user2FirstName user2LastName user2Email

  echo Creating git pairs file...

  # Build pairs file
  cd
  touch .pairs
  echo 'pairs:' >> .pairs
  echo "  $user1Initials: $user1FirstName $user1LastName" >> .pairs
  echo "  $user2Initials: $user2FirstName $user2LastName" >> .pairs
  echo 'email:' >> .pairs
  echo "  $user1Initials: $user1Email" >> .pairs
  echo "  $user2Initials: $user2Email" >> .pairs

  echo Process complete! Git pairs file created!
fi

# Prompt and build new C# project
echo Do you want to create a new C# project? Enter y/n
read input

if [ $input == "yes" ] || [ $input == "y" ] || [ $input == "Y" ]
then
  # Set up Project.Solution directory
  echo Please enter the name of the project you want to create:
  read directoryName
  
  echo Please enter the name of the class you want to create - this needs to be different from your project name:
  read className

  echo Please enter both pair initials:
  echo example: gt lg
  read user1Initials user2Initials

  echo Creating directory $directoryName and building C# project...

  # Build directories and copy assets
  solution='.Solution'
  projectName=$directoryName$solution

  cd
  cd Desktop
  mkdir $projectName
  cd $projectName
  cp -R $baseDirectory/assets/Project ~/Desktop/$projectName
  cp -R $baseDirectory/assets/Project.Tests ~/Desktop/$projectName
  cp $baseDirectory/assets/README.md ~/Desktop/$projectName

  # Rename folders and cs files
  mv Project $directoryName
  mv Project.Tests $directoryName.Tests
  mv $directoryName/Models/ClassName.cs $directoryName/Models/$className.cs
  mv $directoryName/Project.csproj $directoryName/$directoryName.csproj
  mv $directoryName.Tests/ModelTests/ClassName.Tests.cs $directoryName.Tests/ModelTests/$className.Tests.cs
  mv $directoryName.Tests/Project.Tests.csproj $directoryName.Tests/$directoryName.Tests.csproj

  # Initialize git
  git init
  sleep 2
  git pair $user1Initials $user2Initials

  # Add content to Tests.csproj
  cd $directoryName.Tests/
  echo '<Project Sdk="Microsoft.NET.Sdk">' >> $directoryName.Tests.csproj
  echo '' >> $directoryName.Tests.csproj
  echo '  <PropertyGroup>' >> $directoryName.Tests.csproj
  echo '    <TargetFramework>netcoreapp1.1</TargetFramework>' >> $directoryName.Tests.csproj
  echo '  </PropertyGroup>' >> $directoryName.Tests.csproj
  echo '  <ItemGroup>' >> $directoryName.Tests.csproj
  echo '    <PackageReference Include="Microsoft.NET.Test.Sdk" Version="15.0.0" />' >> $directoryName.Tests.csproj
  echo '    <PackageReference Include="MSTest.TestAdapter" Version="1.2" />' >> $directoryName.Tests.csproj
  echo '    <PackageReference Include="MSTest.TestFramework" Version="1.2" />' >> $directoryName.Tests.csproj
  echo '  </ItemGroup>' >> $directoryName.Tests.csproj
  echo '' >> $directoryName.Tests.csproj
  echo '  <ItemGroup>' >> $directoryName.Tests.csproj
  echo '    <ProjectReference Include="..\'$directoryName'\'$directoryName.csproj'" />' >> $directoryName.Tests.csproj
  echo '  </ItemGroup>' >> $directoryName.Tests.csproj
  echo '</Project>' >> $directoryName.Tests.csproj

  # Run dotnet restore
  echo Running dotnet restore. This may take a few seconds...
  dotnet restore
  sleep 10

  # Navigate to and open project in finder
  cd ../../
  open $projectName
  echo Process complete! Your C# project has been created!
else
  echo Goodbye!
fi
