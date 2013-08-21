ENV['RAILS_ENV'] = 'test'

puts "Testing Rails v#{Rails.version}"

puts "\n***Travis CI VM info for debugging POSIX lock fail***\n"
begin; puts "$ sqlite3 -version\n#{`sqlite3 -version`}"; rescue; end
begin; puts "$ uname -r\n#{`uname -r`}"; rescue; end
begin; puts "$ cat /proc/version\n#{`cat /proc/version`}"; rescue; end
begin; puts "$ lsb_release -a\n#{`lsb_release -a`}"; rescue; end
begin; puts "$ cat /proc/mounts\n#{`cat /proc/mounts`}"; rescue; end
begin; puts "$ pwd\n#{`pwd`}"; rescue; end
begin; puts "$ mount\n#{`mount`}"; rescue; end
begin
  puts "testing flock..."
  system 'flock test.lock sleep 5 & sleep 1; if ! flock -n test.lock true ; then echo "flock works"; else echo "flock fails"; fi'
  # give it time to output
  sleep 8
rescue; end

begin
  puts "testing that python is available for further lock testing"
  puts "$ python -V\n#{`python -V`}"
  begin
    puts "testing fcntl lock via python script provided by Dennis Kaarsemaker."
    puts "assuming that a successful test will report something like IOError: [Errno 35] Resource temporarily unavailable"
    py_out = `python -c "import fcntl, os, time\n\nfd = open('/tmp/test.lock', 'w')\nif os.fork():\n    fcntl.lockf(fd, fcntl.LOCK_EX)\n    os.wait()\nelse:\n    time.sleep(0.1)\n    fcntl.lockf(fd, fcntl.LOCK_EX|fcntl.LOCK_NB)\n"`
    if py_out && py_out['Resource temporarily unavailable']
      puts "python test says fcntl lock works"
    else
      puts "maybe fcntl lock not working, according to python"
    end
  rescue => e
    puts "python test of fcntl failed:\n#{e.message}\n#{e.backtrace.join('\n')}"
  end
rescue
  puts "python not on path"
end

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
