(tab = table(mtcars$cyl))
(out = chisq.test(tab))
(make_apa_str(out))
