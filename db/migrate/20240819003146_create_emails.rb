class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :email
      t.string :to
      t.text :content

      t.timestamps
    end
  end
end
