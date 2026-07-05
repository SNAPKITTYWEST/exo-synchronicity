% logic/prolog/topology.pl — Static topology: binds/2, valid_operator/2
% Defines physical port bindings and operator validity paths.

binds(port_42, atmospheric_pressure_delta).
binds(port_07, hardware_interrupt_irq3).
binds(port_99, rf_noise_floor_2_4ghz).
binds(port_13, temperature_gradient_cell_a).
binds(port_88, gyro_z_axis_rate).

latch_polarity(port_42, p).
latch_polarity(port_07, pn).
latch_polarity(port_99, p).
latch_polarity(port_13, p).
latch_polarity(port_88, pn).

valid_operator(operator_A, [path(port_42, p), path(port_07, pn)]).
valid_operator(operator_B, [path(port_99, p)]).
valid_operator(operator_C, [path(port_13, p), path(port_88, pn)]).
valid_operator(operator_D, [path(port_42, pn), path(port_99, pn)]).

operator_gate(operator_A, gate_alpha).
operator_gate(operator_B, gate_beta).
operator_gate(operator_C, gate_gamma).
operator_gate(operator_D, gate_delta).

env_state(port_42, 1.8).
env_state(port_07, 1.8).
env_state(port_99, 0.0).
env_state(port_13, 0.0).
env_state(port_88, 0.0).
