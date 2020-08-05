# Raywenderlich.com iOS interview practice project

![Github Followers](https://img.shields.io/github/followers/zoha131?label=Follow&style=social)
![Twitter Follow](https://img.shields.io/twitter/follow/zoha131?label=Follow&style=social)

<a href="https://www.linkedin.com/in/zoha131/">
    <img src="https://img.shields.io/badge/Support-Recommed%2FEndorse%20me%20on%20Linkedin-yellow?style=for-the-badge&logo=linkedin" alt="Recommend me on LinkedIn" /></a>


## About
This is an implementation of Raywenderlich.com iOS interview practice project. Full description of this project can be found [here](https://github.com/raywenderlich/ios-interview/blob/master/Practical%20Example/README.md)


## 📸 Screenshot

<img src="./images/rw_take_home.png" alt="Raywenderlich.com iOS interview practice project" width="700">


## Accessibility:
- **Dynamic Type:** This app supports dynamic type. When the text size gets large, all the horizontal stacks become vertical stacks and single cell gets full width in the landscape mode.

<table>
  <tr>
    <td> <img src="./images/dynamic_type_portrait.png" alt="Dynamic Type in portrait"/></td>
    <td> <img src="./images/dynamic_type_landscape.png" alt="Dynamic Type in landscape" /></td>
  </tr>
 </table>

- **VoiceOver:** In this app, each CollectionViewCell acts like a single element when the VoiceOver is activated. The `accessibilityLabel` of each Cell consists of the title and type (artticle/video) of the Cell data.

<p float="left">
  <img src="./images/voiceover.png" width="500" alt="VoiceOver support"/>
</p>


## APIs/Libraries, I have used in this project
- Auto Layout
- Custom UIView
- CollectionView with DiffableDataSource & CompositionalLayout
- Combine & URLSession
- **Kingfisher**: Downloading image for the CollectionViewCell is a common problem in the iOS community and the community came up with mutliple solutions. Kingfisher is one of the most popular solutions. It is open sourced and actively maintained. That's why I have choosen this library to download the images. </br> (RW iOS App also uses this library)
- SwiftLint


## Speacial Thanks To
- [raywenderlich.com](https://www.raywenderlich.com/) for the amazing **RW Community Care!**
- [Audrey Tam](https://twitter.com/mataharimau) and all the mentors of **RW Bootcamp**
- All the fellow students of **RW Bootcamp**
