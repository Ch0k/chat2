class CreateRefreshTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :refresh_tokens do |t|
      t.string :token
      t.references :user, foreign_key: true
      t.datetime :expire_at

      t.timestamps
    end
    add_index :refresh_tokens, :token, unique: true
  end
end
