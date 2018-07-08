#!/bin/bash
# A Bash script to configure the git pairs file and construct a basic C# ASP.NET project structure.

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
  
  echo Please enter the name of a base class you want to create - this needs to be different from your project name:
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
  cp -R $baseDirectory/assets/Project/Controllers ~/Desktop/$projectName/Project/
  cp -R $baseDirectory/assets/Project/Views ~/Desktop/$projectName/Project/
  cp -R $baseDirectory/assets/Project/wwwroot ~/Desktop/$projectName/Project/
  cp $baseDirectory/assets/README.md ~/Desktop/$projectName
  cp $baseDirectory/assets/.gitignore ~/Desktop/$projectName

  # Rename files
  mv Project $directoryName
  mv Project.Tests $directoryName.Tests
  mv $directoryName/Project.csproj $directoryName/$directoryName.csproj

  # Initialize git
  git init
  sleep 2
  git pair $user1Initials $user2Initials

  # Replace ProjectNameHere and ClassNameHere in files
  OLD_PROJECT="ProjectNameHere"
  NEW_PROJECT=$directoryName
  OLD_CLASS="ClassNameHere"
  NEW_CLASS=$className

  # Program and Startup
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Program.txt > $directoryName/Program.cs
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Startup.txt > $directoryName/Startup.cs

  # Controllers
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Controllers/HomeController.txt > $directoryName/Controllers/HomeController.cs

  # Models
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Models/ClassName.txt > $directoryName/Models/ClassName2.txt
  sed "s/$OLD_CLASS/$NEW_CLASS/g" $directoryName/Models/ClassName2.txt > $directoryName/Models/$className.cs

  # Database.cs
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName/Models/Database.txt > $directoryName/Models/Database.cs

  # csproj Tests
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName.Tests/Project.Tests.txt > $directoryName.Tests/$directoryName.Tests.csproj

  # ModelTests
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName.Tests/ModelTests/ClassName.Tests.txt > $directoryName.Tests/ModelTests/ClassName2.Tests.txt
  sed "s/$OLD_CLASS/$NEW_CLASS/g" $directoryName.Tests/ModelTests/ClassName2.Tests.txt > $directoryName.Tests/ModelTests/$className.Tests.cs

  # ControllerTests
  sed "s/$OLD_PROJECT/$NEW_PROJECT/g" $directoryName.Tests/ControllerTests/HomeControllerTest.txt > $directoryName.Tests/ControllerTests/HomeControllerTest.cs

  # Remove base text files
  rm $directoryName/Program.txt
  rm $directoryName/Startup.txt
  rm $directoryName/Controllers/HomeController.txt
  rm $directoryName/Models/ClassName.txt
  rm $directoryName/Models/ClassName2.txt
  rm $directoryName/Models/Database.txt
  rm $directoryName.Tests/Project.Tests.txt
  rm $directoryName.Tests/ModelTests/ClassName.Tests.txt
  rm $directoryName.Tests/ModelTests/ClassName2.Tests.txt
  rm $directoryName.Tests/ControllerTests/HomeControllerTest.txt

  # Run dotnet restore for tests directory
  cd $directoryName.Tests
  echo Running dotnet restore in testing directory. This may take a few seconds...
  dotnet restore
  sleep 8

  # Run dotnet restore for project directory
  cd ../$directoryName
  echo Running dotnet restore in project directory. This may take a few seconds...
  dotnet restore
  sleep 8

  # Navigate to and open project in finder
  cd ../../
  open $projectName
  echo Process complete! Your C# project has been created!
else
  echo Goodbye!
fi
