# Instalo los paquetes necesarios (si aún no los tengo instalados)
# install.packages("tidyverse")
# install.packages("ggplot2")

# Cargo los paquetes que voy a usar
library(tidyverse)
library(ggplot2)

# Fijo el dataset
attach(datos_recortados)

##########
# Barras #
##########

datos_recortados %>%
  ggplot(aes(x = GIRAI_region, fill = `Dimensión mejor puntuada`)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    x = "Región",
    y = "Porcentaje de Países",
    fill = "Dimensión"
  ) +
  ggtitle("Distribución de dimensiones mejor puntuadas por región") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1.1))



########################
# Boxplot comparativos #
########################

datos_recortados %>%
  
  mutate(sec_ag = fct_relevel(sec_ag,
                            "Muy bajo", "Bajo", "Medio", "Alto", "Muy alto")) %>%
  ggplot() +

  aes(x = GIRAI, y = sec_ag) +
  geom_boxplot(show.legend = F, fill = "lightgreen", width = 0.4) +
  labs(x = "GIRAI", y = "Nivel de desarrollo") +
  coord_flip() +
  ggtitle("Distribucion del GIRAI segun nivel de desarrollo de Acciones Gubernamentales") +
  theme_light()


##########################
# Diagrama de dispersión #
##########################

datos_recortados <- datos_recortados %>%
  mutate(
    alpha = (p70_sesgo + p70_infancia + p70_divers + p70_genero) / 4,
    beta = (p70_datpers + p70_suphum + p70_segu + p70_transp + p70_laboral) / 5
  )

ggplot(datos_recortados) +
  aes(x = alpha, y = GIRAI) +
  geom_point(color = "darkgreen", alpha = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "lightgreen", width = 0.5) +
  labs(x = "Materia Derechos Humanos", y = "GIRAI")+
  ggtitle("Relacion entre GIRAI y grupo tematico Derechos Humanos") +
  theme_classic()


ggplot(datos_recortados) +
  aes(x = beta, y = GIRAI) +
  geom_point(color = "darkgreen", alpha = 0.5, size = 3) +
  geom_smooth(method = "lm", se = FALSE, color = "lightgreen", width = 0.5) +
  labs(x = "Materia Gobernanza", y = "GIRAI")+
  ggtitle("Relacion entre GIRAI y grupo tematico Gobernanza") +
  theme_classic()


