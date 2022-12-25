class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.column :name, :string
      t.column :email, :string  
      t.column :contact_no, :string
      t.column :message, :text
      t.timestamps
    end
  end
end
