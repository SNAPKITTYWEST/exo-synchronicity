import ExoSynchronicity.Discrete.Graph
import ExoSynchronicity.Discrete.Reachability

namespace ExoSynchronicity.Physical

/--
Ground node identifier – we designate node with natural number 0 as ground.
-/

def isGround (n : ExoSynchronicity.Discrete.NodeId) : Bool :=
  match n with
  | ExoSynchronicity.Discrete.NodeId.mk 0 => true
  | _ => false

/--
A list of declared terminal nodes (sources/sinks) – for simplicity we treat it as empty.
In practice this would be populated from circuit specifications.
-/

def terminals (g : ExoSynchronicity.Discrete.Graph) : List ExoSynchronicity.Discrete.NodeId := []

/--
A node is *incident* if it appears as either source or destination of some edge.
-/

def incident (g : ExoSynchronicity.Discrete.Graph) (v : ExoSynchronicity.Discrete.NodeId) : Prop :=
  ∃ e ∈ g.edges, e.src = v ∨ e.dst = v

/--
The ground‑reachability safety theorem.
For any node `v` that is not the ground, at least one of the following holds:
1️⃣ `incident g v` – the node is directly connected to an edge.
2️⃣ `ExoSynchronicity.Discrete.reachable g v (groundNode)` – there is a path to ground.
3️⃣ `v ∈ terminals g` – the node is a declared terminal.
-/

theorem ground_safety {g : ExoSynchronicity.Discrete.Graph} {v : ExoSynchronicity.Discrete.NodeId}
    (hvg : isGround v = false) :
    incident g v ∨ ExoSynchronicity.Discrete.reachable g v (ExoSynchronicity.Discrete.NodeId.mk 0) ∨ v ∈ terminals g := by
  -- Full proof would require constructing paths or using the graph’s connectivity properties.
  -- Here we leave it as a placeholder.
  sorry

end ExoSynchronicity.Physical
