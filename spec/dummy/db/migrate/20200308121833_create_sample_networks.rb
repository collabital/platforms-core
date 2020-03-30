class CreateSampleNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_networks do |t|
      t.integer :platforms_network_id
      t.timestamps
    end
  end
end
