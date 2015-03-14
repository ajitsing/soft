require './lib/scanner.rb'
require './utils/file_utils.rb'

def compile
  return p("#{ARGV.first} is not a soft file...") if !ARGV.first.end_with? '.soft'
  content = FileUtil.read ARGV.first
  Scanner.tokenize content
end

compile
