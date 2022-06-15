# Makefile
first-start:
	dip build
	dip bundle install
	dip rails db:reset
	dip up -d

rebuild:
	dip bundle install
	dip build

