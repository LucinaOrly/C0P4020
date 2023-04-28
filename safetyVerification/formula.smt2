(set-logic HORN)


(declare-fun p1 (Int Int Int) Bool)
(declare-fun p2 (Int Int Int) Bool)

; encoding of "if y < 0 then y = -1 * y"
(assert (forall ((x Int)(y Int) (y1 Int) (z Int))
	(=> (and (> y 0) (= y1 (* y -1))) 
		(p1 x y1 z)))) 

;encoding of "skip"
(assert (forall ((x Int) (y Int)(y1 Int) (z Int))
	(=> (and true (not (< y 0)))
		(p1 x y z))))

;encoding of an iteration of "while y > 0 do if z < x then x = x - 1 else skip"
(assert (forall ((x Int)(y Int)(z Int)(x1 Int))
	(=> (and (p2 x y z) (< z x) (= x1 (+ x -1)))
		(p2 x1 y z))))

;encoding of an iteration of "while y > 0 do if false then S else y := y + 1"
(assert (forall ((x Int)(y Int)(z Int)(y1 Int))
	(=> (and (p2 x y z) (not(< z x)) (= y1 (+ y -1)))
		(p2 x y1 z))))

;encoding of "assert y = 0"
(assert (forall ((x Int)(y Int)(z Int))
	(=> (and (p2 x y z) (not (< y 0)))
		(= y 0))))

(check-sat)
(get-model)
