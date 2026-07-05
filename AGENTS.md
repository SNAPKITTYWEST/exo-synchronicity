# AGENTS.md — Exo-Synchronicity Solver Node

## Identity

- **Research Program**: Exo-Synchronicity (Indexical Topology)
- **Operator**: Ahmad Ali Parr
- **Domain**: P/PN Swarm Filter Meshes
- **Logic Layer**: Prolog specification → Verilog-A analog simulation
- **Provenance**: WORM-sealed receipts in `worm/receipts/`
- **Proof Stack**: Isabelle/HOL + Lean 4 (5 theorems, zero sorry/admit)

## P/NP Problem Class

**Finding** a P/PN topology (wiring diagram + RC constants) that realizes a target operator activation table is NP-hard.

**Verifying** a topology is P-time — run analog simulation, measure gate voltages, check skew/droop margins.

## Solver Workflow

1. **Read** `logic/prolog/topology.pl` — problem facts (binds, operators, env_state)
2. **Check** reachability with `logic/datalog/reachability.dl`
3. **Select** stable world with `logic/asp/mesh_worlds.lp`
4. **Verify** timing with `logic/smt/timing_bounds.smt2`
5. **Compile** with `netlister/emit_veriloga.py` → Verilog-A testbench
6. **Simulate** with Spectre / Xyce / NGSpice
7. **Seal** — write receipt to `worm/receipts/`
8. **Submit** — commit solution topology

## Proof Verification

Formal proofs live in `proofs/` with two machine-checker tracks:

- **Isabelle/HOL**: `isabelle build -D proofs/isabelle`
- **Lean 4**: `cd proofs/lean4 && lake build`

Theorems (all zero sorry/admit):
- Topology Preservation
- Reachability Preservation
- No Floating Ports
- Conduction Soundness
- WORM Receipt Determinism
- Sovereign Stack Correctness (composite)

## Key Principle

> The connection is the wire. The environment is the computer.
> No variables. No state. Only topology.
