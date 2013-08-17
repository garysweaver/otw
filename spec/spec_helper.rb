ENV['RAILS_ENV'] = 'test'

puts "Testing Rails v#{Rails.version}"

puts "\n***Travis CI VM info for debugging POSIX lock fail***\n"
begin; puts "$ sqlite3 -version\n#{`sqlite3 -version`}"; rescue; end
begin; puts "$ uname -r\n#{`uname -r`}"; rescue; end
begin; puts "$ cat /proc/version\n#{`cat /proc/version`}"; rescue; end
begin; puts "$ lsb_release -a\n#{`lsb_release -a`}"; rescue; end
begin; puts "$ lsblk -f\n#{`lsblk -f`}"; rescue; end
begin; puts "$ cat /etc/fstab\n#{`cat /etc/fstab`}"; rescue; end
begin; puts "$ parted -l\n#{`parted -l`}"; rescue; end
begin; puts "$ cat /proc/mounts\n#{`cat /proc/mounts`}"; rescue; end
begin; puts "$ df -T\n#{`df -T`}"; rescue; end
begin; puts "$ pwd\n#{`pwd`}"; rescue; end
begin; puts "$ sudo blkid\n#{`sudo blkid`}"; rescue; end
begin
  mounts = `mount`
  puts "$ mount\n#{mounts}"
  # 1st is ours in this case, e.g. /vz/private/6061155 on / type simfs (rw)
  `mount`.split("\n").each do |l|
    m = l.split.first
    puts "$ sudo blkid -p #{m}\n#{`sudo blkid -p #{m}`}" unless m == 'none'
  end
rescue; end
puts "\nNow for the tests!"
# add dummy to the load path. now we're also at the root of the fake rails app.
app_path = File.expand_path("../dummy",  __FILE__)
$LOAD_PATH.unshift(app_path) unless $LOAD_PATH.include?(app_path)

# if require rails, get uninitialized constant ActionView::Template::Handlers::ERB::ENCODING_FLAG (NameError)
require 'rails/all'
require 'config/environment'
require 'db/schema' unless ActiveRecord::Base.connection.table_exists?(:foos)
require 'rails/test_help'
require 'rspec/rails'
require 'otw'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.mock_with :rspec
  config.order = :random
  # Make sure this is not set to true, or cannot test concurrency
  config.use_transactional_fixtures = false
end
