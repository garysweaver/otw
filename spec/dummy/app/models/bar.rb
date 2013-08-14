class Bar < ActiveRecord::Base
  before_create :example_before_create
  def example_before_create
    #self.cname = current_controller.to_s
    self.cname = self.current_controller.request.remote_ip
  end
end
