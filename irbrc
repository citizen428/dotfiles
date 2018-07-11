## Prompt
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => ">> ",
  :PROMPT_S => "%l>> ",
  :PROMPT_C => ".. ",
  :PROMPT_N => ".. ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:AUTO_INDENT] = true

begin
  ## awesome_print
  require 'awesome_print'

  ## Looksee
  require 'looksee'

  ## Wirble
  require 'wirble'
  Wirble.init
  Wirble.colorize

  require 'methodfinder'
rescue LoadError
end

## Aliases
alias q exit

# Methods
def ruby_info
  puts Object.constants.grep(/RUBY/).map{ |c| "%-23s: %s" % [c, Object.const_get(c)] }
end

def dumphist(num=1)
  lines = Readline::HISTORY.to_a[-num-1..Readline::HISTORY.length-2]
  `echo '#{lines.join("\n")}'|pbcopy`
  lines
end

# clear screen
def clear
  system 'clear'
end

# idea stolen from irbtools, implementation might be different
class Object
  def d
    self.tap { |s| puts s }
  end
end
