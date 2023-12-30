# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pg'

database = PG.connect(dbname: 'memos')

helpers do
  def escape_text(text)
    Rack::Utils.escape_html(text)
  end
end

def memo_data(connected_database)
  memo = connected_database.exec_params('SELECT * FROM memo WHERE id = $1;', [params[:id]])
  memo[0]
end

get '/memos' do
  @memos = database.exec('SELECT * FROM memo;')
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  @memo = memo_data(database)
  erb :show
end

get '/memos/:id/edit' do
  @memo = memo_data(database)
  erb :edit
end

post '/memos' do
  database.exec_params(
    'INSERT INTO memo (title, description) VALUES ($1, $2);',
    [params[:title], params[:description]]
  )
  redirect to('/memos')
end

patch '/memos/:id' do
  database.exec_params(
    'UPDATE memo SET title = $1, description = $2 WHERE id = $3;',
    [params[:title], params[:description], params[:id]]
  )
  redirect to("/memos/#{params[:id]}")
end

delete '/memos/:id' do
  database.exec_params(
    'DELETE FROM memo WHERE id = $1;',
    [params[:id]]
  )
  redirect to('/memos')
end
