% Coloque estas diretivas no início do seu código
:- discontiguous mover_o/3.
:- discontiguous mover_x/3.

% Inicialização do jogo quando 'x' joga
comecar :- 
    como_jogar, % Exibe instruções
    inicializar([' ',' ',' ',' ',' ',' ',' ',' ',' ']). % Inicializa o jogo com um tabuleiro vazio

% Inicialização do jogo quando 'o' joga
assistir:- 
    inicializarT([' ',' ',' ',' ',' ',' ',' ',' ',' ']). % Inicializa o jogo para 'o' com um tabuleiro vazio

% Inicialização do jogo para 'x'
inicializar(Tabuleiro) :-
    ganhar(Tabuleiro, x), % Verifica se 'x' já ganhou
    write('X ganhou!'), abort(). % Exibe mensagem de vitória de 'x' e encerra o jogo

% Inicialização do jogo para 'o'
inicializar(Tabuleiro) :-
    ganhar(Tabuleiro, o), % Verifica se 'o' já ganhou
    write('O ganhou!'), abort(). % Exibe mensagem de vitória de 'o' e encerra o jogo

% Continuação do jogo
inicializar(Tabuleiro) :-
    read(N), % Lê a jogada de 'x'
    mover_x(Tabuleiro, N, NovoTabuleiro), % Atualiza o tabuleiro com a jogada de 'x'
    imprimir_tabuleiro(NovoTabuleiro), % Exibe o tabuleiro atualizado
    jogar_o(NovoTabuleiro, MaisNovoTabuleiro), % Jogada de 'o'
    imprimir_tabuleiro(MaisNovoTabuleiro), % Exibe o tabuleiro após a jogada de 'o'
    inicializar(MaisNovoTabuleiro). % Inicia o próximo turno

% Inicialização do jogo para 'o'
inicializarT(Tabuleiro) :-
    ganhar(Tabuleiro, x), % Verifica se 'x' já ganhou
    write('X ganhou!'), !. % Exibe mensagem de vitória de 'x' e encerra o jogo

% Inicialização do jogo para 'o'
inicializarT(Tabuleiro) :-
    ganhar(Tabuleiro, o), % Verifica se 'o' já ganhou
    write('O ganhou!'), !. % Exibe mensagem de vitória de 'o' e encerra o jogo

% Continuação do jogo
inicializarT(Tabuleiro) :-
    jogar_x(Tabuleiro, NovoTabuleiro), % Jogada de 'x'
    imprimir_tabuleiro(NovoTabuleiro), % Exibe o tabuleiro atualizado
    jogar_o(NovoTabuleiro, MaisNovoTabuleiro), % Jogada de 'o'
    imprimir_tabuleiro(MaisNovoTabuleiro), % Exibe o tabuleiro após a jogada de 'o'
    inicializarT(MaisNovoTabuleiro). % Inicia o próximo turno

% Verifica se um jogador ('x' ou 'o') ganhou o jogo
ganhar(Tabuleiro, Jogador) :-
    ganhar_linha(Tabuleiro, Jogador);
    ganhar_coluna(Tabuleiro, Jogador);
    ganhar_diagonal(Tabuleiro, Jogador).

% Verifica combinações vencedoras em linhas
ganhar_linha(Tabuleiro, Jogador) :-
    Tabuleiro = [Jogador, Jogador, Jogador, _, _, _, _, _, _];
    Tabuleiro = [_, _, _, Jogador, Jogador, Jogador, _, _, _];
    Tabuleiro = [_, _, _, _, _, _, Jogador, Jogador, Jogador].

% Verifica combinações vencedoras em colunas
ganhar_coluna(Tabuleiro, Jogador) :-
    Tabuleiro = [Jogador, _, _, Jogador, _, _, Jogador, _, _];
    Tabuleiro = [_, Jogador, _, _, Jogador, _, _, Jogador, _];
    Tabuleiro = [_, _, Jogador, _, _, Jogador, _, _, Jogador].

