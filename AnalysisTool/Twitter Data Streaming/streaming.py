from tweepy.streaming import StreamListener
from tweepy import OAuthHandler
from tweepy import Stream


consumer_key = ''
consumer_secret = ''
access_token = ''
access_token_secret = ''


class twitterListener(StreamListener):

    def on_data(self, data):
        print (data)
        return True

    def on_error(self, status):
        print (status)


l = twitterListener()
auth = OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
stream = Stream(auth, l)

stream.filter(languages=["en"], track=['medicine', 'meds', 'medical', 'infected', 'health', 'pill', 'pills', 'drug', 'drugs',\
                                        'surgeon', 'surgeons', 'disease', 'diseases', 'virus', 'viruses', 'bacteria',\
                                        'vaccine', 'vaccines', 'doctor', 'doctors', 'patient', 'patients','hospital'\
                                        'clinic', 'prescription', 'sick', 'illness', 'allergy', 'fever', 'flu', 'autism'\
                                        'cancer', 'diabetes', 'HIV', 'injection', 'antibiotic', 'disorder'])