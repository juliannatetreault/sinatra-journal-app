class UsersController < ApplicationController 

        #renders the signup page for a potential user.
        get '/users/signup' do 
            #binding.pry
            if !logged_in?
              erb :"/users/signup.html"
            else 
                redirect to '/journal_entries'
            end
        end
    
        #first, the post method looks to see whether the user has completely filled out the signup page with valid inputs.
        #if the user fails to do so, the user will be flashed an error message asking them to fill the form out completely.
        #the user will then be redirected to the signup page where they can attempt to signup again.
        #otherwise, if the user fills out the forms' fields completely and validly, the user will be created.
        #the new user will then be shown a success message.
        #following that, the user will be logged in and redirected to their page.
        post '/signup' do 
            if params[:username] == "" || params[:email] == "" || params[:password] == ""
                flash[:errors] = "Please fill out all fields to create an account."
                redirect to '/signup'
            else 
                @user = User.new(params)
                @user.save
                session[:user_id] = @user.id
                flash[:message] = "You have successfully created an account."
                redirect to '/journal_entries'
            end
        end
    
    #renders the login page for a user.
    get '/login' do 
      if logged_in?
        redirect to '/journal_entries'
      else 
        erb :'/users/login'
      end
    end

    #the post method will log a user in via a 'login' form via the post route.
    #the method will first attempt to look for and authenticate the user.
    #if the user fills in the form fields completely and accurately, the user will pass the authentication check and be logged in.
    #they will be greeted with a success message before being redirected to their journal page.
    #if a user fails to be authenticated or does not complete the form, the user will be shown an error message asking them to try again.
    #the user will then be redirected to the login page where they can try to login again.
    post '/login' do 
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/journal_entries'
        else  
            flash[:errors] = "Please sign up for an account before logging in."
            redirect to '/users/login'
        end
    end

    #the get method looks to find an exsisting user by their user id.
    #if the user exists, the user's journal entry show page will be rendered.
    get '/users/:id' do 
        if !logged_in?
            flash[:errors] = "You are not authorized to view this page."
            redirect to '/'
        else 
            @user = User.find_by(id: session[:user_id])
            erb :'/users/show'
        end
    end

    #post '/users' do 
    #   if params[:username] !="" && params[:email] != "" && params[:password] != ""
    #    @user = User.create(params)
    #    session[:user_id] = @user.id
    #    redirect to "/users/#{@user.id}"
    #   else 
    #    redirect to '/signup'
    #end
#end

    #first checks to see if a user is logged in.
    #if a user is logged in, the logout method will clear the user's session, thus logging them out.
    #the user will then be redirected to the login page.
    get '/logout' do 
      if logged_in?
        logout!
        flash[:message] = "You have successfully logged out."
        redirect to '/login'
      else 
        redirect to '/'
    end
  end

end