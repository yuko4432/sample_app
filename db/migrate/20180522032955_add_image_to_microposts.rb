class AddImageToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :image, :strong
  end
end
