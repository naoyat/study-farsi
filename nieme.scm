;;
;; nieme - like (first) (second) ...., but returns *nieme-nil* if not found
;;
;; by naoya_t
;; Feb.18.2008
;;
(define *nieme-nil* #f)

(define (1er l) (if (pair? l) (car l) *nieme-nil*))

(define (next-fn fn)
  (lambda (l) (if (pair? l) (fn (cdr l)) *nieme-nil*)))

(define 2e (next-fn 1er))
(define 3e (next-fn 2e))
(define 4e (next-fn 3e))
(define 5e (next-fn 4e))
(define 6e (next-fn 5e))
(define 7e (next-fn 6e))
(define 8e (next-fn 7e))
(define 9e (next-fn 8e))
(define 10e (next-fn 9e))
(define 11e (next-fn 10e))
(define 12e (next-fn 11e))

(define (nieme n l) ; n-ie`me
  (cond ((< n 1) *nieme-nil*)
		((= n 1) (1er l))
		((> n 1) (if (pair? l) (nieme (- n 1) (cdr l)) *nieme-nil*))
;		((> n 1) ((next-fn (cut nieme (- n 1) <>)) l))
		(else *nieme-nil*)))

(define premier 1er) (define 1ere 1er) (define 1e 1er) (define 1eme 1er) ;1e/1eme for typo
(define 2eme 2e) (define deuxieme 2e)
(define 3eme 3e) (define troisieme 3e)
(define 4eme 4e) (define quatrieme 4e)
(define 5eme 5e) (define cinquieme 5e)
(define 6eme 6e) (define sixieme 6e)
(define 7eme 7e) (define septieme 7e)
(define 8eme 8e) (define huitieme 8e)
(define 9eme 9e) (define neuvieme 9e)
(define 10eme 10e) (define dixieme 10e)
(define 11eme 11e) (define onzieme 11e)
(define 12eme 12e) (define douzieme 12e)
(define n-ieme nieme)

(define (make-nieme-fn n) (lambda (l) (nieme n l)))

;;;
;;; test
;;;
(unless #t
(use gauche.test)
(test-start "n-ieme")

(test-section "#1: premier / 1er(e)")
;(test* "(1 2 3)" 1 (1er '(1 2 3)))
(test* "(1 2)" 1 (1er '(1 2)))
(test* "(1)" 1 (1er '(1)))
(test* "()" *nieme-nil* (1er '()))
(test* "(1 . 2)" 1 (1er '(1 . 2)))
(test* "1" *nieme-nil* (1er 1))
(test* "'a" *nieme-nil* (1er 'a))

(test-section "#2: deuxieme / 2e")
(test* "(1 2 3)" 2 (2e '(1 2 3)))
(test* "(1 2)" 2 (2e '(1 2)))
(test* "(1)" *nieme-nil* (2e '(1)))
(test* "()" *nieme-nil* (2e '()))
(test* "(1 . 2)" *nieme-nil* (2e '(1 . 2)))
(test* "1" *nieme-nil* (2e 1))
;(test* "'a" *nieme-nil* (2e 'a))

(test-section "#3: troisieme / 3e")
(test* "(1 2 3 4)" 3 (3e '(1 2 3 4)))
(test* "(1 2 3)" 3 (3e '(1 2 3)))
(test* "(1 2)" *nieme-nil* (3e '(1 2)))
(test* "(1)" *nieme-nil* (3e '(1)))
(test* "()" *nieme-nil* (3e '()))
(test* "(1 2 . 3)" *nieme-nil* (3e '(1 2 . 3)))
(test* "(1 . 2)" *nieme-nil* (3e '(1 . 2)))
(test* "1" *nieme-nil* (3e 1))
;(test* "'a" *nieme-nil* (3e 'a))

(test-section "#4: quatrieme / 4e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 4 (4e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (4e '(1 2 3)))
(test-section "#5: cinquieme / 5e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 5 (5e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (5e '(1 2 3)))
(test-section "#6: sixieme / 6e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 6 (6e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (6e '(1 2 3)))
(test-section "#7: septieme / 7e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 7 (7e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (7e '(1 2 3)))
(test-section "#8: huitieme / 8e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 8 (8e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (8e '(1 2 3)))
(test-section "#9: neuvieme / 9e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 9 (9e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (9e '(1 2 3)))
(test-section "#10: dixieme / 10e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 10 (10e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (10e '(1 2 3)))
(test-section "#11: onzieme / 11e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 11 (11e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (11e '(1 2 3)))
(test-section "#12: douzieme / 12e")
(test* "(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)" 12 (12e '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)))
(test* "(1 2 3)" *nieme-nil* (12e '(1 2 3)))

(test-section "#n: nieme")
(test* "0 (1 2 3 4)" *nieme-nil* (nieme 0 '(1 2 3 4)))
(test* "1 (1 2 3 4)" 1 (nieme 1 '(1 2 3 4)))
(test* "2 (1 2 3 4)" 2 (nieme 2 '(1 2 3 4)))
(test* "3 (1 2 3 4)" 3 (nieme 3 '(1 2 3 4)))
(test* "4 (1 2 3 4)" 4 (nieme 4 '(1 2 3 4)))
(test* "5 (1 2 3 4)" *nieme-nil* (nieme 5 '(1 2 3 4)))
(test* "1 ()" *nieme-nil* (nieme 1 '()))
(test* "1 1" *nieme-nil* (nieme 1 1))

(test-end)
)