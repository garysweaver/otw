require 'rails'
require 'spec_helper'

describe "Otw"  do
  
  # sqlite locking issue with Rails 3.1.12
  unless Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR < 2
    it "handles concurrency" do
      Bar.delete_all
      Foo.delete_all
      pids = (1..30).to_a.collect do
        fork do
          begin
            25.times do  
              post('/foos', foo: {})
              post('/bars', foo: {})
            end
          rescue => e
            puts "#{e.message}\n#{e.backtrace.join("\n")}"
            raise e
          end
        end
      end
      pids.each {|pid| Process.waitpid pid}
      (Bar.count + Foo.count).should eq 1500
      Bar.all.each {|bar| bar.cname.should eq("127.0.0.1")}
      Foo.all.each {|foo| foo.cname.should eq("FoosController")}
    end
  end

end
