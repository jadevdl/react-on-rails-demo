FROM phusion/passenger-ruby24:0.9.27

# Set correct environment variables. 
ENV HOME /root 

# Use baseimage-docker's init process. 
CMD ["/sbin/my_init"] 

# Additional packages : we are adding the netcat package so we can 
# make pings to the database service 
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install the things
RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" netcat 
RUN apt-get install yarn
RUN apt-get install -y tzdata
RUN apt-get install -y nodejs

# Enable Nginx and Passenger 
RUN rm -f /etc/service/nginx/down 

# Add virtual host entry for the application. Make sure 
# the file is in the correct path 
RUN rm /etc/nginx/sites-enabled/default 
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf 

# In case we need some environmental variables in Nginx. Make sure
# the file is in the correct path 
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Install gems: it's better to build an independent layer for the gems 
# so they are cached during builds unless Gemfile changes 
WORKDIR /tmp 

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

ADD Gemfile /tmp/ 
ADD Gemfile.lock /tmp/ 
RUN bundle install 
RUN yarn

# Copy application into the container and use right permissions: passenger 
# uses the app user for running the application 
RUN mkdir /home/app/ror-demo 
COPY . /home/app/ror-demo 
RUN usermod -u 1000 app 
RUN chown -R app:app /home/app/ror-demo 
WORKDIR /home/app/ror-demo 

# Clean up APT when done. 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
EXPOSE 80