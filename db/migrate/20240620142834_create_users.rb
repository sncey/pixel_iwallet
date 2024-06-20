class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :street
      t.string :suite
      t.string :city
      t.string :zipcode
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
