ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :token
    t.string :auth_token
    t.string :auth_secret
  end
end
