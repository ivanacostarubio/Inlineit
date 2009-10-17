require 'rubygems'
require 'rack/test'
require 'test/unit'
require 'app'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    Sinatra::Application
  end
  
  def test_get_homepage
    get '/'
    assert last_response.ok?
  end
  
  def test_posting_without_html
    post '/work'
    assert last_response.body.include?("Ups... Did you sent us an HTML file?")
  end
  
  def test_posting_without_css
    @html = Rack::Test::UploadedFile.new('test/file.html', 'text/html')
    post '/work', :html => @html
    assert last_response.body.include?("Ups... def Ups... Did you sent us an CSS file?")
  end
  
  def test_posting
    @css = Rack::Test::UploadedFile.new("test/file.css", 'text/css')
    @html = Rack::Test::UploadedFile.new("test/file.html", 'text/html')
    post '/work', :html => @html , :css => @css
    assert last_response.body.include?("BECUASE DESIGNERS DONT LIKE TO INLINE CSS")
  end
  
  def test_should_inline
    @css = Rack::Test::UploadedFile.new("test/file.css", 'text/css')
    @html = Rack::Test::UploadedFile.new("test/file.html", 'text/html')
    post '/work', :html => @html , :css => @css
    assert last_response.body.include?('<p class="i_will_die" style="color: red; font-size: 3em;">BECUASE DESIGNERS DONT LIKE TO INLINE CSS</p>')  
  end
end