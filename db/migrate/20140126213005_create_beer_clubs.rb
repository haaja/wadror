class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|
      t.string :username
      t.int :founded
      t.string :city

      t.timestamps
    end
  end
end
