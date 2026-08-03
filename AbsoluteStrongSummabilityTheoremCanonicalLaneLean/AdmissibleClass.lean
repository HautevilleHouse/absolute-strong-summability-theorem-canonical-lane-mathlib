import Mathlib.Data.Real.Basic
import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace AbsoluteStrongSummabilityTheoremCanonicalLaneLean

structure AbsoluteStrongSummabilityMethod where
  matrix : ℕ → ℕ → ℝ
  regular : Prop
  conservative : Prop

structure AbsoluteStrongSummabilityAdmittedObject where
  method : AbsoluteStrongSummabilityMethod
  input : ℕ → ℝ
  output : ℕ → ℝ
  absoluteConvergence : Prop
  strongSummability : Prop
  bridge : (method.regular ∧ absoluteConvergence) → strongSummability
  carriedRemainder : Prop

abbrev AdmittedObject := AbsoluteStrongSummabilityAdmittedObject

def AbsoluteStrongBridgeCondition (O : AdmittedObject) : Prop :=
  (O.method.regular ∧ O.absoluteConvergence) → O.strongSummability

structure AdmissibleClass where
  object : AdmittedObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded
  bridgeWitness : AbsoluteStrongBridgeCondition object

def bridgeClosed (A : AdmissibleClass) : Prop :=
  AbsoluteStrongBridgeCondition A.object

def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

def ConstrainedAbsoluteStrongSummabilityClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

def absoluteStrongSummability (O : AdmittedObject) : Prop :=
  O.absoluteConvergence ∧ O.strongSummability

def carriedRemainder (A : AdmissibleClass) : Prop :=
  A.remainderRecorded ∨ A.object.carriedRemainder

theorem endpoint_or_remainder_gate (A : AdmissibleClass) :
    A.endpointSatisfied ∨ A.remainderRecorded := by
  exact A.gateWitness

theorem absolute_strong_summability_of_regular_method (O : AdmittedObject)
    (hreg : O.method.regular) (habs : O.absoluteConvergence) : O.strongSummability := by
  exact O.bridge (And.intro hreg habs)

theorem bridge_from_admissible_class (A : AdmissibleClass) : bridgeClosed A := by
  exact A.bridgeWitness

theorem gate_from_admissible_class (A : AdmissibleClass) : gateClosed A := by
  exact A.gateWitness

theorem bridge_closed_iff (A : AdmissibleClass) :
    bridgeClosed A ↔ ((A.object.method.regular ∧ A.object.absoluteConvergence) → A.object.strongSummability) := by
  rfl

theorem gate_closed_iff (A : AdmissibleClass) :
    gateClosed A ↔ (A.endpointSatisfied ∨ A.remainderRecorded) := by
  rfl

theorem absolute_strong_summability_endgame (A : AdmissibleClass) :
    ConstrainedAbsoluteStrongSummabilityClosure A := by
  unfold ConstrainedAbsoluteStrongSummabilityClosure
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end AbsoluteStrongSummabilityTheoremCanonicalLaneLean
end HautevilleHouse