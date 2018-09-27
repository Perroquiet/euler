-module(prob14).
-compile(export_all).
-define(NUM, 1000000).

start() ->
	start(?NUM, [{0,0}]).
start(0, Length) ->
	hd(Length);
start(Num, Length) ->
	J = collatz(Num),
	{_,Len} = hd(Length),
	if
		J > Len ->
			io:format("~w ~w~n", [Num,J]),
			start(Num-1, [{Num,J}|Length]);
		true ->
			start(Num-1, Length)
	end.

collatz(Num) ->
	collatz(Num,[]).
collatz(1,Seq) ->
	length(Seq);
collatz(Num,Seq) ->
	if
		(Num rem 2) == 1 ->
			NewSeq = trunc((Num*3)+1),
			collatz(NewSeq,[NewSeq|Seq]);
		true ->
			New = trunc(Num/2), 
			collatz(New,[New|Seq])
	end.