class GenerateDefaultUserRoles < ActiveRecord::Migration[5.2]
  def change
    #create_general_roles
    UserRole.create(name: "System admin")
    UserRole.create(name: "Company owner")
    UserRole.create(name: "Company admin")
    UserRole.create(name: "Warehouse admin")
    UserRole.create(name: "Dispatcher")
    UserRole.create(name: "Inspector")
    UserRole.create(name: "Warehouse Manager")
  end
end
