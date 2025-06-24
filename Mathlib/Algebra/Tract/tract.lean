/-
Copyright (c) 2025 Shiyue Li. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Shiyue Li
-/

import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.Order.AbsoluteValue.Euclidean
import Mathlib.Algebra.Order.Ring.Basic
import Mathlib.Algebra.Polynomial.FieldDivision

/-!
# Tract

A tract is a pair `(G, N_G)` where `G` is an abelian group, and `N_G` is a subset (called the
nullset) of the the semiring  `ℕ[G]`, satisfying a bunch of axioms.

-/

open MonoidAlgebra
structure Tract where
  group : Type
  isGroup : Group group
  nullSet : Set (MonoidAlgebra ℕ group)

  -- Axiom T1: the zero of the semiring `ℕ[G]` is in the nullset; the identity of `G` is not.
  zero_mem: 0 ∈ nullSet
  one_not_mem: ¬ single 1 1 ∈ nullSet

  -- Axiom T2: the nullset is closed under multiplication
  is_closed_mul: ∀ g : group, ∀ x ∈ nullSet, (single g 1) * x ∈ nullSet

  -- Axiom T3: there exists a unique element `ε ∈ G` such that `1 + ε` is in the nullset.
  one_add_inv: ∃! e : group, ((single 1 1) + single e 1) ∈ nullSet

instance (T : Tract) : Group T.group := T.isGroup

/-!
# Idyll

An idyll `I` is a tract whose nullset is an ideal of the semiring `ℕ[G]`
-/

structure Idyll where
  group : Type
  isGroup : Group group
  nullSet : Set (MonoidAlgebra ℕ group)

  -- Axiom I1: the zero of the semiring `ℕ[G]` is in the nullset; the identity of `G` is not.
  zero_mem: 0 ∈ nullSet
  one_not_mem: ¬ single 1 1 ∈ nullSet

  -- Axiom I2: the nullset is closed under multiplication
  is_closed_add: ∀ x ∈ nullSet, ∀ y ∈ nullSet, x + y ∈ nullSet
  is_closed_mul: ∀ g : group, ∀ x ∈ nullSet, (single g 1) * x ∈ nullSet

  -- Axiom I3: there exists a unique element `ε ∈ G` such that `1 + ε` is in the nullset.
  one_add_inv: ∃! e : group, ((single 1 1) + single e 1) ∈ nullSet

instance (I : Idyll) : Group I.group := I.isGroup
