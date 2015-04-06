class ChangeDogBioToText < ActiveRecord::Migration
  def change
    change_column :dogs, :bio, :text
  end
end
