class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures/new' do
    @figure = Figure.create(params[:figure])
    @figure.titles.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks.create(params[:landmark]) unless params[:landmark][:name].empty?
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])

    erb :'figures/edit'
  end

  patch '/figures/:id/edit' do

    @figure = Figure.find_by_id(params[:id])

    @figure.update(name: params[:figure][:name]) unless params[:figure][:name].empty?

    @figure.titles.create(params[:title]) unless params[:title][:name].empty?
    @figure.landmarks.create(params[:landmark]) unless params[:landmark][:name].empty?

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

end
