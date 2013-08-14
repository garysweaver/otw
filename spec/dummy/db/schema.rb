# NO! running in memory will not work with forks, as each fork has its own memory/process
#ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :foos do |t|
    t.string :cname
  end
  create_table :bars do |t|
    t.string :cname
  end
end
