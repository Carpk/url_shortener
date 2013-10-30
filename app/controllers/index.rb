get '/' do
  @urls = Url.all
  erb :index
end

post '/urls' do
  Url.create(long_url: params[:submitted_url], click_count: 0)
  redirect to ('/')
end

# get '/:short_url' do
#   @url = Url.find(params[:id])
#   redirect to '/<%= @url.long_url %>'
# end