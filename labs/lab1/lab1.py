import pandas as pd
import numpy as np

filename = "labs/lab1/Maths.csv"
df = pd.read_csv(filename)
df['Id'] = df.index
data = np.array(df)
dl = [list(x) for x in data]
columns = list(df.columns)

# 1. Find final G3 grades of students who are in romantic relationship,
#   attend a nursery school, and reported having 4 or above of free time.
#   Output should have only the index of the row and the grade
# print(df.loc[(df['romantic'] == 'yes') & (df['nursery'] == 'yes') & (df['freetime'] >= 4), ['Id', 'G3']])

# 2. Find the average final G3 grade for 15-year old female students from the GP school.
#   Report just the average grade value.
# print(df.loc[(df['school'] == 'GP') & (df['age'] == 'F') & (df['age'] == 15), ['G3']].mean())
# # print(df.loc[(df['school'] == 'GP') & (df['age'] == 'F') & (df['age'] == 15), ['G3']])
# df = df[(df['age'] == 15) & (df['school'] == 'GP') & (df['sex'] == 'F')]
# print(df['G3'].mean())

# 3. Find the highest number of absences that a Mousinho da Silveira student had
#   had in math class. Report just the number.
# df = df[(df['school'] == 'MS')]
# print(df['absences'].max())

# 4. Find all students from MS school who had highest number of absences in math class.
#   For each student report ID, final G3 grade in class, their sex, and age.
# df4 = df[(df['school'] == 'MS')]
# max_absences = df4['absences'].max()
# df4 = df4[(df4['absences'] == max_absences)]
# print(df4[['Id', 'G3', 'sex', 'age']])

# 5. Compare avg. performance of female students who are engaged in extra curricular
#   activities at GP and MS schools in the math class (G3 grade). Report full name of the
#   school with the higher average performance.
# df5 = df[(df['sex'] == 'F') & (df['activities'] == 'yes')]
# df5 = df5.groupby('school')['G3'].mean()
# if df5['GP'] > df5['MS']:
#     print('Gabriel Pereira')
# else:
#     print('Mousinho da Silveira')

# 6. Break students into 2 categories: those who have a romantic relationship and those
#   who are not. For each group report 1) number of students in the group, 2) average math G3 score.
#   Report groups in descending order by the average score. Output should have 2 rows and 
#   3 values in each row: "yes" or "no" for relationship status, number of students, and average score.
# df6 = df.groupby('romantic')['G3'].agg(['count', 'mean'])
# df6 = df6.sort_values(by='mean', ascending=False)
# df6 = df6.rename(columns={'count': 'number of students'})
# df6 = df6.rename(columns={'mean': 'average score'})
# df6 = df6.rename_axis('relationship status')
# print(df6)

# 7. Find how many students in each school who previously failed the math class at least once (
#    look at the failures col) received the final G3 grade of 15 or higher this time. Output
#    should contain 2 rows - one for each school. Each row should contain full name of the school.
#    and the number of students that are computed.
# print(df.loc[(df['failures'] >= 1) & (df['G3'] >= 15), ['failures', 'Id', 'G3', 'school']])
# df7 = df[(df['failures'] > 0) & (df['G3'] >= 15)]
# df7 = df7.groupby('school')['G3'].agg(['count'])
# print(df7)

# 8. For each school, find how many students have a high alcohol consumption. Consider alc. consumption
#    to be high either the weekend consumpation or the weekday consmption is 4 or above. Output
#    should have a school - age combination in each row, sorted by school name, and in asending order to age within each
#    school. Ex. report numberof 15 years olds in GP first then 16 in GP...
# df8 = df[(df['Dalc'] >= 4) | (df['Walc'] >= 4)]
# df8 = df8.groupby(['school', 'age'])['G3'].agg(['count'])
# print(df8)

# 9. Find whether the percentage of students with high consumption (>= 4 on weekend or weekday)
#    is higher among students whose parents live together or separately (Pstatus). Report
#    status with the higher percentage and the percentage value.
# df9 = df[(df['Dalc'] >= 4) | (df['Walc'] >= 4)]
# total = df9['Pstatus'].count()
# df9 = df9.groupby('Pstatus')['G3'].agg(['count'])
# df9['percentage'] = df9['count'] / total
# df9 = df9.sort_values(by='percentage', ascending=False)
# if df9.index[0] == 'T':
#     print('T: ' + str(100*(df9['percentage'][0])))
# else:
#     print('A: ' + str(100*(df9['percentage'][0])))


# 10. List average alcohol consumption level (avg between weekend and weekday consumption)
#    for each student with the highest G3 score in the class. Output should have 2 values in 
#    each row: student ID and the average alcohol consumption level.
# df10 = df.loc[df['G3'] == df['G3'].max()].copy()
# df10['avg_alc'] = (df10['Dalc'] + df10['Walc']) / 2
# print(df10[['Id', 'avg_alc']].to_string(index=False))
