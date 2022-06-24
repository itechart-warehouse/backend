# Makefile
build:
	@which dip &> /dev/null || gem install dip
	@which lefthook &> /dev/null || gem install lefthook
	@dip provision
	@lefthook install
