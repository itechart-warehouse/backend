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
               phone: "+73333335555")
User.create(email: "admin@admin.admin",
            password: "12345678",
            password_confirmation: "12345678",
            first_name: "Admin",
            last_name: "Adminovi4",
            user_role_id: 1,
            company_id: 1,
            birth_date: "66.66.666",
            address: "admin room")


Company.create(name: "Appple",
               email: "Appple@inside.com",
               address: "Ulitsa Pedchenko 10, Gomel",
               phone: "+73333333311")
Company.create(name: "Asssus",
              email: "Asssus@inside.com",
              address: "Gagarin Street 65, Gomel",
              phone: "+73333333322")
Company.create(name: "CoCoLaLa",
             email: "CoCoLaLa@inside.com",
             address: " Chatajevič St 9, Gomel",
             phone: "+73333333333")
User.create(email: "Appple@admin.admin",
           password: "Appple_12345678",
           password_confirmation: "Appple_12345678",
           first_name: "Appple_Admin",
           last_name: "Appple_Adminovi4",
           user_role_id: 2,
           company_id: 2,
           birth_date: "15.06.1989",
           address: "Ulitsa Pedchenko 10, Gomel")
User.create(email: "Asssus@admin.admin",
          password: "Asssus_12345678",
          password_confirmation: "Asssus_12345678",
          first_name: "Asssus_Admin",
          last_name: "Asssus_Adminovi4",
          user_role_id: 2,
          company_id: 3,
          birth_date: "16.05.1998",
          address: "Gagarin Street 65, Gomel")
User.create(email: "CoCoLaLa@admin.admin",
           password: "CoCoLaLa_12345678",
           password_confirmation: "CoCoLaLa_12345678",
           first_name: "CoCoLaLa_Admin",
           last_name: "CoCoLaLa_Adminovi4",
           user_role_id: 2,
           company_id: 4,
           birth_date: "19.05.1987",
           address: "Chatajevič St 9, Gomel")
