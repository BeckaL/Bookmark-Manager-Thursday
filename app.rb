require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/add_bookmarks' do
    erb :add_bookmarks
  end

  post '/add_bookmarks' do
    @bookmark = Bookmark.create(url: params[:url], title: params[:title])
    redirect '/confirmation'
  end

  get '/confirmation' do
    erb :confirmation
  end

  run! if app_file == $0
end
