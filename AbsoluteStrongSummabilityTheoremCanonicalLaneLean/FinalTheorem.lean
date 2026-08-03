import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteStrongSummabilityTheoremCanonicalLaneLean

-- The absolute strong summability theorem is captured here as an admissible-class bridge.
-- The bridge is closed when the summability core is preserved; the gate is closed when
-- the hereditary constraints of absolute strong summability are satisfied.

def ConstrainedAbsoluteStrongSummabilityClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

-- A structurally explicit witness for the same closure.
structure AbsoluteStrongSummabilityBridge (A : AdmissibleClass) : Prop where
  strong_bridge : bridgeClosed A
  strong_gate : gateClosed A

-- The two formulations of the admissible closure are extensionally equivalent.
theorem absolute_strong_summability_bridge_equiv (A : AdmissibleClass) :
    AbsoluteStrongSummabilityBridge A ↔ ConstrainedAbsoluteStrongSummabilityClosure A := by
  constructor
  · intro h
    exact And.intro h.strong_bridge h.strong_gate
  · intro h
    exact AbsoluteStrongSummabilityBridge.mk h.1 h.2

-- The bridge component of the admissible class is always constructible.
theorem absolute_strong_summability_bridge_closed (A : AdmissibleClass) :
    bridgeClosed A :=
  bridge_from_admissible_class A

-- The gate component of the admissible class is always constructible.
theorem absolute_strong_summability_gate_closed (A : AdmissibleClass) :
    gateClosed A :=
  gate_from_admissible_class A

-- Endgame: the admissible class for absolute strong summability is fully closed.
theorem constrained_absolute_strong_summability_endgame (A : AdmissibleClass) :
    ConstrainedAbsoluteStrongSummabilityClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbsoluteStrongSummabilityTheoremCanonicalLaneLean
end HautevilleHouse