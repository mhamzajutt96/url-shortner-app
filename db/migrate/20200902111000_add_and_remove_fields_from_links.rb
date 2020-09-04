class AddAndRemoveFieldsFromLinks < ActiveRecord::Migration[6.0]
  def change
    remove_column :links, :url, :string
    remove_column :links, :slug, :string
    add_column :links, :original_url, :text
    add_column :links, :short_url, :string
    add_column :links, :sanitize_url, :string
  end
end
