install.packages("usdm")
library(usdm)
library(raster)

#to run VIF, setting tf = 5, creating first dataset x of all variables to run
#run data from "for_maxent.R"


x <- stack(c(ma.bio, ma.bio2, ma.bio3, ma.bio4, ma.bio5, ma.bio6, ma.bio7, 
             ma.bio8, ma.bio9, ma.bio10, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
             ma.bio15, ma.bio16, ma.bio17, ma.bio18, ma.bio19))

vif(x)

#bio7 had largest VIF

x2 <- stack(c(ma.bio, ma.bio2, ma.bio3, ma.bio4, ma.bio5, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio10, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio16, ma.bio17, ma.bio18, ma.bio19))
vif(x2)

#bio10 had largest VIF

x3 <- stack(c(ma.bio, ma.bio2, ma.bio3, ma.bio4, ma.bio5, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio16, ma.bio17, ma.bio18, ma.bio19))
vif(x3)

#bio5 had largest VIF

x4 <- stack(c(ma.bio, ma.bio2, ma.bio3, ma.bio4, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio16, ma.bio17, ma.bio18, ma.bio19))
vif(x4)

#bio1 had largest VIF

x5 <- stack(c(ma.bio2, ma.bio3, ma.bio4, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio16, ma.bio17, ma.bio18, ma.bio19))
vif(x5)

#bio16 had largest VIF

x6 <- stack(c(ma.bio2, ma.bio3, ma.bio4, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio17, ma.bio18, ma.bio19))
vif(x6)

#bio4 had largest VIF

x7 <- stack(c(ma.bio2, ma.bio3, ma.bio6, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio17, ma.bio18, ma.bio19))
vif(x7)

#bio6 had largest VIF

x8 <- stack(c(ma.bio2, ma.bio3, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio12, ma.bio13, ma.bio14,
              ma.bio15, ma.bio17, ma.bio18, ma.bio19))
vif(x8)


#bio12 had largest VIF

x9 <- stack(c(ma.bio2, ma.bio3, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio13, ma.bio14,
              ma.bio15, ma.bio17, ma.bio18, ma.bio19))
vif(x9)

#bio17 had largest VIF

x10 <- stack(c(ma.bio2, ma.bio3, 
              ma.bio8, ma.bio9, ma.bio11, ma.bio13, ma.bio14,
              ma.bio15, ma.bio18, ma.bio19))
vif(x10)

#bio3 had largest VIF

x11 <- stack(c(ma.bio2, 
               ma.bio8, ma.bio9, ma.bio11, ma.bio13, ma.bio14,
               ma.bio15, ma.bio18, ma.bio19))
vif(x11)


#bio18 had largest VIF

x12 <- stack(c(ma.bio2, 
               ma.bio8, ma.bio9, ma.bio11, ma.bio13, ma.bio14,
               ma.bio15, ma.bio19))
vif(x12)


##all under 5: bio2, bio8, bio9, bio11, bio13, bio14, bio15, bio19


