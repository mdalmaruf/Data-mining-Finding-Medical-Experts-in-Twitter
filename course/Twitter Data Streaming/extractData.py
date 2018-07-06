import json
import pandas as pd


def readFromFile(filePath):
    # Read from the file and append the data to a list

    tweets_data_path = filePath
    tweets_data = []
    tweets_file = open(tweets_data_path, "r")

    for line in tweets_file:
        # append json file data to a list
        try:
            tweet = json.loads(line)
            tweets_data.append(tweet)
        except:
            continue

    return tweets_data
    

def listToDataFrame(lst, headerList):
    # Read from a list and create a Pandas dataframe with the corresponding headers 
    return pd.DataFrame(lst, columns=header)


header = ['text', 'created_at', 'user']
filePath = r'C:\Winter 2018- home\data mining\twitterResult2.txt'

tweets = listToDataFrame(readFromFile(filePath), header)

tweets = tweets.dropna() #delete NAN rows


tweets['screen_name'] = [d.get('screen_name') for d in list(tweets.user)]
tweets['followers_count'] = [d.get('followers_count') for d in list(tweets.user)]
tweets['friends_count'] = [d.get('friends_count') for d in list(tweets.user)]
tweets['favourites_count'] = [d.get('favourites_count') for d in list(tweets.user)]
tweets['verified'] = [d.get('verified') for d in list(tweets.user)]


tweets.to_csv("twittertest2.csv")
