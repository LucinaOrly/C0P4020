(set-logic HORN)

; example discussed in class
; this one corresponds to the following program which is buggy:
;   "x := 0; while x < N do x := x + 1; assert x = N"
; when z3 is called, the output is "unsat"
; because the assertion is violated for any negative N

(declare-fun p1 (Int Int) Bool)

; encoding of "x := 0"
(assert (forall ((x Int) (x1 Int) (N Int))
   (=> (and true (= x 0))
      (p1 x N))))

; encoding of an iteration of "while x < N do x := x + 1"
(assert (forall ((x Int) (x1 Int) (N Int))
   (=> (and (p1 x N) (< x N) (= x1 (+ x 1)))
      (p1 x1 N))))

; encoding of "assert x = N"
(assert
  (forall ((x Int) (N Int))
    (=> (and (p1 x N) (not (< x N))) (= x N))))

(check-sat)
