class AddOriginDomainToApiApps < ActiveRecord::Migration[5.0]
  def change
    add_column :api_apps, :origin_domain, :string
  end
end
