#Steps
#1. update file_name
#2. update tickers
#3. run

import pandas as pd 
import yfinance as yf



tickers = ['ABNB','ADSK']
#tickers = ['ABNB','ADSK','ALGN','AMRS','AMZN','APPEF','ARAY','ASAN','AYX','BABA','BIDU','BMWYY','BTC-USD','BYND','ACN',
#'CHGG','COIN','CRM','CSCO','DBX','DIS','DMLRY','EA','EB','F','FB','GE','GM','GOOG','HOOD','HPE','HPQ','HUBS','IBM','INTC','INTU',
#'ISRG','JNPR','JPM','LE','LYFT','MDB','ME','MSFT','NET','NEWR','NSIT', 'NFLX','NTNX','NTRA','NVDA','OOMA','PATH',
#'PD','PLTR','POSH','RBLX','RMBS','SAP','SBUX','SFIX','SFT','SNAP','SPOT','SQ','T','TEAM','TSLA',
#'TSM','TWKS','TWTR','U','UPWK','V','YELP','Z','ZM','ZNGA','ZY']


def build_df(tickers):
    df = pd.DataFrame(yf.download(tickers[0], 
                    start='2000-01-01',
                    #end='2022-12-31',
                    progress='True'))
    df.rename(columns={ 'Date':'DATE',
                    'Open':'OPEN',
                    'High':'HIGH',
                    'Low':'LOW',
                    'Close':'CLOSE',
                    'Adj Close':'ADJCLOSE',
                    'Volume':'VOLUME'}, inplace=True)
    df.insert(0, 'TICKER', tickers[0])
    for ticker in tickers[1:]:
        dx =  pd.DataFrame(yf.download(ticker, 
                    start='2000-01-01',
                    #end='2022-12-31',
                    progress='True'))
        dx.insert(0, 'TICKER', ticker)
        dx.rename(columns={ 'Date':'DATE',
                    'Open':'OPEN',
                    'High':'HIGH',
                    'Low':'LOW',
                    'Close':'CLOSE',
                    'Adj Close':'ADJCLOSE',
                    'Volume':'VOLUME'}, inplace=True)
        df = pd.concat([df, dx])
    return df

result = build_df(tickers) 

print(result)

file_name = "/Users/kevin/Dropbox/programming/python/data/yfinance_pricing_mar_03.csv"
result.to_csv(file_name)