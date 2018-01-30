# React on Rails Demo (ror-demo)
## Notes on how the apps were initially created

## Rails App

The following outlines how to create and dockerize a brand new Rails application.

* Create the new Rails React app via a ruby-node Docker Image `docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app starefossen/ruby-node /bin/bash` 

Then run the following commands within the bash session of the Docker Container:

`gem install --no-rdoc --no-ri rails -v 5.1.4`
`rails new ror-demo --webpack=react --skip-bundle #ignore missing gem file error`
`cd ror-demo && bundle`
`rails webpacker:install`
`rails webpacker:install:react`