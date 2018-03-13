# ZemogaTest

This is a test prepared for Zemoga in order to evaluate my coding capacities. In order to run this test, download the project
and extecute 'pod install'. Once installation has finished, open the project in XCode and run it on your phone.

Architecture

In this project, views, apis and models were built as separate components. Each cell, view, model and call were desigend to be resuable throughout the different situations encountered in the app. Posts are first fetched from the local database unless explicitly being required from the API.

Third-party libraries

Third party libraries were used to facilitate the execution of the tasks. To store data locally, Realm was implemented. It is a very popular and well-structured library which allows to parse, store and modify data es required in a local database. NVActivityIndicator was used to block the UI while loading data in order to prevent the user from interacting with empty data sets. Finally, Alamofire was used to handle the url requests and manage the responses.

Hope this project fulfills your standards!.

Thank you for your time.
