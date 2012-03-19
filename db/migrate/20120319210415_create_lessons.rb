class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string    :title
      t.text      :description
      t.integer   :level
      t.boolean   :public
      t.string    :teacher_name
      t.string    :video
      t.string    :image
      t.text      :script
      t.timestamps
    end
  end
end
