-module(prob16).
-compile(export_all).

start() ->
	X = math:pow(2,1000),
	lists:flatten(io_lib:format("~p", [X])).
	