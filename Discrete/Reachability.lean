import ExoSynchronicity.Discrete.Graph

namespace ExoSynchronicity.Discrete

/--
Simple reachability definition for a finite graph.
We say `reachable g a b` holds if there exists a **single edge** from `a` to `b`.
This is a minimal definition sufficient for the monotonicity lemma below.
More sophisticated path‑based definitions can be added later.
-/

def reachable (g : Graph) (a b : NodeId) : Prop :=
  ∃ e ∈ g.edges, e.src = a ∧ e.dst = b

/--
Monotonicity of reachability under edge‑set inclusion.
If `g.edges ⊆ g'.edges` then any direct edge reachable in `g` remains reachable in `g'`.
-/
theorem reachability_monotonic {g g' : Graph} (hsub : g.edges ⊆ g'.edges) {a b : NodeId}
    (h : reachable g a b) : reachable g' a b := by
  rcases h with ⟨e, he_mem, hsrc, hdst⟩
  exact ⟨e, hsub he_mem, hsrc, hdst⟩

end ExoSynchronicity.Discrete
