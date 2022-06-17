# Makefile

provision:
	@dip provision

build:
	bundle install
	dip build
	dip bundle install
	dip up -d
	dip rails db:reset

reset:
	@dip rails db:reset

migrate:
	@dip rails db:migrate

rollback:
	@dip rails db:rollback

