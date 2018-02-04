shinyServer(function(input, output){
  #Selection of two variables
  selectedData <- reactive({
    dane[, c(input$xvar, input$yvar)]
  })
  
  #Plotting data
  #First plot
  output$myPlot <- renderPlot({
    whichcluster<-input$clustering
    
    if(whichcluster=="Kmeans"){
      clusters <- reactive({
        kmeans(selectedData(), input$nclusters)
      })
      fviz_cluster(list(data=selectedData(), cluster=clusters()$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic(),distance_metric = "euclidean") #factoextra::
    }
    else if (whichcluster=="PAM"){
      distance<-input$dist
      if(distance=="Euclidean"){
      clusters <- reactive({
        pam(selectedData(), input$nclusters,metric="euclidean")
      })
      fviz_cluster(list(data=selectedData(), cluster=clusters()$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic(),distance_metric = "euclidean") #factoextra::
      }
      else{
        clusters <- reactive({
          pam(selectedData(), input$nclusters, metric="manhattan")
        })
        fviz_cluster(list(data=selectedData(), cluster=clusters()$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic(),distance_metric = "euclidean") #factoextra::
      }
    }
    else{
      distance<-input$dist
      if(distance=="Euclidean"){
      clusters <- reactive({
        clara(selectedData(), input$nclusters,metric="euclidean")
      })
      fviz_cluster(list(data=selectedData(), cluster=clusters()$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic(),distance_metric = "euclidean") #factoextra::
      }
      else{
        clusters <- reactive({
          pam(selectedData(), input$nclusters, metric="manhattan")
        })
        fviz_cluster(list(data=selectedData(), cluster=clusters()$cluster), ellipse.type="norm", geom="point", stand=FALSE, palette="jco", ggtheme=theme_classic(),distance_metric = "euclidean") #factoextra::
      }
    }
  })
  
  #Second Plot
  output$myPlot1<-renderPlot({
    
    whichcluster<-input$clustering
    if(whichcluster=="Kmeans"){
      clusters <- reactive({
        kmeans(selectedData(), input$nclusters)
      })
      xxc<-cbind(selectedData(), cluster=clusters()$cluster)
      colnames(xxc)[3]<-c("group")
      par(mfrow=c(1,2))
      boxplot(xxc[,1]~xxc[,3], vertical=TRUE, col="red", main="First variable")
      boxplot(xxc[,2]~xxc[,3], vertical=TRUE, col="yellow", main="Second variable")
    }
    else if (whichcluster=="PAM"){
      distance<-input$dist
      if(distance=="Euclidean"){
        clusters <- reactive({
         pam(selectedData(), input$nclusters, metric="euclidean")
        })
        xxc<-cbind(selectedData(), cluster=clusters()$cluster)
        colnames(xxc)[3]<-c("group")
        par(mfrow=c(1,2))
        boxplot(xxc[,1]~xxc[,3], vertical=TRUE, col="red", main="First variable")
        boxplot(xxc[,2]~xxc[,3], vertical=TRUE, col="yellow", main="Second variable")
        }
      else{
        clusters <- reactive({
          pam(selectedData(), input$nclusters, metric="manhattan")
        })
        xxc<-cbind(selectedData(), cluster=clusters()$cluster)
        colnames(xxc)[3]<-c("group")
        par(mfrow=c(1,2))
        boxplot(xxc[,1]~xxc[,3], vertical=TRUE, col="red", main="First variable")
        boxplot(xxc[,2]~xxc[,3], vertical=TRUE, col="yellow", main="Second variable")
      } 
      }
    else{
      distance<-input$dist
      if(distance=="Euclidean"){
      clusters <- reactive({
        clara(selectedData(), input$nclusters, metric="euclidean")
      })
      xxc<-cbind(selectedData(), cluster=clusters()$cluster)
      colnames(xxc)[3]<-c("group")
      par(mfrow=c(1,2))
      boxplot(xxc[,1]~xxc[,3], vertical=TRUE, col="red", main="First variable")
      boxplot(xxc[,2]~xxc[,3], vertical=TRUE, col="yellow", main="Second variable")
      }
      else{
      clusters <- reactive({
        clara(selectedData(), input$nclusters, metric="manhattan")
      })
      xxc<-cbind(selectedData(), cluster=clusters()$cluster)
      colnames(xxc)[3]<-c("group")
      par(mfrow=c(1,2))
      boxplot(xxc[,1]~xxc[,3], vertical=TRUE, col="red", main="First variable")
      boxplot(xxc[,2]~xxc[,3], vertical=TRUE, col="yellow", main="Second variable")
      }
    }
  })
  #Third plot
  output$myPlot2<-renderPlot({
    whichcluster<-input$clustering
    clusters <- reactive({
      kmeans(selectedData(), input$nclusters)
    })
    if(whichcluster=="Kmeans"){
    fviz_nbclust(selectedData(), kmeans, method="silhouette")+theme_classic() # factoextra::
    }
    else if(whichcluster=='PAM'){
      fviz_nbclust(selectedData(), pam, method="silhouette")+theme_classic() # factoextra::
    }
    else{
      fviz_nbclust(selectedData(), clara, method="silhouette")+theme_classic() # factoextra::
    }
  })
})
