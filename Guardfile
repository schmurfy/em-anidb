
require 'eetee'
require 'blink1'

guard 'eetee', blink1: true do
  watch(%r{^lib/em-anidb/(.+)\.rb$})     { |m| "specs/unit/#{m[1]}_spec.rb" }
  watch(%r{specs/.+\.rb$})
end
