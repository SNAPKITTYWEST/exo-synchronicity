% logic/asp/mesh_worlds.lp
% Stable-world selection among possible mesh configurations.

port(port_42; port_07; port_99; port_13; port_88).
polarity(p; pn).
operator(operator_a; operator_b; operator_c; operator_d).

% Candidate path selection: guess which ports route to which operators
{ uses(Op, Port, Pol) } :- operator(Op), port(Port), polarity(Pol).

% Every operator must have at least one valid path
:- operator(Op), not 1 { uses(Op, Port, Pol) : port(Port), polarity(Pol) }.

% A port cannot serve both P and PN for the same operator
:- uses(Op, Port, p), uses(Op, Port, pn).

% Reject worlds where a required port is blocked
blocked(port_07).

:- uses(Op, Port, _), blocked(Port).

% Prefer minimal meshes (fewer connections is better)
#minimize { 1,Op,Port,Pol : uses(Op,Port,Pol) }.

#show uses/3.
