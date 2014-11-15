class AddTokenToGadget < ActiveRecord::Migration
  def change
    add_column :gadgets, :token, :string
  end
end
