# React on Rails demo using Docker Compose

How to get the app up and running on your development machine:

* Install Docker client
* Run the app using `docker-compose up`
* Navigate to [http://localhost/hello_world](http://localhost/hello_world)

## Notes on how to create and Dockerize a new React on Rails app

The following outlines how to create and dockerize a brand new React on Rails application.

* Create the new Rails React app via a ruby-node Docker Image `docker run -it --rm -v "$PWD":/usr/src/app -w /usr/src/app starefossen/ruby-node /bin/bash` 

Then run the following commands within the bash session of the Docker Container:

* `gem install --no-rdoc --no-ri rails -v 5.1.4`
* `rails new ror-demo --webpack=react`
* `cd ror-demo`
* `rails webpacker:install`
* `rails webpacker:install:react`
* Add `gem react_on_rails` to the Gemfile and run `bundle`
*  Manually copy the binstubs to the `bin` directory from [here](https://github.com/rails/webpacker/tree/v3.1.0/exe) *and make them both executable*
* Set `compile: false` in webpacker.yml
* Commmit all the files to a Github repo
* run `rails generate react_on_rails:install`
* Commmit all the files to a Github repo again
* Exit out of the running Docker Container

Now the app boilerplate is ready we can Dockerize the application. I recommend to simply copy the neccesary files from this repo to your new React on Rails project, modify as needed and then run `./push/` to Dockerize the application.

* Add Dockerfile
* Add docker-compose.yml
* Add webapp.conf
* Add rails-env.conf
* Add setup.sh. Set this file to executable chmod +x setup.sh.
* Add a custom logger in config/application.rb which sends logs to STDOUT
* Update the database.yml file with the correct credentials for your database
* Add .dockerignore
* Add push.sh file for building and pushing the Docker image to Docker Hub. Set this file to executable chmod +x push.sh.

Now you should have all the files you need in order to Dockerize your new React on Rails app!

* Run `./push.sh`
* Run `docker-compose up -d && docker-compose logs -f` to start the application
* To see the application in action, navigate to [http://localhost/hello_world](http://localhost/hello_world)