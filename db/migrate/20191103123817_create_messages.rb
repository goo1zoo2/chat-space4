class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.text       :content
      t.string     :image
      t.timestamps null: true
    end
  end
end
