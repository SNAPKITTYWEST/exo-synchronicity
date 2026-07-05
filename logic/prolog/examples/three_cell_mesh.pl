% logic/prolog/examples/three_cell_mesh.pl — Example: 3-cell P/PN Swarm

binds(port_0, sensor_alpha).
binds(port_1, sensor_beta).
binds(port_2, sensor_gamma).

latch_polarity(port_0, p).
latch_polarity(port_1, pn).
latch_polarity(port_2, p).

valid_operator(cell_0, [path(port_0, p)]).
valid_operator(cell_1, [path(port_1, pn)]).
valid_operator(cell_2, [path(port_2, p)]).

operator_gate(cell_0, gate_0).
operator_gate(cell_1, gate_1).
operator_gate(cell_2, gate_2).

env_state(port_0, 1.8).
env_state(port_1, 0.0).
env_state(port_2, 0.0).
