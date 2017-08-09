class AddFile < ActiveRecord::Migration[5.0]
  def change
    create_table :files do |t|
      t.attachment :file
    end
  end
end
