class CreateExports < ActiveRecord::Migration
  def change

    create_table :exports do |t|
      t.integer :user_id
      t.timestamps
    end

    add_attachment :exports, :export

  end
end
