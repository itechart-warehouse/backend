# Makefile
first-start:
	bundle install
	dip build
	dip bundle install
	dip rails db:reset
	dip up -d

rebuild:
	dip bundle install
	dip build

