import ExoSynchronicity.Discrete.Graph

namespace ExoSynchronicity.Discrete

/--
Port incidence list.

Each edge contributes exactly two endpoint appearances:
source port and destination port.
-/

def Graph.portIncidences (g : Graph) : List NodeId :=
  g.edges.bind (fun e => [e.src, e.dst])

/--
The number of port incidences contributed by one edge is exactly two.
-/
theorem one_edge_two_ports (e : Edge) :
    ([e.src, e.dst] : List NodeId).length = 2 := by
  rfl

/--
Handshake lemma, incidence form.

For any finite graph, the number of endpoint incidences is exactly
twice the number of edges.

This is the discrete invariant behind physical mesh compilation:
every symbolic edge must become two physical port incidences.
-/
theorem handshake_incidence (g : Graph) :
    g.portIncidences.length = 2 * g.edges.length := by
  induction g.edges with
  | nil =>
      rfl
  | cons e rest ih =>
      simp [Graph.portIncidences, List.bind, ih, Nat.mul_succ]

end ExoSynchronicity.Discrete
