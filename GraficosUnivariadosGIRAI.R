# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("janitor")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(janitor)
library(tidyverse)
library(ggplot2)

attach(datos_recortados)

############################
#    Gráfico de barras     #
# Dimension mejor puntuada #
############################

datos_recortados %>%
  
  ggplot() + 
  
  #aes(x = Dimensión mejor puntuada) + # Frecuencias absolutas
  aes(x = reorder(`Dimensión mejor puntuada`, `Dimensión mejor puntuada`, function(x) -length(x))) + # Ordenar según frecuencia
  #aes(x = Dimensión mejor puntuada, y = ..count.. / sum(..count..)) + # Porcentajes
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


##############################
#    Gráfico de barras       #
# p70_* (seleccion multiple) #
##############################

tabla_p70 <- datos_recortados %>%
  summarise(across(starts_with("p70"), ~ sum(. == 1, na.rm = TRUE))) %>%
  pivot_longer(
    cols = everything(),
    names_to = "accion",
    values_to = "cantidad"
  ) %>%
  mutate(
    accion = recode(accion,
                    p70_sesgo = "Sesgo y Discriminacion Injusta",
                    p70_infancia = "Derechos de la Infancia",
                    p70_divers = "Diversidad Cultural y Lingüística",
                    p70_datpers = "Proteccion de Datos y Privacidad",
                    p70_genero = "Igualdad de Genero",
                    p70_suphum = "Supervision Humana",
                    p70_laboral = "Proteccion Laboral y Derecho al Trabajo",
                    p70_segu = "Seguridad, Precision y Fiabilidad",
                    p70_transp = "Transparencia y Explicabilidad")
  ) %>%
  mutate(accion = reorder(accion, cantidad))

ggplot(tabla_p70) +
  aes(x = accion, y = cantidad) +
  geom_col(width = 0.4,
           fill = '#7ed021',
           col = "black",
           alpha = 0.6) +
  geom_text(
    aes(label = cantidad),
    hjust = -0.3
  ) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    y = "Cantidad de Países",
    x = "Área temática"
  ) +
  ggtitle("Cantidad de países por 70 puntos superados según área temática") +
  coord_flip() +
  theme_classic()

##########################################
#           Gráfico de barras            #
# Desarrollo de acciones gubernamentales #
#         segun fuentes externas         #
##########################################

datos_recortados %>%
  mutate(sec_ag = fct_relevel(sec_ag,
                              "Muy bajo", "Bajo", "Medio", "Alto", "Muy alto")) %>%
  ggplot() + 
  
  #aes(x = Dimensión mejor puntuada) + # Frecuencias absolutas
  aes(x = reorder(sec_ag, sec_ag, function(x) -length(x))) + # Ordenar según frecuencia
  aes(x = sec_ag, y = ..count.. / sum(..count..)) + # Porcentajes
  # aes(x = reorder(tiempo, tiempo, function(x) -length(x)), 
  #		y = ..count.. / sum(..count..)) +  # Porcentajes ordenados según frecuencia
  scale_y_continuous(labels = scales::percent) +    # Eje para porcentajes
  
  geom_bar(width = 0.4,   # Ancho de barras
           fill = '#7ed021',  # Color de relleno 
           col = "black",  # Color de línea
           alpha = 0.6) +  # Transparencia
  
  stat_count(
    geom = "text",
    aes(label = scales::percent(after_stat(count / sum(count)), accuracy = 0.01)),
    vjust = -0.5
  ) +
  
  labs(y = "Porcentaje de Paises", x = "Nivel de Desarrollo") + # Nombres de ejes
  
  ggtitle("Porcentaje de Paises por Desarrollo de Acciones Gubernamentales segun fuentes externas") +
  
  #coord_flip() + # Barras horizontales o verticales
  
  theme_classic() # Temas preconfigurados de R https://r-charts.com/ggplot2/themes/


#########################
# Tablas usando janitor #
#########################

# Variable cuantitativa

tabla_areas <- tabyl(areas_int) %>%
  mutate(
    "Cant. acumulada" = cumsum(n),
    "% acumulado" = cumsum(percent)
  ) %>% 
  rename(
    "Areas afectadas por actores no gubernamentales" = areas_int,
    "Cant. Paises" = n, 
    "% Paises" = percent
  ) %>% 
  mutate(
    `% Paises` = scales::percent(`% Paises`, accuracy = 0.1),
    `% acumulado` = scales::percent(`% acumulado`, accuracy = 0.1)
  )

#tabla_areas




##############
# Histograma #
##############

# Frecuencias absolutas
# ggplot(datos_recortados) +
#   aes(x = GIRAI) +
#   geom_histogram(fill = "lightgray", col = "black", 
#                  
#                  breaks = seq(0, 100, 10)) + # Límites de intervalos
#   
#   scale_x_continuous(breaks = seq(0, 100, 10)) + #Marcas del eje
#   
#   labs(x = "GIRAI", y = "Cantidad de paises")

# Frecuencias relativas

mediana_girai <- median(datos_recortados$GIRAI, na.rm = TRUE)

ggplot(datos_recortados) +
  aes(x = GIRAI, y = ..count../sum(..count..)) +
  geom_histogram(fill = "lightgreen", col = "black", 
                 breaks = seq(0, 100, 10)) +
  geom_vline(xintercept = mediana_girai, linetype = "dashed", linewidth = 1) +
  scale_x_continuous(breaks = seq(0, 100, 10)) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "GIRAI", y = "Porcentaje de Paises") +
ggtitle("Porcentaje de Paises segun el valor de GIRAI") 
