# Working script 11/16

import pandas as pd
from quickfs import QuickFS as qf
import os
import json


# load the key 
api_key = '783afaac81792374538967ad9ef72226f07be115'
client = qf(api_key)


tickers = ['ABNB','ADSK']
#['ABNB', 'ADSK', 'ALGN', 'ADSK', 'ALGN', 'AMRS', 'AMZN', 'APPEF', 'ARAY', 'ASAN', 'AYX', 'BABA','BIDU','BMWYY','BYND','ACN', 
#'CHGG', 'COIN', 'CRM', 'CSCO', 'DBX', 'DIS', 'DMLRY', 'EA', 'EB', 'F', 'FB', 'GE', 'GM', 'GOOG', 'HOOD', 'HPE', 'HPQ', 'HUBS', 'IBM', 
#'INTC', 'INTU', 'ISRG', 'JAZZ', 'JNPR', 'LE', 'LYFT', 'MDB', 'ME', 'MSFT', 'NET', 'NEWR', 'NSIT', 'NFLX', 'NTNX', 'NTRA', 'NVDA', 'NVTA', 
#'OOMA', 'PACB', 'PATH', 'PD', 'PLTR', 'POSH','RBLX', 'RMBS', 'SAP', 'SBUX', 'SFIX', 'SFT', 'SNAP', 'SPOT', 'SQ', 'T', 'TEAM', 'TSLA', 'TSM', 
#'TWKS', 'TWTR', 'U', 'UPWK', 'V', 'VIR', 'YELP', 'Z', 'ZM', 'ZNGA', 'ZY']

#Basic Materials - Specialty Chemicals
#tickers = ['LIN','AIQUF','AIQUY','SHW','APD','ECL','SXYAY','SKFOF','GVDBF','DD','GVDNY','PPG','IFF','RDSMY','KDSKF','LYB','ALB','EMSHF','AVTR','AKZOF','NVZMF','AKZOY','NVZMY','NPCPF',
#'SYIEY','SYIEF','EVKIF','COIHY','COIHF','BNTGY','BNTGF','PTPIF','WLK','CVVTF','RPM','NDEKF','NDEKY','ARKAY','ARKAF','CHYHY','CRTSF','ASGLY','IMDZF','OLN',
#'CLZNY','JSCPY','AXTA','FUPBY','COVTY','ASH','ESI','CC','LNXSF','MITUY','JMPLF','JMPLY','BCPC','AVNT','INCZY','OCLDY','HXPLF','FUL','KWR','SXT','NEU','LTHM','CBT',
#'WDFC','NGVT','VTXPF','CSNVY','DICCF','SCL','GCP','MTX','IOSP','HUABF','TSE','PRM','FOE','KRO','GPRE','KRA','ECVT','DALQF','AMRS','DLNDY','OEC','CCF','ABSSF','HWKN',
#'LWLG','KOP','GEVO','REX','NOPMF','VITOF','COOSF','NCRBF','ALTO','LOOP','VNTR']

#Technology - Software—Infrastructure
#tickers = ['MSFT','ADBE','ORCL','ADYEY','ADYYF','VMW','SQ','PANW','FTNT','SNPS','CRWD','ZS','OKTA','NET','PLTR','MDB','VRSN','FLT','AKAM','SPLK','PATH','AFRM','CHKP',
#'AFTPF','AFTPY','NLOK','WWLNF','GDDY','FFIV','BKI','HCP','S','HOOD','DOX','DBX','AVASF','IOT','NVEI','FIVN','DLO','TMICY','INFA','TIXT','EEFT',
#'DAVA','WEX','PAGS','WIX','NEWR','PLAN','DOCN','NTNX','IWBB','MIME','TENB','CYBR','BL','QLYS','MCFE','ALTR','BB','STNE','SPSC','SQSP','ACIW','KNBE',
#'BOX','APPN','DRKTF','VRNS','MNDT','SAIL','VRNT','TOITF','EVTC','RAMP','TUYA','STWRY','FOUR','ETWO','SWDAF','EPAY','RXT','APGT','NTCT','SWI','MFGP','ZUO',
#'SPNUF','MCFUF']

#Technology - Software—Application
#tickers = ['CRM','SAP','SAPGF','INTU','NOW','SHOP','TEAM','SNOW','UBER','DASTY','DASTF','WDAY','ADSK','COIN','ZM',
#'CDNS','CNSWF','TTD','ANSS','U','DOCU','APP','HUBS','SSNC','ZI','PAYC','TYL','DIDI','NUAN','BILL',
#'NICE','XM','RNG','DT','PTC','CTXS','FICO','OTEX','LYFT','AVEVF','ZEN','XROLF','CDAY','BSY','KGDEF','PCTY',
#'SGGEF','SGPYY','WTCHF','AZPN','COUP','AVLR','ASAN','GTLB','TMSNY','TMNSF','KGDEY','MNDY','MANH',
#'GWRE','PCOR','ESTC','PEGA','SMAR','DSGX','WK','NATI','FRSH','RPD','BMBL','CDK','LAZR','BRZE',
#'LSPD','PYCR','DAVE','NCNO','MSP','ENV','APPS','DV','APPF','AMPL','MSTR','JAMF','SRAD','ALMFF',
#'AYX','ALRM','BLKB','DUOL','SPT','QTWO','KXSCF']

