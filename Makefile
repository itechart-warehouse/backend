# Makefile

build:
	@if "%OS%" == "Windows_NT" (make build-windows) ELSE (make build-linux)


build-windows:
	@gem install dip
	@dip provision
	@lefthook install

build-linux:
	@which dip &> /dev/null || gem install dip
	@which lefthook &> /dev/null || gem install lefthook
	@dip provision
	@lefthook install
