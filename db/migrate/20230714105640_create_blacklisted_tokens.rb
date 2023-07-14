class CreateBlacklistedTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :blacklisted_tokens do |t|
      t.string :token
      t.references :user, foreign_key: true
      t.datetime :expire_at

      t.timestamps
    end
  end
end
