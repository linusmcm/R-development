install.packages('rsconnect')
library(rsconnect)
rsconnect::setAccountInfo(name='linus', token='00257613C24335E8649BA521312E187C', secret='oFwaBhEpCbHAs8tbymirIF9eF+L6YAQpyMTL57T5')

rsconnect::deployApp('path/to/your/app')