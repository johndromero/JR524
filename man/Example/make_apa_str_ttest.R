data = iris[iris$Species != "virginica",]
(out = t.test(Sepal.Length ~ Species, data = data, var.equal=TRUE))
(make_apa_str(out))
