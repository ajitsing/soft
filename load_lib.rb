load("#{File.dirname(__FILE__)}/lib/tokenizer/tokens/token.rb")
Dir["#{File.dirname(__FILE__)}/lib/tokenizer/tokens/*.rb"].each { |f| load(f) }

load("#{File.dirname(__FILE__)}/lib/tokenizer/state_machine.rb")
Dir["#{File.dirname(__FILE__)}/lib/tokenizer/*.rb"].each { |f| load(f) }

load("#{File.dirname(__FILE__)}/lib/parser/block.rb")
load("#{File.dirname(__FILE__)}/lib/parser/statement.rb")
load("#{File.dirname(__FILE__)}/lib/parser/predicate_statement.rb")
Dir["#{File.dirname(__FILE__)}/lib/parser/*.rb"].each { |f| load(f) }
Dir["#{File.dirname(__FILE__)}/lib/parser/exceptions/*.rb"].each { |f| load(f) }

load("#{File.dirname(__FILE__)}/lib/scanner.rb")
