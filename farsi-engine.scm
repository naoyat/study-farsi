(use util.match)

(require "./nieme")
(define 1c (compose car 1er))
(define 2c (compose car 2e))
(define 3c (compose car 3e))
(define 4c (compose car 4e))
(define 5c (compose car 5e))

; library for string / symbol
(define (string-rtrim-n str n)
  (let1 len (string-length str)
	(if (< len n) str (substring str 0 (- len n)))))

(define (symbol-append . symbols)
  (string->symbol (string-join (map symbol->string symbols) "")))

(require "./dic")
(define (lookup-words dic words)

  ;辞書{dic}からの単純なルックアップ
  (define (lookup word)
	(let1 it (assoc word dic)
	  (if it (cddr it) #f) ;(list '? (string-append "%(" word ")%")))
	  ))

  (let loop ([rest words]
			 [result '()])

	(define (not-found word)
	  (loop (cdr rest) (cons (list '? (string-append "%(" word ")%")) result)))

	(if (null? rest) (reverse! result)
		(let* ([head (car rest)]
			   [trans (lookup head)])
		  (cond [(not trans) ; not found
				 (if (#/ST$/ head)
					 (let1 tmp (lookup (string-rtrim-n head 2))
					   (if tmp
						   (loop (cdr rest) (cons (lookup "@ST") (cons tmp result)))
						   (not-found head) ))
					 (not-found head) )]
				[(eq? 'S (car trans))
				 (loop (cdr rest) (append (reverse! (map lookup (cadr trans))) result))]
				[else
				 (loop (cdr rest) (cons trans result))]
				)
		  ))))

(define (nom->gen nom)
  (case nom
	((あれ) 'あの)
	((これ) 'この)
	((それ) 'その)
	((どれ) 'どの)
	(else (symbol-append nom 'の))
	))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
		 [trans (lookup-words dic words)])
	(let ([pos (map car trans)]
		  [ja (map cadr trans)])
	  (match pos
		;; lesson 5
		[('pron 'n 'be) (format "~aは~aです。" (1c ja) (2c ja))] ;これ(は)
		[('pron 'n 'adj 'be) (format "~a~aは~a。" (nom->gen (1c ja)) (2c ja) (3c ja))] ;この
		;; lesson 6
		[('AYA 'pron 'n 'be '?) (format "~aは~aですか？" (2c ja) (3c ja))] ;これ(は)
		[('pron 'n 'be '?) (format "~aは~aですか？" (1c ja) (2c ja))] ;これ(は)
		[('yn 'pron 'n 'be) (format "~a、~aは~a~a。"
									(1c ja) (2c ja) (3c ja) (4c ja))] ;
		[('pron 'qu 'be '?) (format "~aは~aですか？" (1c ja) (2c ja))] ;これ(は)

		[else ja]
		);match
	  ))
  );define

(define (faTL-test text)
  (format #t "~a →　~a\n" text (faTL->ja text)))

;
(define (fa->ja fa) (faTL->ja (uc->faTL fa)))

(define (fa-test text)
  (format #t "~a\n　~a →　~a\n" text (uc->faTL text) (fa->ja text)))
