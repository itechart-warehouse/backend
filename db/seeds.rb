#create default roles
UserRole.create(name: "System admin")
UserRole.create(name: "Company owner")
UserRole.create(name: "Company admin")
UserRole.create(name: "Warehouse admin")
UserRole.create(name: "Dispatcher")
UserRole.create(name: "Inspector")
UserRole.create(name: "Warehouse Manager")
Company.create(name: "Appl11e",
               email: "g1g@g.c",
               address: "pomos4_ne_pridet",
               phone: "+73333333333")
User.create(email: "admin@admin.admin",
            password: "12345678",
            password_confirmation: "12345678",
            first_name: "Admin",
            last_name: "Adminovi4",
            user_role_id: 1,
            company_id: 1,
            birth_date: "66.66.666",
            address: "admin room")
