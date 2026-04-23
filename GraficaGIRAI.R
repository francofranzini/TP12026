# --- PREPARACIÓN ---
datos_ord <- datos[order(-datos$GIRAI), ]
datos_ord$rank <- 1:nrow(datos_ord)

n <- nrow(datos_ord)
q2 <- floor(0.5 * n)
y_q2 <- ceiling(datos_ord$GIRAI[q2])

# ticks
ticks_x <- seq(0, max(datos_ord$rank), by = 20)
ticks_y <- seq(0, ceiling(max(datos_ord$GIRAI)/20)*20, by = 20)

# --- GRÁFICO ---
plot(datos_ord$rank, datos_ord$GIRAI,
     pch = 16,
     xlab = "Ranking de Paises",
     ylab = "GIRAI",
     xlim = c(0, max(datos_ord$rank)),
     ylim = c(0, max(ticks_y)),
     xaxs = "i", yaxs = "i",
     xaxt = "n", yaxt = "n")

lines(datos_ord$rank, datos_ord$GIRAI)

# líneas guía
abline(v = q2, col = "red", lty = 2)
abline(h = y_q2, col = "blue", lty = 2)

# --- EJE X ---
axis(1, at = ticks_x)
axis(1, at = q2, labels = q2, col.axis = "red")

# --- EJE Y (IMPORTANTE: solo ticks base) ---
axis(2, at = ticks_y)

# --- ETIQUETA Q2 (NO como eje) ---
mtext(text = y_q2, side = 2, at = y_q2, col = "blue")

