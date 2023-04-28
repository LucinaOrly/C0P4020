open Printf

let rec helper n i = 
	if i > n then []
	else (((i * 2) - 1, (i * 2)) :: (helper n (i + 1)))
let mk2 n = (helper n 1)

let rec split xs =
	match xs with
		| [] -> ([], [])
		| (y, z)::xs -> (y :: (fst (split xs)) ,z :: (snd (split xs)))

let ys = mk2 5
let xs = split (ys)

let () = printf "\n"
let () = List.iter (printf "%d ") (fst xs)
let () = printf "\n"
let () = List.iter (printf "%d ") (snd xs)
let () = printf "\n"
