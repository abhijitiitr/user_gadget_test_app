class AddGadgetTokenToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :gadget_token, :string
  end
end
