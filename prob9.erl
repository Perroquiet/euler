-module(prob9).
-compile(export_all).

pyth_triplet(N) ->
	pyth_triplet(N,1,2).
pyth_triplet(N, A, B) when B==N ->
	pyth_triplet(N, A+1, A+2);
pyth_triplet(N, A, B) when A<B ->
	Asquare = math:pow(A,2),
	Bsquare = math:pow(B,2),
	Csquare = Asquare + Bsquare,
	C = math:sqrt(Csquare),
	io:format("A: ~w B: ~w C: ~w~n", [A,B,C]),
	if
		(A+B+C) == N ->
			{A, B, C};
		true ->
			pyth_triplet(N, A, B+1)
	end.
	


check_pyth(A, B, C) ->
	ABsquare =  math:pow(A,2) + math:pow(B,2),
	Csquare = math:pow(C,2),
	if
		ABsquare == Csquare ->
			true;
		true ->
			false
	end.
