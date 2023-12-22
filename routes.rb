# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

helpers do
  def escape_text(text)
    Rack::Utils.escape_html(text)
  end
end

def memo_datas
  memos = File.read('memo.json')
  memos.empty? ? [] : JSON.parse(memos)
end

def memo_data
  memos = JSON.parse(File.read('memo.json'))
  @memo = memos.find { |memo| memo['id'] == params[:id].to_i }
end

get '/memos' do
  @memos = memo_datas
  erb :index
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  memo_data
  erb :show
end

get '/memos/:id/edit' do
  memo_data
  erb :edit
end

post '/memos' do
  memos = File.read('memo.json')
  id = memos.empty? ? 1 : JSON.parse(memos).map { |memo| memo['id'] }.max.to_i + 1

  new_memo = {}
  new_memo['id'] = id
  new_memo['title'] = params[:title]
  new_memo['description'] = params[:description]

  new_memo_datas = memo_datas
  new_memo_datas << new_memo
  File.open('memo.json', 'w') do |file|
    file.write(JSON.pretty_generate(new_memo_datas))
  end
  redirect to('/memos')
end

patch '/memos/:id' do
  update_memo_datas = JSON.parse(File.read('memo.json'))
  memo = update_memo_datas.find { |update_memo_data| update_memo_data['id'] == params[:id].to_i }

  memo['title'] = params[:title]
  memo['description'] = params[:description]

  File.open('memo.json', 'w') do |file|
    file.write(JSON.pretty_generate(update_memo_datas))
  end
  redirect to("/memos/#{params[:id]}")
end

delete '/memos/:id' do
  delete_memo_datas = JSON.parse(File.read('memo.json'))
  delete_memo = delete_memo_datas.find { |delete_memo_data| delete_memo_data['id'] == params[:id].to_i }

  delete_memo_number = delete_memo_datas.index(delete_memo)
  delete_memo_datas.delete_at(delete_memo_number)

  File.open('memo.json', 'w') do |file|
    file.write(JSON.pretty_generate(delete_memo_datas))
  end
  redirect to('/memos')
end
