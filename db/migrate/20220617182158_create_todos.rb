class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :description
      t.uuid :user_id

      t.timestamps
    end
  end
end
