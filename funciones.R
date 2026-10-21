# Funciones compartidas por las tres páginas del taller.
# Requiere los paquetes: car, nortest

# ---- Diagnóstico de supuestos --------------------------------------------
# Recibe un modelo lm/aov y el factor de tratamiento.
# Devuelve dos tablas: pruebas de normalidad (residuales) y prueba de Levene.
diagnostico <- function(modelo, tratamiento) {
  r <- residuals(modelo)

  sw <- shapiro.test(r)
  ad <- nortest::ad.test(r)
  li <- nortest::lillie.test(r)

  normalidad <- data.frame(
    prueba      = c("Shapiro-Wilk", "Anderson-Darling", "Lilliefors (K-S)"),
    estadistico = unname(round(c(sw$statistic, ad$statistic, li$statistic), 4)),
    valor_p     = signif(c(sw$p.value, ad$p.value, li$p.value), 3),
    decision    = ifelse(c(sw$p.value, ad$p.value, li$p.value) < 0.05,
                         "Rechaza normalidad", "No rechaza normalidad")
  )

  lev <- car::leveneTest(r ~ tratamiento, center = median)
  levene <- data.frame(
    prueba      = "Levene (centro: mediana)",
    estadistico = round(lev$`F value`[1], 4),
    gl          = paste(lev$Df[1], lev$Df[2], sep = " y "),
    valor_p     = signif(lev$`Pr(>F)`[1], 3),
    decision    = ifelse(lev$`Pr(>F)`[1] < 0.05,
                         "Rechaza homocedasticidad", "No rechaza homocedasticidad")
  )

  list(normalidad = normalidad, levene = levene)
}

# ---- Gráficos de diagnóstico ---------------------------------------------
graficos_diagnostico <- function(modelo) {
  op <- par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3, 1))
  on.exit(par(op))
  r <- residuals(modelo)
  qqnorm(r, main = "Q-Q de los residuales", pch = 19, col = "#2e7d32",
         xlab = "Cuantiles teóricos", ylab = "Cuantiles de los residuales")
  qqline(r, lwd = 2)
  plot(fitted(modelo), r, pch = 19, col = "#2e7d32",
       main = "Residuales vs. ajustados",
       xlab = "Valores ajustados", ylab = "Residuales")
  abline(h = 0, lty = 2)
}
