## Pry settings
Pry.config.prompt = Pry::NAV_PROMPT
Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.config.editor = "vim"

## Custom methods
def require_safely(*gems)
  gems.each do |gem|
    begin
      require gem
    rescue LoadError => e
      next
    end
  end
end

def ruby_info
  puts Object.constants.grep(/RUBY/).map{ |c| "%-23s: %s" % [c, Object.const_get(c)] }
end

## Additional gems
require_safely 'awesome_print', 'methodfinder'
