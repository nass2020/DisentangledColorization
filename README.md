# Disentangled Image Colorization via Global Anchors

### [Paper](https://menghanxia.github.io/papers/2022_disco_main.pdf) | [Project Page](https://menghanxia.github.io/projects/disco.html) | [Online Demo](https://huggingface.co/spaces/menghanxia/disco)

Conceptually, our disentangled colorization model consists of two components: (i) **anchor color representation** that predicts the global color anchors (i.e. location and probabilistic colors) as the color representation of the whole image; (ii) **anchor-guided color generation** that synthesizes the per-pixel colors deterministically by referring the specified anchor colors.

<div align="center">
	<img src="asserts/network.png" width="95%">
</div>

<br>

:blush: **This is the official PyTorch implementation of our colorization work** [DISCO](https://menghanxia.github.io/projects/disco.html).

## Dependencies and Installation

- PyTorch >= 1.8.0
- CUDA >= 10.2
- Other required packages in [requirements.txt](./requirements.txt)
```
# git clone this repository
git clone https://github.com/MenghanXia/DisentangledColorization
cd DisentangledColorization
```
#### Environment configuration: option 1
```
# create a new anaconda env
conda create -n DISCO python=3.8
source activate DISCO

# install pytortch
conda install pytorch==1.8.0 torchvision==0.9.0 torchaudio==0.8.0 cudatoolkit=10.2 -c pytorch

# install other packages
pip install requirements.txt
```
#### Environment configuration: option 2
```
# create a anaconda env with required packages installed
conda env create -f environment.yml
```


## Checkpoints
| Name |   URL  | Script | Model Description | FID (COCO) |
| :----: | :----: | :----: | :----: | :----: |
| DISCO 	 | [model](https://drive.google.com/file/d/1J4vB6kG4xBLUUKpXr5IhnSSa4maXgRvQ/view?usp=sharing) | [train.sh](./scripts/anchorcolorprob_hint2class-enhanced-h8.sh) | recommended colorization model (*kept updating*) | TBD |
| DISCO-c0.2 | [model](https://drive.google.com/file/d/1jGDOfMq4mpYe6KCc0MtuiFwdEJ7_Hcc-/view?usp=sharing) | [train.sh](./scripts/anchorcolorprob_hint2class-enhanced-h8-c0.2.sh) | colorization model with less aggressive color saturation | 10.47 |
| DISCO-rand | [model](https://drive.google.com/file/d/1GLLowR-0eK2U4RAHijoizEyKd5ny10OI/view?usp=sharing) | [train.sh](./scripts/anchorcolorprob_hint2class-enhanced-rand.sh) | colorization model with higher robustness to anchor sites | 10.25 |


## Quick Inference

- **Download Pre-trained Models**: download a pretrained colorization model by ```sh ./checkpoints/disco_download.sh``` or from the tabulated links, and put it into the folder `./checkpoints`.

- **Prepare Testing Data**: You can put the testing images in a folder, like `./data`

- **Test on Images**: Run the inference script ```sh ./scripts/inferece.sh``` and the colorized images will be saved in `./test-anchor8`. As default, the input image will be resized into 256x256 and colorized at this fixed resolution. Optional arguments includes:
	- `--no_resize`: colorize the image at the original input resolution.
    - `--diverse`: generate diverse (three) colorization results.
	- `--n_clusters`: specify the number of color anchors (default=8).
	- `--random_hint`: use randomly scattered anchor locations.

Also, you can specify your own directories by runing the command below:
```
python ./main/colorizer/inference.py --checkpt [checkpoint path] --data [input dir] \
	--name [save name]
```
You are recommended to use the absolute paths as arguments, otherwise please note that running `inference.py` will redirect the *current dir* to `./main/colorizer`. Note that, changing the random seed `--seed`
may result in different colorization result because the clustering-based anchor location involves randomness.


## Training
- **Download Pre-trained SPixelNet**: download the pretrained [SPixelNet-s16](https://drive.google.com/file/d/1sLIqur7Hxan8PhW0n8kd7vzNEuIXAEdI/view?usp=sharing) and put it into a folder, like `./checkpoints`.

- **Prepare Data and Configuration**: Official [ImageNet](https://image-net.org/download.php) and [COCO](https://cocodataset.org/#download) dataset and any other color image dataset are supported. You need to specify the training arguments below:
	- `--data_dir`: the dataset location
	- `--dataset`: the dataset name (e.g., "imagenet" and "coco") that is required by dataloader construction.
	- `ckpt_dir`: the directory of any pre-trained models required by the training.
	- `save_dir`: the directory to save the training meta data and checkpoints.

- **Train the Model**: Again, you are recommended to use the absolute paths as arguments to avoid accident.
```
sh scripts/anchorcolorprob_hint2class-enhanced-h8.sh
```

## Evaluation

We provide the python implementation of the colorization evaluation metrics [HERE](), and the corresponding running scripts are attached.
```
# fidelity metrics: PSNR, SSIM, LPIPS
sh run_fidelity.sh

# perceptual quality: FID, IS, colorfulness
sh run_perception.sh
```

## Acknowledgement
Part of our codes are taken from from [SpixelFCN](https://github.com/fuy34/superpixel_fcn), [iDeepColor](https://github.com/richzhang/colorization-pytorch), and [DETR](https://github.com/facebookresearch/detr). Thanks for their awesome works.


## Citation
If any part of our paper and code is helpful to your work, please generously cite with:
```
@article{XiaHWW22,
	author   = {Menghan Xia and Wenbo Hu and Tien-Tsin Wong and Jue Wang},
	title    = {Disentangled Image Colorization via Global Anchors},
	journal  = {ACM Transactions on Graphics (TOG)},
	volume   = {41},
	number   = {6},
	pages    = {204:1--204:13},
	year = {2022}
}
```