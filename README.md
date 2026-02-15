Quiz App
========

This is a Spring Boot Maven project for a Quiz application.

Quick start
-----------

Build (using included Maven wrapper):

    ./mvnw package

Run:

    java -jar target/quiz-app-0.0.1-SNAPSHOT.jar

Git
---

A .gitignore file has been added to exclude build artifacts.

You can initialize, commit and push this project using the included PowerShell helper script:

    .\git-init-and-push.ps1 -RemoteUrl "https://github.com/yourname/yourrepo.git" -Branch main

Or follow the manual steps:

    git init
    git add .
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin <your-repo-url>
    git push -u origin main

Choose HTTPS or SSH for <your-repo-url> depending on your preference.
