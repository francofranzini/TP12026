# Instalo los paquetes necesarios (si aún no los tengo instalados)
#install.packages("tidyverse")

# Cargo los paquetes que voy a usar
library(tidyverse)
# Fijo el dataset
attach(datos)

######################
# Renombrar columnas #
######################
datos_recortados <- datos %>% select("Ranking","GIRAI", "GIRAI_region","Dimensión mejor puntuada","sec_ag","areas_ane",
                                     "p70_sesgo",	"p70_infancia",	"p70_divers",	"p70_datpers"	,"p70_genero",
                                     "p70_suphum",	"p70_laboral",	"p70_segu",	"p70_transp")

datos_recortados <- datos_recortados %>% 
  mutate(
    Dimensión mejor puntuada = recode(Dimensión mejor puntuada,
                                      "cap" = "Capacidades en IA",
                                      "gob" = "Gobernanza de la IA",
                                      "ddhh" = "IA y Derechos Humanos")
  )
###########################################
# Seleccionar un subconjunto de registros #
###########################################

# # Opción 1: por criterio
# datos_reducido1 <- datos_orden %>%
#   filter((brotes > 4 & origen == "Nativo/Autóctono") | tiempo == "20 años o más")
# 
# # Opción 2: por indexación
# datos_reducido2 <- datos_orden %>%
#   slice(1:500)