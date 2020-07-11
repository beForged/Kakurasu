type Grid = Matrix Value
type Matrix a = [Row a]
type Row a = [a]
type Value = Bool

type Question = ([Int], [Int]) --column then row?

values :: [Value]
values = [True, False]

--puzzle :: Grid
--puzzle = [[True,False],
         -- [False,True]]


valid :: Question -> Grid-> Bool
valid (q1, q2) g = (sumcheck (rows g) q1) && (sumcheck (cols g) q2)


transpose :: Matrix a -> [Row a]
transpose ([]:_) = []
transpose x = (map head x) : transpose (map tail x)


rows :: Matrix a -> [Row a]
rows = id

cols :: Matrix a -> [Row a]
cols =  transpose 

--if uneven zzz
sumcheck ::Integral b =>  [Row Value] -> [b] -> Bool
sumcheck [] [] = True
sumcheck _ [] = error "uneven"
sumcheck [] _ = error "uneven"
sumcheck (r:rs) (a:as) = (fst(foldl (\(num, count) x -> if x then (num + count, count + 1) else (num, (count + 1))) (0, 1) r) == a ) && (sumcheck rs as)


--treat a list as a nondet set of values
type Choices = [Value]

--not big enough
--choices :: Grid -> Matrix Choices
--choices g = map (map choice) g
--    where 
--        choice v = if empty v then values else [v]

choices :: Int -> Matrix Choices
choices n = replicate n (replicate n [True, False])

-- makes each row a list of all possibilites
-- then makes each list of rows a list of each possibility
collapse :: Matrix [a] -> [Matrix a]
collapse = sequence . map sequence
--(map sequence lst) makes the combination, then the seq combo makes each possibilty ty cameron


solveBrute :: Question -> [Grid]
solveBrute question= filter (valid  question) (collapse (choices (length (fst question))))
--solveBrute question = filter valid . question collapse . choices . length . fst . question





