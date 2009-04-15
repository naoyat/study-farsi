(use srfi-1)
(use util.match)

(define dic '(
              ;第5課
;              ("AN"     "a:n"      pron (あ そ))
;              ("IN"     "i:n"      pron (こ))
              ("AN"     "a:n"      pron (あれ それ))
              ("IN"     "i:n"      pron (これ))

              ("@ST"    "ast"      be   (です))

              ("KTAB"   "keta:b"   n    (本))
              ("SG"     "sa:g"     n    (犬))
              ("MDAD"   "meda:d"   n    (鉛筆))
              ("@SB"    "asb"      n    (馬))
              ("DRKhT"  "derakht"  n    (木))
              ("KAGhDz" "ka:ghaz"  n    (紙))
              ("NAN"    "na:n"     n    (パン))
              ("AB"     "a:b"      n    (水))
              ("GL"     "gol"      n    (花))
              ("SIB"    "si:b"     n    (リンゴ))
              ("GRBH"   "gorbe"    n    (猫))

              ("BRzRG"  "bozorg"   adj  (大きい))
              ("KUChK"  "ku:chek"  adj  (小さい))
              ("SRD"    "sard"     adj  (冷たい 寒い))
              ("QShNG"  "ghashang" adj  (美しい))
              ("SFID"   "sefi:d"   adj  (白い))

              ;第6課
              ("AYA"     "a:ya:"    AYA   (？))
              ("?"       "?"        ?     (？))

              ("BLH"     "bale"     yn    (はい))
              ("NH KhIR" "na kheir" yn    (いいえ))
              ("NKhIR"   "nakheir"  yn    (いいえ))

              ("NIST"    "ni:st"    be    (ではありません))

              ("ChH"     "che"      qu    (何))
              ("ChIST"   "chi:st"   S     ("ChH" "@ST"))
              ("KI"      "ki:"      qu    (誰))
              ("KIST"    "ki:st"    S     ("KI" "@ST"))
              ("KJA"     "koja:"    qu    (どこ))
              ("KJAST"   "koja:st"  S     ("KJA" "@ST"))

              ("INJA"    "i:nja:"   pron  (ここ))
              ("U"       "u:"       pron  (彼 彼女))

              ("JA"      "ja:"      n     (場所))
              ("TUT"     "tu:t"     n     (桑の実))
              ("HSIN"    "hosein"   n     (ホセイン {人名,男}))
              ("IRAN"    "i:ra:n"   n     (イラン))
              ("QLM"     "ghalam"   n     (ペン))
              ("MIRz"    "mi:z"     n     (机))
              (".SNDLI"  "sandali:" n     (椅子))
              ("RzhAPN"  "zha:pon"  n     (日本))

              ;第7課
			  ("SRKh"    "sorkh"     adj  (赤い))
			  ("PIR"     "pi:r"      adj  (年老いた))
			  ("NU"      "nou"       adj  (新しい))
			  ("BLND"    "boland"    adj  (長い))

			  ("PDR"     "pedar"     n    (父))
			  ("MADR"    "ma:dar"    n    (母))

			  ("MN"      "man"       pron (私))
			  ("MA"      "ma:"       pron (私たち))
			  ("ShMA"    "shoma:"    pron (あなた あなたがた))

			  ("MRD"     "mard"      n    (男の人))
			  ("RzN"     "zan"       n    (女の人))

			  ("RAST"    "ra:st"     adj  (右 正しい))
			  ("ChP"     "chap"      adj  (左))

			  ("DST"     "dast"      n    (手))
			  ("PA"      "pa:"       n    (足))
			  ("MU"      "mu:"       n    (髪))
			  ("BChChH"  "bachche"   n    (子供))
			  ("BChH"    "bachche"   n    (子供))
			  ("@SM"     "esm"       n    (名前))

			  ("AQA"     "a:gha:"    n    (_さん))
			  ("KhANM"   "kha:nom"   n    (_さん 婦人))
			  ("KASB"    "ka:seb"    n    (商人))
			  ("BNDR"    "bandar"    n    (港))
			  ("RUD"     "ru:d"      n    (川))
			  ("KUH"     "ku:h"      n    (山))
			  ("ShHR"    "shahr"     n    (市 町))

			  ("V"       "va"        conj (そして _と)); "va" | "o"

			  ("NADR"    "na:der"    n    (ナーデル {人名,男}))
			  ("HSN"     "hasan"     n    (ハサン {人名,男}))
			  ("@FShAR"  "afsha:r"   n    (アフシャール {人名}))
			  ("`BBAS"   "abba:s"    n    (アッバース {人名,男}))
			  ("`BAS"   "abba:s"     n    (アッバース {人名,男}))
			  ("KARUN"   "ka:ru:n"   n    (カールーン {川}))
			  ("DMAUND"  "dama:vand" n    (ダマーヴァンド {山}))
			  ("THRAN"   "tehra:n"   n    (テヘラン))
              ))

