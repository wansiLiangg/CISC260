%Part 1
user(harry).
user(ron).
user(herminone).
user(petunia).
user(molly).
user(dumbledore).
user(testbirthday).

today(20,3,2019).

birthday(harry, date(31,7,1980)).
birthday(ron, date(1,3,1980)).
birthday(herminone, date(19,11,1979)).
birthday(petunia, date(6,9,1953)).
birthday(molly, date(27,2,1954)).
birthday(dumbledore, date(14,8,1881)).
birthday(testbirthday, date(20,3,1972)).

connection(harry, ron, strong).
connection(harry, herminone, strong).
connection(harry, dumbledore, professional).
connection(ron, harry, strong).
connection(ron, herminone, strong).
connection(ron, molly, familial).
connection(ron, dumbledore, professional).
connection(herminone, harry, strong).
connection(herminone, ron, strong).
connection(herminone, dumbledore, professional).
connection(molly, ron, familial).

post(harry, date(5,24,1997), strong, 'I\'m presently safe in the Burrow.').
post(harry, date(9,8,2020), public, 'I\'m honoured to accept the post as Head of the Department of Magical Law Enforcement.').
post(ron, date(18,12,1993), public, 'Looking forward to the holidays!').
post(ron, date(15,1,1994), professional, 'I\'m really enjoying Care of Magical Creatures this year.').
post(ron, date(21,2,1994), strong, 'I didn\'t get enough sleep last night - better skip Care of Magical Creatures.').
post(herminone, date(1,8,2019), public, 'I\'m honoured to accept the post as Minister of Magic.').

%Part 2

%Question 2.1
has_birthday_today(X) :- 
	today(A, _, _), 
	today(_, B, _),
	birthday(X, date(A, B, _)).
		
%Question 2.2
level_appropriate(X, Y, Z) :- 
	relationship(Z);
	(relationship(Z2, Z), connection(X, Y, Z2)), 
	user(X), 
	user(Y).
	
	%helper facts
	relationship(public).
	relationship(strong, strong). 
	relationship(strong, familial). 
	relationship(strong, professional). 
	relationship(familial, familial). 
	relationship(familial, professional). 
	relationship(professional, professional). 
		
%Question 2.3
view_posts(X, Y, Z, C) :- 
	level_appropriate(Y, X, A), 
	post(Y, Z, A, C).
		
%Part 3

%Question 3.1
connected(X, Y) :- 
	connected(X, Y, [X]).
connected(X, Y, L) :-
	connection(X, Y, _),
	not(member(Y, L)).
connected(X, Y, L) :-
	connection(X, Z, _),
	not(member(Z, L)), 
	connected(Z, Y, [Z | L]).
		
%Question 3.2
remove_duplicates([], []).
remove_duplicates([H | T], [H | L]) :-
	not(member(H, T)), 
	remove_duplicates(T, L). 
remove_duplicates([H | T], L) :- 
	member(H, T), 
	remove_duplicates(H, L). 

%Question 3.3
network(A, L) :- 
	findall(X, connected(A, X), LD),
	sort(LD, L).
		


		
	
