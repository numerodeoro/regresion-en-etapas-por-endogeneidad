rm(list=ls())
install.packages("plm")  # Para el manejo de datos de panel
install.packages("AER")  # Para estimación de modelos MC3E
install.packages("lfe")  # Opcional: para estimación de modelos de efectos fijos
install.packages("systemfit") #para estimar MC3E
install.packages("lmtest") #para correr los tests apropiados
install.packages("haven") #para importar datos en otros formatos
install.packages("stargazer") #para los cuadros de reportes
install.packages("lme4")
install.packages("openxlsx") #para poder exportar los reportes de stargazer
library(openxlsx)
library(plm)
library(AER)
library(lfe)
library(systemfit)
library(lmtest)
library(haven)
library(stargazer)
library(lme4)

# panelizo y le pido el nombre de las columnas
datos_panel <- pdata.frame(Datosm, index = "prov")  
names(datos_panel)


#R1. primero calculo el ingreso vs ingreso 1 y pbg y luego hallo el gasto en
#función de las otras exogenas y la endogena estimada por la ec anterior
R1 <- lm(in. ~ in1 + pbg, data = datos_panel)
#Hacemos la predicción de in. (estimación)
est.in <-fitted(R1)
stargazer(R1, type = 'text')
RR1<-stargazer(R1, type = 'text')
writeLines(RR1, "primera etapa R1.txt")
# Sustituimos el valor estimado de in. en la ecuacion del gasto
#Step 2
R12 <- lm(gasto~ est.in + transf+des, data=datos_panel)
stargazer(R12, type = 'text')
RR12<-stargazer(R12, type = 'text')
writeLines(RR12, "segunda etapa R1.txt")
print("****************************************")
print("****************************************")
print("segunda regresión R2")
#R2. primero calculo el ingreso vs ingreso 1 y pbg con el efecto fijo de
#las provincias y luego hallo el gasto en función de las otras exogenas y
#la endogena estimada por la ec anterior
R2 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in2 <-fitted(R2)
stargazer(R2, type = 'text')
RR2<-stargazer(R2, type = 'text')
writeLines(RR2, "primera etapa R2.txt")

# Sustituimos el valor estimado de in. en la ecuacion del gasto
#Step 2
R22 <- lm(gasto~ est.in2 + transf+des, data=datos_panel)
stargazer(R22, type = 'text')
RR22<-stargazer(R22, type = 'text')
writeLines(RR22, "segunda etapa R2.txt")
#Para el test de Hausman corro la regresion con efectos aleatorios para las provincias
Rx <- plm(in. ~ in1 + pbg, data = datos_panel, model = "random", index = "prov")
est.inx=fitted(Rx)
stargazer(Rx, type="text")

#test de Hausman
hausman_test <- phtest(R2, Rx)
print(hausman_test)

# No podemos rechazar H0, cualquiera de los dos métodos es válido. 
#Continuaremos con el modelo de efectos fijos entonces
print("****************************************")
print("****************************************")
print("tercera regresión R3")
#R3: en la primera etapa dejo los efectos fijos, en la segunda etapa agrego 
#la variable pp
R3 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in3 <-fitted(R3)
stargazer(R3, type = 'text')
RR3<-stargazer(R3, type = 'text')
writeLines(RR3, "primera etapa R3.txt")
# Sustituimos el valor estimado de in. en la ecuacion del gasto, ahora agregando
#el efecto de pp
#Step 2
R32 <- lm(gasto~ est.in3 + transf+des+pp, data=datos_panel)
stargazer(R32, type = 'text')
RR32<-stargazer(R32, type = 'text')
writeLines(RR32, "segunda etapa R3.txt")
print("****************************************")
print("****************************************")
print("quinta regresión R5")
#R5: en la primera etapa dejo los efectos fijos, en la segunda etapa agrego 
#las variables "pp" y "aelec"
R5 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in5 <-fitted(R5)
stargazer(R5, type = 'text')
RR5<-stargazer(R5, type = 'text')
writeLines(RR5, "primera etapa R5.txt")
#Sustituimos el valor estimado de in. en la ecuacion del gasto, ahora agregando
#el efecto de pp y aelec
#Step 2
R52 <- lm(gasto~ est.in5 + transf+des+pp+aelec, data=datos_panel)
stargazer(R52, type = 'text')
RR52<-stargazer(R52, type = 'text')
writeLines(RR52, "segunda etapa R5.txt")
print("****************************************")
print("****************************************")
print("séptima regresión R7")
#R7: en la primera etapa dejo los efectos fijos y agrego el efecto del tiempo,
# en la segunda etapa hago lo mismo que en R5 pero con los estimados de R7 
#para el ingreso
R7 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = c("prov", "time"))
#Hacemos la predicción de in. (estimación)
est.in7 <-fitted(R7)
stargazer(R7, type = 'text')
RR7<-stargazer(R7, type = 'text')
writeLines(RR7, "primera etapa R7.txt")
# Sustituimos el valor estimado de in. en la ecuacion del gasto, ahora agregando
#el efecto de pp y aelec
#Step 2
R72 <- lm(gasto~ est.in7 + transf+des+pp, data=datos_panel)
stargazer(R72, type = 'text')
RR72<-stargazer(R72, type = 'text')
writeLines(RR72, "segunda etapa R7.txt")



