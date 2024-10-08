# Optional extra gems
%w[amazing_print interesting_methods methodfinder].each do |gem|
  require gem if Gem::Specification.find_all_by_name(gem).any?
end

if defined?(AmazingPrint) && ENV["SKIP_AP"] != "true"
  AmazingPrint.irb!
  AmazingPrint.defaults = {
    indent: 2,
    ruby19_syntax: true,
    sort_keys: true,
    sort_vars: true,
  }
else
  # Make sure we always have an 'ap' command available
  alias ap pp
end

# Monkey-patches
class Object
  def d
    tap { |s| puts s }
  end
end
