class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :username
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
      t.remove :current_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip
      t.remove :failed_attempts
      t.remove :unlock_token
      t.remove :locked_at

      t.rename :fullname, :name
    end
  end
end
