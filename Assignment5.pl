%Author: Wansi Liang

%Part 1

%make, model, year, widget type, number sold
%widget repair -- 300 type $728.63 -- 400 type $439.52
mmyws(ium+titan/2010/300/224507).
mmyws(ium+titan/2011/300/262391).
mmyws(ium+titan/2012/400/267041).
mmyws(ium+titan/2013/500/268842).
mmyws(ium+titan/2014/500/263528).

mmyws(ium+pluton/2010/300/99356).
mmyws(ium+pluton/2011/300/76184).
mmyws(ium+pluton/2012/300/65830).

mmyws(ium+zircon/2010/400/326624).
mmyws(ium+zircon/2011/400/337295).
mmyws(ium+zircon/2012/500/332653).
mmyws(ium+zircon/2013/500/330106).
mmyws(ium+zircon/2014/500/335865).

mmyws(cosmos+dyne/2010/400/145522).
mmyws(cosmos+dyne/2011/500/149490).
mmyws(cosmos+dyne/2012/500/151870).
mmyws(cosmos+dyne/2013/500/149911).
mmyws(cosmos+dyne/2014/500/149405).

mmyws(cosmos+flux/2010/300/106221).
mmyws(cosmos+flux/2011/300/105672).
mmyws(cosmos+flux/2012/300/105079).
mmyws(cosmos+flux/2013/300/110415).

mmyws(cosmos+orbit/2010/400/85164).
mmyws(cosmos+orbit/2011/400/82390).

%Question 1.1
currency_round(X, Y) :- 
	round(X*100, Z), 
	Y is Z / 100.
		
%Question 1.2
recall_information(X, Y) :- 
	findall(A-B-C, mmyws(A+B/C/300/E);mmyws(A+B/C/400/E), X), 
	findall(E, mmyws(A+B/C/300/E), E300), 
	recall_information_helper(E300, T300), 
	findall(E, mmyws(A+B/C/400/E), E400), 
	recall_information_helper(E400, T400), 
	T is T300 * 728.63 + T400 * 439.52, 
	currency_round(T, Y). 

recall_information_helper([], 0). 
recall_information_helper([H | T], S) :- 
	recall_information_helper(T, Y),
	S is H + Y. 
	
print_list([]).
print_list([Head|Tail]) :-
  format('~w~n', Head),
  print_list(Tail).	

%Part 2 

%Question 2.1
foldl1(X, [H | T], Z) :- 
	foldl1_helper(X, T, H, Z), 
	!. 

foldl1_helper(_, [], Z, Z). 
foldl1_helper(X, [H | T], C, Z) :- 
	call(X, C, H, N), 
	foldl1_helper(X, T, N, Z). 

subtract(X, Y, Z) :-
	Z is X - Y. 
		
%Queestion 2.2
foldr1(_, [H], H) :- 
	!. 
foldr1(X, [H | T], Z) :- 
	foldr1(X, T, C), 
	call(X, H, C, Z). 
