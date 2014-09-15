## Pry settings
Pry.config.prompt = Pry::NAV_PROMPT
Pry.config.editor = "atom"

## Custom methods
def require_safely(*gems)
  gems.each do |gem|
    begin
      require gem
    rescue LoadError => e
      puts "Missing library: %s" % e.message.split(/ -- /).last
      next
    end
  end
end

def ruby_info
  puts Object.constants.grep(/RUBY/).map{ |c| "%-23s: %s" % [c, Object.const_get(c)] }
end

## Additional gems
require_safely 'awesome_print', 'methodfinder', 'shenanigans', 'try_it'

# Blacklist a method that makes methodfinder hang
if Kernel.methods.include?(:prompt) && defined?(MethodFinder)
  MethodFinder::INSTANCE_METHOD_BLACKLIST[:Object] << :prompt
  MethodFinder::CLASS_METHOD_BLACKLIST[:Object] << :prompt
end
