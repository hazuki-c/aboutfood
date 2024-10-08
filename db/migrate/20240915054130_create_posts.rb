class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title
      t.string :body
      t.string :image
      t.timestamps
    end
  end
end
