;
; 2/19 第6課
;
(require "./faTL")
(require "./farsi-engine")

;;(map print (map faTL->uc (list
(for-each fa-test (list
				   ;;p.26
				   "آیا اين کتاب است ؟" ; A~YA IN KTAB AST ?
				   "اين کتاب است ؟" ; IN KTAB AST ?
				   "آیا اين سگ است ؟" ; A~YA IN SG AST ?
				   "بله اين سگ است" ; BLH IN SG AST
				   ;;p.27
				   "آیا اين گربه است ؟" ; A~YA IN GRBH AST ?
				   "نخیر اين گربه نیست" ; NKhYR IN GRBH NYST
				   "اين چیست ؟" ; IN ChYST ?
				   "اينجا کجاست ؟" ; INJA KJAST ?
				   ;;p.28
				   "آن چیست ؟" ; A~N ChYST ?
				   "آن توت است" ; A~N TVT AST
				   "او کیست ؟" ; U KYST ?
				   "او هسین است" ; U HSYN AST
				   "اينجا کجاست ؟" ; INJA KJAST ?
				   "اينجا ايران است" ; INJA IRAN AST
				   ;;練習
				   "آیا اين گل است ؟" ; A~YA IN GL AST ?
				   "بله اين گل است" ; BLH IN GL AST
				   "آیا اين قلم است ؟" ; A~YA IN QLM AST ?
				   "نخیر اين قلم نیست" ; NKhYR IN QLM NYST
				   "اين چیست ؟" ; IN ChYST ?
				   "اين میز است" ; IN MYRz AST
				   "آن چیست ؟" ; A~N ChYST ?
				   "آن صندلی است" ; A~N .SNDLY AST
				   "اينجا کجاست ؟" ; INJA KJAST ?
				   "اينجا ژاپن است" ; INJA RzhAPN AST
				   ))