require 'rubygems'
require 'bundler/setup'

require 'eetee'

$LOAD_PATH.unshift( File.expand_path('../../lib' , __FILE__) )
require 'em-anidb'

require 'eetee/ext/mocha'
require 'eetee/ext/em'

# Thread.abort_on_exception = true
