% logic/asp/constraints.lp
% Hard constraints on admissible mesh configurations.

% Every valid operator must have a conducting path
:- valid_operator(Op), not conducting(Op).

conducting(Op) :- valid_operator(Op, Paths), conducting_paths(Paths).

conducting_paths([]).
conducting_paths([path(Port, p) | Rest]) :-
    env_state(Port, V), V > 0.5, conducting_paths(Rest).
conducting_paths([path(Port, pn) | Rest]) :-
    env_state(Port, V), V < 0.5, conducting_paths(Rest).

% No path may route through a blocked port
:- uses(Op, Port, _), blocked(Port).

% Latency constraint: path length must not exceed max depth
max_depth(4).
:- uses(Op, _, _), #count { P, Po : uses(Op, P, Po) } > D, max_depth(D).

% All ports in a path must share a common sigma domain
:- uses(Op, Port1, _), uses(Op, Port2, _),
   sigma_domain(Port1, D1), sigma_domain(Port2, D2), D1 != D2.

sigma_domain(port_42; port_07; port_99; port_13; port_88, domain_0).
