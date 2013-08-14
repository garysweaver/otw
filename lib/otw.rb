require 'otw/version'

module Otw
  class Registry
    def self.controller=(controller)
      Thread.current[:otw_controller] = controller
    end
    def self.controller
      Thread.current[:otw_controller]
    end
  end

  module ControllerAround
    extend ActiveSupport::Concern
    included { around_filter :controller_around }

    def controller_around
      ::Otw::Registry.controller = self
      yield
    ensure
      ::Otw::Registry.controller = nil
    end
  end

  module HasCurrentController
    extend ActiveSupport::Concern
    def current_controller
      ::Otw::Registry.controller
    end
  end
end

begin; ::ActionController::Base.send(:include, ::Otw::ControllerAround); rescue; end
begin; ::ActiveRecord::Base.send(:include, ::Otw::HasCurrentController); rescue; end
begin; ::Mongoid::Document.send(:include, ::Otw::HasCurrentController); rescue; end
begin; ::MongoMapper::Document.send(:include, ::Otw::HasCurrentController); rescue; end
