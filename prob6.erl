-module(prob6).
-compile(export_all).

% Sum square difference
ss_diff(List) ->
	square_sum(List) - sum_square(List).

% Sum of the square
sum_square(List) ->
	sum_square(List, 0).
sum_square([], Sum) ->
	Sum;
sum_square([H|T], Sum) ->
	sum_square(T, (H*H)+Sum).

% Square of the sum
square_sum(List) ->
	square_sum(List, 0).
square_sum([], Sum) ->
	Sum*Sum;
square_sum([H|T], Sum) ->
	square_sum(T, H+Sum).