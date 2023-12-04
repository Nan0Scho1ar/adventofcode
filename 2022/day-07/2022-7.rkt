#lang racket

(define (find-paths lines)
  (for/fold ([files (list)]
             [cwd (list)]
             #:result files)
            ([line (map string-split lines)])
    (match line
      [(list "$" "cd" "..") (values files (cdr cwd))]
      [(list "$" "cd" dir)  (values files (cons dir cwd))]
      [(list "$" "ls")      (values files cwd)]
      [(list "dir" _)       (values files cwd)]
      [(list size filename)
       (let ([found-file (cons (reverse (cons filename cwd)) size)])
         (values (cons found-file files) cwd))])))

(define (sum-dirs files)
  (let ([groups (group-by (λ (f) (caar f)) files)])
    (map (λ (group) (cons (caaar group)
                          (foldl (λ (f acc) (+ acc (string->number (cdr f))))
                                 0 group)))
         groups)))

(define (dive files)
  (filter-not empty? (map (λ (f)
                            (if (empty? (cddar f))
                                null
                                (cons (cdar f) (cdr f))))
                          files)))

(define (dir-sizes files [dirs (list)])
  (if (empty? files)
      dirs
      (dir-sizes (dive files)
                 (append (sum-dirs files) dirs))))

(define (sum-small-dirs dirs)
  (foldl (λ (size acc) (+ acc (cdr size))) 0
         (filter (λ (dir) (<= (cdr dir) 100000)) dirs)))


;; Part 1
(pretty-print (sum-small-dirs (dir-sizes (find-paths (file->lines "input-7-1.txt")))))



(define example "$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k")

(pretty-print (dir-sizes (find-paths (string-split example "\n"))))
(pretty-print (sum-small-dirs (dir-sizes (find-paths (string-split example "\n")))))
