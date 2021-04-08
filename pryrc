# Optional extra gems
%w[amazing_print interesting_methods methodfinder].each do |gem|
  require gem if Gem::Specification.find_all_by_name(gem).any?
end

if defined?(AmazingPrint) && ENV["SKIP_AP"] != "true"
  AmazingPrint.pry!
  AmazingPrint.defaults = {
    indent: 2,
    ruby19_syntax: true,
    sort_keys: true,
  }
else
  # Make sure we always have an 'ap' command available
  alias ap pp
end

Pry.config.editor = 'vim'

# UI
Pry.config.prompt_name = File.basename(Dir.pwd)
Pry.config.theme = 'monokai'
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# History
Pry::Commands.command(/^$/, 'repeat last command') do
  pry_instance.run_command Pry.history.to_a.last
end

# Custom commands
# See: https://jacopretorius.net/2017/11/customizing-pry.html
Pry.config.commands.command('pbcopy', 'Copy input to clipboard') do |input|
  input = input ? target.eval(input) : pry_instance.last_result
  IO.popen('pbcopy', 'w') { |io| io << input }
end

Pry.config.commands.command('ruby-info', 'Output Ruby info') do
  constants = Object.constants.grep(/RUBY/) - [:RUBYGEMS_ACTIVATION_MONITOR]
  ap constants.map { |c| [c, Object.const_get(c)] }.to_h
end

# Command aliases
# Pry.commands.alias_command 'c', 'continue'
# Pry.commands.alias_command 's', 'step'
# Pry.commands.alias_command 'n', 'next'
# Pry.commands.alias_command 'f', 'finish'
# Pry.commands.alias_command 'w', 'whereami'

if defined?(Rails::ConsoleMethods)
  module Rails::ConsoleMethods
    alias rr reload!
  end
end

# Monkey-patches
class Object
  def d
    tap { |s| puts s }
  end
end
