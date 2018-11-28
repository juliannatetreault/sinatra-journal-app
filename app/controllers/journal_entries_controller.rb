class JournalEntriesController < ApplicationController

    #if the user is logged in, all of their journal enteries will be rendered via the entry index page.
    #otherwise, they will be redirected to the signup page.
    get '/journal_entries' do 
        if logged_in?
            #@user = current_user
            @journal_entries = current_user.journal_entries
            erb :'/journal_entries/index'
        else 
            redirect to '/users/signup'
        end
      end

    #checks to see if a user is logged in.
    #gets the 'new' form to render so that a user is able to create a new entry.
    #if the user is not logged in, the user cannot continue and is redirected to the login page.
    get '/journal_entries/new' do 
        if logged_in?
            erb :'/journal_entries/new'
        else 
          redirect to '/users/login'
        end
    end

     #posts 'entries' to create a new journal entry.
    #first, check to see if the user is logged in.
    #if the user is logged in, they will have the ability to create a new, valid entry.
    #a message will be displayed to the user showing that they've successfully created a new entry.
    #if the entry is invalid, an error message will be displayed and the user will be redirected to the form to try again.
    #otherwise, the user will be redirected to the login page.
    post '/journal_entries' do  
        if logged_in?
            @journal_entry = current_user.journal_entries.create(content: params[:content])
            flash[:message] = "You have successfully created a new journal entry."
            redirect to '/journal_entries'
        else 
            erb :"/journal_entries/new"
        end
    end
  
    #checks to see if the user is logged in.
    #gets the show page for the user's enteries.  
    #if the user is not logged in, they will be redirected to the login page.
    get '/journal_entries/:id' do
        if logged_in?
            @journal_entry = JournalEntry.find_by(id: params[:id]) 
            erb :"/journal_entries/show"
        else
            redirect to '/users/login'
        end
    end

    #checks to see if a user is logged in.
    #if the user is logged in and the entry belongs to the current user, the entry edit page will be rendered for the user.
    #otherwise, the user will be redirected to their entry page.
    #if none of that, then the user will be redirected to the login page.
    get '/journal_entries/:id/edit' do 
        if logged_in?
            @journal_entry = JournalEntry.find_by(id: params[:id])
            if current_user.id == @journal_entry.user_id
                erb :"/journal_entries/edit"
            else 
                flash[:errors] = "You are not authorized to edit this entry. Please login to continue."
                redirect to '/users/login'
            end
    end

    #first, check to see if the user is logged in.
    #if the user is logged in, but their entry is empty, the user will then be redirected to their entry edit page.
    #otherwise, check to see if there is an entry and if said entry belongs to the current user.
    #if the entry belongs to the current user, allow the user to follow through with editing their entry.
    #then redirect that user to the updated entry page.
    #otherwise, redirect the user to the edit page to make a valid update to their entry.
    #if that doesn't work, redirect the user to their entry show page.
    #if all else fails, redirect the user to the login page.
    patch '/journal_entries/:id' do 
        if logged_in?
            @journal_entry = JournalEntry.find_by(id: params[:id])
            @journal_entry.content = params[:content]
            if @journal_entry.save 
                flash[:message] = "You have successfully updated your entry."
                redirect to '/journal_entries'
            else 
                redirect to "/journal_entries/#{@journal_entry.id}/edit"
            end
        end
      end

    #check to see if a user is logged in.
    #begin by finding the user's post by id.
    #if the post exists, and the current user wishing to perform the action is the entery's author, the entry will successfully be deleted.
    #the user will then see a deletion confirmation message and be redirected to their entry show page.
    #otherwise, the user will be greeted with an error message and will be redirected to the login page.
    delete '/entries/:id' do 
    if logged_in?
        @journal_entry = JournalEntry.find_by(id: params[:id])
        if current_user.id == @journal_entry.user_id
            @journal_entry.delete
            flash[:message] = "You have successfully deleted your entry."
            redirect to '/journal_entries'
        else 
            redirect to '/users/login'
        end
    end          
  end
end

end

