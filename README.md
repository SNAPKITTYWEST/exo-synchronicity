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
├── prolog/          # Static topology facts (binds/2, valid_operator/2)
├── netlister/       # Prolog → Verilog-A compiler
├── veriloga/        # Reference Verilog-A cell implementations
├── simulations/     # Spectre / Xyce / NGSpice run scripts
├── tests/           # Python + Prolog test suites
├── docs/            # Theory, architecture, novelty, simulation checks
├── reports/         # Generated whitepapers and simulation reports
└── worm/            # WORM-sealed receipts (provenance chain)
```

## Getting Started

```bash
git clone <this-repo>
cd exo-synchronicity

# Validate topology
python tests/test_topology_facts.py

# Compile Prolog → Verilog-A
python netlister/emit_veriloga.py --spec prolog/examples/three_cell_mesh.pl

# Run analog simulation (NGSpice)
cd simulations/ngspice && ngspice -b exo_mesh_tb.va

# Run all tests
python -m pytest tests/
```

## Status

**v0.1.0** — Research substrate. Prolog specification and Verilog-A simulation models are stable. Netlister is functional. Simulation verification reports are generated.

## License

Apache 2.0
