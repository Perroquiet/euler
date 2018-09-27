-module(prob4).
-compile(export_all).

dummy(Pal, P, Q) ->
	receive
		{new, Value, X, Y} ->
			if
				Value>Pal ->
					dummy(Value, X, Y);
				true ->
					dummy(Pal,P,Q)
			end;
		{get, From} -> From ! {value, Pal, P, Q}
	end.

big_pal() ->
	register(pal, spawn(?MODULE, dummy, [0,0,0])),
	big_pal(999, 999).
big_pal(100,100) ->
	pal ! {get, self()},
	receive
		{value, Pal, P, Q} -> io:format("Palindrome is ~w with multipliers ~w and ~w~n", [Pal, P, Q])
	end;
big_pal(P, Q) ->
	Pal = P * Q,
	Chk = check_pal(Pal),
	case Chk of
		true ->
			pal ! {new, Pal, P, Q};
		false ->
			ok
	end,
	case Q of
		100 ->
			big_pal(P-1, 999);
		_ ->
			big_pal(P, Q-1)
	end.


check_pal(X) ->
	Pal = integer_to_list(X),
	RevPal = lists:reverse(Pal),
	case Pal of
		RevPal ->
			true;
		_ ->
			false
	end.