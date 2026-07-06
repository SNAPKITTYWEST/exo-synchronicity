import ExoSynchronicity.Discrete.Graph
import Std.Data.HashMap

namespace ExoSynchronicity.Audit

/--
A very simple canonical representation of a graph.
We sort the list of edges lexicographically by source and destination node identifiers.
The resulting list uniquely describes the graph up to node ordering.
-/

def canonical (g : ExoSynchronicity.Discrete.Graph) : List (ExoSynchronicity.Discrete.NodeId × ExoSynchronicity.Discrete.NodeId) :=
  g.edges.map (fun e => (e.src, e.dst))
  |> List.sort (fun a b =>
       match a, b with
       | (s1, d1), (s2, d2) =>
         if s1 = s2 then if d1 = d2 then false else d1 < d2 else s1 < s2)

/--
A placeholder hash function for a graph.
In a real system this would be a cryptographic hash of the serialized canonical form.
Here we just return the length of the canonical list for illustration.
-/

def hash (g : ExoSynchronicity.Discrete.Graph) : Nat :=
  (canonical g).length

/--
If two graphs have the same canonical representation, then their hashes are equal.
This captures the deterministic receipt property: identical symbolic topologies produce identical WORM receipts.
-/
theorem canonical_hash_determinism {g₁ g₂ : ExoSynchronicity.Discrete.Graph}
    (h : canonical g₁ = canonical g₂) : hash g₁ = hash g₂ := by
  unfold hash canonical at *
  -- Since `hash` is defined as the length of the canonical list, equality follows from `h`.
  simpa [h]

end ExoSynchronicity.Audit
