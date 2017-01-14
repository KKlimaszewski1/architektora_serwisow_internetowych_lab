class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :tytuł
      t.text :składniki
      t.text :opis
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
