## About
This repository hosts the necessary scripts to create labeled data for tomograms to be used in model training. This data can range from segmenting entire bacteria to labeling flagellar motors.
#### Contents
- 

#### What you need
- Conda/mamba
- Python
- ITK-SNAP (Download [here](http://www.itksnap.org/pmwiki/pmwiki.php?n=Downloads.SNAP3))

## File Conventions for Segmentation Data
Please do your best to follow the below conventions so all the data can stay organized. They're not set in stone, but we do need to make sure we stay on the same page.

#### File Structure for Annotation Data
Note: the `env_setup.sh` script should auto-build these directories. They **will not** end up in the GitHub repo, as tomograms are too big to store there. So, don't worry that these files do not show up on the repository. We will primarily be storing the files on the supercomputer. More on that later.
```
.
├── segmentation_data
│   ├── raw_tomograms # directory for raw images
│   │   ├── dataset_1
│   │   │   ├── tomo_1.mrc
│   │   │   ├── tomo_1.mha
│   │   │   ├── tomo_2.mrc
│   │   │   └── tomo_2.mha
│   ├── annotatons # directory for segmentation files
│   │   ├── dataset_1
│   │   │   ├── annotation_1.mrc
│   │   │   └── annotation_2.mrc
│   │   └──
│   └──
└──
```
#### File Names
Raw images are automatically downloaded and renamed to run_<runID>.mrc and converted to run_<runID>.mha. They are saved in the directory dataset_<datasetID>. All IDs correspond to the CZI database IDs.

Annotations should be saved following the pattern <annotation_type>_<runID>. For example, a membrane segmentation from dataset 10084, run 6100 would be saved as segmentation_data/annotations/dataset_10084/membrane_6100.mha (or whatever file type you chose to save as).

#### Setup and Install

#### Uploading to Supercomputer