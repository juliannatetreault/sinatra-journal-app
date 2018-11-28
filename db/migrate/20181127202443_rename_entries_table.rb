class RenameEntriesTable < ActiveRecord::Migration
  def change
    rename_table :journal_enteries, :journal_entries
  end
end
