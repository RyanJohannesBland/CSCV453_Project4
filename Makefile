parse: scanner.l parser.y
	lex scanner.l
	yacc -v -d parser.y
	gcc lex.yy.c y.tab.c symtable_provided.c syntax_tree.c

clean:
	rm *.o
	rm parser


test_old: scanner.l parser.y
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

test: scanner.l parser.y
	./a.out < tests/test01.c
	./a.out < tests/test02.c
	./a.out < tests/test03.c
	./a.out < tests/test04.c
	./a.out < tests/test05.c
	./a.out < tests/test06.c
	./a.out < tests/test07.c
	./a.out < tests/test08.c
	./a.out < tests/test09.c
	./a.out < tests/test10.c
	./a.out < tests/test11.c
	./a.out < tests/test12.c
	./a.out < tests/test13.c
	./a.out < tests/test14.c
	./a.out < tests/test15.c
	./a.out < tests/test16.c
	./a.out < tests/test17.c
	./a.out < tests/test18.c
	./a.out < tests/test19.c
	./a.out < tests/test20.c
	./a.out < tests/test21.c
	./a.out < tests/test22.c
	./a.out < tests/test23.c
	./a.out < tests/test24.c
	./a.out < tests/test25.c
	./a.out < tests/test26.c
	./a.out < tests/test27.c
	./a.out < tests/test28.c
	./a.out < tests/test29.c
	./a.out < tests/test30.c
	./a.out < tests/test31.c
	./a.out < tests/test32.c
	./a.out < tests/test33.c
	./a.out < tests/test34.c
	./a.out < tests/test35.c
	./a.out < tests/test36.c
	./a.out < tests/test37.c
	./a.out < tests/test38.c
	./a.out < tests/test39.c
	./a.out < tests/test40.c
	./a.out < tests/test41.c
	./a.out < tests/test42.c
	./a.out < tests/test43.c
	./a.out < tests/test44.c
	./a.out < tests/test45.c
	./a.out < tests/test46.c
	./a.out < tests/test47.c
	./a.out < tests/test48.c
	./a.out < tests/test49.c
	./a.out < tests/test50.c
	./a.out < tests/test51.c
	./a.out < tests/test52.c
	./a.out < tests/test53.c
	./a.out < tests/test54.c
	./a.out < tests/test55.c
	./a.out < tests/test56.c
	./a.out < tests/test57.c
	./a.out < tests/test58.c
	./a.out < tests/test59.c
	./a.out < tests/test60.c
	./a.out < tests/test61.c
	./a.out < tests/test62.c
	./a.out < tests/test63.c
	./a.out < tests/test64.c
	./a.out < tests/test65.c
	./a.out < tests/test66.c
	./a.out < tests/test67.c
	./a.out < tests/test68.c
	./a.out < tests/test69.c
	./a.out < tests/test70.c
	./a.out < tests/test71.c
	./a.out < tests/test72.c
	./a.out < tests/test73.c
	./a.out < tests/test74.c
	./a.out < tests/test75.c
