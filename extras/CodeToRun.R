library(antipsychotics)

# ‘DatabaseConnector’, ‘SqlRender’, ‘EmpiricalCalibration’, ‘Cyclops’, ‘FeatureExtraction’, 
# ‘CohortMethod’, ‘ggplot2’, ‘ffbase’, ‘MethodEvaluation’, ‘OhdsiSharing’, ‘ParallelLogger’, ‘readr’
install.packages("remotes")
library(remotes)

install.packages("devtools")

devtools::install_github("ohdsi/DatabaseConnectorJars")
devtools::install_github("ohdsi/DatabaseConnector")

remotes::install_github("OHDSI/DatabaseConnector", ref = "v4.0.0", build = FALSE)

remotes::install_github("ohdsi/SqlRender", ref = "v1.5.3")


install_github("ohdsi/DatabaseConnector", ref = "v2.4.2", args = "--no-multiarch", build = FALSE)


install_github("ohdsi/OhdsiSharing", ref = "v0.1.3")
install_github("ohdsi/FeatureExtraction", ref = "v2.2.5")
install_github("ohdsi/CohortMethod", ref = "v3.1.0")
install_github("ohdsi/EmpiricalCalibration", ref = "v2.0.0")
install_github("ohdsi/MethodEvaluation", ref = "v1.1.0")
install_github("ohdsi/ParallelLogger", ref = "v1.1.1")

remotes::install_github("OHDSI/DatabaseConnector@v2.4.0", build = F)
remotes::install_github("OHDSI/DatabaseConnector@v2.3.0", build = F)

.libPaths('~/R/renv')
.libPaths('~/synology/renv')

outputFolder <- "~/storage/21/output/2025/antipsychotics/T01"

# Details for connecting to the server:

dbms <- "sql server"
user <- 'gansujin'
pw <- 'sujin30401@'
server <- '10.5.99.50'
port <- '1433'
DATABASECONNECTOR_JAR_FOLDER<- '~/Users/gansujin/path/mssql'
Sys.setenv("DATABASECONNECTOR_JAR_FOLDER" = '~/Users/gansujin/path/mssql')

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port,
                                                                pathToDriver = DATABASECONNECTOR_JAR_FOLDER)


# The name of the database schema where the CDM data can be found:
cdmDatabaseSchema <- 'CDMPv536.dbo'
cohortDatabaseSchema <- 'cohortDb.dbo'
cdmDatabaseName <- 'AUSOM'
cohortTable <- "sooj_antipsychotics_250416_test_T01"

# Optional: specify where the temporary files (used by the ff package) will be created:
options(fftempdir = "./temp")
oracleTempSchema <- NULL
options(sqlRenderTempEmulationSchema = NULL)
options(andromedaTempFolder = "./androtemp")

maxCores <- 1

execute(connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        oracleTempSchema = oracleTempSchema,
        outputFolder = outputFolder,
        databaseId = databaseId,
        databaseName = databaseName,
        databaseDescription = databaseDescription,
        createCohorts = T,
        synthesizePositiveControls = F,
        runAnalyses = T,
        runDiagnostics = F,
        packageResults = T,
        maxCores = maxCores)

# resultsZipFile <- file.path(outputFolder, "export", paste0("Results", databaseId, ".zip"))
# dataFolder <- file.path(outputFolder, "shinyData")
# 
# prepareForEvidenceExplorer(resultsZipFile = resultsZipFile, dataFolder = dataFolder)
# launchEvidenceExplorer(dataFolder = dataFolder, blind = TRUE, launch.browser = FALSE)
