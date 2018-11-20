class UsersController < ApplicationController 

    get '/login' do 

        erb :login
    end

    post '/login' do 

        redirect to '/login'
    end

    get '/signup' do 

        erb :signup
    end

    post '/signup' do 

        redirect to '/signup'
    end

end