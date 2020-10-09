# 500px
The objective is to build an application that showcases **Popular** photos from 500px and display their details using 500px API.
<br/>
<br/>
# Swift Libraries Used  
* Alamofire
* Kingfisher
* RNCryptor<br/><br/>
# Consumer Key
Since consumer key should not be visible on the public repository, **RNCryptor** was used to encrypt the consumer key. The project folder itself only contains encrypted consumer key that is illegible by human. Later in the process, the consumer key is decrypted into a string within the application.<br/><br/>
# Photo Showcase
In the very first view, **Popular** photos are displayed as grid with three columns. <br/>
Photos can expand their column when the requirements are satisfied. <br/>
When the user scrolls to the very bottom, infinite scroll loads photos from next page and it is achieved through **scrollViewDidScroll**.<br/>
Clicking a photo will display only that photo with details. <br/><br/>
<img src="https://i.imgur.com/pDZJWhS.png" width="216" height="460"><br/><br/>
# Photo Detail
This view is separated into two sub-views; **scrollView** for the photo and **visualEffectView** for the detail. <br/>
The image is placed inside the **scrollView** to achieve pinch-to-zoom feature.<br/>
The text is placed inside the **visualEffectView** to achieve hide/show feature.<br/><br/>
**Available Gestures**
* Single Tap
  * Toggle hide/show the detail.
* Double Tap
  * Toggle zoom in/out of the photo in a fixed zoom scale (*1.0 to 4.0*).
* Pinch
  * To zoom in/out of the photo.<br/><br/>
<img src="https://i.imgur.com/A5hbduG.png" width="216" height="460"><br/><br/>
# Fetching Data
Data from 500px API is fetched by **Alamofire**.<br/><br/>
# Images
Images are downloaded and cached using **Kingfisher**.<br/><br/>
# Author
Kurt Kim<br/>
[Kurtsh.Kim@gmail.com](mailto:kurtsh.kim@gmail.com)
