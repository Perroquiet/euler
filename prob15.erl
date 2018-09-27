-module(prob15).
-compile(export_all).

counts(Num) ->
	receive
		{add} ->
			counts(Num+1);
		{get, From} ->
			From ! {send, Num}
	end.


routes(X,Y) ->
	Pid = spawn(?MODULE, counts, [0]),
	Moves = X+Y,
	NewX = lists:seq(1,X),
	NewY = lists:seq(1,Y),
	OrigData = {X,Y,Moves},
	routes(Pid,NewX,NewY,Moves,OrigData).
routes(Pid,_,_,0,OrigData) ->
	Pid ! {add},
	{X,Y,Moves} = OrigData,
	routes(Pid,X,Y,Moves,OrigData)
routes(Pid,X,Y,Moves,OrigData) ->
	routes(Pid,X,Y,Moves-1,OrigData)