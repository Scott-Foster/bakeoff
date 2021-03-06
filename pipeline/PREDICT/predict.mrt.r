##########################################################################################
# MULTIVARIATE REGRESSION TREE
##########################################################################################

require(mvpart)
require(caret)

##########################################################################################

for (j in 1:3) {

	nsp <- length(DD_t[[j]])

	load(file=file.path(FD,set_no,paste("mrts_",j,"_",dataN[sz],".RData",sep="")))

	Yv <- y_valid[[j]]
	
	Xv <- x_valid[[j]][,c(2:(ncovar+1))]
	colnames(Xv)<-paste("V",(ncol(Yv)+1):(ncol(Yv)+ncol(Xv)),sep="")
	rownames(Xv)<-paste("e",1:nrow(Xv),sep="")
	Xv <- as.data.frame(Xv)

	mrt_probs <- predict(mrts,type="matrix", newdata=Xv)
	rm(mrts)

	nsp <- ncol(y_valid[[j]])
	nsites <- nrow(y_valid[[j]])

	mrt1_PAs <- array(dim=c(nsites,nsp,REPs))

	for (n in 1:REPs){
  		mrt1_PAs[,,n] <- rbinom(mrt_probs,1,mrt_probs)
		}
	rm(mrt_probs)

	save(mrt1_PAs, file=file.path(PD2,set_no,paste("mrt1_PAs_",j,"_",dataN[sz],".RData",sep="")))

	rm(mrt1_PAs)	
	gc()

	}
########################################################################################## 
