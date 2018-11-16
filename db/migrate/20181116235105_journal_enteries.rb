class JournalEnteries < ActiveRecord::Migration
  def change
    create_table :journal_enteries do |t|
      t.string :content 
      t.integer :user_id
    end
  end
end
