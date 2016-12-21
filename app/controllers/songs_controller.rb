require 'rack-flash'
class SongsController < ApplicationController
  use Rack::Flash
  enable :sessions


  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genre = Genre.all
    erb :"/songs/new"
  end

  post '/songs' do
    anything = Artist.find_by(name: params[:artist][:name])
    if anything == nil
      @artist = Artist.create(params[:artist])
      @song = Song.create(params[:song])
      @song.update(artist_id: @artist.id)
    else
      @song = Song.create(params[:song])
      @song.update(artist_id: anything.id)
    end
    @song.update(genre_ids: params[:genre][:ids]) #create relation to genre for songs
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    erb :"/songs/show"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genre = Genre.all
    erb :"songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(artist_id: params[])
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

end
