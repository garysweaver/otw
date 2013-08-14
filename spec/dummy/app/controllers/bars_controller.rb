class BarsController < ApplicationController
  def create
    Bar.create!
    head :ok, :content_type => 'text/html'
  end
end
