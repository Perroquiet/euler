-module(prob12).
-compile(export_all).

tri_num() ->
	tri_num(2,1).
tri_num(0,_) ->
	ok;
tri_num(N,TriNum) ->
	NewTriNum = N+TriNum,
	%io:format("TriNum: ~w~n",[TriNum]),
	FactorsNum = length(get_all_factors(TriNum)),
	if
		FactorsNum > 500 ->
			io:format("TriNum: ~w, NumFactors: ~w~n",[TriNum, FactorsNum]),
			timer:sleep(infinity),
			tri_num(0,TriNum);
		true ->
			ok
	end,
	%io:format("TriNum: ~w, NumFactors: ~w~n",[NewTriNum, FactorsNum]),
	tri_num(N+1,NewTriNum).

factors(List) ->
	receive
		{add, Factor} ->
			factors([Factor|List]);
		{get, From} ->
			From ! {factors, List}
	end.	

get_all_factors(N) ->
	Max = trunc(math:sqrt(N)),
	Pid = spawn(?MODULE, factors, [[]]),
	get_all_factors(N,Pid,1,Max).
get_all_factors(_,Pid,Min,Max) when Min > Max ->
	Pid ! {get, self()},
	receive
		{factors, List} -> List
	end;
get_all_factors(N,Pid,Min,Max) ->
	if
		(N rem Min) == 0 ->
			Pid ! {add, Min},
			if
				Min /= (N/Min) ->
					Pid ! {add, trunc(N/Min)};
				true ->
					ok
			end;
			true ->
				ok
	end,
	get_all_factors(N,Pid,Min+1,Max).


get_all_prime_factors(N) ->
	get_all_prime_factors(N,N,[]).
get_all_prime_factors(_,0,List) ->
	%io:format("~w~n", [List]),
	List;
get_all_prime_factors(N,Factor,List) ->
	if
		(N rem Factor) == 0 ->
			get_all_prime_factors(N,Factor-1,[Factor|List]);
		true ->
			get_all_prime_factors(N,Factor-1,List)
	end.


check_num_divs(TriNum) ->
	PrimesL = sieve(TriNum),
	PrimeFactorsL = check_prime_factor(PrimesL,TriNum,[]),
	PrimeFactorsL.


check_prime_factor([],_,Acc) ->
	lists:reverse(Acc);
check_prime_factor([H|T],Num,Acc) ->
	if
		(Num rem H) == 0 ->
			check_prime_factor(T,Num,[H|Acc]);
		true ->
			check_prime_factor(T,Num,Acc)
	end.
	
sieve([]) ->
    [];
sieve([H|T]) -> 		 
    List = lists:filter(fun(N) -> N rem H /= 0 end, T),
    [H|sieve(List)];
sieve(N) ->
    sieve(lists:seq(2,N)).