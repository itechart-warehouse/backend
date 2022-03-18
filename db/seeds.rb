#create default roles
UserRole.create(name: "System admin", code: 'c_sadmin')
UserRole.create(name: "Company owner", code: 'c_cowner')
UserRole.create(name: "Company admin", code: 'c_cadmin')
UserRole.create(name: "Warehouse admin", code: 'c_wadmin')
UserRole.create(name: "Dispatcher", code: 'c_dispatcher')
UserRole.create(name: "Inspector", code: 'c_inspector')
UserRole.create(name: "Warehouse Manager", code: 'c_wmanager')
Company.create(name: "adminCo",
               email: "admonCo@admin.admin",
               address: "AdminCoCo",
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
