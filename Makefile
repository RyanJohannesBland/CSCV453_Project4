parse: scanner.l parser.y
	lex scanner.l
	yacc -v -d parser.y
	gcc lex.yy.c y.tab.c symtable_provided.c

clean:
	rm *.o
	rm parser


test: scanner.l parser.y
	./a.out < testcases/test01.c
	./a.out < testcases/test02.c
	./a.out < testcases/test03.c
	./a.out < testcases/test04.c
	./a.out < testcases/test05.c
	./a.out < testcases/test06.c
	./a.out < testcases/test07.c
	./a.out < testcases/test08.c
	./a.out < testcases/test09.c
	./a.out < testcases/test10.c
	./a.out < testcases/test11.c
	./a.out < testcases/test12.c
	./a.out < testcases/test13.c
	./a.out < testcases/test14.c
	./a.out < testcases/test15.c
	./a.out < testcases/test16.c
	./a.out < testcases/test17.c
	./a.out < testcases/test18.c
	./a.out < testcases/test19.c
	./a.out < testcases/test20.c
