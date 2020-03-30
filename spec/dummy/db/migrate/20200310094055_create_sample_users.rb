class CreateSampleUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_users do |t|
      t.integer :platforms_user_id
      t.timestamps
    end
  end
end
