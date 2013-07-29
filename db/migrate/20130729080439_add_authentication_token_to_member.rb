class AddAuthenticationTokenToMember < ActiveRecord::Migration
  def change
    add_column :members, :confirmation_token, :string
    add_column :members, :confirmed_at, :datetime
    add_column :members, :confirmation_sent_at, :datetime
    add_column :members, :unconfirmed_email, :string
    add_column :members, :unlock_token, :string
    add_column :members, :authentication_token, :string

    add_index :members, :confirmation_token,   :unique => true
    add_index :members, :unlock_token,         :unique => true
    add_index :members, :authentication_token, :unique => true
  end
end