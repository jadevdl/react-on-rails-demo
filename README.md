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

We did not find a spec/rails_helper.rb or spec/spec_helper.rb to add
the React on Rails Test helper, which ensures that if we are running
js tests, then we are using latest webpack assets. You can later add
this to your rspec config:

# This will use the defaults of :js and :server_rendering meta tags
ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)


What to do next:

  - See the documentation on https://github.com/rails/webpacker/blob/master/docs/webpack.md
    for how to customize the default webpack configuration.

  - Include your webpack assets to your application layout.

      <%= javascript_pack_tag 'hello-world-bundle' %>

  - Run `rails s` to start the Rails server and use Webpacker's default lazy compilation.

  - Visit http://localhost:3000/hello_world and see your React On Rails app running!

  - Run bin/webpack-dev-server to start the Webpack dev server for compilation of Webpack
    assets as soon as you save. This default setup with the dev server does not work
    for server rendering

  - Alternately, you may turn off compile in config/webpacker.yml and run the foreman
    command to start the rails server and run webpack in watch mode.

      foreman start -f Procfile.dev

  - To turn on HMR, edit config/webpacker.yml and set HMR to true. Restart the rails server
    and bin/webpack-dev-server. Or use Procfile.dev-server.

  - To server render, change this line app/views/hello_world/index.html.erb to
    `prerender: true` to see server rendering (right click on page and select "view source").

      <%= react_component("HelloWorldApp", props: @hello_world_props, prerender: true) %>