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

  echo Please enter both pair initials, or hit enter to skip:
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
  cp $baseDirectory/assets/.gitignore ~/Desktop/$projectName

  # Rename folders and cs files
  mv Project $directoryName
  mv Project.Tests $directoryName.Tests
  mv $directoryName/Models/ClassName.txt $directoryName/Models/$className.cs
  mv $directoryName/Project.csproj $directoryName/$directoryName.csproj
  mv $directoryName.Tests/ModelTests/ClassName.Tests.cs $directoryName.Tests/ModelTests/$className.Tests.cs
  mv $directoryName.Tests/Project.Tests.csproj $directoryName.Tests/$directoryName.Tests.csproj

  # Initialize git
  git init
  sleep 2
  git pair $user1Initials $user2Initials

  # Replace ProjectNameHere and ClassNameHere in all files
  OLD_PROJECT="ProjectNameHere"
  NEW_PROJECT=$directoryName
  OLD_CLASS="ClassNameHere"
  NEW_CLASS=$className
  OLD_MODEL="ProjectNameHere.Models"
  NEW_MODEL=$directoryName.Models

  # Program and Startup
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Program.txt > $directoryName/Program.cs
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Startup.txt > $directoryName/Startup.cs

  # Controllers
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Controllers/HomeController.txt > $directoryName/Controllers/HomeController2.txt
  sed "s/$OLD_MODEL/$NEW_MODEL/g" $directoryName/Controllers/HomeController2.txt > $directoryName/Controllers/HomeController.cs

  # Views

  # Models
  sed "s/$OLD_MODEL/$NEW_MODEL/g" $directoryName/Models/ClassName.txt > $directoryName/Models/ClassName2.txt
  sed "s/$OLD_CLASS/$NEW_CLASS/g" $directoryName/Models/ClassName2.txt > $directoryName/Models/$className.cs

  # Remove base text files
  rm $directoryName/Program.txt
  rm $directoryName/Startup.txt
  rm $directoryName/Controllers/HomeController.txt
  rm $directoryName/Controllers/HomeController2.txt
  rm $directoryName/Models/ClassName.txt
  rm $directoryName/Models/ClassName2.txt

  # Models


  # Add content to ClassName.Tests.cs


  # Add content to Tests.csproj


  # Run dotnet restore for Tests
  #echo Running dotnet restore. This may take a few seconds...
  #dotnet restore
  #sleep 10

  # Navigate to and open project in finder
  cd ..
  open $projectName
  echo Process complete! Your C# project has been created!
else
  echo Goodbye!
fi
