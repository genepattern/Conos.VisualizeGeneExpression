
# Conos.VisualizeGeneExpression (v1.0)

This is a minimalistic implementation of visualization options for Conos. This module is intended to be used after [Conos.Cluster](https://cloud.genepattern.org/gp/pages/index.jsf?lsid=urn:lsid:broad.mit.edu:cancer.software.genepattern.module.analysis:00410:0.1) has been ran.

Module Author: Edwin Juarez

Contact: https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!forum/genepattern-help

Algorithm Version: Conos 1.4.4



## References

More details in the original package: https://github.com/kharchenkolab/conos

- Barkas N., Petukhov V., Nikolaeva D., Lozinsky Y., Demharter S., Khodosevich K., & Kharchenko P.V. 
Joint analysis of heterogeneous single-cell RNA-seq dataset collections. 
Nature Methods, (2019). doi:10.1038/s41592-019-0466-z

- Viktor Petukhov, Nikolas Barkas, Peter Kharchenko, and Evan
Biederstedt (2021). conos: Clustering on Network of Samples. R
package version 1.4.4.


### Technical notes:
- Docker container for this module: [genepattern/conos:2.1](https://hub.docker.com/layers/177185187/genepattern/conos/2.1/images/sha256-4581c6067d9fad91ef9eecc6953b91f929742003365b6d1658e99416acf1dfdb?context=repo)
- GitHub repo for this module: https://github.com/genepattern/Conos.VisualizeGeneExpression

## Parameters

#### conos_object
- Default: [blank]
- Required: Yes
- Description: RDS file created by Conos.Cluster.

#### genesofinterest
- Default: [blank]
- Required: Yes
- Description: A list of gene identifiers. The expression of these genes will be plotted on the embedded map. Gene names need to be separated by a coma and a space (e.g. MS4A1, CD74, LYZ, CD14).

#### clustering
- Default: none
- Required: Yes
- Description: Option to show clustering information besides gene expression (none, leiden, walktrap, both).

#### output_file_name
- Default: ConosMarkers
- Required: Yes
- Description: Basename of the file to be saved.




## Output Files
- <output_filename>.pdf: Collection of plots containing the expression of the genes listed in the parameters.
- stdout.txt: A list of non-essential messages printed by Conos, this may be helpful to debug should any errors occur.
- stderr.txt: If there were errors in completing the job, they'd appear here. Note that the mere presence of a file with this name does not imply that there were errors. Here is an example of the contents of the stderr.txt file from our test run:


## License
https://github.com/genepattern/Conos.VisualizeGeneExpression/blob/develop/LICENSE


Version Comments
Version	Release Date	Description
1	2021-11-30	Initial release of module
