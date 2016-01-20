ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email, :first_name, :last_name, :admin
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
index do
    selectable_column
    column :id
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :admin
    actions
  end




end
