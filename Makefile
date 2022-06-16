# Makefile

provision:
	dip provision

build:
	bundle install
	dip build
	dip bundle install
	dip rails db:reset
	dip up -d

start:
	dip up -d

down:
	dip down

reset:
	dip rails db:reset

migrate:
	dip rails db:migrate

rollback:
	dip rails db:rollback

rspec:
	dip rspec

rebuild:
	dip bundle install
	dip build

