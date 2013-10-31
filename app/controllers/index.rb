# GET =======================================================================

get '/' do
  @urls = Url.all
  erb :index
end

get '/counter/:short_url' do
  url = Url.find_by_short_url(params[:short_url])
  url.clicked
  redirect to "#{url.long_url}"
end

get '/:short_url' do
  @url = Url.find_by_short_url(params[:short_url])
  @url.clicked
  redirect to "#{@url.long_url}"
end

# POST ======================================================================

post '/urls' do
  Url.create(long_url: params[:submitted_url], click_count: 0)
  redirect to ('/')
end

post '/update_db' do
  @url = Url.find_by_short_url(params[:short_url])

  redirect to "#{@url.long_url}"
end