% Verifica combinações vencedoras nas diagonais
ganhar_diagonal(Tabuleiro, Jogador) :-
    Tabuleiro = [Jogador, _, _, _, Jogador, _, _, _, Jogador];
    Tabuleiro = [_, _, Jogador, _, Jogador, _, Jogador, _, _].

% Movimento de 'o' (Computador)
mover_o([A, ' ', C, D, E, F, G, H, I], Jogador, [A, Jogador, C, D, E, F, G, H, I]).
mover_o([A, B, C, D, E, F, G, ' ', I], Jogador, [A, B, C, D, E, F, G, Jogador, I]).
% ... Outros movimentos de 'o'

% Movimento de 'x' (Jogador humano)
mover_x([' ', B, C, D, E, F, G, H, I], 1, [x, B, C, D, E, F, G, H, I]).
mover_x([A, ' ', C, D, E, F, G, H, I], 2, [A, x, C, D, E, F, G, H, I]).
mover_x([A, B, ' ', D, E, F, G, H, I], 3, [A, B, x, D, E, F, G, H, I]).
% ... Outros movimentos de 'x'

% Movimento de 'x' (Jogador humano)
mover_x([A, B, C, D, E, F, G, H, ' '], 9, [A, B, C, D, E, F, G, H, x]).
mover_x([A, B, C, D, E, F, G, ' ', I], 8, [A, B, C, D, E, F, G, x, I]).
mover_x([A, B, C, D, E, F, ' ', H, I], 7, [A, B, C, D, E, F, x, H, I]).
mover_x([A, B, C, D, E, ' ', G, H, I], 6, [A, B, C, D, E, x, G, H, I]).
mover_x([A, B, C, D, ' ', F, G, H, I], 5, [A, B, C, D, x, F, G, H, I]).
mover_x([A, B, C, ' ', E, F, G, H, I], 4, [A, B, C, x, E, F, G, H, I]).
% Adicionar mais movimentos de 'x' (por exemplo, 1, 2, 3).


% Imprime o tabuleiro
imprimir_tabuleiro([A, B, C, D, E, F, G, H, I]) :-
    write('|'), write([A, B, C]), write('|'), nl,
    write('|'), write([D, E, F]), write('|'), nl,
    write('|'), write([G, H, I]), write('|'), nl, nl.

% Exibe instruções de como jogar
como_jogar :-
    write('Você é o jogador x.'), nl,
    write('Para jogar, escreva o número da posição desejada e um ponto final.'), nl,
    write('Exemplo: ?- 5.'), nl, nl,
    imprimir_tabuleiro([1, 2, 3, 4, 5, 6, 7, 8, 9]).

% Estratégia de jogada para 'x'
jogar_x(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, x, NovoTabuleiro), % Tenta encontrar uma jogada que resulta na vitória de 'x'
    ganhar(NovoTabuleiro, x).

jogar_x(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, x, NovoTabuleiro), % Evita que 'o' ganhe
    not(o_pode_ganhar(NovoTabuleiro)).

jogar_x(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, x, NovoTabuleiro). % Faz uma jogada aleatória

% Estratégia de jogada para 'o' (Computador)
jogar_o(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, o, NovoTabuleiro), % Tenta encontrar uma jogada que resulta na vitória de 'o'
    ganhar(NovoTabuleiro, o), !.

jogar_o(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, o, NovoTabuleiro), % Evita que 'x' ganhe
    not(x_pode_ganhar(NovoTabuleiro)), !.

jogar_o(Tabuleiro, NovoTabuleiro) :-
    mover_o(Tabuleiro, o, NovoTabuleiro). % Faz uma jogada aleatória

% Verifica se 'o' pode ganhar na próxima jogada
o_pode_ganhar(Tabuleiro) :-
    mover_o(Tabuleiro, o, NovoTabuleiro),
    ganhar(NovoTabuleiro, o),
    write('O pode ganhar'), nl.

% Verifica se 'x' pode ganhar na próxima jogada
x_pode_ganhar(Tabuleiro) :-
    mover_o(Tabuleiro, x, NovoTabuleiro),
    ganhar(NovoTabuleiro, x),
    write('X pode ganhar'), nl.
