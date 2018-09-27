-module(prob7).
-compile(export_all).

find_prime(N) ->
	find_prime(N-1, 3).
find_prime(0, P) ->
	P-2;
find_prime(N, P) ->
	case prob3:is_prime(P) of
		true ->
			find_prime(N-1, P+2);
		false ->
			find_prime(N, P+2)
	end.