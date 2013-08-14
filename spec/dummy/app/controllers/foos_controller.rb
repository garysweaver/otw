class FoosController < ApplicationController
  def create
    Foo.create!
    head :ok, :content_type => 'text/html'
  end
end
