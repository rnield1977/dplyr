 library(dplyr)
 library(hflights)
 
 data(hflights)
 head(hflights)
 
 flights <- tbl_df(hflights)
 
 # This is filter a the output based on data rows
 filter(flights,Month==1,DayofMonth==1)
 filter(flights, UniqueCarrier=="AA" | UniqueCarrier=="UA")
 filter(flights UniqueCarrier %in% c("AA","UA"))
 
 # This is select a specific column
 select(flights, DepTime, ArrTime, FlightNum)
 select(flights, Year:DayofMonth, contains("Taxi"),contains("Delay"))
 
 # Chaining equivalent of a | in Unix
 flights %>%
   select(UniqueCarrier, DepDelay) %>%
   filter(DepDelay > 60)
 
 
 #arrange reordering rows
 
 flights %>%
   select(UniqueCarrier, DepDelay) %>%
   arrange(DepDelay)
 
 flights %>%
   select(UniqueCarrier, DepDelay) %>%
   arrange(desc(DepDelay))
 
 flights %>%
   select(Distance,AirTime) %>%
   mutate(Speed = Distance/AirTime*60)
 
 flights %>%
   group_by(Dest) %>%
   summarise(avg_delay = mean(ArrDelay, na.rm=TRUE))
 
 flights %>%
   group_by(UniqueCarrier) %>%
   summarise_each(funs(mean), Cancelled, Diverted)
 
 flights %>%
   group_by(UniqueCarrier) %>%
   summarise_each(funs(min(.,na.rm=TRUE),max(.,na.rm=TRUE)), matches("Delay"))
 
 flights %>%
   group_by(Month,DayofMonth) %>%
   summarise(flight_count = n()) %>%
   arrange(desc(flight_count))

 flights %>%
   group_by(Month,DayofMonth) %>%
   tally(sort=TRUE)
 
 flights %>%
   group_by(Dest) %>%
   summarise(flight_count = n(), plain_count = n_distinct(TailNum))
 
 
 flights %>%
   group_by(UniqueCarrier) %>%
   select(Month, DayofMonth, DepDelay) %>%
   top_n(2) %>%
   arrange(UniqueCarrier, desc(DepDelay))
 
 flights %>%
   group_by(Month) %>%
   summarise(flight_count = n()) %>%
   mutate(change = flight_count - lag(flight_count))
 
 flights %>% sample_n(5)
 
 flights %>% sample_frac(0.25, replace=TRUE)
 
 glimpse(flights)
 
 flights %>%
   select(UniqueCarrier, DepDelay) %>%
   arrange(desc(DepDelay))
 
 my_db <- src_sqlite("my_db.sqlite3", create=TRUE)
 
 flights_tbl <- tbl(my_db,"hflights")
 
 
   