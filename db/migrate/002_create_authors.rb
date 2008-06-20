class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table "authors", :force => true do |t|
      t.string      :login, :email
      t.string      :crypted_password,          :limit => 40
      t.string      :salt,                      :limit => 40
      t.string      :remember_token
      t.datetime    :remember_token_expires_at
      t.timestamps
      t.string      :first_name, :last_name, :website, :identity_url
      t.text        :notes
    end
  end

  def self.down
    drop_table "authors"
  end
end