(define (string-rtrim-n str n)
  (let1 len (string-length str)
	(if (< len n) str (substring str 0 (- len n)))))

(define (lookup-words dic words)
  ;; 辞書{dic}からの単純なルックアップ
  (define (lookup word)
    (let1 it (assoc word dic)
      (if it (cddr it) #f) ; (list '? (string-append "%(" word ")%")))))
	  ))

;	(list (cons 'ezafe (car trans)) (cdr trans)))
;  (map lookup words))

  (let loop ([rest words]
             [result '()])

	(define (push-and-next trans)
	  (loop (cdr rest) (cons trans result)))
	(define (push2-and-next t1 t2)
	  (loop (cdr rest) (cons t2 (cons t1 result))))
    (define (not-found word)
	  (push-and-next (list '? (list (string-append "%(" word ")%"))) ))

    (if (null? rest) (reverse! result)
        (let* ([head (car rest)]
               [trans (lookup head)])
          (cond [(not trans) ; not found
				 (cond [(#/ST$/ head)
						(let1 tmp (lookup (string-rtrim-n head 2))
						  (if tmp
							  (push2-and-next tmp (lookup "@ST"))
							  (not-found head) ))]
					   [(#/-[Yy]?e$/ head)
						(cond [(#/-Ye$/ head)
							   (let* ([body (string-rtrim-n head 3)]
									  [body+Y (string-append body "I")])
								 (let1 t1 (lookup body+Y)
								   (if t1 
									   (push-and-next (ezafe t1))
									   (let1 t2 (lookup body)
										 (if t2
											 (push-and-next (ezafe t2))
											 (not-found head) )))))]
							  [(#/-ye$/ head)
							   (push-and-next (ezafe (lookup (string-rtrim-n head 3))))]
							  [(#/-e$/ head)
							   (push-and-next (ezafe (lookup (string-rtrim-n head 2))))]
							  [else (not-found head)])]
					   )]
                [(eq? 'S (car trans))
                 (loop (cdr rest) (append (reverse! (map lookup (cadr trans))) result))]
                [else
				 (push-and-next trans)]
                )
          ))))

(define (symbol-append . symbols)
  (string->symbol (string-join (map symbol->string symbols) "")))

(define (nom->gen nom)
  (case nom
    ((あれ) 'あの)
    ((これ) 'この)
    ((それ) 'その)
    ((どれ) 'どの)
    (else (symbol-append nom 'の))
    ))

;
; modify
;
(define (tagged? tag obj) (and (pair? obj) (eq? tag (car obj))))

(define (modified? obj) (tagged? 'modified obj))
(define (modified-body obj)
  (if (modified? obj)
	  (second obj)
	  obj))
(define (modified-modifiers obj)
  (if (modified? obj)
	  (third obj)
	  '()))
(define (modify obj . modifiers)
  (if (modified? obj)
	  (list 'modified (modified-body obj) (append modifiers (modified-modifiers obj)))
	  (list 'modified obj modifiers)))

(unless #t
(use gauche.test)
(test-start "modify")
(define o0 'hair)
(test* "modified?" #f (modified? o0))
(test* "modified-body" 'hair (modified-body o0))
(test* "modified-modifiers" '() (modified-modifiers o0))
(define o1 (modify o0 'blond))
(test* "modified?" #t (modified? o1))
(test* "modified-body" 'hair (modified-body o1))
(test* "modified-modifiers" '(blond) (modified-modifiers o1))
(define o2 (modify o1 'long))
(test* "modified?" #t (modified? o2))
(test* "modified-body" 'hair (modified-body o2))
(test* "modified-modifiers" '(long blond) (modified-modifiers o2))
(test-end)
)

(define (pos obj) ; 品詞
  (if (modified? obj)
	  (pos (modified-body obj))
	  (car obj)))

(define (ezafe obj)
  (cons 'ezafe obj))
;	(format #t "\n~a\n" (cons 'ezafe trans))
;  `((ezafe ,(car obj)) (,(symbol-append (caadr obj) '-of)) ))
(define (ezafe? obj) (tagged? 'ezafe obj))
(define (ezafe-body obj)
  (if (ezafe? obj) (cdr obj) obj))
;;

;a b Ec Ed e f = a b (c- d- e) f
;              = f (e -d -c) b a
(define (resolve-ezafe objs)
  (define (f-ezafe rest curr-obj past)
	(if (null? rest)
		(reverse! (if curr-obj (cons curr-obj past) past))
		(let1 head (car rest)
		  (if curr-obj
			  (if (ezafe? head)
				  ; (... ezafe) ezafe
				  (f-ezafe (cdr rest) (modify curr-obj (ezafe-body head)) past)
				  ; (... ezafe) -
				  (f-ezafe (cdr rest) #f (cons (modify curr-obj head) past))
				  )
			  (if (ezafe? head)
				  ; #f ezafe
				  (f-ezafe (cdr rest) (ezafe-body head) past)
				  ; #f -
				  (f-ezafe (cdr rest) #f (cons head past))
				  )
			  ))))
  (f-ezafe objs #f '()))

(define (faTL->ja text)
  (let* ([words (string-split text " ")]
         [trans (lookup-words dic words)]
;		 [X (print "trans: " trans)]
		 [trans* (resolve-ezafe trans)]
;		 [Y (print "trans*: " trans*)]
		 )
	(map (lambda (t)
		   (if (modified? t)
			   (format "+ ~a : ~a : ~a" (pos t) (modified-body t) (modified-modifiers t))
			   (format "- ~a : ~a" (pos t) t)
			   ))
		 trans*)
	))
(define (faTL->ja text)
  (let* ([words (string-split text " ")]
         [trans (lookup-words dic words)])
    (let ([pos (map pos trans)]  ; (pron n be)
          [ja (map identity trans)]) ; (こ 本 です)
      (match pos
        ;; lesson 5
;        [('pron 'n 'be) (format "~aは~aです。" (first ja) (second ja))] ;これ(は)
;        [('pron 'n adj 'be) (format "~a~aは~a。" (nom->gen (first ja)) (second ja) (third ja))] ;この
        [('pron (or 'n 'adj) 'be) (format "~aは~aです。" (first ja) (second ja))]
        [('pron 'n (or 'n 'adj) 'be) (format "~a~aは~a。" (nom->gen (first ja)) (second ja) (third ja))] ;この
        ;; lesson 6
        [('AYA 'pron 'n 'be '?) (format "~aは~aですか？" (second ja) (third ja))] ;これ(は)
        [('pron (or 'n 'adj) 'be '?) (format "~aは~aですか？" (first ja) (second ja))] ;これ(は)
        [('yn 'pron 'n 'be) (format "~a、~aは~a~a。"
                                    (first ja) (second ja) (third ja) (fourth ja))] ;
        [('pron 'qu 'be '?) (format "~aは~aですか？" (first ja) (second ja))] ;これ(は)

		;; lesson 7
        [('ezafe x) (format "{~a}-~a" (second ja) (first ja))]
        [('ezafe 'ezafe x) (format "{{~a}-~a}-~a" (third ja) (second ja) (first ja))]
		[('ezafe x 'conj 'ezafe y) (format "{~a}-~aと{~a}-~a"
										   (second ja) (first ja)
										   (fifth ja) (fourth ja))]

        [('pron 'ezafe x 'be) (format "~aは{~a}-~aです。" (first ja) (third ja) (second ja))]
        [('ezafe x 'adj 'be) (format "{~a}-~aは~a。" (second ja) (first ja) (third ja))]
        [('ezafe 'pron 'n 'be) (format "~a~aは~aです。" (nom->gen (second ja)) (first ja) (third ja))]
        [('ezafe 'pron 'n 'be '?) (format "~a~aは~aですか？" (nom->gen (second ja)) (first ja) (third ja))]
        [('pron 'n adj 'be '?) (format "~a~aは~aですか？" (nom->gen (first ja)) (second ja) (third ja))] ;この
        [('ezafe 'pron 'n) (format "{{~a}-~a}-~a" (nom->gen (second ja)) (third ja) (first ja))]
        [('ezafe 'ezafe 'pron 'n) (format "{{{~a}-~a}-~a}-~a" (nom->gen (third ja)) (fourth ja) (second ja) (first ja))]
        [('ezafe 'ezafe 'ezafe 'pron 'n) (format "{{{{~a}-~a}-~a}-~a}-~a" (nom->gen (fourth ja)) (fifth ja) (third ja) (second ja) (first ja))]
        [else ja]) )))

;;
;; TEST
;;
(use gauche.test)
(test-start "第７課")
;(require "./lesson5-test")
;(require "./lesson6-test")
;(require "./lesson7-test")
(define-macro (faTL->ja-test cap faTL ja) 
  `(begin
	 (print "testing " ,faTL " ...")
	 (map print (faTL->ja ,faTL))))
(faTL->ja-test "〔句〕" "GL-e SRKh" "赤い花")
(faTL->ja-test "〔句〕" "PDR-e U" "彼の父")
(faTL->ja-test "〔句〕" "PDR-e PIR-e U" "彼の年老いた父")
(faTL->ja-test "〔句〕" "PA-Ye @SB" "馬の足")
(faTL->ja-test "〔句〕" "MU-Ye SFID" "白い髪")
(faTL->ja-test "〔句〕" ".SNDLI-ye NU" "新しい椅子")
(faTL->ja-test "〔句〕" "BChChH-ye MN" "私の子供")
(faTL->ja-test "" "IN GL-e SRKh @ST" "これは赤い花です。")

(test-section "第7課:練習")
(faTL->ja-test "1) " "DST-e U BLND @ST" "彼の手は長い。")
(faTL->ja-test "2) " "MU-Ye SFID-e BLND-e AN MRD" "あの男の人の長い白髪")
(faTL->ja-test "3) " "@SM-e ShMA ChIST ?" "あなたの名前は何ですか？")
(faTL->ja-test "   " "@SM-e MN NADR @ST" "私の名前はナーデルです。")
(faTL->ja-test "4) " "AN MRD KIST ?" "あの男の人は誰ですか？")
(faTL->ja-test "   " "U PDR-e MA @ST" "彼は私たちの父です。")
(faTL->ja-test "5) " "AN MRD PDR-e U @ST" "あの男の人は彼のお父さんです。")
(faTL->ja-test "6) " "AN RzN KIST ?" "あの女の人は誰ですか？")
(faTL->ja-test "   " "U MADR-e HSN @ST" "彼女はハサンのお母さんです。")
(faTL->ja-test "7) " "DST-e RAST V DST-e ChP" "右手と左手")

(test-end)
