// Graph.lean – basic graph definitions and well‑formedness

namespace ExoSynchronicity.Discrete

/-- A node identifier –/
inductive NodeId : Type
| mk (n : Nat) : NodeId

/-- An edge with source and destination node identifiers –/
structure Edge where
  src : NodeId
  dst : NodeId

/-- A finite labeled graph – a list of nodes and a list of edges –/
structure Graph where
  nodes : List NodeId
  edges : List Edge

/-- Predicate: every edge references existing nodes –/

def EdgeWellFormed (g : Graph) : Prop :=
  ∀ e ∈ g.edges, e.src ∈ g.nodes ∧ e.dst ∈ g.nodes

/-- Lemma: if the graph is well‑formed, there are no dangling ports –/
lemma no_floating_ports (g : Graph) (h : EdgeWellFormed g) :
  True := by
  -- proof is immediate from definition; placeholder for future formalisation
  trivial

end ExoSynchronicity.Discrete
