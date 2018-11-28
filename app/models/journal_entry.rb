class JournalEntry < ActiveRecord::Base 
    belongs_to :user 

    validates :content, presence: true
end