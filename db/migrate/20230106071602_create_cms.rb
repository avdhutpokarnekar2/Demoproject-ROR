class CreateCms < ActiveRecord::Migration[6.1]
  def change
    create_table :cms do |t|
      t.string   :title
      t.text     :content
      t.text     :meta_title
      t.text     :meta_description
      t.text     :meta_keyword
      t.timestamps
    end
  end
end
