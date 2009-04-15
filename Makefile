
check: test

test: faTL-test \
	lesson-test-a
#	lesson-test

direct: lesson5-a lesson6-a lesson-test-a

lessons: lesson5 lesson6

lesson5: lesson5.scm farsi.scm
	gosh lesson5.scm

lesson5-a: lesson5-a.scm farsi.scm faTL.scm
	gosh lesson5-a.scm

lesson6: lesson6.scm farsi.scm
	gosh lesson6.scm

lesson6-a: lesson6-a.scm farsi.scm faTL.scm
	gosh lesson6-a.scm

lesson-test: lesson-test.scm farsi.scm
	gosh lesson-test.scm

lesson-test-a: lesson-test-a.scm farsi.scm faTL.scm
	gosh lesson-test-a.scm

faTL-test: faTL-test.scm faTL.scm
	gosh faTL-test.scm

