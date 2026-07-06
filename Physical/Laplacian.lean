import ExoSynchronicity.Discrete.Graph

namespace ExoSynchronicity.Physical

/--
Laplacian matrix for a finite undirected graph.
Rows and columns correspond to nodes (in the order of `g.nodes`).
The entry L[i][j] is:
- `degree(i)` on the diagonal (i=j)
- `-1` if there is an edge between i and j
- `0` otherwise.
-/

def laplacianMatrix (g : ExoSynchronicity.Discrete.Graph) : List (List Int) :=
  g.nodes.map (fun n_i =>
    g.nodes.map (fun n_j =>
      if n_i = n_j then
        -- degree of n_i: count edges incident to n_i
        List.length (g.edges.filter (fun e => e.src = n_i ∨ e.dst = n_i))
      else if (g.edges.any (fun e => (e.src = n_i ∧ e.dst = n_j) ∨ (e.src = n_j ∧ e.dst = n_i)) then
        -1
      else
        0))

/--
Predicate that the graph is undirected: for every edge there is a twin edge with swapped endpoints.
-/

def isUndirected (g : ExoSynchronicity.Discrete.Graph) : Prop :=
  ∀ e ∈ g.edges, ∃ e' ∈ g.edges, e'.src = e.dst ∧ e'.dst = e.src

/--
If the graph is undirected, the Laplacian matrix is symmetric (L = Lᵀ).
-/
theorem laplacian_symmetry {g : ExoSynchronicity.Discrete.Graph} (hU : isUndirected g) :
    laplacianMatrix g = (laplacianMatrix g).transpose := by
  -- Proof sketch: symmetry follows from the definition of `laplacianMatrix` and the
  -- undirected property `hU`. A full proof would require reasoning about `List.map`
  -- and `List.transpose`. We leave it as a placeholder.
  sorry

end ExoSynchronicity.Physical
