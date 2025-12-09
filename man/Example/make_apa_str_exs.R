### T-TEST
data = iris[iris$Species != "virginica",]
(out = t.test(Sepal.Length ~ Species, data = data, var.equal=TRUE))
(make_apa_str(out))

### Chi-Square Test
(tab = table(mtcars$cyl))
(out = chisq.test(tab))
(make_apa_str(out))

### 1 Factor ANOVA
(out = anova(lm(Sepal.Length ~ Species, data=iris)))
make_apa_str(out)
