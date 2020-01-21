class CreateAdvertiserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :advertiser_infos do |t|
      t.references :user, foreign_key: true
      t.string :organisation
      t.string :position

      t.timestamps
    end
  end
end
