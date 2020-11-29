#### Reshape data of RE in MSY, FMSY, and SSBMSY ####
msy_re_data <- function(dir, case_num, em_name, case_info, bc_info, sr_name){
  figure_data_dir <- file.path(dir, "results", paste("C", case_num, sep=""))
  for(j in 1:length(figure_data_dir)){
    load(file.path(figure_data_dir[j], "output", "performance_measure.RData"))
    if (length(em_name) != length(re_list[[1]]$msy)) stop (paste("In C", j,": Number of EMs specified here doesn't equal to number of EMs showed in the outputs!", sep=""))
    em_num <- length(em_name)
    if (j==1){
      msy_re <- matrix(NA, nrow=length(re_list), ncol=em_num*length(figure_data_dir))
      fmsy_re <- matrix(NA, nrow=length(re_list), ncol=em_num*length(figure_data_dir))
      ssbmsy_re <- matrix(NA, nrow=length(re_list), ncol=em_num*length(figure_data_dir))
    }
    for (i in 1:length(re_list)){
      msy_re[i,((j-1)*em_num+1):((j-1)*em_num+em_num)] <- as.matrix(re_list[[i]]$msy)
      fmsy_re[i,((j-1)*em_num+1):((j-1)*em_num+em_num)] <- as.matrix(re_list[[i]]$fmsy)
      ssbmsy_re[i,((j-1)*em_num+1):((j-1)*em_num+em_num)] <- as.matrix(re_list[[i]]$ssbmsy)
    }
  }

  msy_stat <- matrix(NA, nrow=em_num*length(figure_data_dir), ncol=3)
  fmsy_stat <- matrix(NA, nrow=em_num*length(figure_data_dir), ncol=3)
  ssbmsy_stat <- matrix(NA, nrow=em_num*length(figure_data_dir), ncol=3)

  sapply(1:nrow(msy_stat), function(x) {
    msy_stat[x,] <<- boxplot.stats(msy_re[,x])$`stats`[c(1,3,5)]
    fmsy_stat[x,] <<- boxplot.stats(fmsy_re[,x])$`stats`[c(1,3,5)]
    ssbmsy_stat[x,] <<- boxplot.stats(ssbmsy_re[,x])$`stats`[c(1,3,5)]
  })

  # round(msy_stat[2,c(37:38, 41:42)], digits = 2)
  # round(fmsy_stat[2,c(37:38, 41:42)], digits = 2)
  # round(ssbmsy_stat[2,c(37:38, 41:42)], digits = 2)
  stat <- list(msy_stat=msy_stat,
               fmsy_stat=fmsy_stat,
               ssbmsy_stat=ssbmsy_stat)
  names(stat) <- c("MSY", "FMSY", "SSBMSY")

  output <- list()

  for (i in 1:length(stat)){
    data <- as.data.frame(stat[[i]])
    colnames(data) <- c("Lower", "Median", "Upper")
    data$case_num <- rep(paste("C", case_num, sep=""), each=em_num)
    data$case_info <- rep(case_info, each=em_num)
    data$case_info_f <- factor(data$case_info, levels=unique(data$case_info))
    data$EM <- factor(rep(em_name, times=length(case_num)))
    data$SR <- rep(sr_name, times=length(case_num)*em_num)
    data$type <- rep(names(stat)[i], times=length(case_num)*em_num)
    data$BC <- rep(bc_info, each=em_num)
    data$BC_f <- factor(data$BC, levels=unique(data$BC))
    data$Case <- paste(data$BC_f, data$case_info_f, sep="")
    data$Case_f <- factor(data$Case, levels=unique(data$Case))
    output[[i]] <- data
  }
  names(output) <- names(stat)
  return(list(msy_re=output$MSY,
              fmsy_re=output$FMSY,
              ssbmsy_re=output$SSBMSY))
}

#### Reshape data of SSB, R, and F ####
SSB_R_F_data <- function(dir, case_num, model_name, case_info, bc_info, sr_name, output_file, year){
  variable <- c("ssb", "recruit", "Ftot", "ssbratio", "fratio")
  variable_names <- c("SSB", "R", "F", "Rel SSB", "Rel F")
  temp_list <- list()
  temp_dataframe <- data.frame(year=numeric(),
                               value=numeric(),
                               variable=character(),
                               omparam=character(),
                               case_num=character(),
                               case_info=character(),
                               sr_name=character(),
                               model_name=character(),
                               stringsAsFactors=FALSE)
  figure_data_dir <- file.path(dir, "results", paste("C", case_num, sep=""))
  for(j in 1:length(figure_data_dir)){
    for(i in 1:length(output_file)){
      temp_list[[i]] <- get(load(file.path(figure_data_dir[j], "output", output_file[i])))
      for(k in 1:length(variable)){
        temp <- data.frame(year=year,
                           value=apply(temp_list[[i]][[variable[k]]], 1, median),
                           variable=rep(variable_names[k], times=length(year)),
                           omparam=rep(bc_info[j], times=length(year)),
                           case_num=rep(case_num[j], times=length(year)),
                           case_info=rep(case_info[j], times=length(year)),
                           sr_name=rep(sr_name, times=length(year)),
                           model_name=rep(model_name[i], times=length(year)))
        temp_dataframe <- rbind(temp_dataframe, temp)
      }
    }
  }
  temp_dataframe$variable_f <- factor(temp_dataframe$variable, levels=unique(temp_dataframe$variable))
  temp_dataframe$omparam_f <- factor(temp_dataframe$omparam, levels=unique(temp_dataframe$omparam))
  temp_dataframe$case_info_f <- factor(temp_dataframe$case_info, levels=unique(temp_dataframe$case_info))
  temp_dataframe$model_name_f <- factor(temp_dataframe$model_name, levels=unique(temp_dataframe$model_name))
  temp_dataframe$sr_name_f <- factor(temp_dataframe$sr_name, levels=unique(temp_dataframe$sr_name))
  return(temp_dataframe)
}
