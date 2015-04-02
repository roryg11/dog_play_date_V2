class AddDogParksModel < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :title
      t.string :address
      t.integer :rating
      t.text :description
      t.float :latitude
      t.float :longitude
      
      t.timestamps null: false
    end
  end
end
