class AddContentToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :content, :text
    add_reference :posts, :user, foreign_key: true
  end
end
