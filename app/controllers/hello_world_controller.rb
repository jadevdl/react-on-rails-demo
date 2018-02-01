# frozen_string_literal: true

class HelloWorldController < ApplicationController
  layout "hello_world"

  def index
    @hello_world_props = { name: "Darren" }
    @message_props = { text: "Hello from Controller!" }
   end
end
