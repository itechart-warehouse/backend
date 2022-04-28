#create default roles
UserRole.create(name: "System admin", code: 'sadmin')
UserRole.create(name: "Company owner", code: 'cowner')
UserRole.create(name: "Company admin", code: 'cadmin')
UserRole.create(name: "Warehouse admin", code: 'wadmin')
UserRole.create(name: "Dispatcher", code: 'dispatcher')
UserRole.create(name: "Inspector", code: 'inspector')
UserRole.create(name: "Warehouse Manager", code: 'wmanager')
Company.create(name: "adminCo",
               email: "admonCo@admin.admin",
               address: "AdminCoCo",
               phone: "+375-(29)-9933171")
User.create(email: "admin@admin.admin",
            password: ENV['BASE_USER_PASSWORD'],
            first_name: "Robert",
            last_name: "Ford",
            user_role_id: 1,
            company_id: 1,
            birth_date: "1980-01-15",
            address: "Gagarin Street 15, Gomel")

Warehouse.create(name: "AdminCoWarehouse",
                 address: "Gagarin Street 15, Gomel",
                 phone: "+375-(29)-9933172",
                 area: "100000",
                 company_id: 1)

User.create(email: "waradmin@admin.admin",
            password: ENV['BASE_USER_PASSWORD'],
            first_name: "Carol",
            last_name: "Baker",
            user_role_id: 4,
            company_id: 1,
            warehouse_id: 1,
            birth_date: "1980-01-15",
            address: "Gagarin Street 17, Gomel")
User.create(email: "disadmin@admin.admin",
            password: ENV['BASE_USER_PASSWORD'],
            first_name: "Susan",
            last_name: "Brown",
            user_role_id: 5,
            company_id: 1,
            warehouse_id: 1,
            birth_date: "1980-01-15",
            address: "Gagarin Street 17, Gomel")

User.create(email: "insadmin@admin.admin",
            password: ENV['BASE_USER_PASSWORD'],
            first_name: "Marlene",
            last_name: "Gonzalez",
            user_role_id: 6,
            company_id: 1,
            warehouse_id: 1,
            birth_date: "1980-01-15",
            address: "Gagarin Street 17, Gomel")

User.create(email: "manadmin@admin.admin",
            password: ENV['BASE_USER_PASSWORD'],
            first_name: "Joel",
            last_name: "Kim",
            user_role_id: 7,
            company_id: 1,
            warehouse_id: 1,
            birth_date: "1980-01-15",
            address: "Gagarin Street 17, Gomel")

Company.create(name: "Appple",
               email: "Appple@inside.com",
               address: "Ulitsa Pedchenko 10, Gomel",
               phone: "+375-(29)-9933173")
Company.create(name: "Asssus",
              email: "Asssus@inside.com",
              address: "Gagarin Street 65, Gomel",
              phone: "+375-(29)-9923174")
Company.create(name: "CoCoLaLa",
             email: "CoCoLaLa@inside.com",
             address: " Chatajevič St 9, Gomel",
             phone: "+375-(29)-9433217")
User.create(email: "Appple@admin.admin",
           password: ENV['BASE_USER_PASSWORD'],
           first_name: "Virginia",
           last_name: "Ramos",
           user_role_id: 2,
           company_id: 2,
           birth_date: "1980-01-15",
           address: "Ulitsa Pedchenko 10, Gomel")
User.create(email: "Asssus@admin.admin",
          password: ENV['BASE_USER_PASSWORD'],
          first_name: "Jessie",
          last_name: "Marshall",
          user_role_id: 2,
          company_id: 3,
          birth_date: "1980-01-15",
          address: "Gagarin Street 65, Gomel")
User.create(email: "CoCoLaLa@admin.admin",
           password: ENV['BASE_USER_PASSWORD'],
           first_name: "Joan",
           last_name: "McKenzie",
           user_role_id: 2,
           company_id: 4,
           birth_date: "1980-01-15",
           address: "Chatajevič St 9, Gomel")
ReportType.create(name: "Discrepancy")
ReportType.create(name: "Spoiled")
ReportType.create(name: "Stolen")
