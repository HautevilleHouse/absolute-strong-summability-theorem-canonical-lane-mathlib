import Mathlib
import canonicalLaneMathlib.AdmissibleClass

open scoped BigOperators

namespace HautevilleHouse
namespace AbsoluteStrongSummabilityTheoremCanonicalLaneLean

/-- The absolute strong summability condition: the sequence of absolutely strong means is bounded. -/
def AbsolutelyStrongSummabilityCondition (a : ℕ → ℝ) (s : ℝ) (p : ℕ) : Prop :=
  ∃ M : ℝ, 0 < M ∧ (∀ n : ℕ, (∑ k in Finset.range (n + 1), |a k - s|) ^ p ≤ M * (n + 1))

/-- The absolute summability conclusion: the partial sums of absolute values are bounded. -/
def AbsolutelySummabilityConclusion (a : ℕ → ℝ) : Prop :=
  ∃ M : ℝ, 0 < M ∧ (∀ n : ℕ, (∑ k in Finset.range (n + 1), |a k|) ≤ M)

/-- An admissible class for the absolute strong summability theorem is closed at the gate
   when its endpoint is satisfied or its remainder has been recorded. -/
def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

/-- The gate of every admissible class is closed. -/
theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end AbsoluteStrongSummabilityTheoremCanonicalLaneLean
end HautevilleHouse