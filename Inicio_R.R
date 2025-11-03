#Baixando todos os pacotes e carregando
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyverse")

library("tidyverse")
library("dplyr")
library("ggplot2")

#Leitura de dados em excel
dados <- read.csv("Pokemon_full.csv") 

head (dados) # Incio dos dados
tail(dados)  # Final dos dados
tail(dados, 10) # Últimas 10 linhas

getwd() # Mostra o diretório atual
setwd() # Troca o diretório


names(dados)

# Seleciona colunas
select(dados, name, hp, speed, attack)

# Filtra as colunas
filter(dados, attack > 50)

# Operações

mutate(dados, x = attack+speed) # Cria nova variavél
mutate(dados, attack = attack/2) # modifica variavél

# Exemplo operador
df <- select(dados, name, hp, attack, speed)
df <- filter(df, attack < 50)
df <- mutate (df, x = attack+speed)
df

# O operador pipe pega o que esta a direita e coloca como primeiro argumento da próxima função
df <- dados %>%
  select(dados, name, hp, attack, speed)
  filter(df, attack < 50)
  mutate (df, x = attack+speed)
  
x = c("Camila","Thomas","Thais")
# Se colocar ponto, o pipe rastreia e substitui. Se não colocar ele pôe como primeiro argumento
x %>%
  gsub("Th","th", .)


mutate(dados, IMC = weight/(height*height))

dados <- mutate(dados, IMC = weight/(height*height)) # atribui as novas colunas pedidas


dados %>%
  filter(height > 10) %>%
  select(name, height, weight) %>%
  mutate(imc = weight/(height*height)) %>%
  ggplot() +
  geom_density(aes(x = imc))


head(dados)
dados %>% head
glimpse (dados)

dados %>% pull(IMC) # Retorna como vetor
dados %>% select(IMC) # Retorna como coluna

mean(c(1,2,3,4))

dados %>%
  mutate(media = mean (IMC))

dados %>%
  summarise(media = mean(IMC), desvio = sd(IMC)) # Resume os dados, retornando a coluna para cada

dados %>%
  group_by(type)%>%
  mutate(media= mean(IMC))%>% View # Cria e preenche uma coluna com o mesmo valor

dados %>%
  group_by(type)%>%
  mutate(media= mean (IMC))%>%
  filter(IMC > media)%>% View

dados %>%
  ungroup() %>%
  mutate(media = mean(IMC))

grep("saurifly", dados$name) # Busca padrões # Aceita Regular Expressions (ReGex)
grepl("saur", dados$name) 

grep("[Ss]aur", dados$name)

x
grep("Th[oa]", x)

n <- c("123.321.456-80", "456.894.78-89")
grepl("\\d{3}\\.\\d{3}\\-\\{2}", n)

dados %>%
  filter(attack >50)

dados$attack > 50

dados %>%
  filter(grepl("saur",name), attack >50, type != "fire")

"saur" == "ivysaur"
grepl("saur", "uvysaur")

## Trabalhando juntando dados

# Bind rows

df1 <- dados%>%
  select(attack, speed, weight)%>%
  filter(attack > 70)

df2 <- dados%>%
  select(attack, speed, hp)%>%
  filter(attack <= 70)

rbind(df1, df2) # Juntar linhas mas não aceita dimensões e nomes diferentes

bind_rows(df1, df2) # Junta independente do N de colunas de cada dado - colunas com mesmo nome vira uma única coluna, mas as que não existe em alguma das dataframes fica como NA

bind_cols(df1, df2) # Junta colunas



# Juntar colunas
df1 <- dados%>%head(100)
df2 <- dados%>%tail(100)

cbind(df1,df2) %>% names

bind_cols(df1,df2)
#ou
bind_cols(df1, df2,.name_repair = "unique")

#####

df_resumo <- dados %>% 
  group_by(type) %>% 
  summarise(media = mean(IMC), desvio = sd(IMC)) # resume os dados, retornando uma coluna para cada

# Fazendo join
# left, rigth, full, inner

left_join(dados, df_resumo, by = c("type")) %>% View
right_join(dados, df_resumo, by = c("type")) %>% View

df_resumo_mis <- df_resumo %>% filter(type !="grass")

left_join(dados, df_resumo, by = c("type")) %>% View
right_join(dados, df_resumo, by = c("type")) %>% View

df_resumo_mis$type[5] <- "thomas" 

right_join(dados, df_resumo_mis, by = c("type")) %>% View
left_join(dados, df_resumo_mis, by = c("type")) %>% View

####### Atalhos do teclado ########

# <- "alt + -"
# copiar para linha seguinte - "shift + alt + seta"
# %>%  - "Ctrl + shift + m"
# Movimentar a linha no script - "alt + seta"