#agrego la variable gasto2
datos_panel$gasto2 <- datos_panel$gasto - datos_panel$transf
  #*********************************
  #************************************
  #*************************************
  #*tabla 3
  #**********************************
  #************************************
  #R8.La primera etapa es igual que en R2, asi que voy a usar lo mismo
R8 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in8 <-fitted(R8)
stargazer(R8, type = 'text')
RR8<-stargazer(R8, type = 'text')
writeLines(RR8, "primera etapa R8.txt")
# Sustituimos el valor estimado de in. en la ecuacion del gasto2
#Step 2
R82 <- lm(gasto2~ est.in8 +des, data=datos_panel)
stargazer(R82, type = 'text')
RR82<-stargazer(R82, type = 'text')
writeLines(RR82, "segunda etapa R8.txt")
print("****************************************")
print("****************************************")
print("segunda regresión R2")
#R9. la primera etapa cpincide con R2
R9 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in9 <-fitted(R9)
stargazer(R9, type = 'text')
RR9<-stargazer(R9, type = 'text')
writeLines(RR9, "primera etapa R9.txt")

# Sustituimos el valor estimado de in. en la ecuacion del gasto2 y agregamos pp
#Step 2
R92 <- lm(gasto2~ est.in9 + pp+des, data=datos_panel)
stargazer(R92, type = 'text')
RR92<-stargazer(R92, type = 'text')
writeLines(RR92, "segunda etapa R9.txt")




#R11: La primera etapa es igual que en R2, en la segunda etapa agrego 
#la variable aelec
R11 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = "prov")
#Hacemos la predicción de in. (estimación)
est.in11 <-fitted(R11)
stargazer(R11, type = 'text')
RR11<-stargazer(R11, type = 'text')
writeLines(RR11, "primera etapa R11.txt")
# Sustituimos el valor estimado de in. en la ecuacion del gasto2, ahora 
# agregando el efecto de pp y de aelec
#Step 2
R112 <- lm(gasto2~ est.in11 +des+pp+aelec, data=datos_panel)
stargazer(R112, type = 'text')
RR112<-stargazer(R112, type = 'text')
writeLines(RR112, "segunda etapa R11.txt")
#R13: la primera etapa es como R7, en la segunda etapa quito aelec
R13 <- plm(in. ~ in1 + pbg, data = datos_panel, model = "within", index = c("prov", "time"))
#Hacemos la predicción de in. (estimación)
est.in13 <-fitted(R13)
stargazer(R13, type = 'text')
RR13<-stargazer(R13, type = 'text')
writeLines(RR13, "primera etapa R13.txt")
#Sustituimos el valor estimado de in. en la ecuacion del gasto2, ahora 
#agregando el efecto de pp y aelec
#Step 2
R132 <- lm(gasto2~ est.in13 +des+pp, data=datos_panel)
stargazer(R132, type = 'text')
RR132<-stargazer(R132, type = 'text')
writeLines(RR132, "segunda etapa R13.txt")

