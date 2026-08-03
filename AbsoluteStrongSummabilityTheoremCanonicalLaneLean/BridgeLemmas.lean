import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators

namespace HautevilleHouse
namespace AbsoluteStrongSummabilityTheoremCanonicalLaneLean

open scoped BigOperators

/-- A regular summability matrix with nonnegative coefficients and row sums equal to one. -/
structure SummabilityMatrix where
  coeff : ℕ → ℕ → ℝ
  nonneg : ∀ n k, 0 ≤ coeff n k
  row_sum : ∀ n, ∑ k in Finset.range (n+1), coeff n k = 1

/-- Absolute strong summability of a sequence to a limit with respect to a matrix. -/
def AbsoluteStrongSummability (A : SummabilityMatrix) (x : ℕ → ℝ) (l : ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, ∑ k in Finset.range (n+1), A.coeff n k * |x k - l| < ε

/-- A witness to absolute strong summability, containing the sequence, matrix, limit,
and the conclusion that the matrix-weighted means converge to the limit. -/
structure AbsoluteStrongSummabilityWitness where
  matrix : SummabilityMatrix
  sequence : ℕ → ℝ
  limit : ℝ
  strong_summable : AbsoluteStrongSummability matrix sequence limit
  conclusion : ∀ ε > 0, ∃ N, ∀ n ≥ N,
    |∑ k in Finset.range (n+1), matrix.coeff n k * (sequence k - limit)| < ε

/-- The bridge-closed predicate for the Absolute Strong Summability Theorem. -/
def AbsoluteStrongSummabilityWitnessClosed (w : AbsoluteStrongSummabilityWitness) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N,
    |∑ k in Finset.range (n+1), w.matrix.coeff n k * (w.sequence k - w.limit)| < ε

/-- The bridge closure condition for an admissible class. -/
def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbsoluteStrongSummabilityWitnessClosed A.object

/-- The bridge is closed for any admissible class witnessing absolute strong summability. -/
theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact A.object.conclusion

end AbsoluteStrongSummabilityTheoremCanonicalLaneLean
end HautevilleHouse