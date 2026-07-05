% logic/prolog/schema.pl — Type and arity validation for topology facts.

validate_binds_have_polarity :-
    findall(Port, (binds(Port, _), \+ latch_polarity(Port, _)), Unpolarized),
    (Unpolarized == []
    -> format('OK: All bound ports have polarity definitions.~n')
    ;  format('ERROR: Ports without polarity: ~p~n', [Unpolarized])).

validate_operator_paths_resolve :-
    findall(Port, (valid_operator(_, Paths),
                   member(path(Port, _), Paths),
                   \+ binds(Port, _)), Unbound),
    (Unbound == []
    -> format('OK: All operator paths reference bound ports.~n')
    ;  format('ERROR: Unbound ports in operator paths: ~p~n', [Unbound])).

validate_operators_have_gates :-
    findall(Op, (valid_operator(Op, _), \+ operator_gate(Op, _)), Missing),
    (Missing == []
    -> format('OK: All operators have gate assignments.~n')
    ;  format('ERROR: Operators without gates: ~p~n', [Missing])).

run_all_validations :-
    validate_binds_have_polarity,
    validate_operator_paths_resolve,
    validate_operators_have_gates.
