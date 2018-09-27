-module(prob3).
-compile(export_all).

lpf(N) ->
	lpf(N,3, []).
lpf(N, P, List) when P>=N ->
	hd(List);
lpf(N, P, List) ->
	if % checks if divisible by 2
		((N rem P) == 0) ->
			case is_prime(P) of
				true ->
					io:format("~w~n", [P]),
					lpf(N, P+2, [P|List]);
				false ->
					lpf(N, P+2, List)
			end;
		true ->
			lpf(N, P+2, List)
	end.


is_prime(N) ->
	case N of
		2 ->
			true;
		3 ->
			true;
		X when ((X rem 2) == 0) ->
			false;
		_ ->	
			is_prime(N, 3)
	end.
is_prime(N, P) when P>=N ->
	true;
is_prime(N, P) when P<N ->
	if
		((N rem P) == 0) ->
			false;
		true ->
			is_prime(N, P+2)
	end.