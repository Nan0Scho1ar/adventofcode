#lang racket

(define moves (list 'Rock 'Paper 'Scissors))

(define (select-move move index-offset)
  (list-ref moves (modulo (+ index-offset (index-of moves move)) 3)))

(define (parse-games move-parser filename)
  (map (λ (str) (move-parser (string-split str)))
      (file->lines filename)))

(define (part-1-parser moves)
  (let ([their-move (match (first moves) ["A" 'Rock] ["B" 'Paper] ["C" 'Scissors])]
        [your-move (match (second moves) ["X" 'Rock] ["Y" 'Paper] ["Z" 'Scissors])])
    (list their-move your-move)))

(define (part-2-parser moves)
  (let ([their-move (match (first moves) ["A" 'Rock] ["B" 'Paper] ["C" 'Scissors])]
        [your-condition (match (second moves) ["X" 'Lose] ["Y" 'Draw] ["Z" 'Win])])
    (list their-move (find-your-move their-move your-condition))))

(define (find-your-move their-move desired-condition)
  (match desired-condition
    ['Win (select-move their-move 1)]
    ['Lose (select-move their-move -1)]
    ['Draw their-move]))

(define (score-game their-move your-move)
  (let ([move-score (add1 (index-of moves your-move))])
    (cond
      [(eq? (select-move your-move -1) their-move) (+ 6 move-score)]
      [(eq? (select-move your-move 1) their-move) move-score]
      [else (+ 3 move-score)])))

(define (score-games games)
  (for/sum ([game games])
    (score-game (first game) (second game))))

(display "Part 1: ")
(displayln (score-games (parse-games part-1-parser "input-2-1.txt")))

(display "Part 2: ")
(displayln (score-games (parse-games part-2-parser "input-2-1.txt")))
