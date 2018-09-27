-module(prob10).
-compile(export_all).

series(List, PrimesList) ->
	receive
		{del, From, SieveList, P} ->
			NewList = ordsets:subtract(List, SieveList),
			io:format("~w~n", [P]),
			From ! {notif},
			series(NewList,[P|PrimesList]);
		{get, From} ->
			From ! {get, List},
			series(List, PrimesList);
		{sum, From} ->
			TotalSum = lists:foldl(fun(X, Sum) -> X+Sum end, 0, PrimesList),
			From ! {sum, TotalSum},
			series(List, PrimesList)
	end.

sum_primes(N) ->
	List = lists:seq(2,N),
	Pid = spawn(?MODULE, series, [List, []]),
	sum_primes(Pid, N).
sum_primes(Pid, 0) ->
	Pid ! {sum, self()},
	receive
		{sum, Sum} -> Sum
	end;
sum_primes(Pid, N) ->
	Pid ! {get, self()},
	receive
		{get, List} -> ok
	end,
	case List of
		[] ->
			sum_primes(Pid,0);
		X ->
			P = hd(X),
			if
				P<N ->
					SieveList = get_list_items(List, P, []),
					Pid ! {del, self(), SieveList, P},
					receive
						{notif} -> sum_primes(Pid, N)
					end;
				true ->
					sum_primes(Pid, N-1)
			end
	end.


get_list_items([], _, List) ->
	lists:reverse(List);
get_list_items([H|T], P, List) ->
	if
		(H rem P) == 0 ->
			get_list_items(T, P, [H|List]);
		true ->
			get_list_items(T, P, List)
	end.