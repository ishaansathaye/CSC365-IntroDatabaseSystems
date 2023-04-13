import pandas as pd
import numpy as np

filenameWorld = "labs/lab1/lab1-2/world_population.csv"

worldDf = pd.read_csv(filenameWorld)   ## pandas data frame for world population data

worldData = np.array(worldDf)          ## numPy array with the  world population data

worldDl = [list(x) for x in worldData]  ## List of lists with the world population data

worldColumns = list(worldDf.columns)   ## list of column names - in the order of columns in both the Pandas data frame and the NumPy array



filenameCorruption = "labs/lab1/lab1-2/corruption_data.csv"

corrDf = pd.read_csv(filenameCorruption)   ## pandas data frame for corruption index data

corrDf['country'] = [x.strip() for x in corrDf["region_name"]]

corrData = np.array(corrDf)              ## numPy array with the  corruption index data

corrDl = [list(x) for x in corrData]     ## List of lists with the corruption index data

corrColumns = list(corrDf.columns)      ## list of column names - in the order of columns in both the Pandas data frame and the NumPy array

# 1. Find how much the population of a country whose capital 
# is the city of Bujumbura has changed between 2000 and 2020. Report
# the name of the country and the absolute value of the pop change.
# worldDf1 = worldDf[worldDf['Capital'] == 'Bujumbura']
# print(worldDf1['Country'].values[0])
# print(abs(worldDf1['2020 Population'].values[0] - worldDf1['2000 Population'].values[0]))

# 2. Report the change in the corruption index of Poland
# between the years of 2012 and 2021.
# corrDf2 = corrDf[corrDf['country'] == 'Poland']
# print(corrDf2['2021'].values[0] - corrDf2['2012'].values[0])

# 3. Find the average population density in each continent (output)
# shall contain one row per continent, with the continent name and
# the average population density for a country in that continent
# reported). Use Density (per km^2) column.
# worldDf3 = worldDf.groupby('Continent')['Density (per km²)'].agg(['mean'])
# worldDf3.rename(columns={'mean': 'Average Density'}, inplace=True)
# print(worldDf3)

# 4. Break all countries into "good" (corruption index of 70 or higher),
# "average" (index between 45 nad 69), and "bad" (index below 45).
# Report number of countries with "good", "avera", and "bad" corrupation
# indexes in 2020. Ouput should consist of 3 rows - one per type of country ("gppd",
# # "average", and "bad").
# corrDf4 = corrDf[['country', '2020']].copy()
# for index, row in corrDf4.iterrows():
#     if row['2020'] >= 70:
#         corrDf4.loc[index, 'Corruption'] = 'good'
#     elif row['2020'] >= 45:
#         corrDf4.loc[index, 'Corruption'] = 'average'
#     else:
#         corrDf4.loc[index, 'Corruption'] = 'bad'
# corrDf4 = corrDf4.groupby('Corruption')['country'].agg(['count'])
# corrDf4.rename(columns={'count': 'Number of Countries'}, inplace=True)
# print(corrDf4)

# 5. Find hte most corrupt country (or countries - may be ties) in Asia
# in 2020.
# corrDf5 = corrDf[['country', '2020']].copy()
# corrDf5 = corrDf5[corrDf5['country'].isin(worldDf[worldDf['Continent'] == 'Asia']['Country'])]
# corrDf5 = corrDf5[corrDf5['2020'] == corrDf5['2020'].min()]

# 6. Find the European country or countries if ties that showed
# highest improvement of their corruption index between 2012 and 2020.
# Report names of countries (in alphabetical order if more than 1 country)
# and the 2012 and 2020 corruption indexes.
# corrDf6 = corrDf[['country', '2012', '2020']].copy()
# corrDf6 = corrDf6[corrDf6['country'].isin(worldDf[worldDf['Continent'] == 'Europe']['Country'])]
# corrDf6['Improvement'] = corrDf6['2020'] - corrDf6['2012']
# corrDf6 = corrDf6[corrDf6['Improvement'] == corrDf6['Improvement'].max()]
# corrDf6 = corrDf6.sort_values(by=['country'])
# corrDf6 = corrDf6[['country', '2012', '2020']]
# print(corrDf6)

