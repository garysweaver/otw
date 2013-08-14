require 'rails'
require 'spec_helper'

describe FoosController do
  describe "GET index" do
    it 'has controller_around method' do
      @controller.controller_around do; end
    end

    it 'creates foos with correct fields' do
      Foo.delete_all
      post :create, foo: {}
      assert_equal('FoosController', Foo.first.cname)
    end
  end
end
