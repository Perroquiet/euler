-module(prob1).
-compile(export_all).

get_sum_multiples(N) ->
	get_sum_multiples(N-1, 0).
get_sum_multiples(0, Q) ->
	Q;
get_sum_multiples(P, Q) ->
	if
		((P rem 3) == 0) or ((P rem 5) == 0) ->
		X = P + Q;
		true ->
			X = Q
	end,
	get_sum_multiples(P-1, X).