
<div align="center">

<img width="128" height="128" src="./repo_metadata/project_icon.png" alt="logo">

<span>

`COURSE PROJECT`

</span>

# Thai Food Image Recognition

<p>A project that implemented various kind of learning-based techniques such as SVM, and CNN to classify Thai food images. The models were trained using a dataset of Thai food images with 38 classes each of which has 250 images.</p>
</div>

![Project Hero Image](/repo_metadata/hero_image.png)

## 🚩 Abstract
Due to the nature of cooking and food in general, recognizing foods from their visual appearance proves to be a difficult task because of the visual diversity and the
visual similarity of each type of food. In this paper, we conducted a comparative study on multiple deep learning-based models for the multi-class Thai food recognitions using food dish photos. We experimented with a total of 10 classification models, four of which are designed and trained from scratch. The other five is built upon existing pre-trained models using transfer learning. The other uses the naive feature similarity technique. To evaluate the performance of all models, we also accumulated photos from the internet and our own photos to create a dataset of 38 classes each of which has 250 images. We discovered that models from transfer learning are generally more efficient in training and more performant even when the dataset is small than the ones trained from scratch. Moreover, we also found that training models from scratch are time-consuming and troublesome because there are countless hyperparameters to be dealt with. However, despite the fact that transfer learning models are better, they are unable to distinguish and correctly classify some distinct kind of foods are visually similar.

## 🖼 Dataset
The dataset that we used has 9,500 images. Currently, there are 38 kinds of Thai foods, each of which has 250 images. 
|Name                                      |Thai Name              |
|------------------------------------------|-----------------------|
|Caesar Salad                              |ซีซาร์สลัด             |
|Charcoal Boiled Pork neck                 |คอหมูย่าง              |
|Chow mein                                 |หมี่ซั่ว               |
|Coconut Milk Soup                         |ต้มข่าไก่              |
|Fried Mussel Pancakes                     |หอยแมลงภู่ทอด          |
|Green Curry                               |แกงเขียวหวาน           |
|Hamburger                                 |แฮมเบอร์เกอร์          |
|Hot and sour  fish and vegetable ragout   |แกงส้ม                 |
|Kebab                                     |เคบับ                  |
|Khao Soi                                  |ข้าวซอย                |
|Noodles with Fish Curry                   |ขนมจีน                 |
|Omlette                                   |ไข่เจียว               |
|Onion Rings                               |หอมหัวใหญ่ชุบแป้งทอด   |
|Pad Thai                                  |ผัดไทย                 |
|Peking Duck                               |เป็ดปักกิ่ง            |
|Pizza                                     |พิซซ่า                 |
|Spaghetti Bolognese                       |สปาเกตตี้ซอสเนื้อ      |
|Spaghetti Carbonara                       |สปาเก็ตตี้คาโบนาร่า    |
|Spring Rolls                              |ปอเปี๊ยะ               |
|Steak                                     |สเต็ก                  |
|Steamed Rice Roll                         |ก๋วยเตี๋ยวหลอด         |
|Stewed Pork Leg                           |ขาหมู                  |
|Thai Papaya Salad                         |ส้มตำไทย               |
|Yellow Curry                              |แกงกะหรี่              |
|Fried Pork with Rice                      |ข้าวหมูทอด             |
|Barbecued red pork in sauce with Rice     |ข้าวหมูแดง             |
|Rice crispy pork                          |ข้าวหมูกรอบ            |
|Crispy Pork with Kale with Rice           |ข้าวคะน้าหมูกรอบ       |
|Pad see ew                                |ผัดซีอิ้ว              |
|Noodles without soup                      |ก๋วยเตี๋ยวแห้ง         |
|Noodles                                   |ก๋วยเตี๋ยวน้ำ          |
|Rice topped with stir-fried meat and basil|ข้าวผัดกะเพราเนื้อสัตว์|
|Fried rice                                |ข้าวผัด                |
|Steamed chicken with rice                 |ข้าวมันไก่             |
|Fried chicken with rice                   |ข้าวมันไก่ทอด          |
|Steak with Rice                           |ข้าวเนื้อสเต็ก         |
|Spicy Chicken Salad with rice             |ข้าวยำไก่แซ่บ          |
|Spicy Stir Fried Pork with Red Curry Paste|ข้าวผัดเผ็ดหมู         |


## 🛠 Implementation

This project has 2 phases:
1. **Phase 1:** Implemented using **MATLAB**
    - There are 2 models implemented in this phase.
        1. **Image Features Vector Similarity** - This method utilizes manual image features extraction such as mean color values, texture features (e.g. homogeity, energy, entropy) along with the area size of edge and so on. This technique proves to be very naive because, for each image, features are packed as a vector and compared using cosin similarity.
        2. **Transfer Learning using CNN as a feature extractor for a SVM (Support Vector Machine)** - This method relies on a pre-trained CNN, in this case ResNet50, and another SVM. Basically, we feed an image into the pre-trained CNN in order to get the activation of the last fully-connected layer. We use that to feed train an SVM to ensure that it learns to classify our images. We repeat this process for every train image. Then we later use the train SVM to predict.
2. **Phase 2:** Implemented using **Python with Keras and TensorFlow**
    - There are 8 models implemented in this phase.
        1. First 4 models are **designed and trained from scratch**
        2. The other 4 models are pre-trained models for **transfer learning**
            - DenseNet201
            - ResNet101v2
            - ResNet50v2
            - Xception
    - Summary: The transfer learning models are obviously a better choice for its training efficiency and performance. Our custom models are outperformed by transfer learning models.

## 📃 Submitted Papers
- Phase 1: [Link](https://github.com/rektplorer64/ITCS402-PJ_Thai_Food_Image_Recognition/blob/master/Digital_Image_Processing___MATLAB___Project_Paper.pdf)
- Phase 2: [Link](https://github.com/rektplorer64/ITCS402-PJ_Thai_Food_Image_Recognition/blob/master/Digital_Image_Processing___PYTHON___Project_Paper.pdf)

## 🎓 What I learned from this project
1. Training deep learning models really take a lot of time even if you have a lot of computing resources.
2. Careful parameter finetuning is very important because it means you are less like to spend less time to try it out by training.
3. Transfer learning is like a cheat to get an outstanding performance.
4. Preparing dataset is quite an time-consuming task.
5. My knowledge from deeplearning.ai 's Deep Learning course on Coursera can be applied to this project.

