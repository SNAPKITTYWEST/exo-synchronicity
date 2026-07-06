import ExoSynchronicity.Discrete.Graph

namespace ExoSynchronicity.Discrete

/--
A placeholder type for conductance annotations attached to edges.
In a real implementation this would be a numeric value (e.g., a `ℝ`), but for the purpose of the theorem we only need existence and uniqueness.
-/
structure ConductanceAnnotation where
  edge : Edge
  value : Nat -- placeholder for conductance magnitude

/--
Assume we have a list of conductance annotations, one per edge.
-/

def annotations (g : Graph) : List ConductanceAnnotation :=
  g.edges.map (fun e => ⟨e, 1⟩) -- using dummy value `1` for all edges

/--
The theorem states that for every edge in the graph there exists **exactly one** conductance annotation.
-/

theorem conductance_annotation_totality (g : Graph) :
  (∀ e ∈ g.edges, ∃! a ∈ annotations g, a.edge = e) := by
  intro e he
  refine ⟨⟨e, 1⟩, ?_, ?_⟩
  · -- membership of the constructed annotation in the list
    have : (⟨e, 1⟩ : ConductanceAnnotation) ∈ g.edges.map (fun e => ⟨e, 1⟩) := by
      apply List.mem_map.2
      exact ⟨e, he, rfl⟩
    simpa [annotations] using this
  · intro a ha
    -- a is any annotation in the list whose edge equals e; we must show a = ⟨e,1⟩
    have hmem : a ∈ g.edges.map (fun e => ⟨e, 1⟩) := by
      simpa [annotations] using ha
    rcases List.mem_map.1 hmem with ⟨e', he', rfl⟩
    -- now we have a = ⟨e',1⟩ and e' = e from `ha`
    cases a with
    | mk edge value =>
      dsimp at *
      have : e' = e := by
        -- from the hypothesis `a.edge = e`
        simpa using ha
      subst this
      rfl

end ExoSynchronicity.Discrete
