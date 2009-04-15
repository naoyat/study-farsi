(use util.match)

(require "./nieme")
(define 1c (compose car 1er))
(define 2c (compose car 2e))
(define 3c (compose car 3e))
(define 4c (compose car 4e))
(define 5c (compose car 5e))

; library for string / symbol
;(define (string-rtrim-n str n)
;  (let1 len (string-length str)
;	(if (< len n) str (substring str 0 (- len n)))))
;
;(define (symbol-append . symbols)
;  (string->symbol (string-join (map symbol->string symbols) "")))

(require "./dic-1")
(define (lookup-words dic words)
  ;辞書{dic}からの単純なルックアップ
  (define (lookup word)
	(let1 it (assoc word dic)
	  (if it (cddr it) (list '? (string-append "%(" word ")%")))
	  ))
  (map lookup words))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
		 [trans (lookup-words dic words)])
	(let ([pos (map car trans)]
		  [ja (map caadr trans)])
	  (match pos
		;; lesson 5
		[('pron 'n 'be) (format "~aれは~aです。" (car ja) (cadr ja))] ;こ-れ は
		[('pron 'n 'adj 'be) (format "~aの~aは~a。" (car ja) (cadr ja) (caddr ja))] ;こ-の
		[else ja]
		)
	  )))

;(define (faTL-test text)
;  (format #t "~a →　~a\n" text (faTL->ja text)))
;
;(define (fa->ja fa) (faTL->ja (uc->faTL fa)))
;(define (fa-test text)
;  (format #t "~a\n　~a →　~a\n" text (uc->faTL text) (fa->ja text)))
