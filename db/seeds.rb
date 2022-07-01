# create default roles
UserRole.create(name: 'System admin', code: 'sadmin')
UserRole.create(name: 'Company owner', code: 'cowner')
UserRole.create(name: 'Company admin', code: 'cadmin')
UserRole.create(name: 'Warehouse admin', code: 'wadmin')
UserRole.create(name: 'Dispatcher', code: 'dispatcher')
UserRole.create(name: 'Inspector', code: 'inspector')
UserRole.create(name: 'Warehouse Manager', code: 'wmanager')

Company.create(name: 'adminCo',
               email: 'admonCo@admin.admin',
               address: 'AdminCoCo',
               phone: '+375-(29)-9933171')

User.skip_callback(:validation, :before, :generate_password)

User.create(email: 'admin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Robert',
            last_name: 'Ford',
            user_role_id: 1,
            company_id: 1,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 15, Gomel',
            confirmed_at: DateTime.now)

Warehouse.create(name: 'AdminCoWarehouse',
                 address: 'Gagarin Street 15, Gomel',
                 phone: '+375-(29)-9933172',
                 area: '100000',
                 company_id: 1)

User.create(email: 'cowadmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Armen',
            last_name: 'Bader',
            user_role_id: 2,
            company_id: 1,
            birth_date: '1983-07-15',
            address: 'Gagarin Street 77, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'comadmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Amin',
            last_name: 'Bader',
            user_role_id: 3,
            company_id: 1,
            birth_date: '1982-04-15',
            address: 'Gagarin Street 77, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'waradmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Carol',
            last_name: 'Baker',
            user_role_id: 4,
            company_id: 1,
            warehouse_id: 1,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 17, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'disadmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Susan',
            last_name: 'Brown',
            user_role_id: 5,
            company_id: 1,
            warehouse_id: 1,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 17, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'insadmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Marlene',
            last_name: 'Gonzalez',
            user_role_id: 6,
            company_id: 1,
            warehouse_id: 1,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 17, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'manadmin@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Joel',
            last_name: 'Kim',
            user_role_id: 7,
            company_id: 1,
            warehouse_id: 1,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 17, Gomel',
            confirmed_at: DateTime.now)

Company.create(name: 'Appple',
               email: 'Appple@inside.com',
               address: 'Ulitsa Pedchenko 10, Gomel',
               phone: '+375-(29)-9933173')

Company.create(name: 'Asssus',
               email: 'Asssus@inside.com',
               address: 'Gagarin Street 65, Gomel',
               phone: '+375-(29)-9923174')

Company.create(name: 'CoCoLaLa',
               email: 'CoCoLaLa@inside.com',
               address: ' Chatajevič St 9, Gomel',
               phone: '+375-(29)-9433217')

User.create(email: 'Appple@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Virginia',
            last_name: 'Ramos',
            user_role_id: 2,
            company_id: 2,
            birth_date: '1980-01-15',
            address: 'Ulitsa Pedchenko 10, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'Asssus@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Jessie',
            last_name: 'Marshall',
            user_role_id: 2,
            company_id: 3,
            birth_date: '1980-01-15',
            address: 'Gagarin Street 65, Gomel',
            confirmed_at: DateTime.now)

User.create(email: 'CoCoLaLa@admin.admin',
            password: ENV['BASE_USER_PASSWORD'],
            first_name: 'Joan',
            last_name: 'McKenzie',
            user_role_id: 2,
            company_id: 4,
            birth_date: '1980-01-15',
            address: 'Chatajevič St 9, Gomel',
            confirmed_at: DateTime.now)

User.set_callback(:validation, :before, :generate_password)

ReportType.create(name: 'Discrepancy')
ReportType.create(name: 'Spoiled')
ReportType.create(name: 'Stolen')

Country.create(name: 'Poland')
Country.create(name: 'Belarus')
Country.create(name: 'USA')
Country.create(name: 'Russia')
Country.create(name: 'Japan')

City.create(name: 'Warsaw',
            country_id: 1)
City.create(name: 'Lublin',
            country_id: 1)
City.create(name: 'Minsk',
            country_id: 2)
City.create(name: 'Grodno',
            country_id: 2)
City.create(name: 'Washington',
            country_id: 3)
City.create(name: 'Chicago',
            country_id: 3)
City.create(name: 'Moscow',
            country_id: 4)
City.create(name: 'Saint Petersburg',
            country_id: 4)
City.create(name: 'Tsushima',
            country_id: 5)
City.create(name: 'Komaki',
            country_id: 5)

