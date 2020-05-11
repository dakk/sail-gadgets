all:
	#sudo rm -r _build
	dune build && ./_build/default/src/main.exe
