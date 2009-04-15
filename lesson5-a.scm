;
; 2/19 第5課
;
(require "./faTL")
(require "./farsi-engine")

;;(map print (map faTL->uc (list
(for-each fa-test (list
				   "آن کتاب است" ; A~N KTAB AST
				   "اين کتاب است" ; IN KTAB AST
				   "اين کتاب بزرگ است" ; IN KTAB BRzRG AST
				   "آن سگ کوچک است" ; A~N SG KVChK AST
				   ;;練習問題 (pp.24-25)
				   "آن مداد است" ; A~N MDAD AST
				   "اين اسب است" ; IN ASB AST
				   "آن درخت است" ; A~N DRKhT AST
				   "اين کاغذ است" ; IN KAGhDz AST
				   "آن نان است" ; A~N NAN AST
				   "اين آب سرد است" ; IN A~B SRD AST
				   "آن گل قشنگ است" ; A~N GL QShNG AST
				   "اين سیب بزرگ است" ; IN SYB BRzRG AST
				   "اين گربه کوچک است" ; IN GRBH KVChK AST
				   "آن کاغذ سفید است" ; A~N KAGhDz SFYD AST
				   ))
