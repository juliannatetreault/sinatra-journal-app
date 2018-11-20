class JournalEnteriesController < ApplicationController

    get '/enteries' do 
      if session[:user_id]
        @enteries = Enteries.all 
        erb :'/journal_enteries/index'
    end

    post '' do 

    end
end