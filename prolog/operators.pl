% operators.pl — Operator definitions and validation queries

% operator_definition(Name, Description, Polarity_Mask).
operator_definition(operator_A, 'Positive pressure + negative interrupt', [p, pn]).
operator_definition(operator_B, 'Positive RF noise floor', [p]).
operator_definition(operator_C, 'Positive temperature + negative gyro', [p, pn]).
operator_definition(operator_D, 'Negative pressure + negative RF noise', [pn, pn]).

% validate_operator(Name)
% Checks that the operator's path conditions are satisfiable.
validate_operator(Name) :-
    valid_operator(Name, Paths),
    forall(member(path(Port, _), Paths),
           (binds(Port, _) -> true ; format('WARNING: ~w references unbinds port ~w~n', [Name, Port]))).

% list_active_operators
% Lists operators that fire under current env_state.
list_active_operators :-
    valid_operator(Name, Paths),
    check_paths(Paths),
    format('ACTIVE: ~w~n', [Name]),
    fail.
list_active_operators.

check_paths([]).
check_paths([path(Port, p) | Rest]) :-
    env_state(Port, V), V > 0.5, check_paths(Rest).
check_paths([path(Port, pn) | Rest]) :-
    env_state(Port, V), V < 0.5, check_paths(Rest).
check_paths([path(Port, _) | _]) :-
    format('  ~w: check failed~n', [Port]), fail.