#Communication Services - Internet Content & Information
#tickers = ['GOOG','FB','TCEHY','TCTZF','PROSY','PROSF','BIDU','BAIDF','SNAP','DASH','TWLO','SPOT','NPSNY','NAPRF','MTCH','TWTR'
#,'RPGRF','PINS','YNDX','ADEVF','Z','ZG','WB','IAC','TME','ATDRY','RTMVY','SCOTF','CSXXY','ANGI','ATHM','CARG','YY','SSTK'
#,'LZ','IQ','FVRR','YELP','TTGT','ZH','CDLX','MOMO','MLRYY','DAO','GENI','THRY','SMWB','MAX','PERI','GRPN'
#,'TRVG','OPRA','OB','DOYU','SOHU','BODY','NEAPF','CANG','EVER','UXIN','OPNDF','TRUE','SCOR','PCOM','LTRPB'
#,'LTRPA','CMCM','LKCO','ATY','MVEN','JFIN','ZDGE','SLGG','LOV','IZEA','LIZI','QTT','FENG','BLCT','TC'
#,'ZMDTF','SFUN','AUTO','KRKR','TNYYF','CRTD','LYL','GROM','CXKJ','LIVC']

#Healthcare - Biotechnology
#tickers = ['NVO','NONOF','CSLLY','CMXHF','REGN','MRNA','VRTX','WXIBF','WXXWY','BNTX','SGEN','BGNE','GNMSF','GMAB','UCBJY','UCBJF','RPRX'
#,'INCY','BMRN','ALNY','TECH','SBHMY','ARGX','SBMFF','UTHR','JAZZ','BHVN','DNA','ASND','GNNSF','NTLA','NVAX','MRTX','OBMP','SRPT'
#,'IVBXF','LEGN','EXEL','ARNA','ARWR','HALO','HCM','AKABY','CRSP','RARE','IONS','VIR','AKBLF','GLPG','BEAM','BPMC'
#,'ZLAB','ALKS','ABCM','CERT','ABCZF','DNLI','IDRSF','APLS','MRVI','ACAD','CERE','FATE','ARVN','CVAC','KRTX','VSBC','KOD','PTCT'
#,'BCRX','CYTK','SWTX','FOLD','INSM','PPTDF','IOVA','ZNTL','ABCL','BVNRY','SAGE','RLAY','ADPT','AAGH','RCUS','CORT'
#,'AUPH','HRMY','KYMR','BVNKF','NKTR','LGND','VCYT','XNCR','RXRX','IMAB']

#Healthcare - Diagnostics & Research
#tickers = ['TMO','DHR','ILMN','LZAGY','LZAGF','IQV','IDXX','A','MTD','LH','ICLR','PKI','WAT','ERFSF','DGX','CRL'
#,'BMXMF','SKHCF','SKHHY','EXAS','QGEN','SYNH','DSRLF','GH','NTRA','MEDP','SHC','QDEL','OCDX','NEOG','TWST','NEO'
#,'NVTA','PACB','CDNA','OPK','MYGN','ME','FLGT','OLK','LNTH','RDNT','SENS','NRC','CSTL','VIVO','BNR','IDGXF'
#,'NOTV','MXCT','BNGO','CO','PSNL','RNLX','DMTK','GTH','BGLC','FLDM','SERA','CODX','AXDX','NVYTF'
#,'QTNT','ENZ','CELC','XGN','DRIO','VNRX','AKU','AWH','BDSX','CNTG','STIM','ANIX','BIOQ','TTOO','NDRA','APDN','COPRF'
#,'EDTXF','IBXXF','SQIDF','BIOC','CHEK','TOMDF','PMD','OPGN','GENE','CGNSF','PRPO','IDXG','CEMI','IZOZF','TRIB']


#metrics = ['period_end_date']

# Selected metrics in the API resp = client.get_available_metrics()
metrics = ['period_end_date','revenue','gross_profit', 'rnd', 'operating_income','eps_diluted', 'shares_diluted', 'total_opex', 'total_current_assets', 'total_assets',
'accounts_payable','st_debt', 'total_current_liabilities', 'lt_debt', 'total_liabilities', 'total_equity', 'total_liabilities_and_equity', 'book_value', 'tangible_book_value',
'cfo_net_income', 'cf_cfo', 'cf_cfi', 'cf_cff', 'fcf', 'roa', 'roe', 'roic', 'roce', 'rotce', 'gross_margin', 'operating_margin', 'net_income_margin', 'fcf_margin',
'assets_to_equity', 'equity_to_assets', 'debt_to_equity', 'debt_to_assets', 'book_value_per_share', 'tangible_book_per_share', 'revenue_per_share', 'operating_income_per_share',
'fcf_per_share', 'revenue_growth', 'operating_income_growth', 'net_income_growth', 'eps_diluted_growth', 'shares_diluted_growth', 'total_assets_growth', 'total_equity_growth',
'fcf_growth', 'market_cap', 'period_end_price', 'price_to_fcf', 'price_to_earnings', 'price_to_book', 'price_to_tangible_book', 'price_to_sales','intangible_assets','goodwill','shares_eop','dividends']


# Create dataframe
df = pd.DataFrame(client.get_data_batch(companies=tickers, metrics=metrics, period='FQ-90:FQ'))

# Unpivot dataframe (https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.explode.html)
ex = df.explode(list(metrics))
#ex.rename(columns={ df.columns[0]: "ticker" }, inplace = True)

print(ex)

# Export results to .csv
file_name = "/Users/kevin/Dropbox/programming/python/data/financials_mar_03.csv"
ex.to_csv(file_name)

