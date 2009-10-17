require 'rubygems'
require 'sinatra'
require 'haml'
require 'hpricot'
require 'tamtam'

get '/' do
  haml :index
end

post '/work' do
  if params[:html].nil?
    "Ups... Did you sent us an HTML file?"
  elsif params[:css].nil?
    "Ups... def Ups... Did you sent us an CSS file?"
  else
    @html = params[:html][:tempfile].read
    @css =  params[:css][:tempfile].read
    @inlined = TamTam.inline(:css => @css, :body => @html)
    haml :work  
  end
end