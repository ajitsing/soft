load("#{File.dirname(__FILE__)}/../load_lib.rb")

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

# Or, if you're using rspec-mocks in another context:
RSpec::Mocks.configuration.syntax = :should
