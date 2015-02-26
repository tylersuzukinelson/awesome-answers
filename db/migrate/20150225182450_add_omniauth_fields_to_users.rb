class AddOmniauthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :twitter_consumer_token, :string
    add_column :users, :twitter_consumer_secret, :string
    add_column :users, :omniauth_raw_data, :text

    add_index :users, [:provider, :uid] # Composite index

    # Currently this index is set to have a unique e-mail
    # which will disallow multiple users with no e-mail
    remove_index :users, :email
    add_index :users, :email
  end
end