# 7. List all countries in South America that had population
# increase between 2015 an 2020 sorted in descending order by their
# 2020 corruption index. For each country report absolute value 
# population increase between 2015 and 2020 and the 2020 corruption index.
# Report only countries for which corruption index exists.
# worldDf7 = worldDf[['Country', '2015 Population', '2020 Population']].copy()
# worldDf7 = worldDf7[worldDf7['Country'].isin(worldDf[worldDf['Continent'] == 'South America']['Country'])]
# worldDf7['Population Increase'] = worldDf7['2020 Population'] - worldDf7['2015 Population']
# worldDf7 = worldDf7[worldDf7['Population Increase'] > 0]
# corrDf7 = corrDf[['country', '2020']].copy()
# corrDf7 = corrDf7[corrDf7['country'].isin(worldDf7['Country'])]
# worldDf7 = worldDf7.merge(corrDf7, left_on='Country', right_on='country')
# worldDf7 = worldDf7[['Country', 'Population Increase', '2020']]
# worldDf7 = worldDf7.sort_values(by=['2020'], ascending=False)
# print(worldDf7)

# 8. Find all countries in Africa for which there is no corruption index data. Report names
# of countries in alphabetical order.
# print(corrDf)
# corrDf8 = corrDf[['country']].copy()
# worldDf8 = worldDf[['Country']].copy()
# worldDf8 = worldDf8[worldDf8['Country'].isin(worldDf[worldDf['Continent'] == 'Africa']['Country'])]
# worldDf8 = worldDf8[~worldDf8['Country'].isin(corrDf8['country'])]
# worldDf8 = worldDf8.sort_values(by=['Country'])
# print(worldDf8)

# 9. Report 2020 population of the most corrupt country for that year 
# on each continent (include all ties). Report the continent, the
# name of the country, the 2020 corruption index,
# and the 2020 population. Sort output in alphabetical 
# order by continent, and within continent - in descending order by the country's
# 2020 population (if there are ties).
# corrDf9 = corrDf[['country', '2020']].copy()
# worldDf9 = worldDf[['Country', 'Continent', '2020 Population']].copy()
# corrDf9 = corrDf9.merge(worldDf9, left_on='country', right_on='Country')
# corrDf9.rename(columns={'2020': 'Corruption Index'}, inplace=True)
# corrDf9 = corrDf9[['Continent', 'Country', 'Corruption Index', '2020 Population']]
# continents = corrDf9['Continent'].unique()
# continents.sort()
# continentDfs = []
# for continent in continents:
#     continentDf = corrDf9[corrDf9['Continent'] == continent].copy()
#     minCorruption = continentDf['Corruption Index'].min()
#     continentDf = continentDf[continentDf['Corruption Index'] == minCorruption]
#     continentDf = continentDf.sort_values(by=['2020 Population'], ascending=False)
#     continentDfs.append(continentDf)
# corrDf9 = pd.concat(continentDfs)
# corrDf9 = corrDf9.sort_values(by=['Continent', 'Country'])
# print(corrDf9)

# 10. Find the largest (by area) country with a "good" (70 or above)
# corruption for each of the years reported in the corruption 
# index data file. Report the name of the country, its average 
# corruption index over all years, and its area.
worldDf10 = worldDf[['Country', 'Area (km²)']].copy()
corrDf10 = corrDf[['country', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020']].copy()
corrDf10 = corrDf10.merge(worldDf10, left_on='country', right_on='Country')
corrDf10.drop(columns=['Country'], inplace=True)
countryAreas = {}
for index, row in corrDf10.iterrows():
    # check if country has 70 or above corruption index on all years
    if (row['2012'] >= 70 and row['2013'] >= 70 and 
        row['2014'] >= 70 and row['2015'] >= 70 and 
        row['2016'] >= 70 and row['2017'] >= 70 and 
        row['2018'] >= 70 and row['2019'] >= 70 and row['2020'] >= 70):
        # calculate average corruption index
        avgCorruption = (row['2012'] + row['2013'] + 
                         row['2014'] + row['2015'] + row['2016'] + 
                         row['2017'] + row['2018'] + row['2019'] + 
                         row['2020']) / 9
        countryAreas[row['country']] = [avgCorruption, row['Area (km²)']]
countryAreasDf = pd.DataFrame.from_dict(countryAreas, orient='index', columns=['Average Corruption Index', 'Area (km²)'])
countryAreasDf = countryAreasDf.sort_values(by=['Area (km²)'], ascending=False)
print(countryAreasDf.head(1))
        
        


