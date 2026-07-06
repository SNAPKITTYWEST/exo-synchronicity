import ExoSynchronicity.Discrete.Graph

namespace ExoSynchronicity.Discrete

/--
Incidence matrix of a finite graph.
Rows correspond to edges (in order of `g.edges`).
Columns correspond to nodes (in order of `g.nodes`).
Each row has exactly two non‑zero entries: -1 at the source column and +1 at the destination column.
-/

def incidenceMatrix (g : Graph) : List (List Int) :=
  g.edges.map (fun e =>
    g.nodes.map (fun n =>
      if n = e.src then -1 else if n = e.dst then 1 else 0))

/--
Lemma: for any edge `e` in the graph, the corresponding row of the incidence matrix contains exactly one -1 and one +1, and all other entries are 0.
-/
theorem incidence_row_correct (g : Graph) (e : Edge) (hmem : e ∈ g.edges) :
    let row := (incidenceMatrix g).get! (g.edges.indexOf e)
    row.count (fun v => v = -1) = 1 ∧
    row.count (fun v => v = 1) = 1 ∧
    row.filter (fun v => v ≠ -1 ∧ v ≠ 1) = List.replicate (g.nodes.length) 0 := by
  -- Proof sketch: unfold definitions, use `hmem` to locate the row, then evaluate the mapping.
  -- Full formal proof would require `List.indexOf` lemmas; we leave as `sorry` placeholder.
  sorry

end ExoSynchronicity.Discrete
