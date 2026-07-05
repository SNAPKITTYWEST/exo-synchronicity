# Multi-Logic Verification Stack

Exo-Synchronicity does not use one logic engine. It stages logic by physical role:

| Layer | Logic | Purpose |
|---|---|---|
| Topology | **Prolog** | Defines physical bindings and valid operators |
| Reachability | **Datalog** | Checks finite graph reachability and disconnected ports |
| World Selection | **ASP** | Selects stable admissible mesh configurations under competing constraints |
| Numeric Feasibility | **SMT** | Verifies timing, voltage, and threshold inequalities |
| Physical Validation | **Verilog-A / SPICE** | Simulates analog collapse fidelity |

## Pipeline

```
Environment facts
       |
       v
    Prolog ────── Static topology validation
       |
       v
   Datalog ────── Finite reachability / no-floating-port checks
       |
       v
      ASP ──────── Stable-world selection among possible mesh configurations
       |
       v
     SMT ──────── Numeric constraint feasibility: skew, droop, thresholds
       |
       v
Verilog-A/SPICE ─ Physical collapse simulation
       |
       v
  WORM receipt
```

## File Layout

```
logic/
├── prolog/
│   ├── topology.pl     # binds/2, valid_operator/2, env_state/2
│   └── schema.pl       # Type/arity validation queries
├── datalog/
│   └── reachability.dl # Graph reachability, floating port detection
├── asp/
│   ├── mesh_worlds.lp  # Stable-world selection
│   └── constraints.lp  # Hard constraints on admissible meshes
└── smt/
    └── timing_bounds.smt2  # Skew, droop, threshold inequalities
```

## Why Multiple Logics?

Each logic is chosen for what it *cannot* do:

- **Prolog** is Turing-complete but its search is unbounded — we use it only for static topology where search depth is bounded by fact count.
- **Datalog** guarantees termination (no function symbols) — we use it for reachability where we need a decision procedure.
- **ASP** supports default negation and stable-model semantics — we use it for world selection where we need to choose among competing configurations under constraints.
- **SMT** handles real arithmetic — we use it for timing and voltage feasibility where we need numeric proofs.
- **Verilog-A / SPICE** models continuous physics — we use it for the final collapse check that no discrete logic can approximate.

This separation means each logic operates in the fragment where it is strongest and most tractable.
