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
  cd
  cd Desktop
  mkdir $directoryName.Solution
  cd $directoryName.Solution
  cp $baseDirectory/assets/Project ~/Desktop/$directoryName
  cp $baseDirectory/assets/Project.Tests ~/Desktop/$directoryName
  cp $baseDirectory/assets/README.md ~/Desktop/$directoryName

  # Rename folders and cs files
  mv Project $directoryName
  mv Project.Tests $directoryName.Tests
  mv $directoryName/Models/ClassName.cs $directoryName/Models/$className.cs
  mv $directoryName.Tests/ModelTests/ClassName.Tests.cs $directoryName.Tests/ModelTests/$className.Tests.cs

  # Initialize git
  git init
  sleep 2
  git pair $user1Initials $user2Initials

  # Navigate to and open project in finder
  cd ..
  open $directoryName
  echo Process complete! Your C# project has been created!
else
  echo Goodbye!
fi