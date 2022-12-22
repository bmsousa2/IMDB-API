# Carregando pacotes

library('RMySQL')
library('dplyr')
library('plumber')

############################
# Construindo API
###########################


#* @apiTitle IMDB- API
#* @apiDescription API para acessar base de dados do IMDB
#* @apiVersion 1.0.0

#* @apiTag Interacting Interagindo com os dados

#* melhores filmes de todos os tempos
#* @tag Interacting
#* @get /TOP10

function() {
  con = dbConnect(RMySQL::MySQL(),dbname = 'filmes', user = 'root', password = 'bruno2020', host = 'localhost')
  
  df_top_10 <- con %>%
    tbl("filmes_imdb_res") %>%
    select(movie_title,director_name, title_year, genres, imdb_score) %>%
    arrange(-imdb_score) %>% 
    collect()
  
  
  return(head(df_top_10, n= 10))
}