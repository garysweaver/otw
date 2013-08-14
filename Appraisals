['~> 3.1.12', '~> 3.2.14', '~> 4.0.0'].each do |rails_version|
#['~> 3.2.14', '~> 4.0.0'].each do |rails_version|
#['~> 4.0.0'].each do |rails_version|
  appraise "rails_#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
  end
end
