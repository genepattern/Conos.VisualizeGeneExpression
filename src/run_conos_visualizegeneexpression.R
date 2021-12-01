print('==========================================================')
print("Loading libraries: optparse, Matrix, dplyr, pagoda2, conos, conosPanel")
library("optparse")
library("Matrix")
library("dplyr")
library("pagoda2")
library("conos")
library("conosPanel")
print("Loaded libraries: optparse, Matrix, dplyr, pagoda2, conos, conosPanel")
print('==========================================================')
options(ggrepel.max.overlaps = Inf)

# # ====================================

# # PARAMETERS for Leiden communities and walktrap
# runleiden <- TRUE
# leiden_resolution = 1
# runwalktrap <- TRUE
# walktrap_steps = 10
# # ====================================
# # PARAMETERS for UMAP
# umap_distance = 0.05
# umap_spread = 5
# # ====================================

# Parse input arguments
parser = OptionParser()
# ====================================
parser <- add_option(parser, c("--conos_object"), help = "RDS file created by Conos.Cluster.")
parser <- add_option(parser, c("--output_file_name"),type='character',default='ConosMarkers', help = "Basename of the file to be saved.")
# ====================================
# PARAMETERS for Leiden
parser <- add_option(parser, c("--genesofinterest"),type='character',default='', help = "A list of gene identifiers. The expression of these genes will be plotted on the embedded map. Gene names need to be separated by a coma and a space (e.g. MS4A1, CD74, LYZ, CD14)")
parser <- add_option(parser, c("--clustering"),type='character', default='None', help = "Option to show clustering information besides gene expression (None, ).")
# ====================================
print('==========================================================')
args <- parse_args(parser)
print('Parameters used:')
print(args)
print('==========================================================')
# ====================================
# Setting up the PDF file for the plots
pdf(file=paste(args$output_file_name,'.pdf',sep=''))

# Restore the object

#Begin 2021-11-24

# {
#   "geneofinterest": { "name": "Gene Identifier:", "description": "A gene identifier to plot expression on the embedded map (e.g. MS4A1, CD74)", "type": "text"}, 
#   "clustering": { "name": "Show Clustering:", "description": "Option to show clustering information beside gene expression", "type": "choice", "choices": {"None": "none", "Show Leiden": "leiden", "Show Walktrap": "walktrap", "Show Both Leiden and Walktrap": "both"}, "default": "none"},  
#   "output_var": { "hide": "True" } }}

customplot <- function(geneofinterest,clustering){
    cat("Creating graphs...")
    
    if (clustering == "none"){
    print(con$plotPanel(color.by='gene', gene=paste0(geneofinterest), embedding=embeddings))}

    if (runleiden == TRUE & clustering == "leiden"){
    print(cowplot::plot_grid(con$plotPanel(alpha=0.1, clustering='leiden', embedding=embeddings),
                             con$plotPanel(color.by='gene', gene=paste0(geneofinterest), embedding=embeddings))
                 )}

    if (runwalktrap == TRUE & clustering == "walktrap"){
#     pdf(paste0("Walktrap_Clusters_with_",geneofinterest,"_Expression.pdf"), width=14.88, height=8.2)
#     cowplot::plot_grid(con$plotPanel(alpha=0.1, clustering='walktrap', embedding=embeddings),
#                        con$plotPanel(alpha=0.1, color.by='gene', gene=paste0(geneofinterest), embedding=embeddings))
#     dev.off()
    print(cowplot::plot_grid(con$plotPanel(alpha=0.1, clustering='walktrap'),
    con$plotPanel(color.by='gene', gene=paste0(geneofinterest), embedding=embeddings)))}

    if (runleiden == TRUE & runwalktrap == TRUE & clustering == "both"){
#     pdf(paste0("Leiden_and_Walktrap_Clusters_with_",geneofinterest,"_Expression.pdf"), width=14.88, height=8.2)
#     cowplot::plot_grid(con$plotPanel(alpha=0.1, clustering='leiden', embedding="umap"), 
#                        con$plotPanel(alpha=0.1, clustering='walktrap', embedding="umap"),
#     con$plotPanel(alpha=0.1, color.by='gene', embedding="umap", gene=paste0(geneofinterest)))
#     dev.off()
    print(cowplot::plot_grid(con$plotPanel(alpha=0.1, clustering='leiden', embedding=embeddings), 
                             con$plotPanel(alpha=0.1, clustering='walktrap', embedding=embeddings),
                             con$plotPanel(color.by='gene', gene=paste0(geneofinterest), embedding=embeddings))

         )}
    print("... done!")
    return()
}

# print(R.Version())
cat('Reading Conos.Cluster output RDS (this may take about a minute)...')

conos_object <- readRDS(file = args$conos_object)  # reads in a varaible called 'conos_object'
# con <- conos_object$con
# con_space <- conos_object$con_space
# data_source <- conos_object$data_source
print('...done!')
cat('Loading variables into memory...')
con <- conos_object$con
paintcluster <- conos_object$paintcluster
runleiden <- conos_object$runleiden
runwalktrap <- conos_object$runwalktrap
data_source <- conos_object$data_source

if (!is.null(con$samples[[1]]@reductions$umap)){
  embeddings <- 'umap'} else {embeddings <- 'tsne'
}
print('...done!')
cat('Making polots now...')
# Run for each gene in the list
for (gene in unlist(strsplit(args$genesofinterest, ', '))){
  customplot(gene,args$clustering)
}
print('...done!')
dev.off()
