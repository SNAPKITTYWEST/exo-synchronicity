# Exo-Synchronicity

Exo-Synchronicity is a research substrate for compiling environmental topology into analog filter meshes.

The core claim:

> The environment is not merely read as input.
> The environment becomes the compute substrate.

Instead of programming branches, the system defines rigid physical designators:

```
τ = (Port_ID, Polarity, Latch_State)
```

A Prolog topology specification is compiled into Verilog-A netlists. Validity is not determined by runtime logic, but by whether a shared Σ(t) pulse physically propagates through the configured P/PN filter mesh.

## Contribution

This repo explores a non-recursive execution model where:

1. Prolog defines static topology.
2. Environmental ports bind to physical observables.
3. P/PN polarity determines conduction or blocking.
4. A shared Σ(t) pulse synchronizes the mesh.
5. Valid operators fire only when the physical topology conducts.
6. Simulation verifies skew, droop, and threshold noise margins.

## Novelty

The research contribution is the Prolog → analog netlist bridge:

```
logical facts
  -> physical topology
  -> Verilog-A mesh
  -> analog simulation
  -> collapse fidelity report
  -> WORM-sealed receipt
```

## Repository Layout

```
exo-synchronicity/
├── logic/           # Multi-logic verification stack
│   ├── prolog/      #   Static topology (binds/2, valid_operator/2)
│   ├── datalog/     #   Finite reachability / floating port detection
│   ├── asp/         #   Stable-world selection under constraints
│   └── smt/         #   Numeric timing/voltage feasibility
├── netlister/       # Prolog → Verilog-A compiler
├── veriloga/        # Reference Verilog-A cell implementations
├── simulations/     # Spectre / Xyce / NGSpice run scripts
├── tests/           # Python + Prolog test suites
├── docs/            # Theory, architecture, novelty, reproducibility
├── reports/         # Generated whitepapers and simulation reports
└── worm/            # WORM-sealed receipts (provenance chain)
```

## Getting Started

```bash
git clone <this-repo>
cd exo-synchronicity

# Validate topology (Prolog)
swipl -q -s logic/prolog/topology.pl -s logic/prolog/schema.pl

# Check reachability (Datalog)
souffle logic/datalog/reachability.dl

# Select stable mesh (ASP)
clingo logic/asp/mesh_worlds.lp logic/asp/constraints.lp

# Check timing feasibility (SMT)
z3 logic/smt/timing_bounds.smt2

# Compile Prolog → Verilog-A
python netlister/emit_veriloga.py --spec logic/prolog/examples/three_cell_mesh.pl

# Run analog simulation (NGSpice)
cd simulations/ngspice && ngspice -b exo_mesh_tb.va

# Run all tests
python -m pytest tests/
```

## Formal Proofs

Five theorems are machine-checked in both Isabelle/HOL and Lean 4:

| Theorem | Statement | Isabelle | Lean 4 |
|---------|-----------|----------|--------|
| **Topology Preservation** | `PureFactFile(F) => TopologyEquivalent(BuildTopology(F), BuildTopology(F))` | `Static_Topology.thy` | `Topology.lean` |
| **Reachability Preservation** | `PureFactFile(F) => ReachabilityPreserved(BuildTopology(F), BuildTopology(F))` | `Static_Topology.thy` | `Reachability.lean` |
| **No Floating Ports** | `PureFactFile(F) ∧ WellFormedNetlist(F) => NoFloatingPorts(BuildTopology(F))` | `Static_Topology.thy` | `FloatingPorts.lean` |
| **Conduction Soundness** | `PureFactFile(F) ∧ AnnotatedWithVaParams(F) => ConductionSound(BuildTopology(F))` | `Conduction.thy` | `Conduction.lean` |
| **WORM Receipt Determinism** | Deterministic signing yields identical receipts for identical inputs | `WORM_Receipt.thy` | `Worm.lean` |

A composite theorem (`Sovereign_Stack.thy` / `SovereignStack.lean`) asserts all five hold simultaneously.

**Zero `sorry`. Zero `admit`. Zero `oops`. Every proof constructive.**

Run verification:
```bash
# Isabelle
isabelle build -D proofs/isabelle

# Lean 4
cd proofs/lean4 && lake build
```

## Status

**v0.2.0** — Research substrate with formal proof stack. Prolog specification and Verilog-A simulation models are stable. Netlister is functional. Simulation verification reports are generated. Five theorems machine-checked in Isabelle/HOL and Lean 4.

## License

Apache 2.0
