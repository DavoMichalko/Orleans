# Processes various calculations on the community
# role measures.
# 
# Version: 2
# Author: Vincent Labatut 06/2013,07/2014
#
# setwd("~/eclipse/workspaces/Networks/Orleans/")
# setwd("C:/Eclipse/workspaces/Networks/Orleans/")
# source("RoleMeasures/role-measures.R")
###############################################################################
source("RoleMeasures/process-rolemeas.R")


###############################################################################
# Returns the list of names for the community role measures
# corresponding to the specified code.
#
# role.meas: role measure variant:
#				- "GA": original Guimera-Amaral measures (2 measures)
#				- "GAdir": our directd extension of GA (2x2 measures)
#				- "DLPp": our own measures for partition-based communities (2x4 measures)
#				- "DLPo": variant for overlapping communities  (2x6 measures)
###############################################################################
get.rolemeas.names <- function(role.meas)
{	if(role.meas=="GA")
		result <- c("P","z")
	else if(role.meas=="GA-dir")
		result <- c("P-in", "P-out", "z-in", "z-out")
	else if(role.meas=="DLP-p")
		result <- c("I-int-in","I-int-out","I-ext-in","I-ext-out","H-in","H-out","D-in","D-out")
	else if(role.meas=="DLP-o")
		result <- c("I-int-in","I-int-out","H-int-in","H-int-out","D-int-in","D-int-out","I-ext-in","I-ext-out","H-ext-in","H-ext-out","D-ext-in","D-ext-out")
	
	return(result)
}

###############################################################################
# Indicates if the considered set role measures is meant
# to handle directed graphs.
#
# role.meas: role measure variant.
###############################################################################
is.directed.rolemeas <- function(role.meas)
{	result <- role.meas!="GA"
	return(result)
}

###############################################################################
# Returns the name of the file containing the role measures, 
# for the specified code.
#
# folder.data: folder containing all input and output files.
# role.meas: role measure variant:
#				- "GA": original Guimera-Amaral measures (2 measures)
#				- "GAdir": our directd extension of GA (2x2 measures)
#				- "DLPp": our own measures for partition-based communities (2x4 measures)
#				- "DLPo": variant for overlapping communities  (2x6 measures)
# norm: whether one wants the filename for the original or normalized data.
# comdet.algo: algorithm used for community detection (needed to infer the file name)
###############################################################################
get.rolemeas.filename <- function(folder.data, role.meas, norm=FALSE, comdet.algo)
{	result <- paste(folder.data,"comdet=",comdet.algo,sep="")
	result <- paste(result,".rolemeas=",role.meas,sep="")
	if(norm)
		result <- paste(result,".normvals.txt",sep="")
	else
		result <- paste(result,".rawvals.txt",sep="")
	return(result)
}

###############################################################################
# Processes the specified role measures, for the specified network and
# community.
#
# folder.data: folder containing all input and output files.
# role.meas: role measure variant to process:
#				- "GA": original Guimera-Amaral measures (2 measures)
#				- "GAdir": our directd extension of GA (2x2 measures)
#				- "DLPp": our own measures for partition-based communities (2x4 measures)
#				- "DLPo": variant for overlapping communities  (2x6 measures)
# comdet.algo: algorithm used for community detection (needed to infer the file name)
# force: whether or not to force recalulation of the role measures when the file already exists.
###############################################################################
process.role.measures <- function(folder.data, role.meas, comdet.algo, force=FALSE)
{	# should be using the C++ version: this R stuff is temporary
	retrieve.role.measures(folder.data, role.meas, comdet.algo, force)
	
	# TODO @Nico stub for the C++ wrapper
#	# get file paths
#	net.file <- get.network.filename(folder.data)
#	clean.file <- get.network.clean.filename(folder.data) #TODO @Nico one or the other?
#	compiled.file <- get.network.compiled.filename(folder.data) #TODO @Nico one or the other?
#	com.file <- get.communities.filename(folder.data,comdet.algo)
#	out.file <- get.rolemeas.filename(folder.data,role.meas,norm=FALSE,comdet.algo)
#	
#	# compile to a binary file if necessary
#	if(!file.exists(compiled.file))
#		compile.graph.file(folder.data)
#	
#	# set up the appropriate command
#	if(role.meas=="GA")
#		cmd <- ""	# TODO @Nico
#	else if(role.meas=="GAdir")
#		cmd <- ""	# TODO @Nico
#	else if(role.meas=="DLPp")
#		cmd <- ""	# TODO @Nico
#	else if(role.meas=="DLPo")
#		cmd <- ""	# TODO future dev
#	
#	# execute the command from R
#	system(command=cmd)
#	
#	# possibly post-process
#	# TODO @Nico
}
