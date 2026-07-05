# Exo-Synchronicity: Environment-as-Computer via P/PN Filter Meshes

**Author:** Ahmad Ali Parr
**Date:** 2026-07-04
**Version:** v0.1.0

## Abstract

Exo-Synchronicity proposes a non-recursive execution model where computation is conducted rather than executed. A Prolog-defined static topology is compiled into a Verilog-A analog filter mesh. The environment configures conductive paths. A global Σ(t) pulse propagates through open latches. Operators fire when physical topology conducts.

## The Problem

Conventional computing requires stored state (registers, memory), sequential control flow (instruction fetch, branch prediction), and explicit coordination (consensus, locks). These requirements create fundamental complexity barriers.

## The Solution

Replace stored state with physical latch states determined by instantaneous environmental voltage levels. Replace instruction fetch with analog wavefront propagation. Replace coordination with physics (shared clock domain, impedance matching).

## Architecture

**Layer 1 — Prolog Topology:** `binds/2` maps ports to observables. `valid_operator/2` defines conduction paths. `env_state/2` configures the environment.

**Layer 2 — Compilation:** `netlister/emit_veriloga.py` reads Prolog facts and emits structural Verilog-A.

**Layer 3 — Analog Mesh:** `exo_cell` (P/PN conductance switch), `sigma_source` (Σ(t) pulse generator), `lossy_bus_segment` (RC interconnect).

**Layer 4 — Verification:** SPICE-level simulation checks skew, droop, and noise margins.

**Layer 5 — Provenance:** WORM-sealed receipts in `worm/receipts/`.

## Verification

A topology is valid iff:
1. All operator paths resolve to bound ports
2. Under the given environment, the correct set of operators fire
3. Analog simulation confirms voltage at each op_gate exceeds VTH within skew budget
4. No false triggers on blocked paths across Monte Carlo process variation

## Open Problems

1. Topology synthesis (NP-hard)
2. Skew budget closure (NP-complete)
3. Impedance matching (P)

## Conclusion

Exo-Synchronicity offers a testable hypothesis: that computation can be reduced to topology, and that correctness can be verified by physics rather than logic. This repo provides the substrate to explore that hypothesis.
