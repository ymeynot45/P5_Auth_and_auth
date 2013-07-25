class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_hash
      t.string :access_level, default: 1

      t.timestamps
    end
  end
end
