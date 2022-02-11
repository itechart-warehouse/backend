#create default roles
UserRole.create(name: "System admin")
UserRole.create(name: "Company owner")
UserRole.create(name: "Company admin")
UserRole.create(name: "Warehouse admin")
UserRole.create(name: "Dispatcher")
UserRole.create(name: "Inspector")
UserRole.create(name: "Warehouse Manager")
User.create(email: "admin@admin.admin", password: "12345678", password_confirmation: "12345678", role_id: 1)
