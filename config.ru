=begin
Here is an example config.ru file that does two things. 
First, it requires your main app file, whatever it's called. In the example, it will look for myapp.rb. 
Second, run your application. 
If you're subclassing, use the subclass's name, otherwise use Sinatra::Application.
=end
require './app'

run Sinatra::Application