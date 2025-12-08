make_apa_str = function(out) {

  #' @title Make APA String
  #'
  #' @description Given the output of the tests from Psych 522/4,
  #' returns the APA Formatted String.
  #'
  #' @param out The output of the test
  #' @return APAstr or named list of APAstr if multiple hypothesis tests
  #' @example man/Example/make_apa_str_1f_anova.R

  #' @export

  APAstr = list()

  get_eq = function(p) ifelse(p >= 0.001, '=', '<')
  get_pstr = function(p) ifelse(p,
                                sub('0.','.',sprintf('%0.4f', p)),
                                '.001')
  # Chi-Square
  if (any(grepl("Chi-squared", attr(out, "heading"), fixed=T))) {

    pstr = get_pstr(out$p.value)
    eq = get_eq(out$p.value)
    APAstr = sprintf('Chi-Squared(%d,N=%d) = %5.4f, p %s %s',
                  out$parameter,
                  sum(out$observed),
                  out$statistic,
                  eq, pstr)
  }

  # T-Test
  if (any(grepl("t-test", out$method, fixed=T))) {

    pstr = get_pstr(out$p.value)
    eq = get_eq(out$p.value)
    dfstr = ifelse(out$parameter %% 1 == 0,
                   sprintf('%.0f', out$parameter),
                   sprintf('%0.2f', out$parameter))
    APAstr = sprintf('_t(%s) = %0.2f, p %s %s_', dfstr,
                     out$statistic, eq, pstr)
  }
  #

  # Type III ANOVA Table
  if (any(grepl('Type III', attr(out, "heading"), fixed=T))) {

    for (r in row.names(out)) {

      pstr = get_pstr(out[r, ]$`Pr(>F)`)
      eq = get_eq(out[r, ]$`Pr(>F)`)

      str = sprintf('_F(%0.0f,%0.0f) = %0.2f, p %s %s_',
                    out[r, "NumDF"], out[r, "DenDF"],
                    out[r,]$`F value`, eq, pstr)

      r = gsub(":", "x", r)
      APAstr[[r]] = str
    }

  }

  # Type I ANOVA Table
  else {

    for (r in row.names(out)) {
      if (r != 'Residuals') {

        pstr = get_pstr(out[r, ]$`Pr(>F)`)
        eq = get_eq(out[r, ]$`Pr(>F)`)

        str = sprintf('_F(%0.0f,%0.0f) = %0.2f, p %s %s_',
                      out[r, "Df"], out["Residuals", "Df"],
                      out[r, ]$`F value`, eq, pstr)

        r = gsub(":", "x", r)
        APAstr[[r]] = str
      }
    }
  }

  return(APAstr)

}

