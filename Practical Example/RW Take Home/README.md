# Raywenderlich.com iOS interview practice project

![Github Followers](https://img.shields.io/github/followers/zoha131?label=Follow&style=social)
![Twitter Follow](https://img.shields.io/twitter/follow/zoha131?label=Follow&style=social)

<a href="https://www.linkedin.com/in/zoha131/">
    <img src="https://img.shields.io/badge/Support-Recommed%2FEndorse%20me%20on%20Linkedin-yellow?style=for-the-badge&logo=linkedin" alt="Recommend me on LinkedIn" /></a>


## About
This is an implementation of Raywenderlich.com iOS interview practice project. Full description of this project can be found [here](https://github.com/raywenderlich/ios-interview/blob/master/Practical%20Example/README.md)


## 📸 Screenshot

<img src="./images/rw_take_home.png" alt="Raywenderlich.com iOS interview practice project">


## Accessibility:
- **Dynamic Type**: This app support dynamic type. When the text size gets large then all the horizontal stack become vertical stack and in the landscape mode single cell gets the full width.
<p float="left">
  <img src="./images/dynamic_type_portrait.png" style="width: 45%" />
  <img src="./images/dynamic_type_landscape.png" style="width: 45%"/> 
</p>

- **VoiceOver**: In this app each CollectionViewCell act like a single element when the Voice over is activated. The `accessibilityLabel` of each Cell is consists of the title and type (artticle/video) of the Cell data.
<p float="left">
  <img src="./images/voiceover.png" style="width: 45%" />
</p>


## APIs/Libraris, I have used in this project
- Auto Layout
- Custom UIView
- CollectionView with DiffableDataSource & CompositionalLayout
- Combine & URLSession
- **Kingfisher**: Downloading image for the CollectionViewCell is a common problem in the iOS Community and the community came up with mutliple solutions. Kingfisher is one of the most popular solutions. It is open sourced and actively maintained. That's why I have choosen this library to download the images. </br> ( RW iOS App also use this library )


## Speacial Thanks To
- [raywenderlich.com](https://www.raywenderlich.com/) for the amazing **RW Community Care!**
- All the mentors of **RW Bootcamp**
- All the fellow students of **RW Bootcamp**

<p>
Don't forget to star ⭐ the repo it motivates me to share more open source projects
</p>
