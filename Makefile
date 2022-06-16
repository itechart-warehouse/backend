# Makefile

provision:
	@dip provision

build:
	@bundle install
	@dip build
	@dip bundle install
	@dip rails db:reset
	@dip up -d

reset:
	@dip rails db:reset

migrate:
	@dip rails db:migrate

rollback:
	@dip rails db:rollback

