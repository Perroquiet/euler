-module(prob5).
-compile(export_all).

no_rem(List) ->
	no_rem(List, List, 7256535).
no_rem(_, [], Z) ->
	Z;
no_rem(List, [H|T], Z) ->
	Rem = Z rem H,
	case Rem of
		0 ->
			no_rem(List, T, Z);
		_ ->
			no_rem(List, List, Z+7256535)
	end.