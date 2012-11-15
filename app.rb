require 'rubygems'
require 'sinatra'
require 'haml'
require 'tamtam'

get '/' do
  haml :index
end

post '/work' do
  if params[:html].nil?
    @htmlerror="Ups... Did you sent us an HTML file?"
    haml :error
  elsif params[:css].nil?
    @csserror="Ups... Did you sent us an CSS file?"
    haml :error
  else
    @html = params[:html][:tempfile].read
    @css =  params[:css][:tempfile].read
    @inlined = TamTam.inline(:css => @css, :body => @html)
    haml :work  
  end
end