all:
	dune build && ./_build/default/src/main.exe

clean:
	rm -r _build
