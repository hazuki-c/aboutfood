class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3

      t.timestamps
    end
  end
end
