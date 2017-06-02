-- transition systems

namespace transition

universes u v

structure system (label : Type v) :=
  mk ::
    (state : Type u)
    (step : state → state → list label → Prop)
    (init : state)
    (final : state → Prop)

-- FIXME
-- instance : has_coe system Type := ⟨system.state⟩

section sequences

variable {α : Type u}
variable {label : Type v}

inductive star (R : α → α → list label → Prop) : α → α → list label → Prop
| refl : ∀ a,
  star a a []
| step : ∀ a b c ls lss,
  R a b ls → star b c lss → star a c (ls ++ lss)

lemma star_refl_eq : ∀ (R : α → α → list label → Prop) a b,
  a = b → star R a b [] :=
begin
  intros a b R H,
  subst H, constructor
end

lemma star_one : ∀ (R : α → α → list label → Prop) a b ls,
  R a b ls → star R a b ls :=
begin
  intros,
  assert ls_rew: (ls = ls ++ []), { simp [] },
  rw [ls_rew],
  apply star.step,
  { assumption },
  { constructor }
end

lemma star_trans : ∀ (R : α → α → list label → Prop) a b ls,
  star R a b ls →
  ∀ c ls', star R b c ls' → star R a c (ls ++ ls') :=
begin
  intros R a b ls S1,
  induction S1,
  { intros, simp [], assumption },
  { intros c1 ls' H_c_c1,
    note ih := ih_1 _ _ H_c_c1,
    rw [list.append_assoc],
    apply star.step; assumption
  }
end

-- Todo: more lemmas about star

inductive iter (R : α → α → list label → Prop) : nat → α → α → list label → Prop
| zero : ∀ a,
  iter 0 a a []
| succ : ∀ n a b c ls lss,
  R a b ls → iter n b c lss → iter (nat.succ n) a c (ls ++ lss)

def big (sys : system label) (a a' : sys.state) (l : list label) : Prop :=
  (star sys.step) a a' l ∧ sys.final a'

end sequences

def unstuck {lbl} (sys : system lbl) (s : sys.state) :=
  sys.final s ∨ ∃ s' ls, sys.step s s' ls

-- def safe {lbl} (sys : system lbl) :=
--   ∀ s ls,
--     (star sys.step) sys.init s ls →
--     unstuck sys s

def quasi_refinement
  {lbl} (A B : system lbl) (R : A.state → B.state → Prop) :
  Prop
:=
  R A.init B.init ∧
  ∃ (m : B.state → A.state → nat), -- XX
  ∀ (a : A.state) (b : B.state),
  R a b →
    (∃ a' l, A.step a a' l →
       ∃ a'' b' n,
       (star A.step) a' a'' [] ∧
       (iter B.step n) b b' l ∧
       R a'' b' ∧
       (n = 0 → m b a > m b a')) ∧
    (A.final a →
       ∃ b', (big B) b b' [] ∧ R a b')

end transition