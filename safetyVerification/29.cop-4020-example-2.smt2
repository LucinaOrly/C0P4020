(set-logic HORN)

; another example discussed in class
; that corresponds to the following program which is correct:
;   "if N < 0 then N := N * -1 else skip; x := 0; while x < N do x := x + 1; assert x = N"
; when z3 is called, the output is "sat"

(declare-fun p1 (Int Int) Bool)
(declare-fun p2 (Int Int) Bool)

; encoding of "if N < 0 then N := N * -1"
(assert (forall ((x Int) (N1 Int) (N Int))
   (=> (and true (< N 0) (= N1 (* N -1)))
      (p1 x N1))))

; encoding of "skip"
(assert (forall ((x Int) (N1 Int) (N Int))
   (=> (and true (>= N 0))
      (p1 x N))))

; encoding of "x := 0"
(assert (forall ((x Int) (x1 Int) (N Int))
   (=> (and (p1 x N) (= x1 0)) (p2 x1 N))))

; encoding of an iteration of "while x < N do x := x + 1"
(assert (forall ((x Int) (x1 Int) (N Int))
  (=> (and (p2 x N) (< x N) (= x1 (+ x 1)))
     (p2 x1 N))))

; encoding of "assert x = N"
(assert
 (forall ((x Int) (N Int))
   (=> (and (p2 x N) (not (< x N))) (= x N))))

(check-sat)
(get-model)
