% Defina as cidades e suas coordenadas
city(mamanguape, 0, 0).
city(riotinto, 2, 4).
city(itashow, 3, 1).
city(guarafogo, 5, 3).
city(jampacity, 6, 6).
city(bt, 1, 5).
city(salema, 7, 2).
city(sitiocapim, 4, 4).

% Ponto de partida fixo
start_city(mamanguape).

% Calcula a dist�ncia entre duas cidades
distance(X1, Y1, X2, Y2, D) :- D is sqrt((X1 - X2)^2 + (Y1 - Y2)^2).

% Calcula o custo de uma rota
route_cost([], 0).
route_cost([_], 0).
route_cost([City1, City2 | Rest], Cost) :-
    city(City1, X1, Y1),
    city(City2, X2, Y2),
    distance(X1, Y1, X2, Y2, D),
    route_cost([City2 | Rest], RestCost),
    Cost is D + RestCost.

% Algoritmo Hill Climbing com ponto de partida fixo
hill_climbing(BestRoute, BestCost) :-
    start_city(Start),
    permutation([Start,riotinto,itashow,guarafogo,jampacity,bt,salema,sitiocapim], Route),
    route_cost(Route, Cost),
    hill_climbing_best(Route, Cost, BestRoute, BestCost).

hill_climbing_best(CurrentRoute, CurrentCost, BestRoute, BestCost) :-
    hill_climbing_step(CurrentRoute, CurrentCost, CurrentRoute, CurrentCost, BestRoute, BestCost).

hill_climbing_step(_, _, BestRoute, BestCost, BestRoute, BestCost).
hill_climbing_step(_, CurrentCost, _, BestCost,_, BestCost) :-
    CurrentCost >= BestCost.

hill_climbing_step(CurrentRoute, CurrentCost, BestRoute, BestCost,_, _) :-
    permutation(CurrentRoute, NewRoute),
    route_cost(NewRoute, NewCost),
    NewCost < CurrentCost,
    hill_climbing_best(NewRoute, NewCost, BestRoute, BestCost).

% Consulta para encontrar a melhor rota e seu custo
:- hill_climbing(BestRoute, BestCost), write('Melhor rota: '), write(BestRoute), nl, write('Custo minimo: '), write(BestCost), nl.
