""" The following file, answers the Ortex Data Engineer Programming Exercise PART 2
    My name is Pablo Segovia! Thank you for your time and the opportunity to submit my proposals to this exercise
"""

# Import libraries
import pandas as pd
import numpy as np
import os
from pathlib import Path

# Import csv file and save it as a DataFrame
BASE_DIR = Path(os.getcwd())
CSV_FILE = os.path.join(BASE_DIR,'2017.csv')
df = pd.read_csv(CSV_FILE)

# Task 1: Which are the 3 source with the highest ratio of Buy to Sell transactions weighed
        # by the number of shares per transaction
"""
Explaination:
Both the 'number of buy transactions' and 'number of sell transaction' are in the quotient the weight 'number of 
shares per transactions', these are cancelled.
Thus, the task_1 solution only is the 'buying shares' over the 'selling shares'. 
"""

# Number of shares for Buy transaction type, grouped by source
buy_shares = df.loc[df['transactionType']=='Buy'].groupby('source').sum()['shares']

# Number of shares for Sell transaction type, grouped by source
sell_shares = df.loc[df['transactionType']=='Sell'].groupby('source').sum()['shares']

# Calculate ratio buy/sell shares for the top 3 source
task_1 = (buy_shares / sell_shares).sort_values(ascending=False).head(3)


# Task 2: Which are the top 3 currency by the total numerical value of trades in that currency

# Top 3 currency with highest total numerical value of trades
task_2 = df.groupby('currency').count()['transactionType'].sort_values(ascending=False).head(3)


# Task 3: What is the total number of transactions where inputdate was more than 2 weeks after tradedate

# Transform the date columns into date type actually
input_date = pd.to_datetime(df['inputdate'].astype(str), format='%Y%m%d')
trade_date = pd.to_datetime(df['tradedate'].astype(str), format='%Y%m%d')

# Define a column to save the delta time
df['deltaday'] = input_date - trade_date

# Convert it into an integer column for easier filtering
df['deltaday'] = df['deltaday']/np.timedelta64(1, 'D')

# Calculate the final value
task_3 = df.loc[df['deltaday']>14]['transactionType'].count()


if __name__ == '__main__':
    # Task 1 solution
    print("The top 3 sources with highest ratio of Buy/Sell transactions are:\n", task_1)

    # Task 2 solution
    print("Top 3 currency with highest total numerical value of trades:\n", task_2)

    # Task 3 solution
    print("The total number of transactions where inputdate was more than 2 weeks after tradedate:\n", task_3)
