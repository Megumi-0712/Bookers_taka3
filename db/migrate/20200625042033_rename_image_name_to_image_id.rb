class RenameImageNameToImageId < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :image_name, :image_id
  end
end
