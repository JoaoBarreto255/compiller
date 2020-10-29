#compile@x-y: Compile Parser and Lexer
compile@x-and-y:
	alex -o src/Lexer.hs models/Lexer.x
	happy -o src/Parser.hs models/Parser.y

#compile@all
compile@all:
	alex -o src/Lexer.hs models/Lexer.x
	happy -o src/Parser.hs models/Parser.y
	stack build
	stack install

#exec@repl
exec@repl:
	stack exec crepl