#***************************************************
#*****************************************************
#*******************************************************
# Ajustar una regresión con provincias como variables dummy 
#en la segunda etapa de R5
ef5 <- lm(gasto ~ est.in5 + transf+des+pp+aelec+ factor(prov) - 1, data = datos_panel)
reporte_efectos_fijos<-stargazer(ef5, type="text")
# la funcion write.xlsx lo exporta a un excel pero no salio bien, 
#asi que lo exporte tambien a un txt
write.xlsx(reporte_efectos_fijos, "reporte efectos fijos.xlsx")
writeLines(reporte_efectos_fijos, "reporte efectos fijos.txt")

#***********************************************
#***********************************************
#*#***********************************************
#para la tabla 6 necesito hacer un dataframe resumido con los datos del año 2022 
#unicamente y sin las provincias de La Pampa y San Luis
# Suponiendo que "datos_panel" es tu dataframe y las columnas son "year" y "prov"
nuevo_datos <- subset(datos_panel, año == 2022 & !(prov %in% c("San Luis", "La Pampa")))
#con el nuevo dataframe, corro la regresion de los efectos fijos vs la coparticipacion
R19=lm(efp~cop.norm, data=nuevo_datos)
stargazer(R19, type="text")
#*******************************************
#*******************************************
#*******************************************
#ahora debo correr la regresion de los efectos fijos vs el indice fiscal
# la variable rf (indice fiscal) la interpreta como categorica porque solo toma 3 valores
# la transformo en numerica
nuevo_datos$rf <- as.numeric(nuevo_datos$rf)
# debo generar un ruido para que la interprete como numérica
# voy a usar una distribucion normal con media 0 y muy poco desvio
#para que no me queden los numeros todos iguales
# Genero el ruido
nuevo_datos$ruido <- rnorm(length(nuevo_datos$rf), mean = 0, sd = 0.1)

# Agrego el ruido a la variable original
nuevo_datos$rfr <- nuevo_datos$rf + nuevo_datos$ruido
#ahora sí corro la R20 y pido el reporte
R20=lm(efp~rfr,data=nuevo_datos)
stargazer(R20, type="text")

#*******************************************
#*******************************************
#*******************************************
#sólo falta la R21 que regresa los efectos fijos vs la coparticipacion 
#normalizada y el indice fiscal
R21=lm(efp~rfr+cop.norm,data=nuevo_datos)
stargazer(R21, type="text")

RREF<-stargazer(R19,R20,R21,type="text", title = "Efectos fijos vs indice fiscal y coparticipación",
          align = TRUE, 
          column.labels = c("Coeficientes", "R19", "R20", "R21"))
writeLines(RREF, "reporte tabla 6.txt")


#*******************************************
#*******************************************
#*******************************************
#análisis de endogeneidad
# debo regresar el gasto vs in. (MCO) y luego calcular los residuos
RMCO <- lm(gasto~ in.+pbg , data=datos_panel)
stargazer(RMCO, type = 'text')
residuos_in <- residuals(RMCO)
datos_panel$u=residuos_in

#endogeneidad de in.
correlacion_in. <- cor(residuos_in, datos_panel$in.)
test_correlacion_in. <- cor.test(residuos_in, datos_panel$in.)
print(correlacion_in.)
print(test_correlacion_in.)

#No encuentra endogeneidad entre in. y gasto

#endogeneidad de transf
RMCOx <- lm(gasto~ transf+pbg , data=datos_panel)
stargazer(RMCOx, type = 'text')
residuos_transf <- residuals(RMCOx)
datos_panel$ux=residuos_transf

#endogeneidad de transf
correlacion_transf <- cor(residuos_transf, datos_panel$transf)
test_correlacion_transf <- cor.test(residuos_transf, datos_panel$transf)
print(correlacion_transf)
print(test_correlacion_transf)

#endogeneidad transf vs in.

RMCOE<-lm(transf~in., data=datos_panel)
RRE<-stargazer(RMCOE, type = 'text')
residuos_E <- residuals(RMCOE)
datos_panel$E=residuos_E
writeLines(RRE, "reporte endogeneidad.txt")
# conclusion:la endogeneidad entre el gasto y el ingreso se da 
#a traves de las transferencias

