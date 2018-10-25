require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions

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
    session[:confirm] = :add
    redirect '/confirmation'
  end

  get '/confirmation' do
    @confirmation_message = "Bookmark added" if session[:confirm] == :add
    @confirmation_message = "Bookmark deleted" if session[:confirm] == :delete
    @confirmation_message = "Bookmark updated" if session[:confirm] == :update
    erb :confirmation
  end

  get '/delete_bookmark' do
    erb :delete_bookmark
  end

  post '/delete_bookmark' do
    Bookmark.delete(params[:'Bookmark to delete'])
    session[:confirm] = :delete
    redirect '/confirmation'
  end

  get '/update_bookmark' do
    erb :update_bookmark
  end

  post '/update_bookmark' do
    session[:'Bookmark to update'] = params['Bookmark to update']
    redirect '/update_specific_bookmark'
  end

  get '/update_specific_bookmark' do
    @to_update = Bookmark.get_by_title(session[:'Bookmark to update'])
    session[:to_update] = @to_update
    erb :update_specific_bookmark
  end

  post '/update_specific_bookmark' do
    @to_update = session[:to_update]
    Bookmark.update(@to_update['id'], params["title"], params["url"])
    session[:confirm] = :update
    redirect '/confirmation'
  end

  run! if app_file == $0
end
