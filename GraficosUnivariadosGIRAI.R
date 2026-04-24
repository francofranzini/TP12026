#####################
# Gráfico de barras #
#####################

datos_recortados %>%
  
  ggplot() + 
  
  #aes(x = tiempo) + # Frecuencias absolutas
  aes(x = reorder(Dimensión mejor puntuada, Dimensión mejor puntuada, function(x) -length(x))) + # Ordenar según frecuencia
  #aes(x = tiempo, y = ..count.. / sum(..count..)) + # Porcentajes
  # aes(x = reorder(tiempo, tiempo, function(x) -length(x)), 
  #		y = ..count.. / sum(..count..)) +  # Porcentajes ordenados según frecuencia
  #scale_y_continuous(labels = scales::percent) +    # Eje para porcentajes
  
  geom_bar(width = 0.4,   # Ancho de barras
           fill = '#7ed021',  # Color de relleno 
           col = "black",  # Color de línea
           alpha = 0.6) +  # Transparencia
  
  labs(y = "Cantidad de paises", x = "Dimensión mejor puntuada") + # Nombres de ejes
  
  ggtitle("Cantidad de paises por dimension predominante") +
  
  #coord_flip() + # Barras horizontales o verticales
  
  theme_classic() # Temas preconfigurados de R https://r-charts.com/ggplot2/themes/



###########################################
# Gráfico de barras a partir de una tabla #
###########################################
# 
# datos_limpios %>%
#   mutate(
#     alguna = atracnosis + roya + manchas + ampollas,
#     ninguna = ifelse(alguna == 0, 1, 0)
#   ) %>%
#   summarize(atracnosis = sum(atracnosis),
#             roya = sum(roya),
#             manchas = sum(manchas),
#             ampollas = sum(ampollas),
#             ninguna = sum(ninguna)) %>%
#   pivot_longer(cols = c(atracnosis, roya, manchas, ampollas, ninguna),
#                names_to = "plaga",
#                values_to = "cant") %>%
#   
#   ggplot() + 
#   
#   aes(x = reorder(plaga, cant), 
#       y = cant / sum(cant)) +  # Porcentajes ordenados según frecuencia
#   
#   scale_y_continuous(labels = scales::percent) +    # Eje para porcentajes
#   
#   geom_bar(stat = "identity", # Argumento necesario si partimo de una tabla
#            width = 0.75) +
#   labs(y = "Cantidad de árboles", x = "Presencia de plagas") +
#   ggtitle("Plagas presentes en los árboles") +
#   coord_flip() +
#   theme_classic() # Temas preconfigurados de R https://r-charts.com/ggplot2/themes/
#