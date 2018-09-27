-module(prob2).
-compile(export_all).


dummy(Sum) ->
	receive
		{add, Value} -> dummy(Sum+Value);
		{get, From} -> From ! {value, Sum}
	end.

fib_sum(N) ->
	register(summy, spawn(?MODULE, dummy, [2])),
	fib_sum(N, 1, 2).
fib_sum(N, Prev, Next) ->
	Current = Prev + Next,
	if 
		Current < N ->
			if
				((Current rem 2) == 0)  ->
					summy ! {add, Current};
				true ->
					true
			end,

			fib_sum(N, Next, Current);
		true ->
			summy ! {get, self()},
			receive
				{value, Sum} -> Sum
			end
	end.